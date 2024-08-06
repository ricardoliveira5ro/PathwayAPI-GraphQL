module Mutations::Roadmap
  class CreateRoadmap < Mutations::BaseMutation
    argument :title, String, required: true
    argument :description, String, required: true
    argument :category_ids, [ID], required: true
    argument :steps, [Types::StepInputType], required: false

    field :roadmap, Types::RoadmapType, null: true
    field :errors, Types::ValidationErrorsType, null: true

    def resolve(title:, description:, category_ids:, steps: [])
      roadmap = Roadmap.new(title: title, description: description)

      categories = Category.find(category_ids)
      roadmap.categories << categories

      steps.each do |step_attrs|
        step = roadmap.steps.build(step_attrs.to_h)
        step.save!
      end

      if roadmap.save
        { roadmap: roadmap, success: true }
      else
        { errors: roadmap.errors, success: false }
      end
    end
  end
end