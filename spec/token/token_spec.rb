require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Gyunyu::Token do
  def stub_magazine
    RR.stub.instance_of(Gyunyu::Token).magazine {
      File.dirname(__FILE__) + '/../../tmp/.token'
    }
  end

  describe 'get' do
    shared_examples_for 'get token' do
      context 'alive_all' do
        subject {
          Gyunyu::Token.get
          RTM::List.alive_all.length
        }
        it {
          should > 0
        }
      end
    end

    context 'saved' do
      it_behaves_like 'get token'
    end
    context 'purged' do
      before {
        Gyunyu::Token.purge
      }

      it_behaves_like 'get token'
    end
  end

  describe 'save & load' do
    before(:each) {
      stub_magazine
      @token = Gyunyu::Token.new
    }
    describe 'save' do
      subject {
        @token.save( 'abc' )
      }
      it {
        should == 'abc'
      }
    end

    describe 'load' do
      subject {
        @token.load
      }
      it {
        should == 'abc'
      }
    end
  end

  describe 'magazine' do
    context 'RTMSTAT_TOKEN' do
      before {
        RR.stub.instance_of(Gyunyu::Token).env {
          '/path/to/token'
        }
      }
      subject {
        Gyunyu::Token.new.magazine
      }
      it {
        should == '/path/to/token'
      }
    end

    context 'dot file in home' do
      before {
        @token = Gyunyu::Token.new
        RR.stub(@token).env { nil }
      }
      subject {
        Gyunyu::Token.new.magazine
      }
      it {
        should == @token.dotfile
      }
    end
  end
end
