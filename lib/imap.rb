require 'net/imap'

# monkeypatch to support idle behaviour

class Net::IMAP
 def idle(&response_handler)
   puts "idling"
   
   raise LocalJumpError, "no block given" unless response_handler

   response = nil

   synchronize do
     tag = Thread.current[:net_imap_tag] = generate_tag
     cmd = "IDLE"
     put_string "#{tag} #{cmd}#{CRLF}"

     add_response_handler response_handler

     begin
       response = get_tagged_response(tag, cmd)

     rescue LocalJumpError # can't break cross-threads or something

     ensure
       unless response then
         cmd = "DONE"
         put_string "#{cmd}#{CRLF}"
         response = get_tagged_response(tag, cmd)
       end

       remove_response_handler response_handler
     end
   end

   response
 end
end