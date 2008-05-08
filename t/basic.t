use strict;
use warnings;
use Test::More tests => 5;

use String::TT 'tt';

is a(), 'foobar', 'foobar works';
like b(), qr/SCALAR/, "references aren't dereferenced";
is c(), 'A::foo', 'methods work';
is d(), 'foo foo bar 1', 'arrays and hashes work';
is e(), 'array foo_a', 'nothing overwritten';

sub a {
    my $foo = 'foo';
    my $bar = 'bar';
    return tt '[% foo %][% bar %]';
}

sub b {
    my $foo = \'reference';
    return tt '[% foo %]';
}

{
    sub A::foo { return 'A::foo' }
    
    sub c {
        my $a = bless { foo => 'bar' } => 'A';
        return tt '[% a.foo %]';
    }
}

sub d {
    my $foo = 'foo';
    my @bar = qw/bar/;
    my %baz = ( baz => 1 );
    return tt '[% foo %] [% foo_s %] [% bar_a.0 %] [% baz_h.baz %]';
}

sub e {
    my $foo_a = 'foo_a';
    my @foo = qw/array/;
    return tt '[% foo_a.0 %] [% foo_a_s %]'
}
