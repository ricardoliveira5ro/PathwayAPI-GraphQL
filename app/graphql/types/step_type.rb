module Types
  class StepType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :order, Integer, null: false
    field :roadmap_id, ID, null: false
    
    field :completed, Boolean, null: false
    def completed
      Tracker.find_by(user_id: context[:current_user], step_id: object.id)&.completed || false
    end
  end
end