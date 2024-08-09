module Types
  class RoadmapType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :categories, [Types::CategoryType], null: false
    field :steps, [Types::StepType], null: false

    field :completed, Boolean, null: false
    def completed
      object.steps.each do |step|
        is_step_completed = Tracker.find_by(user_id: context[:current_user], step_id: step.id)&.completed || false
        if !is_step_completed
          return false
        end
      end

      true
    end
  end
end