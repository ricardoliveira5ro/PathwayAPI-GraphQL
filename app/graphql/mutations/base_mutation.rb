# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    object_class Types::BaseObject

    field :success, Boolean
    field :errors, [String]
  end
end
