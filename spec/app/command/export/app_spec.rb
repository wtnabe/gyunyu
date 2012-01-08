# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../../../spec_helper'

describe Gyunyu::Command::Export::App do
  let(:app) { Gyunyu::Command::Export::App.new }

  describe 'build_filter' do
    subject {
      app.build_filter
    }

    context 'multiple list' do
      before {
        app._init_option( %w( -l 仕事 -l 個人 ) )
      }
      it {
        should == '(list:仕事 or list:個人)'
      }
    end
    context 'custom filter and list' do
      before {
        Gyunyu::Command::Export::CustomFilter.class_eval {
          def self.today
            Date.parse('2012-01-05')
          end
        }
        app._init_option( %w( -l 仕事 -c this_week ) )
      }
      it {
        should == '(list:仕事) and (dueAfter:2011-12-31T23:59:59Z and dueBefore:2012-01-07T24:00:00Z)'
      }
    end
    context 'multiple list and filter' do
      before {
        app._init_option( %w( -l 仕事 -l 個人 -f status:completed ) )
      }
      it {
        should == '(list:仕事 or list:個人) and (status:completed)'
      }
    end
  end
end
