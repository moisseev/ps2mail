use strict;
use warnings;

use t::lib::Test qw(run);

run(
    'good',
    {
        meta =>
'From: Отправитель документа <from@mailinator.com> To: "Получатель документа" <rcpt@mailinator.com>',
        ps_file => './t/files/good_utf-8_cyrillic.ps',
    }
);
