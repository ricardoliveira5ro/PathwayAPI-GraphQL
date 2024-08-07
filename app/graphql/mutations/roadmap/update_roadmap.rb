module Mutations::Roadmap
  class UpdateRoadmap < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :description, String, required: false
    argument :category_ids, [ID], required: false
    argument :steps, [Types::StepInputType], required: false

    field :roadmap, Types::RoadmapType, null: true
    field :errors, Types::ValidationErrorsType, null: true

    def resolve(id:, steps: [], **args)
      check_authentication!

      roadmap = Roadmap.find(id)     
      check_roadmap_ownership!(roadmap)

      if roadmap.update(args.except(:steps))
        # Append to existent steps
        steps.each do |step_attrs|
          roadmap.steps.create!(step_attrs.to_h)
        end

        { roadmap: roadmap, success: true }
      else
        { errors: roadmap.errors, success: false }
      end
    end
  end
end