use strict;
use warnings;

use t::lib::Test qw(run);

run(
    'bad',
    {
        meta => 'From: From name from@mailinator.com> To: To name <rcpt@mailinator.com>',

        aborted => 'bad sender address',
    }
);
