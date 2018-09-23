use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";

use Test qw(run);

use constant TO => 'to@example.org';

run('good');
