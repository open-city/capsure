# CAPSure

Chicago Alternative Policing Strategy meetings, or CAPS meetings, are occasional sit-downs between the Chicago Police Department and Chicago residents. These meetings are the place to meet the cops that work in your beat, chat about local problems, and work together to fix them.

CAPSure helps you find out when and where your next meeting is, in an effort to get more Chicagoans involved in community policing.

## Installation

``` bash
git clone git@github.com:open-city/capsure.git
cd capsure
gem install bundler
bundle install
rake db:setup
rake import:all
```

``` bash
foreman start
```

navigate to http://localhost:5000/

## Dependencies

* Rails 3.2.13
* Ruby 1.9.3-p194
* Haml
* Heroku
* Twitter Bootstrap
* Google Fusion Tables

## Team

* [Derek Eder](mailto:derek.eder+git@gmail.com)
* Nick Doiron
* Forest Gregg
* Aya O'Connor

## Errors / Bugs

If something is not behaving intuitively, it is a bug, and should be reported.
Report it here: https://github.com/open-city/capsure/issues

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Commit, do not mess with rakefile, version, or history.
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2013 Open City. Released under the MIT License.
