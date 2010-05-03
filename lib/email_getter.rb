# pop email retrieval
require 'net/pop'
require 'tmail_body_extractors/tmail_mail_extension'

class EmailGetter < ActionMailer::Base
  @queue = :get_mail

  attr_accessor :imap
  
  def receive(email)
    return email
  end
  
  def self.perform()
    # puts "worker start"
    
    self.load_config

    Net::POP3.enable_ssl(OpenSSL::SSL::VERIFY_NONE)
    Net::POP3.start(@config[:pop_host], @config[:pop_port], @config[:username], @config[:password]) do |pop|
      if pop.mails.empty?
        puts "email_getter: No mail. @ #{Time.now}"
      else
        # puts "email_getter: #{pop.mails.length} new"

        pop.each_mail do |email|
          str = email.pop
          
          ob = EmailGetter.receive(str)

          db_e = Email.create(:subject => ob.subject, :body_plain => ob.body_plain, :body_html => ob.body_html, :origional => str)
          
          associate_addresses(db_e, ob.to_addrs, "to")
          associate_addresses(db_e, ob.cc_addrs, "cc")
          associate_addresses(db_e, ob.from_addrs, "from")
          associate_addresses(db_e, ob.bcc_addrs, "bcc")
          
          puts "email_getter: '#{ob.subject}' @ #{Time.now}"
        end
      end
    end
    
    # puts "worker end"
  end

  def self.associate_addresses(db_e, addresses_tmail, context_str)
    addresses_tmail.uniq.each do |address_tmail|
      self.associate_address(db_e, address_tmail, context_str)
    end if addresses_tmail
  end
  
  def self.associate_address(db_e, address_tmail, context_str)
    # try to find
    db_a = EmailAddress.find_by_address(address_tmail.address)
    
    # create if new
    unless db_a
      db_a = EmailAddress.create(:name => address_tmail.name, :address => address_tmail.address)
    end
    
    # associate
    Relation.create(:email_address_id => db_a.id, :email_id => db_e.id, :context => context_str)
  end
  
  def self.load_config
    @config = YAML.load_file("#{RAILS_ROOT}/config/mail_daemon.yml")
    @config = @config[RAILS_ENV].to_options
    
    @config
  end
end
