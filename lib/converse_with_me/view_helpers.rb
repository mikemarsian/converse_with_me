module ConverseWithMe
  module ViewHelpers

    def include_converse_with_me
      puts "I was called"
    end

  end
end

# add methods to ActionView helpers
ActionView::Base.send :include, ConverseWithMe::ViewHelpers