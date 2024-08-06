module Types
  class StepInputType < Types::BaseInputObject
    argument :title, String, required: true
    argument :description, String, required: true
    argument :order, Integer, required: true
  end
end