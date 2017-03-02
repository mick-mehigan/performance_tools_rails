# PerformanceToolsRails

## Installation

Add this line to your application's Gemfile:

```ruby
group :development, :test do
  gem 'performance_tools', git: 'git@github.com:mick-mehigan/performance_tools.git', branch: 'master'
  gem 'performance_tools_rails', git: 'git@github.com:mick-mehigan/performance_tools_rails.git', branch: 'master'
end
```

And then execute:

    $ bundle

Open your application's `config/routes.rb` file, and add this line:

```ruby
  mount PerformanceToolsRails::Engine => '/performance_tools', as: :performance_tools
```

It is recommended to quieten your rails server console, so open `config/environments/development.rb`, and set the `log_level` flag

```ruby
# config/environments/development.rb

YourApplication::Application.configure do
....
  config.log_level = :error
end
```

## Usuage

### MemoryProfile Mode

By default, PerformanceTools works in memory profile mode.

Launch your Rails application as normal, and notice the rails server console will dump information in this form
```
    [Controller Action] WelcomeController#index
    +--------+---------+
    | Object | Count   |
    +--------+---------+
    | object |   8,677 |
    | class  |      47 |
    | string |  91,073 |
    | regexp |      24 |
    | array  |  24,484 |
    | hash   |   2,871 |
    | struct |     197 |
    | file   |      37 |
    | data   |   6,629 |
    | match  |   2,707 |
    | symbol |       4 |
    | imemo  |  12,528 |
    | iclass |      26 |
    +--------+---------+
    | Total  | 149,304 |
    +--------+---------+
```
This output is a synopsis of the number of ruby objects your application creates while processing a request.

A Blank Page template is provided to allow you get a baseline metric.
The URL for the blank page is

    http://your-application.lvh.me:3000/performance_tools/performance_tests

Navigating to this URL will report a memory profile like this:

```
[Controller Action] PerformanceToolsRails::TestsController#index
+--------+---------+
| Object | Count   |
+--------+---------+
| object |  11,602 |
| class  |      24 |
| module |       3 |
| string | 107,703 |
| regexp |     848 |
| array  |  66,820 |
| hash   |  22,710 |
| struct |     826 |
| bignum |       3 |
| file   |      28 |
| data   |   4,880 |
| match  |   5,379 |
| imemo  |  74,422 |
| node   |     282 |
| iclass |      25 |
+--------+---------+
| Total  | 295,555 |
+--------+---------+
```

### Exception Trace mode

You can switch to ExceptionTrace mode by adding this block to the `config/environments/development.rb` file

```ruby
# config/environments/development.rb

YourApplication::Application.configure do
  ....
  config.log_level = :error
end

# add this block to control which mode PerformanceTools operates in
PerformanceTools.configure do |config|
  config.memory_profiler_on = false   # switch off Memory Profiling
  config.exception_trace_on = true    # switch on Exception Trace
end
```

Save your changes. Stop and restart your application's rail server. Log in to your application, and note the rails server console now spits out content such as this:

```
    [Controller Action] WelcomeController#index
    [Exception] Timeout::Error - execution expired => 3
    [Exception] NewRelic::Agent::LicenseException - Invalid license key, please contact support@newrelic.com => 1
```

This shows the exceptions that have been raised and rescued while processing a request. The number to the right of the `=>` indicates how many times that particular exception has been raised.
Rails applications typically raise a number of different exceptions while processing requests.
If the number to the right of the `=>` is low, say fewer than `5`, one shouldn't be too concerned.
But if one exception has been raised serveral hundred times, it is a clear indication that you application logic can be altered to improve the performance of your application by dealing with the exception at source.
