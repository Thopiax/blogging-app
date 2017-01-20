# Best Blogging Service

This is the Best Blogging Service. It is a simple, yet beautiful service that
allows you to put all your thoughts into words and much more!

### Getting it to run
Run the application in 6 simple steps:
  1. Open you terminal and go to the root directory of the app. This application runs on Rails 5.0.1, you might need to download that in order to get it working properly.
  2. Run `bundle install` to install all the gems needed by the application.
  3. Run `rake db:create` followed by `rake db:migrate` to set up the database.
  4. Run `rails server`.
  5. Open your favorite web browser to `http://localhost:3000`
  6. Voila!

### Testing it
Test the application easily:
  1. Open your terminal once again in the root directory of the app. Make sure you have ran the commands above and that they are working properly.
  2. Run `./test.sh`
  3. You should see rubocop tests as well as rspec tests running. If you don't make sure the files permissions are properly set by running `chmod +x test.sh` while still in the root directory of the application.
