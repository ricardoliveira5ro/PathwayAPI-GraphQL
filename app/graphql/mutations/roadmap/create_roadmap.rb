module Mutations::Roadmap
  class CreateRoadmap < Mutations::BaseMutation
    argument :title, String, required: true
    argument :description, String, required: true
    argument :category_ids, [ID], required: true

    field :roadmap, Types::RoadmapType, null: true
    field :errors, Types::ValidationErrorsType, null: true

    def resolve(title:, description:, category_ids:)
      roadmap = Roadmap.new(title: title, description: description)

      categories = Category.find(category_ids)
      roadmap.categories << categories

      if roadmap.save
        { roadmap: roadmap, success: true }
      else
        { errors: roadmap.errors, success: false }
      end
    end
  end
end