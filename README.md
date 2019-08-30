git clone git@github.com:mikero5/micro-reddit.git

You'll need to run rails db:migrate in the clone directory

directory: ./app/models/
files: user.rb, post.rb, comment.rb

The files listed above show the associations I made for the ActiveRecord support
- (also the ./db/schema.rb file might be useful to see the table defs)


run: rails console, or rails console --sandbox (command output indented followd by newline):


mike@mercury:~/code/learning/ruby/scratch_testing/micro-reddit$ rails console --sandbox
    Running via Spring preloader in process 30205
    Loading development environment in sandbox (Rails 5.2.3)
    Any modifications you make will be rolled back on exit

irb(main):001:0> u = User.new(name: "Foo", email: "foo@bar.com")
    => #<User id: nil, name: "Foo", email: "foo@bar.com", created_at: nil, updated_at: nil>

irb(main):002:0> u.valid?
      User Exists (0.2ms)  SELECT  1 AS one FROM "users" WHERE "users"."name" = ? LIMIT ?  [["name", "Foo"], ["LIMIT", 1]]
      User Exists (0.1ms)  SELECT  1 AS one FROM "users" WHERE LOWER("users"."email") = LOWER(?) LIMIT ?  [["email", "foo@bar.com"], ["LIMIT", 1]]
    => true

irb(main):003:0> Post.all
      Post Load (0.2ms)  SELECT  "posts".* FROM "posts" LIMIT ?  [["LIMIT", 11]]
    => #<ActiveRecord::Relation []>

irb(main):004:0> u.save
       (0.2ms)  SAVEPOINT active_record_1
      User Exists (0.3ms)  SELECT  1 AS one FROM "users" WHERE "users"."name" = ? LIMIT ?  [["name", "Foo"], ["LIMIT", 1]]
      User Exists (0.3ms)  SELECT  1 AS one FROM "users" WHERE LOWER("users"."email") = LOWER(?) LIMIT ?  [["email", "foo@bar.com"], ["LIMIT", 1]]
      User Create (0.2ms)  INSERT INTO "users" ("name", "email", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["name", "Foo"], ["email", "foo@bar.com"], ["created_at", "2019-08-30 20:52:33.867957"], ["updated_at", "2019-08-30 20:52:33.867957"]]
       (0.0ms)  RELEASE SAVEPOINT active_record_1
    => true

irb(main):005:0> u
    => #<User id: 1, name: "Foo", email: "foo@bar.com", created_at: "2019-08-30 20:52:33", updated_at: "2019-08-30 20:52:33">

irb(main):006:0> p = Post.new(title: "Post title", body: "post body text", user_id: 1)
    => #<Post id: nil, title: "Post title", body: "post body text", created_at: nil, updated_at: nil, user_id: 1>

irb(main):007:0> p.valid?
      Post Exists (0.3ms)  SELECT  1 AS one FROM "posts" WHERE "posts"."title" = ? LIMIT ?  [["title", "Post title"], ["LIMIT", 1]]
    => false

irb(main):008:0> p.errors.full_messages
    => ["User must exist"]

irb(main):009:0> exit
       (0.4ms)  rollback transaction

mike@mercury:~/code/learning/ruby/scratch_testing/micro-reddit$ e app/models/post.rb &

************

NOTE: After I exit the first run of rails console, I edit post.rb file and uncomment the ', optional: true' portion of the line starting with 'belongs_to' (line 5).

************

- Now re-run rails console:
---------------------------
mike@mercury:~/code/learning/ruby/scratch_testing/micro-reddit$ rails console --sandbox
    Running via Spring preloader in process 30301
    Loading development environment in sandbox (Rails 5.2.3)
    Any modifications you make will be rolled back on exit

irb(main):001:0> User.all
    User Load (0.4ms)  SELECT  "users".* FROM "users" LIMIT ?  [["LIMIT", 11]]
    => #<ActiveRecord::Relation []>

irb(main):002:0> u = User.new(name: "Foo", email: "foo@bar.com")
    => #<User id: nil, name: "Foo", email: "foo@bar.com", created_at: nil, updated_at: nil>

irb(main):003:0> u.valid?
    User Exists (0.1ms)  SELECT  1 AS one FROM "users" WHERE "users"."name" = ? LIMIT ?  [["name", "Foo"], ["LIMIT", 1]]
    User Exists (0.1ms)  SELECT  1 AS one FROM "users" WHERE LOWER("users"."email") = LOWER(?) LIMIT ?  [["email", "foo@bar.com"], ["LIMIT", 1]]
    => true

irb(main):004:0> u.save
    (0.2ms)  SAVEPOINT active_record_1
    User Exists (0.3ms)  SELECT  1 AS one FROM "users" WHERE "users"."name" = ? LIMIT ?  [["name", "Foo"], ["LIMIT", 1]]
    User Exists (0.3ms)  SELECT  1 AS one FROM "users" WHERE LOWER("users"."email") = LOWER(?) LIMIT ?  [["email", "foo@bar.com"], ["LIMIT", 1]]
    User Create (0.5ms)  INSERT INTO "users" ("name", "email", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["name", "Foo"], ["email", "foo@bar.com"], ["created_at", "2019-08-30 20:54:42.011495"], ["updated_at", "2019-08-30 20:54:42.011495"]]
    (0.1ms)  RELEASE SAVEPOINT active_record_1
    => true

irb(main):005:0> p = Post.new(title: "Post title", body: "Post body text", user_id: 1)
    => #<Post id: nil, title: "Post title", body: "Post body text", created_at: nil, updated_at: nil, user_id: 1>

irb(main):006:0> p.valid?
    Post Exists (0.4ms)  SELECT  1 AS one FROM "posts" WHERE "posts"."title" = ? LIMIT ?  [["title", "Post title"], ["LIMIT", 1]]
    => true

irb(main):007:0> User.first.posts
    User Load (0.4ms)  SELECT  "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
    Traceback (most recent call last):
    1: from (irb):7
    NoMethodError (undefined method `posts' for #<User:0x0000564c2935fe50>)
    Did you mean?  Posts
    Posts=

irb(main):008:0> User.first.Posts
    User Load (0.2ms)  SELECT  "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
    Post Load (0.1ms)  SELECT  "posts".* FROM "posts" WHERE "posts"."user_id" = ? LIMIT ?  [["user_id", 1], ["LIMIT", 11]]
    => #<ActiveRecord::Associations::CollectionProxy []>

irb(main):009:0> p.save
    (0.2ms)  SAVEPOINT active_record_1
    Post Exists (0.3ms)  SELECT  1 AS one FROM "posts" WHERE "posts"."title" = ? LIMIT ?  [["title", "Post title"], ["LIMIT", 1]]
    Post Create (0.3ms)  INSERT INTO "posts" ("title", "body", "created_at", "updated_at", "user_id") VALUES (?, ?, ?, ?, ?)  [["title", "Post title"], ["body", "Post body text"], ["created_at", "2019-08-30 20:55:52.454485"], ["updated_at", "2019-08-30 20:55:52.454485"], ["user_id", 1]]
    (0.1ms)  RELEASE SAVEPOINT active_record_1
    => true

irb(main):010:0> User.first.Posts
    User Load (0.3ms)  SELECT  "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
    Post Load (0.2ms)  SELECT  "posts".* FROM "posts" WHERE "posts"."user_id" = ? LIMIT ?  [["user_id", 1], ["LIMIT", 11]]
    => #<ActiveRecord::Associations::CollectionProxy [#<Post id: 1, title: "Post title", body: "Post body text", created_at: "2019-08-30 20:55:52", updated_at: "2019-08-30 20:55:52", user_id: 1>]>

irb(main):011:0> Post.first.Users
    Post Load (0.7ms)  SELECT  "posts".* FROM "posts" ORDER BY "posts"."id" ASC LIMIT ?  [["LIMIT", 1]]
    Traceback (most recent call last):
    1: from (irb):11
    NoMethodError (undefined method `Users' for #<Post:0x0000564c29452510>)
    Did you mean?  User
    User=

irb(main):012:0> Post.first.User
    Post Load (0.2ms)  SELECT  "posts".* FROM "posts" ORDER BY "posts"."id" ASC LIMIT ?  [["LIMIT", 1]]
    => nil

irb(main):013:0> exit
       (0.4ms)  rollback transaction

***************

Note: The second run of rails console shows the newly created post as valid (only after changing belongs_to :User to be optional in post.rb)
      - I don't think that it should need to be optional for the new post to be valid
      
Note: The last command (Post.first.User) returns nil, but it's supposed to return the user that was saved (?!?)

***************



# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
s
* ...
