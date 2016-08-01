# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../../../spec_helper'

describe Gyunyu::Command::Export::TotalEstimate do
  include Gyunyu::Command::Export::TotalEstimate

  let(:tasks) {
    [
      { "list"        => "個人",
        "name"        => "gyunyu開発",
        "estimate(d)" => 0,
        "estimate(h)" => 2,
        "estimate(m)" => 45},
      { "list"        => "家",
        "name"        => "小さな整理",
        "estimate(d)" => 0,
        "estimate(h)" => 0,
        "estimate(m)" => 25},
      { "list"        => "個人",
        "name"        => "ありがちanalyticsコード改善",
        "estimate(d)" => 0,
        "estimate(h)" => 0,
        "estimate(m)" => 60}
    ]
  }

  describe 'sum_estimate' do
    subject {
      sum_estimate( tasks, %w{list name estimate(d) estimate(h) estimate(m)} )
    }
    it {
      should == {
        'estimate(d)' => 0,
        'estimate(h)' => 4,
        'estimate(m)' => 10
      }
    }
  end

  describe 'have_estimate_fields?' do
    context 'name, due' do
      subject {
        have_estimate_fields?( %w( name due ) )
      }
      it {
        should be_falsey
      }
    end
    context 'name, estimate' do
      subject {
        have_estimate_fields?(%w{ name estimate(d) estimate(h) estimate(m) })
      }
      it {
        should be_truthy
      }
    end
  end
end

