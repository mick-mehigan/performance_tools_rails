module PerformanceToolsRails
  class Engine < ::Rails::Engine
    isolate_namespace PerformanceToolsRails

    require 'performance_tools_rails/application_controller_helper'
  end
end
