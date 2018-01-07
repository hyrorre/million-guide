# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
port        ENV.fetch("PORT") { 3000 }

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch("RAILS_ENV") { "development" }

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked webserver processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
# workers ENV.fetch("WEB_CONCURRENCY") { 2 }
workers 1

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory. If you use this option
# you need to make sure to reconnect any threads in the `on_worker_boot`
# block.
#
preload_app!

# If you are preloading your application and using Active Record, it's
# recommended that you close any connections to the database before workers
# are forked to prevent connection leakage.
#
# before_fork do
#   ActiveRecord::Base.connection_pool.disconnect! if defined?(ActiveRecord)
# end

# The code in the `on_worker_boot` will be called if you are using
# clustered mode by specifying a number of `workers`. After each worker
# process is booted, this block will be run. If you are using the `preload_app!`
# option, you will want to use this block to reconnect to any threads
# or connections that may have been created at application boot, as Ruby
# cannot share connections between processes.
#
on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end


# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

daemonize false

app_dir = "/var/www/MillionGuide/current"
bind "unix://#{app_dir}/tmp/sockets/puma.sock"
pidfile "#{app_dir}/tmp/pids/puma.pid"
state_path "#{app_dir}/tmp/pids/puma.state"
stdout_redirect "#{app_dir}/log/puma.stdout.log", "#{app_dir}/log/puma.stderr.log", true
activate_control_app

#lib/capistrano/tasks/puma.rake
task :smart_restart do
    if !puma_preload_app? && puma_workers.to_i > 1
      invoke 'puma:phased-restart'
    else
      invoke 'puma:restart'
    end
end

# launcher.rb
def prune_bundler
	return unless defined?(Bundler)
	puma = Bundler.rubygems.loaded_specs("puma")
	dirs = puma.require_paths.map { |x| File.join(puma.full_gem_path, x) }
	puma_lib_dir = dirs.detect { |x| File.exist? File.join(x, '../bin/puma-wild') }

	unless puma_lib_dir
	  log "! Unable to prune Bundler environment, continuing"
	  return
	end

	deps = puma.runtime_dependencies.map do |d|
	  spec = Bundler.rubygems.loaded_specs(d.name)
	  "#{d.name}:#{spec.version.to_s}"
	end

	log '* Pruning Bundler environment'
	home = ENV['GEM_HOME']
	Bundler.with_clean_env do
	  ENV['GEM_HOME'] = home
	  ENV['PUMA_BUNDLER_PRUNED'] = '1'
	  wild = File.expand_path(File.join(puma_lib_dir, "../bin/puma-wild"))
	  args = [Gem.ruby, wild, '-I', dirs.join(':'), deps.join(',')] + @original_argv
	  Kernel.exec(*args)
	end
end

# launcher.rb
def prune_bundler?
	@options[:prune_bundler] && clustered? && !@options[:preload_app]
end

  def clustered?
	(@options[:workers] || 0) > 0
end