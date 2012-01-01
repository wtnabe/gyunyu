# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../../../spec_helper'

describe Gyunyu::Command::Export::Option do
  describe 'parser' do
    subject {
      Gyunyu::Command::Export::Option.new.parser
    }
    it {
      subject.class.should == OptionParser
    }

    describe 'lists' do
      context 'no lists' do
        subject {
          Gyunyu::Command::Export::Option.new.lists
        }
        it {
          should == []
        }
      end
      context 'one list' do
        subject {
          Gyunyu::Command::Export::Option.new( %w( -l 仕事 ) ).lists
        }
        it {
          should == %w( 仕事 )
        }
      end
      context 'two lists' do
        subject {
          Gyunyu::Command::Export::Option.new( %w( -l 仕事 -l 勉強 ) ).lists
        }
        it {
          should == %w( 仕事 勉強 )
        }
      end
      context 'twice same list' do
        subject {
          Gyunyu::Command::Export::Option.new( %w( -l 仕事 -l 仕事 ) ).lists
        }
        it {
          should == %w( 仕事 )
        }
      end
    end
  end
end
