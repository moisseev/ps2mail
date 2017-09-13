requires 'Email::Address';
requires 'Email::Valid', '== 1.200';
requires 'IO::Interactive';
requires 'MIME::Lite';
requires 'Net::Domain::TLD';
requires 'Net::DNS';

on test => sub {
    requires 'IPC::Run3';
    requires 'IPC::Shareable';
    requires 'Text::Template';
}
