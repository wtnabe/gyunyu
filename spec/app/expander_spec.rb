# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'

describe Gyunyu::Expander do
  describe 'taskseries' do
    shared_examples_for :taskseries do
      it 'array of hash' do
        subject.class.should == Array
        subject.each { |e|
          e.class.should == Hash
        }
      end
    end

    context 'array given' do
      it_should_behave_like :taskseries do
        subject {
          Gyunyu::Expander.taskseries( task_raw_data.first['taskseries'] )
        }
      end
    end
    context 'hash given' do
      it_should_behave_like :taskseries do
        subject {
          Gyunyu::Expander.taskseries( task_raw_data.first )
        }
      end
    end
  end

  describe 'tasks' do
    subject {
      Gyunyu::Expander.tasks(task_raw_data.first['taskseries'].first)
    }
    it {
      should == [
        { "taskseries_id"=>"118872028",
          "created"=>"2011-05-28T01:04:49Z",
          "modified"=>"2011-10-10T22:00:53Z",
          "name"=>"jsのlintについて",
          "source"=>"js",
          "url"=>"",
          "location_id"=>"",
          "tags"=>[{"tag"=>["research", "writing"]}],
          "participants"=>[{}],
          "notes"=>
          [{"note"=>
              [{"id"=>"26111105",
                  "created"=>"2011-10-10T22:00:53Z",
                  "modified"=>"2011-10-10T22:00:53Z",
                  "title"=>"",
                  "content"=>"意図が分かんないな、このメモ。結局何をしたかった？"}]}],
          "task_id"=>"181820465",
          "due"=>"",
          "has_due_time"=>"0",
          "added"=>"2011-05-28T01:04:49Z",
          "completed"=>"",
          "deleted"=>"",
          "priority"=>"1",
          "postponed"=>"0",
          "estimate"=>""}]
    }
  end
end

def task_raw_data
  # [{'id' => list id,
  #   'taskseries' =>
  #   []
  #  }]
[{"id"=>"135243",
  "taskseries"=>
   [{"id"=>"118872028",
     "created"=>"2011-05-28T01:04:49Z",
     "modified"=>"2011-10-10T22:00:53Z",
     "name"=>"jsのlintについて",
     "source"=>"js",
     "url"=>"",
     "location_id"=>"",
     "tags"=>[{"tag"=>["research", "writing"]}],
     "participants"=>[{}],
     "notes"=>
      [{"note"=>
         [{"id"=>"26111105",
           "created"=>"2011-10-10T22:00:53Z",
           "modified"=>"2011-10-10T22:00:53Z",
           "title"=>"",
           "content"=>"意図が分かんないな、このメモ。結局何をしたかった？"}]}],
     "task"=>
      [{"id"=>"181820465",
        "due"=>"",
        "has_due_time"=>"0",
        "added"=>"2011-05-28T01:04:49Z",
        "completed"=>"",
        "deleted"=>"",
        "priority"=>"1",
        "postponed"=>"0",
        "estimate"=>""}]},
    {"id"=>"46116936",
     "created"=>"2009-08-01T08:35:30Z",
     "modified"=>"2010-05-10T03:18:43Z",
     "name"=>"あの本読む",
     "source"=>"js",
     "url"=>"",
     "location_id"=>"",
     "tags"=>[{"tag"=>["reading"]}],
     "participants"=>[{}],
     "notes"=>[{}],
     "task"=>
      [{"id"=>"65881131",
        "due"=>"",
        "has_due_time"=>"0",
        "added"=>"2009-08-01T08:35:30Z",
        "completed"=>"",
        "deleted"=>"",
        "priority"=>"N",
        "postponed"=>"0",
        "estimate"=>"1時間"}]},
    {"id"=>"115609158",
     "created"=>"2011-05-02T10:13:47Z",
     "modified"=>"2011-05-07T12:26:43Z",
     "name"=>"この本読む",
     "source"=>"js",
     "url"=>"",
     "location_id"=>"",
     "tags"=>[{"tag"=>["reading"]}],
     "participants"=>[{}],
     "notes"=>[{}],
     "task"=>
      [{"id"=>"176273444",
        "due"=>"",
        "has_due_time"=>"0",
        "added"=>"2011-05-02T10:13:47Z",
        "completed"=>"",
        "deleted"=>"",
        "priority"=>"1",
        "postponed"=>"0",
        "estimate"=>"8h"}]}
      ]}]
end
