use strict;
use warnings;

use t::lib::Test qw(run);

run(
    'good_fallback',
    {
        meta => 'mail:rcpt1@mailinator.com, rcpt2@mailinator.com',
    }
);
