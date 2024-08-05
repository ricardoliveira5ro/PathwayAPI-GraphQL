module Types
  class StepType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :order, Integer, null: false
  end
end