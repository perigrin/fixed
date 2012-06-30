use strict;
use warnings;
 
package fixed;
BEGIN {
  $fixed::AUTHORITY = 'cpan:PERIGRIN';
}
{
  $fixed::VERSION = '0.01';
}
# ABSTRACT: conditionals as expressions
 
use Sub::Exporter -setup => {
    exports => ['fixed'],
    groups  => { default => ['fixed'] },
};
 
use Devel::CallParser;
use XSLoader;
 
XSLoader::load(
    __PACKAGE__,
    $fixed::{VERSION} ? ${ $fixed::{VERSION} } : (),
);

1;
__END__