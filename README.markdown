Sinatra Diddies
===============

All those handy tunes in one elegant package.

Sinatra::Mailer
===============

Adds an `email` method to your email handlers, that receives a hash of values
to create your email.

For example:

    post "/signup" do
      # sign up the user, and then:
      email :to      => @user.email, 
            :from    => "awesomeness@example.com", 
            :subject => "Welcome to Awesomeness!",
            :body    => haml(:some_template)
    end

Configuration
=============

This plugin is very dirty yet :) Since it's just a port to Sinatra of
[Merb::Mailer][merb-mailer]. So the configuration is not Sinatra-y, yet.
But we'll get to that. 

Using SMTP
----------

    Sinatra::Mailer.config = {
      :host   => 'smtp.yourserver.com',
      :port   => '25',
      :user   => 'user',
      :pass   => 'pass',
      :auth   => :plain # :plain, :login, :cram_md5, the default is no auth
      :domain => "localhost.localdomain" # the HELO domain provided by the client to the server
    }

Using Gmail SMTP
----------------

You need [smtp-tls][], a gem that improves `net/smtp` to add support for secure
servers such as Gmail.

    require "smtp-tls"
    
    Sinatra::Mailer.config = {
      :host => 'smtp.gmail.com',
      :port => '587',
      :user => 'user@gmail.com',
      :pass => 'pass',
      :auth => :plain
    }
    
Make sure that when you call your `email` method you pass the `:text` option 
and not `:body`.

Using sendmail
--------------

    Sinatra::Mailer.config = {:sendmail_path => '/somewhere/odd'}
    Sinatra::Mailer.delivery_method = :sendmail

Credits
=======

This has been blatantly adapted from [Merb::Mailer][merb-mailer], so all credit
is theirs, I just ported it to [Sinatra][].

[merb-mailer]: http://github.com/wycats/merb-more/tree/master/merb-mailer
[smtp-tls]: http://github.com/ambethia/smtp-tls/tree/master
[Sinatra]: http://sinatrarb.com
