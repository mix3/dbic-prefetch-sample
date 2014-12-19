```
$ carton install
$ carton exec prove -lvr t
t/count.t ..
ok 1 - use App::Schema::Result::User;
ok 2 - use App::Schema::Result::UserAvatar;
ok 3 - use App::Schema::Result::UserAvatarEquipment;
ok 4 - use App::Schema::Result::UserAvatarEquipmentSet;
ok 5 - use App::Schema::Result::AvatarEquipment;
    # Subtest: simple
    ok 1 - count: 450
    1..1
ok 6 - simple
    # Subtest: where in
    ok 1 - count: 401
    1..1
ok 7 - where in
    # Subtest: where in + prefetch
    ok 1 - count: 1
    1..1
ok 8 - where in + prefetch
1..8
ok
All tests successful.
Files=1, Tests=8, 11 wallclock secs ( 0.03 usr  0.02 sys +  2.12 cusr  0.69 csys =  2.86 CPU)
Result: PASS
```
