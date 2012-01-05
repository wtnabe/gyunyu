require File.dirname(__FILE__) + '/../../../spec_helper'

describe Gyunyu::Command::Export::CustomFilter do
  mod = Gyunyu::Command::Export::CustomFilter

  define_method :force_weekday do
    mod.class_eval {
      def self.today
        Date.parse('2012-01-05')
      end
    }
  end

  define_method :force_sunday do
    mod.class_eval {
      def self.today
        Date.parse('2012-01-01')
      end
    }
  end

  before {
    force_weekday
  }

  describe 'today' do
    subject {
      mod.today
    }
    it {
      should == Date.parse('2012-01-05')
    }
  end

  describe 'last_sunday' do
    context 'weekdy 2012-01-05' do
      subject {
        mod.last_sunday
      }
      it {
        should == Date.parse('2012-01-01')
      }
    end
    context 'sunday 2012-01-01' do
      before {
        force_sunday
      }
      subject {
        mod.last_sunday
      }
      it {
        should == Date.parse('2011-12-25')
      }
    end
  end

  describe 'next_sunday' do
    context 'weekday 2012-01-05' do
      subject {
        mod.next_sunday
      }
      it {
        should == Date.parse('2012-01-08')
      }
    end
    context 'sunday 2012-01-01' do
      before {
        force_sunday
      }
      subject {
        mod.next_sunday
      }
      it {
        should == Date.parse('2012-01-08')
      }
    end
  end

  describe 'from_yesterday' do
    subject {
      mod.from_yesterday
    }
    it {
      should == '2012-01-03T23:59:59Z'
    }
  end

  describe 'until_yesterday' do
    subject {
      mod.until_yesterday
    }
    it {
      should == '2012-01-04T24:00:00Z'
    }
  end

  describe 'from_today' do
    subject {
      mod.from_today
    }
    it {
      should == '2012-01-04T23:59:59Z'
    }
  end

  describe 'until_today' do
    subject {
      mod.until_today
    }
    it {
      should == '2012-01-05T24:00:00Z'
    }
  end

  describe 'from_tomorrow' do
    subject {
      mod.from_tomorrow
    }
    it {
      should == '2012-01-05T23:59:59Z'
    }
  end

  describe 'until_tomorrow' do
    subject {
      mod.until_tomorrow
    }
    it {
      should == '2012-01-06T24:00:00Z'
    }
  end

  describe 'from_last_week' do
    context 'weekday 2012-01-05' do
      subject {
        mod.from_last_week
      }
      it {
        should == '2011-12-24T23:59:59Z'
      }
    end
    context 'sunday 2012-01-01' do
      before {
        force_sunday
      }
      subject {
        mod.from_last_week
      }
      it {
        should == '2011-12-24T23:59:59Z'
      }
    end
  end

  describe 'until_last_week' do
    context 'weekday 2012-01-05' do
      subject {
        mod.until_last_week
      }
      it {
        should == '2011-12-31T24:00:00Z'
      }
    end
    context 'sunday 2011-01-01' do
      before {
        force_sunday
      }
      subject {
        mod.until_last_week
      }
      it {
        should == '2011-12-31T24:00:00Z'
      }
    end
  end

  describe 'from_this_week' do
    context 'weekday 2012-01-05' do
      subject {
        mod.from_this_week
      }
      it {
        should == '2011-12-31T23:59:59Z'
      }
    end
    context 'sunday 2012-01-01' do
      before {
        force_sunday
      }
      subject {
        mod.from_this_week
      }
      it {
        should == '2011-12-31T23:59:59Z'
      }
    end
  end

  describe 'until_this_week' do
    context 'weekday 2012-01-05' do
      subject {
        mod.until_this_week
      }
      it {
        should == '2012-01-07T24:00:00Z'
      }
    end
    context 'sunday 2012-01-01' do
      before {
        force_sunday
      }
      subject {
        mod.until_this_week
      }
      it {
        should == '2012-01-07T24:00:00Z'
      }
    end
  end

  describe 'from_next_week' do
    context 'weekday 2012-01-05' do
      subject {
        mod.from_next_week
      }
      it {
        should == '2012-01-07T23:59:59Z'
      }
    end
    context 'sunday 2012-01-01' do
      before {
        force_sunday
      }
      subject {
        mod.from_next_week
      }
      it {
        should == '2012-01-07T23:59:59Z'
      }
    end
  end

  describe 'until_next_week' do
    context 'weekday 2012-01-05' do
      subject {
        mod.until_next_week
      }
      it {
        should == '2012-01-14T24:00:00Z'
      }
    end
    context 'sunday 2012-01-01' do
      before {
        force_sunday
      }
      subject {
        mod.until_next_week
      }
      it {
        should == '2012-01-14T24:00:00Z'
      }
    end
  end

  describe 'from_last_month' do
    subject {
      mod.from_last_month
    }
    it {
      should == '2011-11-30T23:59:59Z'
    }
  end

  describe 'until_last_month' do
    subject {
      mod.until_last_month
    }
    it {
      should == '2011-12-31T24:00:00Z'
    }
  end

  describe 'from_this_month' do
    subject {
      mod.from_this_month
    }
    it {
      should == '2011-12-31T23:59:59Z'
    }
  end

  describe 'until_this_month' do
    subject {
      mod.until_this_month
    }
    it {
      should == '2012-01-31T24:00:00Z'
    }
  end

  describe 'from_next_month' do
    subject {
      mod.from_next_month
    }
    it {
      should == '2012-01-31T23:59:59Z'
    }
  end

  describe 'until_next_month' do
    subject {
      mod.until_next_month
    }
    it {
      should == '2012-02-29T24:00:00Z'
    }
  end
end

