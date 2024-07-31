module Mutations::Authentication
  class Login < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true
    
    field :token, String, null: true

    def resolve(email:, password:)
      user = User.find_by(email: email)
      errors = {}
  
      if user&.authenticate(password)
        context[:current_user] = user
        token = JWT.encode({ user_id: user.id }, 'secret', 'HS256')

        { token: token, success: true }
      else
        context[:current_user] = nil

        raise GraphQL::ExecutionError, "Incorrect Email/Password"
      end
    end
  end
end