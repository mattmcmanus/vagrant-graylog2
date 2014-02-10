## Start the server

    sudo service elasticsearch start
    sudo /etc/init.d/graylog2ctl start
    sudo /opt/graylog2-web-interface-0.20.0-preview.8/bin/graylog2-web-interface

Go to [http://localhost:9000/](http://localhost:9000/)

Credentials: admin/promptworks

Configure the UDP source by going here: 
[http://localhost:9000/system/nodes](http://localhost:9000/system/nodes)

Action (Dropdown) -> Manage Inputs

Select GELF UDP, Launch New Input

Give it a name, and click Launch.  DO NOT PRESS ENTER.  IT WILL PULL A JIRA AND SUCK.


## Notes for non-vagrant installs

The files needed for the install are all in the repo. The bootstrap script assumes they all will be accessible at `/vagrant/`. Either put the files there or adjust the script accordingly

## Debugging
If you aren't getting any logging messages, load the VirtualBox ui, and verify the ports are configured.  You can verify that things work from within the box with the following ruby script.  (Bear in mind this is ruby 1.8.7)


    sudo gem install gelf

```ruby
require 'rubygems'
require 'gelf'

host = "localhost"
port = 12201
logger = GELF::Logger.new(host, port, 'WAN', :facility => 'jeff-drools')

logger.notify(short_message: "jeff drools", _jobid: 123)
```
