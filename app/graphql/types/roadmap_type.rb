module Types
  class RoadmapType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :categories, [Types::CategoryType], null: false
    field :steps, [Types::StepType], null: false
  end
end