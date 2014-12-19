package t::Util;

use 5.10.1;

use strict;
use warnings;
use utf8;

use parent 'Exporter';

use Test::More;
use Test::Deep;
use Test::Deep::Matcher;
use Test::mysqld;
use App::Schema;

our @EXPORT = qw(
    schema
    trace_sqls
);

sub import {
    my ( $class, @args ) = @_;

    strict->import;
    warnings->import;
    utf8->import;

    $class->export_to_level( 1, $class, @args );

    Test::More->export_to_level(1);
    Test::Deep->export_to_level(1);
    Test::Deep::Matcher->export_to_level(1);
}

my $MYSQLD;

END { undef $MYSQLD }

sub schema {
    state $schema = do {
        $MYSQLD = Test::mysqld->new( my_cnf => { "skip-networking" => "" } )
            or plan skip_all => $Test::mysqld::errstr;
        my $schema = App::Schema->connection( $MYSQLD->dsn );
        $schema->deploy;
        $schema;
    };
    $schema;
}

sub trace_sqls (&) {
    my $code = shift;
    my @sqls;
    require DBIx::Tracer;
    my $tracer = DBIx::Tracer->new(
        sub {
            my %args = @_;
            push @sqls, $args{sql};
        }
    );
    $code->();
    @sqls;
}

1;
