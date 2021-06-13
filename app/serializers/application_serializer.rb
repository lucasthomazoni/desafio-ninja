# frozen_string_literal: true

class ApplicationSerializer
  def self.inherited(klass)
    super
    klass.send(:include, JSONAPI::Serializer)
  end
end
