use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";

use Test qw(run);

run(
    'bad',
    {
        meta => 'From: From name <from@mailinator.com> To: To name <rcpt@example.local>',

        aborted => 'invalid address: rcpt@example.local (tldcheck)',
    }
);
