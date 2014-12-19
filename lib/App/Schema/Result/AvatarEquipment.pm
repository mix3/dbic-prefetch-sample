package App::Schema::Result::AvatarEquipment;

use strict;
use warnings;
use utf8;

use parent "App::Schema::Result";

use App::Schema::Types;

__PACKAGE__->table('avatar_euipment');

__PACKAGE__->add_columns(
    id   => INTEGER,
    name => VARCHAR( size => 191 ),
);

__PACKAGE__->set_primary_key(qw/id/);

sub to_hashref {
    my $self = shift;
    +{  id   => $self->id,
        name => $self->name,
    };
}

1;
