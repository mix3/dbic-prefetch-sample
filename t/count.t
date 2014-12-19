use t::Util;

use_ok "App::Schema::Result::User";
use_ok "App::Schema::Result::UserAvatar";
use_ok "App::Schema::Result::UserAvatarEquipment";
use_ok "App::Schema::Result::UserAvatarEquipmentSet";
use_ok "App::Schema::Result::AvatarEquipment";

{
    my $create_data = {
        1 => "頭",
        2 => "体",
        3 => "足",
    };
    while ( my ( $id, $name ) = each %$create_data ) {
        my $ae_row = schema->resultset('AvatarEquipment')->create(
            {   id   => $id,
                name => $name,
            }
        );
    }
}

sub create_user {
    my $user_row = schema->resultset('User')->create(
        {   name              => "test",
            current_ua_number => 1,
        }
    );

    my @uae_row = ();
    for my $ae_id ( 1 .. 3 ) {
        push @uae_row,
            schema->resultset('UserAvatarEquipment')->create(
            {   user_id => $user_row->id,
                ae_id   => $ae_id,
            }
            );
    }
    schema->resultset('UserAvatar')->create(
        {   user_id                => $user_row->id,
            number                 => 1,
            current_uae_set_number => 1,
        }
    );
    schema->resultset('UserAvatarEquipmentSet')->create(
        {   user_id     => $user_row->id,
            number      => 1,
            head_uae_id => $uae_row[0]->id,
            body_uae_id => $uae_row[1]->id,
            leg_uae_id  => $uae_row[2]->id,
        }
    );
}

create_user for ( 1 .. 50 );

subtest simple => sub {
    my @sqls = trace_sqls {
        for my $user_id ( 1 .. 50 ) {
            my $user_row = schema->resultset('User')->find($user_id);
            $user_row->current_ua;
            $user_row->current_ua->current_uae_set;
            $user_row->current_ua->current_uae_set->head_uae;
            $user_row->current_ua->current_uae_set->body_uae;
            $user_row->current_ua->current_uae_set->leg_uae;
            $user_row->current_ua->current_uae_set->head_uae->ae;
            $user_row->current_ua->current_uae_set->body_uae->ae;
            $user_row->current_ua->current_uae_set->leg_uae->ae;
        }
    };
    pass sprintf "count: %d", scalar(@sqls);
};

subtest "where in" => sub {
    my @sqls = trace_sqls {
        my @ids = 1 .. 50;
        my $user_rs = schema->resultset('User')->search( { id => { -in => \@ids } } );
        while ( my $row = $user_rs->next ) {
            $row->current_ua;
            $row->current_ua->current_uae_set;
            $row->current_ua->current_uae_set->head_uae;
            $row->current_ua->current_uae_set->body_uae;
            $row->current_ua->current_uae_set->leg_uae;
            $row->current_ua->current_uae_set->head_uae->ae;
            $row->current_ua->current_uae_set->body_uae->ae;
            $row->current_ua->current_uae_set->leg_uae->ae;
        }
    };
    pass sprintf "count: %d", scalar(@sqls);
};

subtest "where in + prefetch" => sub {
    my @sqls = trace_sqls {
        my @ids     = 1 .. 50;
        my $user_rs = schema->resultset('User')->search(
            { 'me.id' => { -in => \@ids } },
            {   prefetch => {
                    current_ua => {
                        current_uae_set => {
                            head_uae => 'ae',
                            body_uae => 'ae',
                            leg_uae  => 'ae',
                        },
                    },
                },
            }
        );
        while ( my $row = $user_rs->next ) {
            $row->current_ua;
            $row->current_ua->current_uae_set;
            $row->current_ua->current_uae_set->head_uae;
            $row->current_ua->current_uae_set->body_uae;
            $row->current_ua->current_uae_set->leg_uae;
            $row->current_ua->current_uae_set->head_uae->ae;
            $row->current_ua->current_uae_set->body_uae->ae;
            $row->current_ua->current_uae_set->leg_uae->ae;
        }
    };
    pass sprintf "count: %d", scalar(@sqls);
};

done_testing;
