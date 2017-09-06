use strict;
use warnings;

use t::lib::Test qw(run);

run(
    'good',
    {
        meta => 'rcpt@mailinator.com',
    }
);
