package App::Schema::Result::User;

use strict;
use warnings;
use utf8;

use parent "App::Schema::Result";

use App::Schema::Types;

__PACKAGE__->table('user');

__PACKAGE__->add_columns(
    id                => PK_INTEGER,
    name              => VARCHAR( size => 191 ),
    current_ua_number => INTEGER,
    created_at        => DATETIME,
);

__PACKAGE__->set_primary_key(qw/id/);

__PACKAGE__->has_one(
    current_ua => "App::Schema::Result::UserAvatar",
    {   'foreign.user_id' => 'self.id',
        'foreign.number'  => 'self.current_ua_number',
    },
    { 'is_foreign_key_constraint' => 0 },
);

sub to_hashref {
    my $self = shift;
    +{  id                => $self->id,
        name              => $self->name,
        current_ua_number => $self->current_ua_number,
        created_at        => $self->created_at,
    };
}

1;
