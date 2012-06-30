#!/usr/bin/env perl
use strict;
use Test::More;
use Try::Tiny;
use fixed;

fixed ($foo, $bar) = (1,2);

::pass('got here');

try { $foo = 2 } catch { ::pass('read only') if /^Modification of a read-only value attempted/; };
try { $bar = 1 } catch { ::pass('read only') if /^Modification of a read-only value attempted/; };

is $foo, 1, 'foo is still 1';
is $bar, 2, 'bar is still 2';

done_testing;
