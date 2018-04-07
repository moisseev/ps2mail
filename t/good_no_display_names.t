use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";

use Test qw(run);

run(
    'good',
    {
        meta => 'From: from@mailinator.com To: rcpt@mailinator.com',
    }
);
