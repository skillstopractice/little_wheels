module LittleWheels
  VERSION = "0.0.5"

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
      if self.class.const_defined?("TEMPLATE") 
        t(self.class.const_get("TEMPLATE"), c: self, x: self.x, slot: slot ) 
      else
        t!("shared/#{default_template_name}", c: self, x: self.x, slot: slot )
      end
    end

    def accepts_slot(block)
      @_slot = block
    end

    def slot
      @_slot.call.to_s
    end

    def renderer
      ApplicationController
    end

    def default_template_name
      self.class.name.underscore
    end
  end
end