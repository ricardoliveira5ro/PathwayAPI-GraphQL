module Mutations::Step
  class UpdateStep < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :description, String, required: false
    argument :order, Integer, required: false

    field :step, Types::StepType, null: true
    field :errors, Types::ValidationErrorsType, null: true

    def resolve(id:, **args)
      check_authentication!

      step = Step.find(id)
      roadmap = Roadmap.find(step.roadmap_id)
      check_roadmap_ownership!(roadmap)

      if step.update(args)
        { step: step, success: true }
      else
        { errors: step.errors, success: false }
      end
    end
  end
end