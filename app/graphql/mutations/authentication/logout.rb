module Mutations::Authentication
  class Logout < Mutations::BaseMutation
    field :success, Boolean, null: false

    def resolve
      context[:current_user] = nil
      { success: true }
    end
  end
end