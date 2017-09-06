use strict;
use warnings;

use t::lib::Test qw(run);

run(
    'good',
    {
        meta => 'From: from@mailinator.com To: rcpt@mailinator.com',
    }
);
