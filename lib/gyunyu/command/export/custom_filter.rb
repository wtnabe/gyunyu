module Gyunyu
  module Command
    module Export
      module CustomFilter
        START_SECOND = 'T23:59:59Z'
        LAST_SECOND  = 'T24:00:00Z'

        class << self
          def today
            Date.today
          end

          def filter
            filter = {}

            %w( yesterday today tomorrow last_week this_week next_week
                last_month this_month next_month ).each { |term|
              due = [
                "dueAfter:" + send("from_#{term}"),
                "dueBefore:" + send("until_#{term}")
              ].join( ' and ' )
              filter[term] = due
              filter["#{term}_yet"] = due + incomplete
            }

            filter
          end

          def last_sunday
            if today.sunday?
              today - 7
            else
              proc { |d|
                until d.sunday?
                  d -= 1
                end
                d
              }.call(today)
            end
          end

          def next_sunday
            if today.sunday?
              today + 7
            else
              proc { |d|
                until d.sunday?
                  d += 1
                end
                d
              }.call(today)
            end
          end

          def from_yesterday
            (today - 2).to_s + START_SECOND
          end

          def until_yesterday
            (today - 1).to_s + LAST_SECOND
          end

          def from_today
            (today - 1).to_s + START_SECOND
          end

          def until_today
            today.to_s + LAST_SECOND
          end

          def from_tomorrow
            today.to_s + START_SECOND
          end

          def until_tomorrow
            (today + 1).to_s + LAST_SECOND
          end

          def from_last_week
            if today.sunday?
              (last_sunday - 1).to_s + START_SECOND
            else
              (last_sunday - 8).to_s + START_SECOND
            end
          end

          def until_last_week
            if today.sunday?
              (today - 1).to_s + LAST_SECOND
            else
              (last_sunday - 1).to_s + LAST_SECOND
            end
          end

          def from_this_week
            if today.sunday?
              (today - 1).to_s + START_SECOND
            else
              (last_sunday - 1).to_s + START_SECOND
            end
          end

          def until_this_week
            (next_sunday - 1).to_s + LAST_SECOND
          end

          def from_next_week
            (next_sunday - 1).to_s + START_SECOND
          end

          def until_next_week
            (next_sunday + 6).to_s + LAST_SECOND
          end

          def from_last_month
            d = today << 2
            Date.new( d.year, d.mon, -1 ).to_s + START_SECOND
          end

          def until_last_month
            d = today << 1
            Date.new( d.year, d.mon, -1 ).to_s + LAST_SECOND
          end

          def from_this_month
            d = today << 1
            Date.new( d.year, d.mon, -1 ).to_s + START_SECOND
          end

          def until_this_month
            d = today
            Date.new( d.year, d.mon, -1 ).to_s + LAST_SECOND
          end

          def from_next_month
            d = today
            Date.new( d.year, d.mon, -1 ).to_s + START_SECOND
          end

          def until_next_month
            d = today >> 1
            Date.new( d.year, d.mon, -1 ).to_s + LAST_SECOND
          end

          def incomplete
            ' and status:incomplete'
          end
        end
      end
    end
  end
end
