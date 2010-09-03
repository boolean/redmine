require File.expand_path('../enumeration_exemplar', __FILE__)

class TimeEntryActivity < Enumeration
  generator_for :name, :method => :next_name
  generator_for :type => 'TimeEntryActivity'

  def self.next_name
    @last_name ||= 'TimeEntryActivity0'
    @last_name.succ!
    @last_name
  end
end
