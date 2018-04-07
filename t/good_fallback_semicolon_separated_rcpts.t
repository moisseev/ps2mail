use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";

use Test qw(run);

run(
    'good_fallback',
    {
        meta => 'mail:rcpt1@mailinator.com; rcpt2@mailinator.com',
    }
);
