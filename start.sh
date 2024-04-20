set -e

rm -f tmp/pids/server.pid

bundle check || bundle install

if bundle exec rails db:exists; then
  bundle exec rails db:migrate
else
  bundle exec rails db:create
  bundle exec rails db:migrate
  bundle exec rails db:seed
fi

bundle exec rails s -p 3000 -b 0.0.0.0
