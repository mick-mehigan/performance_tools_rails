module PerformanceToolsRails
  module ApplicationControllerHelper
    def self.included(base)
      base.before_filter :display_action_name, :start_exception_trace, :start_memory_profile
      base.after_filter :finish_exception_trace, :finish_memory_profile
    end

    private

    def start_memory_profile
      PerformanceTools::MemoryProfiler.start
    end

    def finish_memory_profile
      PerformanceTools::MemoryProfiler.finish
    end

    def start_exception_trace
      PerformanceTools::ExceptionTrace.start
    end

    def finish_exception_trace
      PerformanceTools::ExceptionTrace.finish
    end

    def display_action_name
      if Rails.env.development?
        puts ''
        puts '[Controller Action] ' + self.class.name + '#' + action_name
      end
    end
  end
end

ActionController::Base.include PerformanceToolsRails::ApplicationControllerHelper
