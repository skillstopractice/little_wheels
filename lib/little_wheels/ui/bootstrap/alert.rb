# These components would live in one or several seperate gems.
# This is just to test reusabiltiy via a gem.

module LittleWheels
  module UI
    module Bootstrap
      class Alert < LittleWheels::Component
        def initialize(message, variant: "primary")
          @message     = message
          @variant     = variant

          @class_list  = ["alert", "alert-#{@variant}"].join("  ")
        end

        attr_reader :message, :variant, :class_list

        TEMPLATE = <<-EOS
          <div class="<%= c.class_list %>" role="alert">
            <%= c.message %>
          </div>
        EOS
      end
    end
  end
end