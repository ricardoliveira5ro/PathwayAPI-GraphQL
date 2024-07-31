module Mutations::Authentication
  class Register < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: true
    field :errors, Types::ValidationErrorsType, null: true
  
    def resolve(args)
      user = User.new(args)

      if user.save
        { user: user, success: true }
      else
        { errors: user.errors, success: false }
      end
    end
  end
end