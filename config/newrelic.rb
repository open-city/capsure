# Here are the settings that are common to all environments
common: &default_settings
  # ============================== LICENSE KEY ===============================

  # You must specify the license key associated with your New Relic
  # account.  This key binds your Agent's data to your account in the
  # New Relic service.
  license_key: '<%= ENV["NEW_RELIC_LICENSE_KEY"] %>'
  
  # Agent Enabled (Rails Only)
  # Use this setting to force the agent to run or not run.
  # Default is 'auto' which means the agent will install and run only
  # if a valid dispatcher such as Mongrel is running.  This prevents
  # it from running with Rake or the console.  Set to false to
  # completely turn the agent off regardless of the other settings.
  # Valid values are true, false and auto.
  #
  # agent_enabled: auto
  
  # Application Name Set this to be the name of your application as
  # you'd like it show up in New Relic. The service will then auto-map
  # instances of your application into an "application" on your
  # dashboard page. If you want to map this instance into multiple
  # apps, like "AJAX Requests" and "All UI" then specify a semicolon
  # separated list of up to three distinct names, or a yaml list.
  # Defaults to the capitalized RAILS_ENV or RACK_ENV (i.e.,
  # Production, Staging, etc)
  #
  # Example:
  #
  #   app_name:
  #       - Ajax Service
  #       - All Services
  # 
  app_name: <%= ENV["NEW_RELIC_APP_NAME"] %>

  # When "true", the agent collects performance data about your 
  # application and reports this data to the New Relic service at 
  # newrelic.com. This global switch is normally overridden for each 
  # environment below. (formerly called 'enabled')
  monitor_mode: true

  # Developer mode should be off in every environment but
  # development as it has very high overhead in memory.
  developer_mode: false

  # The newrelic agent generates its own log file to keep its logging
  # information separate from that of your application.  Specify its
  # log level here.
  log_level: info

  # Optionally set the path to the log file This is expanded from the
  # root directory (may be relative or absolute, e.g. 'log/' or
  # '/var/log/') The agent will attempt to create this directory if it
  # does not exist.
  # log_file_path: 'log'
  
  # Optionally set the name of the log file, defaults to 'newrelic_agent.log'
  # log_file_name: 'newrelic_agent.log'

  # The newrelic agent communicates with the service via http by
  # default.  If you want to communicate via https to increase
  # security, then turn on SSL by setting this value to true.  Note,
  # this will result in increased CPU overhead to perform the
  # encryption involved in SSL communication, but this work is done
  # asynchronously to the threads that process your application code,
  # so it should not impact response times.
  ssl: false

  # EXPERIMENTAL: enable verification of the SSL certificate sent by
  # the server. This setting has no effect unless SSL is enabled
  # above. This may block your application. Only enable it if the data
  # you send us needs end-to-end verified certificates.
  #
  # This means we cannot cache the DNS lookup, so each request to the
  # service will perform a lookup. It also means that we cannot
  # use a non-blocking lookup, so in a worst case, if you have DNS
  # problems, your app may block indefinitely.
  # verify_certificate: true
  
  # Set your application's Apdex threshold value with the 'apdex_t'
  # setting, in seconds. The apdex_t value determines the buckets used
  # to compute your overall Apdex score. 
  # Requests that take less than apdex_t seconds to process will be
  # classified as Satisfying transactions; more than apdex_t seconds
  # as Tolerating transactions; and more than four times the apdex_t
  # value as Frustrating transactions. 
  # For more about the Apdex standard, see
  # http://newrelic.com/docs/general/apdex

  apdex_t: 0.5
  
  #============================== Browser Monitoring ===============================
  # New Relic Real User Monitoring gives you insight into the performance real users are
  # experiencing with your website. This is accomplished by measuring the time it takes for
  # your users' browsers to download and render your web pages by injecting a small amount
  # of JavaScript code into the header and footer of each page. 
  browser_monitoring:
      # By default the agent automatically injects the monitoring JavaScript 
      # into web pages. Set this attribute to false to turn off this behavior.
      auto_instrument: true

  # Proxy settings for connecting to the service.
  #
  # If a proxy is used, the host setting is required.  Other settings
  # are optional.  Default port is 8080.
  #
  # proxy_host: hostname
  # proxy_port: 8080
  # proxy_user:
  # proxy_pass:

  
  # Tells transaction tracer and error collector (when enabled)
  # whether or not to capture HTTP params.  When true, frameworks can
  # exclude HTTP parameters from being captured.
  # Rails: the RoR filter_parameter_logging excludes parameters
  # Java: create a config setting called "ignored_params" and set it to
  #     a comma separated list of HTTP parameter names.
  #     ex: ignored_params: credit_card, ssn, password 
  capture_params: false


  # Transaction tracer captures deep information about slow
  # transactions and sends this to the service once a
  # minute. Included in the transaction is the exact call sequence of
  # the transactions including any SQL statements issued.
  transaction_tracer:
  
    # Transaction tracer is enabled by default. Set this to false to
    # turn it off. This feature is only available at the Professional
    # and above product levels.
    enabled: true
    
    # Threshold in seconds for when to collect a transaction
    # trace. When the response time of a controller action exceeds
    # this threshold, a transaction trace will be recorded and sent to
    # the service. Valid values are any float value, or (default)
    # "apdex_f", which will use the threshold for an dissatisfying
    # Apdex controller action - four times the Apdex T value.
    transaction_threshold: apdex_f
 
    # When transaction tracer is on, SQL statements can optionally be
    # recorded. The recorder has three modes, "off" which sends no
    # SQL, "raw" which sends the SQL statement in its original form,
    # and "obfuscated", which strips out numeric and string literals
    record_sql: obfuscated
    
    # Threshold in seconds for when to collect stack trace for a SQL
    # call. In other words, when SQL statements exceed this threshold,
    # then capture and send the current stack trace. This is
    # helpful for pinpointing where long SQL calls originate from
    stack_trace_threshold: 0.500

    # Determines whether the agent will capture query plans for slow
    # SQL queries.  Only supported in mysql and postgres.  Should be
    # set to false when using other adapters.
    # explain_enabled: true

    # Threshold for query execution time below which query plans will not 
    # not be captured.  Relevant only when `explain_enabled` is true.
    # explain_threshold: 0.5
  
  # Error collector captures information about uncaught exceptions and
  # sends them to the service for viewing
  error_collector:
    
    # Error collector is enabled by default. Set this to false to turn
    # it off. This feature is only available at the Professional and above
    # product levels
    enabled: true
    
    # Rails Only - tells error collector whether or not to capture a 
    # source snippet around the place of the error when errors are View 
    # related.
    capture_source: true    
    
    # To stop specific errors from reporting to New Relic, set this property
    # to comma separated values.  Default is to ignore routing errors
    # which are how 404's get triggered.
    #
    ignore_errors: ActionController::RoutingError

  # (Advanced) Uncomment this to ensure the cpu and memory samplers
  # won't run.  Useful when you are using the agent to monitor an
  # external resource
  # disable_samplers: true
  
  # If you aren't interested in visibility in these areas, you can
  # disable the instrumentation to reduce overhead.
  #
  # disable_view_instrumentation: true
  # disable_activerecord_instrumentation: true
  # disable_memcache_instrumentation: true
  # disable_dj: true

  # If you're interested in capturing memcache keys as though they
  # were SQL uncomment this flag. Note that this does increase
  # overhead slightly on every memcached call, and can have security
  # implications if your memcached keys are sensitive
  # capture_memcache_keys: true
  
  # Certain types of instrumentation such as GC stats will not work if 
  # you are running multi-threaded.  Please let us know.
  # multi_threaded = false

# Application Environments
# ------------------------------------------
# Environment specific settings are in this section.
# For Rails applications, RAILS_ENV is used to determine the environment
# For Java applications, pass -Dnewrelic.environment <environment> to set
# the environment

# NOTE if your application has other named environments, you should
# provide newrelic configuration settings for these environments here.

development:
  <<: *default_settings
  # Turn off communication to New Relic service in development mode (also 
  # 'enabled').
  # NOTE: for initial evaluation purposes, you may want to temporarily 
  # turn the agent on in development mode.
  monitor_mode: false

  # Rails Only - when running in Developer Mode, the New Relic Agent will 
  # present performance information on the last 100 transactions you have
  # executed since starting the mongrel.
  # NOTE: There is substantial overhead when running in developer mode.
  # Do not use for production or load testing.  
  developer_mode: true
  
  # Enable textmate links
  # textmate: true

test:
  <<: *default_settings
  # It almost never makes sense to turn on the agent when running
  # unit, functional or integration tests or the like.
  monitor_mode: false

# Turn on the agent in production for 24x7 monitoring.  NewRelic
# testing shows an average performance impact of < 5 ms per
# transaction, you you can leave this on all the time without
# incurring any user-visible performance degradation.
production:
  <<: *default_settings
  monitor_mode: true

# Many applications have a staging environment which behaves
# identically to production.  Support for that environment is provided
# here.  By default, the staging environment has the agent turned on.
staging:
  <<: *default_settings
  monitor_mode: true
  app_name: <%= ENV["NEW_RELIC_APP_NAME"] %> (Staging)
