module Gyunyu
  module Command
    module Export
      module TotalEstimate
        def sum_estimate( tasks, fields )
          if have_estimate_fields?( fields )
            sum = {}; estimate_fields.map { |f| sum[f] = 0 }

            tasks.each { |t|
              fields.grep(/\Aestimate/).each { |f|
                sum[f] += t[f].to_i
              }
            }
            @total_estimate = moveup_minute( sum )
          end
        end

        #
        # [param]  Hash sum
        # [return] Hash
        #
        def moveup_minute( sum )
          movedup_hour            =  sum[App::ESTIMATE_MIN] / 60
          sum[App::ESTIMATE_HOUR] += movedup_hour
          sum[App::ESTIMATE_MIN]  =  sum[App::ESTIMATE_MIN] - movedup_hour * 60
          sum
        end

        def have_estimate_fields?( fields )
          estimate_fields & fields == estimate_fields
        end

        def estimate_fields
          App.constants.map(&:to_s).grep(/\AESTIMATE/).map { |e|
            App.const_get(e)
          }
        end
      end
    end
  end
end
