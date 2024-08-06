# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    object_class Types::BaseObject

    field :success, Boolean
    field :errors, [String]

    def check_authentication!
      return if context[:current_user]

      raise GraphQL::ExecutionError, "You need to authenticate to perform this action"
    end

    def check_roadmap_ownership!(roadmap)
      return if roadmap.user_id == context[:current_user].id

      raise GraphQL::ExecutionError, "Cannot perform this operation, roadmap created by another user"
    end
  end
end
