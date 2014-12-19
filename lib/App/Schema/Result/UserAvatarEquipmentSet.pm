package App::Schema::Result::UserAvatarEquipmentSet;

use strict;
use warnings;
use utf8;

use parent "App::Schema::Result";

use App::Schema::Types;

__PACKAGE__->table('user_avatar_equipment_set');

__PACKAGE__->add_columns(
    number      => INTEGER,
    user_id     => INTEGER,
    head_uae_id => INTEGER,
    body_uae_id => INTEGER,
    leg_uae_id  => INTEGER,
);

__PACKAGE__->set_primary_key(qw/number user_id/);

__PACKAGE__->has_one(
    head_uae => "App::Schema::Result::UserAvatarEquipment",
    {   'foreign.user_id' => 'self.user_id',
        'foreign.id'      => 'self.head_uae_id',
    },
    { 'is_foreign_key_constraint' => 0 },
);

__PACKAGE__->has_one(
    body_uae => "App::Schema::Result::UserAvatarEquipment",
    {   'foreign.user_id' => 'self.user_id',
        'foreign.id'      => 'self.body_uae_id',
    },
    { 'is_foreign_key_constraint' => 0 },
);

__PACKAGE__->has_one(
    leg_uae => "App::Schema::Result::UserAvatarEquipment",
    {   'foreign.user_id' => 'self.user_id',
        'foreign.id'      => 'self.leg_uae_id',
    },
    { 'is_foreign_key_constraint' => 0 },
);

sub to_hashref {
    my $self = shift;
    +{  number      => $self->number,
        user_id     => $self->user_id,
        head_uae_id => $self->head_uae_id,
        body_uae_id => $self->body_uae_id,
        leg_uae_id  => $self->leg_uae_id,
    };
}

1;
