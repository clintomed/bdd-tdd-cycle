require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

Given(/^the following movies exist:$/) do |table|
  table.hashes.each do |movie|
		Movie.create movie
	end
end

Then(/^the director of "(.*?)" should be "(.*?)"$/) do |arg1, arg2|
	Movie.find_by_title(arg1).director == arg2
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
	rating_list.split(',').each do |rating|
		if uncheck
			uncheck "ratings_#{rating}"
		else
			check "ratings_#{rating}"
		end
	end
end

