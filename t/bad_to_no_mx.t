use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";

use Test qw(run);

use constant TO => 'to@example.org';

run(
    'bad',
    {
        meta => 'From: From name <from@mailinator.com> To: To name <' . TO . '>',

        aborted => 'invalid address: ' . TO . ' (mxcheck)',
    }
);
