module LittleWheels
  VERSION = "0.0.6"

  class Component
    def t(template, **locals)
      renderer.render(inline: template, locals:)
    end

    def t!(template, **locals)
      renderer.render(template, locals:, layout: nil)
    end
    
    def x
      renderer.helpers.tag
    end

    def to_s
      renderer.helpers.capture do
        if self.class.const_defined?(:TEMPLATE) 
          t(self.class.const_get(:TEMPLATE), c: self, x: self.x ) 
        else
          t!("shared/#{default_template_name}", c: self, x: self.x )
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
      ApplicationController
    end

    def default_template_name
      self.class.name.underscore
    end
  end
end