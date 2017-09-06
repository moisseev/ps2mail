use strict;
use warnings;

use t::lib::Test qw(run);

use constant TO => 'to@example.org';

run(
    'bad',
    {
        meta => 'From: From name <from@mailinator.com> To: To name <'
          . TO . '>',

        aborted => 'invalid address: ' . TO . ' (mxcheck)',
    }
);
