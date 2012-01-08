# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../../../../spec_helper'

describe Gyunyu::Command::Export::Format::Csv do
  csv_formatter = Gyunyu::Command::Export::Format::Csv

  let(:app) { Gyunyu::Command::Export::App.new }

  before {
    stub(app).task_list { task_raw_data }
    stub(app).find_list {
      list = Struct.new( :name ).new
      list.name ='仕事'
      list
    }
  }

  describe 'export' do
    subject {
      app.export
    }

    context 'tags' do
      before {
        app._init_option( %w( -d name,tags ) )
      }
      it {
        should == <<EOD
list,name,tags,""
仕事,jsのlintについて,research,writing
仕事,あの本読む,reading,""
仕事,この本読む,reading,""
EOD
      }
    end
    context 'notes' do
      before {
        app._init_option( %w( -d name,notes ) )
      }
      it {
        should == <<EOD
list,name,notes
仕事,jsのlintについて,意図が分かんないな、このメモ。結局何をしたかった？
仕事,あの本読む,""
仕事,この本読む,""
EOD
      }
    end
  end

  describe 'expand_fields' do
    context 'empty' do
      subject {
        csv_formatter.expand_fields( [] )
      }
      it {
        should == []
      }
    end
    context 'missing number of tags' do
      before {
        csv_formatter.instance_variable_set( '@num_tags', nil )
      }
      subject {
        csv_formatter.expand_fields( %w( name tags ) )
      }
      it {
        should == %w( name tags )
      }
    end
    context 'have max 1 tags' do
      before {
        csv_formatter.instance_variable_set( '@num_tags', 1 )
      }
      subject {
        csv_formatter.expand_fields( %w( name tags ) )
      }
      it {
        should == %w( name tags )
      }
    end
    context 'have max 2 tags' do
      before {
        csv_formatter.instance_variable_set( '@num_tags', 2 )
      }
      subject {
        csv_formatter.expand_fields( %w( name tags ) )
      }
      it {
        should == ['name', 'tags', '']
      }
    end
    context 'have max 3 notes' do
      before {
        csv_formatter.instance_variable_set( '@num_notes', 3 )
      }
      subject {
        csv_formatter.expand_fields( %w( name notes due ) )
      }
      it {
        should == ['name', 'notes', '', '', 'due']
      }
    end
  end
end
