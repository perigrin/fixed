use strict;
use warnings;
use Devel::CallParser;
use IO::File;
 
write_header('callparser.h', eval { Devel::CallParser::callparser1_h } || Devel::CallParser::callparser0_h);
 
sub write_header {
    my ($header, $content) = @_;
    my $fh = IO::File->new($header, 'w') or die $!;
    $fh->print($content) or die $!;
    $fh->close or die $!;
}
 
1;
 
use ExtUtils::MakeMaker 6.30;
 
my %WriteMakefileArgs = (
  'ABSTRACT' => 'fixed "variables" ala Erlang',
  'AUTHOR' => 'Chris Prather <chris@prather.org>',
  'BUILD_REQUIRES' => {
    'Test::More' => '0'
  },
  'CONFIGURE_REQUIRES' => {
    'Devel::CallParser' => '0',
    'ExtUtils::MakeMaker' => '6.30',
    'IO::File' => '0'
  },
  'DISTNAME' => 'fixed',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'fixed',
  'OBJECT' => '$(BASEEXT)$(OBJ_EXT)',
  'PREREQ_PM' => {
    'Devel::CallParser' => '0',
    'Sub::Exporter' => '0',
    'XSLoader' => '0',
    'strict' => '0',
    'warnings' => '0'
  },
  'VERSION' => '0.01',
  'clean' => {
    'FILES' => 'callchecker0.h callparser.h'
  },
  'test' => {
    'TESTS' => 't/*.t'
  }
);
 
 
unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}
 
delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };
 
$WriteMakefileArgs{CCFLAGS} = ( $Config::Config{ccflags} || '' ) . ' -I.';
 
WriteMakefile(%WriteMakefileArgs);