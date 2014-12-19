package App::Schema::Result::UserAvatarEquipment;

use strict;
use warnings;
use utf8;

use parent "App::Schema::Result";

use App::Schema::Types;

__PACKAGE__->table('user_avatar_equipment');

__PACKAGE__->add_columns(
    id         => PK_BIGINT,
    user_id    => INTEGER,
    ae_id      => INTEGER,
    created_at => DATETIME,
);

__PACKAGE__->set_primary_key(qw/id/);

__PACKAGE__->has_one(
    ae => "App::Schema::Result::AvatarEquipment",
    { 'foreign.id'                => 'self.ae_id', },
    { 'is_foreign_key_constraint' => 0 },
);

sub to_hashref {
    my $self = shift;
    +{  id         => $self->id,
        user_id    => $self->user_id,
        ae_id      => $self->ae_id,
        careted_at => $self->created_at,
    };
}

1;
