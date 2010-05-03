# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_cothink_convo_app_session',
  :secret      => '62652c1f12fdec5e5ff5d65ef349a1741ba2284eddfc399c9458247a6f7fbff51ab982544199649323954b855e307d46e5d1c9b7694f90f9c50da693812de416'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
