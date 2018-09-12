#
# config/initializers/scheduler.rb

require 'rufus-scheduler'

# Let's use the rufus-scheduler singleton
#
s = Rufus::Scheduler.singleton


# Stupid recurrent task...
#
s.every '6h' do

  Rails.logger.info "hello, it's #{Time.now}"
  ImportCompaniesJob.perform_later
  Rails.logger.flush
end