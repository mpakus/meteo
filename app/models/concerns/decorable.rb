# frozen_string_literal: true

module Decorable
  extend ActiveSupport::Concern

  def decorate(decorate_class = nil)
    (decorate_class || "#{self.class}Decorator".constantize).new(self)
  end
end
