use strict;
use warnings;

use t::lib::Test qw(run);

run(
    'good',
    {
        meta => 'from: From name <from@mailinator.com> to: To name <rcpt@mailinator.com>',
    }
);
