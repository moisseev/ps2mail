requires 'Email::Address::XS';
requires 'Email::Valid', '== 1.200';
requires 'IO::Interactive';
requires 'Locale::gettext';
requires 'MIME::Lite';
requires 'Net::Domain::TLD';
requires 'Net::DNS';

on 'test' => sub {
    requires 'IPC::Run3';
    requires 'IPC::Shareable';
    requires 'Text::Template';
};

on 'develop' => sub {
    requires 'Code::TidyAll';
    requires 'Code::TidyAll::Plugin::Test::Vars';
    requires 'Perl::Critic';
    requires 'Perl::Tidy';
    requires 'Pod::Tidy';
};
