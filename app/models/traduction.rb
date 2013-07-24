class Traduction
  include Mongoid::Document
  field :fr, type: String
  field :en, type: String
end
