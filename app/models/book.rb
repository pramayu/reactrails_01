class Book
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :sinopsis, type: String
  field :price, type: BigDecimal
  field :published_on, type: Date
  field :status, type: Mongoid::Boolean
end
