module LittleWheels
  VERSION = "0.0.2"

  class Component
    def t(template, **locals)
      renderer.render(:inline => template, locals:)
    end

    def t!(template, **locals)
      renderer.render(template, locals:)
    end

    def renderer
      ApplicationController
    end
  end
end