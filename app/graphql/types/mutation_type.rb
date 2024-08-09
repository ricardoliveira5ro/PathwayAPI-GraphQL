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
    field :delete_roadmap, mutation: Mutations::Roadmap::DeleteRoadmap

    # Step mutations
    field :update_step, mutation: Mutations::Step::UpdateStep
    field :delete_steps, mutation: Mutations::Step::DeleteSteps

    # Tracking mutations
    field :track_step, mutation: Mutations::Step::TrackStep
  end
end
