# -*- coding: utf-8 -*-

class TestingAppExport < Gyunyu::Command::Export::App
  def _init_lists
    @lists = [
      RTM::List.new({ 'id'   => '1234',
                      'name' => 'Inbox' }),
      RTM::List.new({ 'id'   => '2345',
                      'name' => '個人' }),
      RTM::List.new({ 'id'   => '3456',
                      'name' => '勉強' })
    ]
  end
end

def app_export
  app = TestingAppExport.new
end
