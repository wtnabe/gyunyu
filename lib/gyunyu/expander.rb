module Gyunyu
  module Expander
    class << self
      #
      # [param]  Array or Hash taskseries
      # [return] Array
      #
      def taskseries( list )
        expanded = []

        if list.is_a?( Hash ) and list.has_key?( 'taskseries' )
          list = list['taskseries']
        end

        list.each { |series|
          expanded += tasks( series )
        }

        expanded
      end

      #
      # [param]  Hash taskseries
      # [return] Array
      #
      def tasks( taskseries )
        task = Marshal.load( Marshal.dump( taskseries ) )
        task.delete('id')
        task.delete('task')
        task['taskseries_id'] = taskseries['id']

        taskseries['task'].map { |t|
          t['task_id'] = t['id']
          t.delete( 'id' )
          task.merge( t )
        }
      end
    end # of << self
  end
end
