module LittleWheels
  VERSION = "0.0.7"

  module Component
    def t(template, **locals)
      renderer.render(inline: template, locals:)
    end

    def t!(template, **locals)
      renderer.render(template, locals:, layout: nil)
    end
    
    def x
      renderer.helpers.tag
    end

    def o(&block)
      block.binding.receiver.capture(&block)
    end

    def +(other)
      o { [to_s, other].join }
    end

    def to_s
      renderer.helpers.capture do
        if self.class.const_defined?(:TEMPLATE) 
          t(self.class.const_get(:TEMPLATE), c: self, x: self.x ) 
        else
          t!(default_template_name, c: self, x: self.x )
        end
      end
    end

    def to_str
      to_s
    end

    def accepts_slot(block)
      @_slot = block
    end

    def slot
      context = @_slot.binding.receiver

      context.capture(&@_slot)
    end

    def renderer
      ApplicationController
    end

    def default_template_name
      "shared/#{self.class.name.underscore}"
    end

    def capture(&block)
      block.call.to_s.html_safe
    end
  end
end