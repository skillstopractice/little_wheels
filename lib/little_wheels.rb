module LittleWheels
  VERSION = "0.0.11"

  def self.renderer
    ApplicationController
  end

  def self.helpers
    renderer.helpers
  end

  class Buffer
    def initialize(string)
      @string = string.html_safe
    end

    def +(other)
      self.class.new(@string + other.to_s)
    end

    def to_s
      @string
    end
  end

  module Component
    def t(template, **locals)
      renderer.render(inline: template, locals:)
    end

    def t!(template, **locals)
      renderer.render(template, locals:, layout: nil)
    end

    def x
      helpers.tag
    end

    def o(&block)
      block.binding.receiver.capture(&block)
    end

    def +(other)
      Buffer.new(to_s + other.to_s)
    end

    def to_s
      helpers.capture do
        if self.class.const_defined?(:TEMPLATE)
          t(self.class.const_get(:TEMPLATE), c: self, x: self.x )
        else
          t!(default_template_name, c: self, x: self.x )
        end
      end
    end

    def accepts_slot(block)
      @_slot = block
    end

    def slot
      context = @_slot.binding.receiver

      context.capture(&@_slot)
    end

    def renderer
      LittleWheels.renderer
    end

    def helpers
      LittleWheels.helpers
    end

    def default_template_name
      "shared/#{self.class.name.underscore}"
    end

    def capture(&block)
      block.call.to_s.html_safe
    end

    def render_in(context)
      context.render(:inline => to_s)
    end
  end
end
