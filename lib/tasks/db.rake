namespace :db do
  desc "Drop, recreate, migrate and seed the database"
  task :regenerate => %w[db:drop db:create db:migrate db:seed]
end