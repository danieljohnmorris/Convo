class IndexController < ApplicationController
  def index
    @thread = Email.find(:all, :conditions => "subject LIKE '%in the loop%'", :order => "created_at DESC")
    
    @addresses = []
    @thread.collect do |e| 

      e.all_addresses.each do |ea|
        found = false

        @addresses.each do |a|          
          if a && a[:address] == ea
            a[:count] += 1
            found = true
          end          
        end
        
        @addresses << {:address => ea, :count => 1} unless found    
      end
    end
    @address_names = @addresses.map { |a| a[:address].address }.join("|")
    @address_values = @addresses.map { |a| a[:count] }.join(",")
  end

end
