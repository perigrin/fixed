#!/usr/bin/env perl
use strict;
use Test::More;
use Try::Tiny;
use fixed;

fixed $foo = 1;

::pass('got here');

done_testing;
