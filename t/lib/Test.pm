#
# Functional test for ps2mail
#
# https://github.com/moisseev/ps2mail
#
# Copyright (c) 2017, Alexander Moisseev <moiseev@mezonplus.ru>
# This software is licensed under the terms of the 2-Clause BSD License.
#

package Test;

use 5.014;
use warnings;

use base 'Exporter';
our @EXPORT_OK = qw(run);

use Fcntl qw(O_RDONLY O_NONBLOCK);
use IPC::Run3;
use IPC::Shareable ();
use POSIX qw(mkfifo);
use Test::More tests => 4;
use Text::Template;

# Program under test
my $cmd      = './ps2mail';
my @cmd_args = qw( -c -w132 -l66 -i0 -n test -h testhost );

my $templates = {
    bad => {
        tag_start => '0(ojo)0 {',
        tag_end   => '}',

        exit_status => 2,
        log_msg     => [ 'job', 'meta', 'aborted', 'sm_error' ],
        sm_to       => 'from@mailinator.com',
    },
    good => {
        tag_start => '0(ojo)0 {',
        meta      => 'From: From name <from@mailinator.com> To: To name <rcpt@mailinator.com>',
        tag_end   => '}',

        exit_status => 0,
        log_msg     => [ 'job', 'meta', 'sm_delivery' ],
    },
    good_fallback => {
        tag_start => '@@',
        meta      => 'mail: rcpt@mailinator.com',
        tag_end   => '@@',

        exit_status => 0,
        log_msg     => [ 'job', 'eop1', 'fallback', 'meta', 'sm_delivery' ],
    },
    none => {},
};

sub run {
    my ( $template, $case ) = @_;

    # Merge test template and test case
    my $t = { %{ $templates->{ $template // 'none' } }, %{ $case // {} } };

    my %HoT = (
        job => sub {
            is( $_[0], "print job: " . join( ' ', @cmd_args ), $_[0] );
        },
        eop1 => sub {
            is( $_[0], 'end of page 1 reached', $_[0] );
        },
        fallback => sub {
            is( $_[0], 'tags not found, searching for fallback tags', $_[0] );
        },
        meta => sub {
            is( $_[0], "meta:  $t->{meta}", $_[0] );
        },
        aborted => sub {
            is( $_[0], "job aborted: " . $t->{aborted}, $_[0] );
        },
        sm_delivery => sub {
            like( $_[0], qr/sendmail\(delivery\): from/, $_[0] );
        },
        sm_error => sub {
            is( $_[0], 'sendmail(error): from=ps2mail@example.org, to=' . $t->{sm_to} . ', rcpt=1, status=sent',
                $_[0] );
        },
    );

    my $glue = substr $$, -4;
    tie my @log, 'IPC::Shareable', $glue, { create => 1, destroy => 1 }
      or die "cannot tie to shared memory: $!";

    my $stdin = $t->{ps_file}
      ? do {
        local $/;
        open( my $fh, "<", $t->{ps_file} )
          || die "opening PS file $t->{ps_file} failed: $!";
        <$fh>;
      }
      : do {
        my $ps_template = Text::Template->new(
            DELIMITERS => [ '{{', '}}' ],
            SOURCE     => './t/files/template.ps'
        ) or die "Couldn't construct template: $Text::Template::ERROR";
        $ps_template->fill_in( HASH => $t );
      };

    my ( $stdout, $stderr );
    my $expected_stdout = <<'EOF';
%%[ ProductName: GPL Ghostscript ]%%
%%[Page: 1]%%
%%[LastPage]%%
EOF

    run3( [ $cmd, '--test', $glue, @cmd_args ], \$stdin, \$stdout, \$stderr );

    is( ( $? >> 8 ), $t->{exit_status}, 'exit status' );
    is( $stdout, $expected_stdout, 'stdout' );
    is( $stderr, '', 'stderr' );

    subtest "Log" => sub {
        foreach ( @{ $t->{log_msg} } ) {
            my $msg = shift @log;
            $HoT{$_}->($msg);
        }
        is( join( '', @log ), '', "EOF" );
    };
}

1;
