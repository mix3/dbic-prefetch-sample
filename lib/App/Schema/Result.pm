package App::Schema::Result;

use strict;
use warnings;
use utf8;

use Time::Piece qw//;

use parent 'DBIx::Class::Core';

sub sqlt_deploy_hook {
    my ( $self, $sqlt_table ) = @_;

    $sqlt_table->extra(
        mysql_table_type => 'InnoDB',
        mysql_charset    => 'utf8mb4',
    );
}

sub insert {
    my $self = shift;

    if ( $self->can('created_at') or $self->can('updated_at') ) {
        my $now = Time::Piece::localtime->strftime('%Y-%m-%d %H:%M:%S');
        $self->created_at($now) if $self->can('created_at');
        $self->updated_at($now) if $self->can('updated_at');
    }

    $self->next::method(@_);
}

1;
