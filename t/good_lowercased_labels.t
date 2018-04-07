use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";

use Test qw(run);

run(
    'good',
    {
        meta => 'from: From name <from@mailinator.com> to: To name <rcpt@mailinator.com>',
    }
);
