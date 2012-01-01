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

    describe 'filter' do
      context 'no filter' do
        subject {
          Gyunyu::Command::Export::Option.new( %w() ).filter
        }
        it {
          should be_nil
        }
      end
      context 'one filter' do
        subject {
          Gyunyu::Command::Export::Option.new( %w( -f filter ) ).filter
        }
        it {
          should == 'filter'
        }
      end
      context 'multiple filters' do
        subject {
          Gyunyu::Command::Export::Option.new( %W( -f first\ one -f last\ one ) ).filter
        }
        it {
          should == 'last one'
        }
      end
    end
  end
end
