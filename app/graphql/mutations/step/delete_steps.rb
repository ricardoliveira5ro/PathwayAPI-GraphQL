module Mutations::Step
  class DeleteSteps < Mutations::BaseMutation
    argument :steps_ids, [ID], required: true

    field :message, String, null: false
    field :errors, Types::ValidationErrorsType, null: true

    def resolve(steps_ids:)
      check_authentication!

      steps_ids.each do |id|
        step = Step.find(id)
        roadmap = Roadmap.find(step.roadmap_id)

        check_roadmap_ownership!(roadmap)
      end

      steps_ids.each { |id| Step.find(id).destroy! }
      { message: "Steps successfully deleted", success: true }
    end
  end
end