package App::Schema::Result::UserAvatar;

use strict;
use warnings;
use utf8;

use parent "App::Schema::Result";

use App::Schema::Types;

__PACKAGE__->table('user_avatar');

__PACKAGE__->add_columns(
    number                 => INTEGER,
    user_id                => INTEGER,
    current_uae_set_number => INTEGER,
);

__PACKAGE__->set_primary_key(qw/number user_id/);

__PACKAGE__->has_one(
    current_uae_set => "App::Schema::Result::UserAvatarEquipmentSet",
    {   'foreign.user_id' => 'self.user_id',
        'foreign.number'  => 'self.current_uae_set_number',
    },
    { 'is_foreign_key_constraint' => 0 },
);

sub to_hashref {
    my $self = shift;
    +{  number                 => $self->number,
        user_id                => $self->user_id,
        current_uae_set_number => $self->current_uae_set_number,
    };
}

1;
