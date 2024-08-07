module Mutations::Roadmap
  class DeleteRoadmap < Mutations::BaseMutation
    argument :id, ID, required: true

    field :message, String, null: false
    field :errors, Types::ValidationErrorsType, null: true

    def resolve(id:)
      check_authentication!

      roadmap = Roadmap.find(id)     
      check_roadmap_ownership!(roadmap)

      if roadmap.destroy
        { message: "Roadmap with id=#{id} successfully deleted", success: true }
      else
        { errors: roadmap.errors, success: false }
      end
    end
  end
end