module Ramaze
  module Informing
    def tag_inform(tag, meth, *strings)
      strings.each do |string|
        inform(tag, string.send(meth))
      end
    end

    def info(*strings)
      tag_inform(:info, :to_s, *strings)
    end

    def warn(*strings)
      tag_inform(:warn, :to_s, *strings)
    end

    def debug(*strings)
      tag_inform(:debug, :inspect, *strings)
    end

    alias << debug

    def error(ex)
      if ex.respond_to?(:exception)
        message = ex.backtrace[0..Global.backtrace_size]
        message.unshift(ex.inspect)
      else
        message = ex.to_s
      end
      tag_inform(:error, :to_s, *message)
    end

    def inform(*args)
      raise "#inform should be implemented by an instance including this module (#{self})"
    end

    def shutdown
    end
  end
end
