# frozen_string_literal: true

class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: current_user_from_token
    }
    result = PathwayApiGraphQlSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue StandardError => e
    handle_error(e)
  end

  private

  def current_user_from_token
    token = request.headers['Authorization'].to_s.split(' ').last
    return unless token

    decoded_token = JWT.decode(token, 'secret', true, algorithm: 'HS256')
    User.find(decoded_token[0]['user_id'])
  end

  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error(error)
    case error
    when JWT::DecodeError
      render json: { errors: [{ message: "Invalid token: #{error.message}" }] }, status: 401
    when ActiveRecord::RecordNotFound
      render json: { errors: [{ message: "Invalid token" }] }, status: 401
    else
      if Rails.env.development?
        handle_error_in_development(error)
      else
        handle_error_in_production(error)
      end
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end

  def handle_error_in_production(e)
    logger.error e.message
    render json: { errors: [{ message: 'Internal server error' }] }, status: 500
  end
end
