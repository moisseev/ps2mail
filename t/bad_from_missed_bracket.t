use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";

use Test qw(run);

run(
    'bad',
    {
        meta => 'From: From name from@mailinator.com> To: To name <rcpt@mailinator.com>',

        aborted => 'bad sender address',
        sm_to   => 'ps2mail@example.org',
    }
);
