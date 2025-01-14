# frozen_string_literal: true

module SlashCommand
  module Commands
    class In < Template
      NAME = "in"
      DESC = "This command will start a new activity."
      HELP = "Start the timer for a new activity. Usage: `/tt in [NOTE]"

      EMPTY_NOTE_MSG = "You need a note to this activity!"
      NEW_ACTIVITY_CREATED = "You have just started working on a new activity. Keep going."
      STOPED_LAST_CREATED_NEW = "The previous activity was stopped and the next one just started."

      def call
        response.result = result
      end

      private

      def result
        return EMPTY_NOTE_MSG if data.blank?

        create_activity
      end

      def create_activity
        message = if user.stop_running_activity
                    STOPED_LAST_CREATED_NEW
                  else
                    NEW_ACTIVITY_CREATED
                  end

        user.build_time_entry(note: data).tap(&:save)

        message
      end
    end
  end
end
