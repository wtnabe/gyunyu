# -*- mode: ruby -*-
namespace :git do
  desc "list git-untracked files"
  task :untracked do
    sh 'git ls-files -o --exclude-from=.gitignore'
  end
end
