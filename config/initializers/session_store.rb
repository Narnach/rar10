# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rar10_session',
  :secret      => 'a24e6c1d91f71d1e7d0dedaae889673459e5702d805e782d4b8d8addebceaace16dd9ce61dda512a2c17326968c1f96e4a5b3e9118555093550fe35289598dc7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
