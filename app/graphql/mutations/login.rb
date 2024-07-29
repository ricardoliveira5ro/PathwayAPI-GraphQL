module Mutations
  class Login < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true
    
    field :token, String, null: false
    field :errors, Types::ValidationErrorsType, null: true

    def resolve(email:, password:)
      user = User.find_by(email: email)
  
      if user&.authenticate(password)
        token = JWT.encode({ user_id: user.id }, 'secret', 'HS256')
        { token: token, success: true }
      else
        { errors: user.errors, success: false }  
      end
    end
  end
end