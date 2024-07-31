module Mutations::Category
  class Create < Mutations::BaseMutation
    argument :name, String, required: true

    field :category, Types::CategoryType, null: true
    field :errors, Types::ValidationErrorsType, null: true

    def resolve(args)
      category = Category.new(args)

      if category.save
        { category: category, success: true }
      else
        { errors: category.errors, success: false }
      end
    end
  end
end