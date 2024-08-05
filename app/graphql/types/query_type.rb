# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :is_running, String, null: false,
      description: "Test if the API is running without major problems"
    def is_running
      "The API is running"
    end

    ############# Category ################
    field :category, Types::CategoryType, null: true, description: "Returns a Category instance" do
      argument :id, Integer, required: true
    end
    def category(id:)
      check_authentication!
      Category.find(id)
    end

    field :categories, [Types::CategoryType], null: true, description: "Returns all categories"
    def categories
      check_authentication!
      Category.all
    end

    ############# Roadmap ################
    field :roadmap, Types::RoadmapType, null: true, description: "Returns a Roadmap instance" do
      argument :id, Integer, required: true
    end
    def roadmap(id:)
      check_authentication!
      Roadmap.find(id)
    end

    field :roadmaps, [Types::RoadmapType], null: true, description: "Returns all roadmaps"
    def roadmaps
      check_authentication!
      Roadmap.all
    end
  end
end
