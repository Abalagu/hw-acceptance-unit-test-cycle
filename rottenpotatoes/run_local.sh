bundle install --without production
bundle exec rake db:migrate
bundle exec rake db:test:prepare
bundle exec rake db:setup
rails server -p $PORT -b $IP
