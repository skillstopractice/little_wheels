module LittleWheels
  VERSION = "0.0.3"

  class Component
    def t(template, **locals)
      renderer.render(inline: template, locals:)
    end

    def t!(template, **locals)
      renderer.render(template, locals:, layout: nil)
    end

    def to_s
      t!("shared/#{name}", c: self)
    end

    def renderer
      ApplicationController
    end

    def name
      self.class.name.underscore
    end
  end
end