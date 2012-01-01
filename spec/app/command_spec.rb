require File.dirname(__FILE__) + '/../spec_helper'

describe Gyunyu::Command do
  describe 'commands' do
    let(:commands) {
      Gyunyu::Command.commands
    }
    describe 'array' do
      it {
        commands.size.should > 0
      }
    end
    describe 'array of strings' do
      it 'array of strings' do
        commands.map { |e| e.should.class == String }
      end
    end
  end

  describe 'dispatch' do
    context 'correct command' do
      before {
        stub.instance_of(Gyunyu::Command::Export::App).run {
          "`export' dispatched"
        }
      }
      subject {
        Gyunyu::Command.dispatch( 'export' )
      }
      it {
        should == "`export' dispatched"
      }
    end
    context 'wrong command' do
      subject {
        Gyunyu::Command.dispatch( 'foo' )
      }
      it {
        lambda {subject}.should raise_error(Gyunyu::Command::NotFound)
      }
    end
  end

  describe 'app_const' do
    context 'correct app' do
      subject {
        Gyunyu::Command.app_const( 'export' )
      }
      it {
        should == Gyunyu::Command::Export::App
      }
    end
    context 'wrong app' do
      subject {
        Gyunyu::Command.app_const( 'foo' )
      }
      it {
        lambda {subject}.should raise_error( NameError )
      }
    end
  end
end
