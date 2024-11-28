# These components would live in one or several seperate gems.
# This is just to test reusabiltiy via a gem.

module LittleWheels
  module UI
    module Bootstrap
      class Alert < LittleWheels::Component
        def initialize(message, variant: "primary", dismissable: false)
          @message     = message
          @variant     = variant
          @dismissable = dismissable
        end

        def alert_class_list
          class_list = ["alert", "alert-#{@variant}"]
          class_list << "alert-dismissable" if @dismissable

          class_list.join(" ")
        end

        TEMPLATE = <<-EOS
          <div class="<%= c.alert_class_list %>" role="alert">
            <%= c.message %>
          </div>
        EOS
      end
    end
  end
end