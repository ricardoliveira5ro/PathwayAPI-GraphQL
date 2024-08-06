# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # Authentication mutations
    field :register, mutation: Mutations::Authentication::Register
    field :login, mutation: Mutations::Authentication::Login
    field :logout, mutation: Mutations::Authentication::Logout

    # Roadmap mutations
    field :create_roadmap, mutation: Mutations::Roadmap::CreateRoadmap
    field :update_roadmap, mutation: Mutations::Roadmap::UpdateRoadmap
  end
end
