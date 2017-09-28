require 'mina/bundler'
require 'mina/rails'

namespace :sneakers do
  set :sneakers_env,     -> { fetch(:rails_env, 'production') }
  set :sneakers_pid,     -> { "#{fetch(:shared_path)}/tmp/pids/sneakers.pid" }
  set :sneakers_run_cmd, -> { "#{fetch(:bundle_prefix)} rake sneakers:run" }

  desc 'Start sneakers'
  task start: :environment do
    comment 'Sneakers starting ...'
    in_path(fetch(:current_path)) do
      command fetch(:sneakers_run_cmd)
    end
  end

  desc 'Stop sneakers'
  task stop: :environment do
    comment 'Sneakers stopping ...'
    command %{
      if [ -e "#{fetch(:sneakers_pid)}" ]; then
        if [ -e /proc/$(cat '#{fetch(:sneakers_pid)}') ]; then
          kill -INT `cat '#{fetch(:sneakers_pid)}'`
        else
          echo 'Sneakers stopped!';
        fi
      else
        echo 'Sneakers is not running!';
      fi
    }
  end

  desc 'Hard stop sneakers'
  task hard_stop: :environment do
    comment 'Sneakers stopping --hard ...'
    command %{
      if [ -e "#{fetch(:sneakers_pid)}" ]; then
        if [ -e /proc/$(cat '#{fetch(:sneakers_pid)}') ]; then
          kill -9 `cat '#{fetch(:sneakers_pid)}'`
        else
          echo 'Sneakers stopped!';
        fi
      else
        echo 'Sneakers is not running!';
      fi
    }
  end

  desc 'Get status of sneakers'
  task status: :environment do
    comment 'Sneakers status...'
    command %{
      if [ -e "#{fetch(:sneakers_pid)}" ]; then
        if [ -e /proc/$(cat '#{fetch(:sneakers_pid)}') ]; then
          echo 'Sneakers is running'
        else
          echo 'Sneakers stopped';
        fi
      else
        echo 'Sneakers not running';
      fi
    }
  end

  desc 'Restart sneakers'
  task restart: :environment do
    comment 'Restart sneakers...'
    invoke :'sneakers:stop'
    invoke :'sneakers:start'
  end

  desc 'Restart sneakers (phased restart). Auto Scaling support'
  task phased_restart: :environment do
    comment 'Phased restart sneakers... '
    command %{
      if [ -e "#{fetch(:sneakers_pid)}" ]; then
        if [ -e /proc/$(cat '#{fetch(:sneakers_pid)}') ]; then
          kill -SIGUSR2 `cat #{fetch(:sneakers_pid)}` && kill -SIGUSR1 `cat #{fetch(:sneakers_pid)}`
        else
          echo 'Sneakers stopped!';
        fi
      else
        echo 'Sneakers is not running!';
      fi
    }
  end
end
