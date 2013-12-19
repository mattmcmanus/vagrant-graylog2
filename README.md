## Start the server

    sudo /etc/init.d/graylog2ctl start
    sudo /opt/graylog2-web-interface-0.20.0-preview.8/bin/graylog2-web-interface

Go to http://localhost:9000/

Credentials: admin/promptworks

## Notes for non-vagrant installs

The files needed for the install are all in the repo. The bootstrap script assumes they all will be accessible at `/vagrant/`. Either put the files there or adjust the script accordingly
