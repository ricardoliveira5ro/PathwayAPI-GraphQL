module Mutations::Step
  class TrackStep < Mutations::BaseMutation
    argument :step_id, ID, required: true
    argument :is_completed, Boolean, required: true

    field :step, Types::StepType, null: true
    field :errros, Types::ValidationErrorsType, null: true

    def resolve(step_id:, is_completed:)
      check_authentication!

      step = Step.find(step_id)
      tracking = Tracker.find_by(user_id: context[:current_user], step_id: step)

      if tracking
        tracking.update(completed: is_completed)
      else
        tracking = Tracker.new(step_id: step.id, user_id: context[:current_user].id, completed: is_completed)
      end

      if tracking.save!
        { step: step, success: true }
      else
        { errors: step.errors, success: false }
      end
    end
  end
end