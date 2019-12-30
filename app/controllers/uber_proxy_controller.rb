class UberProxyController < ActionController::API
  def attendee_search
    uber_req = {
      "method": "attendee.search",
      "params": ["Test Developer"]
    }
    render json: {
      result: call_uber(uber_req)
    }, status: 200
  end

  def get_departments
    req_body = {
      "method": "dept.list"
    }

    render json: {
      result: call_uber(req_body)
    }, status: 200
  end

  def get_shifts
    Rails.logger.info(params[:department_id])
    req_body = {
      method: "shifts.lookup",
      params: {
        department_id: params[:department_id]
      }
    }

    render json: {
      result: call_uber(req_body)
    }, status: 200
  end

  def mark_shift_worked
    req_body = {
      method: "shifts.set_worked",
      params: [
        params[:shift_id],
        59709335,
        54944008,
        "Shift marked automatically by techops dashboard"
      ]
    }
    render json: {
      result: call_uber(req_body)
    }, status: 200
  end

  def mark_shift_not_worked
    req_body = {
      method: 'shifts.set_worked',
      params: [
        params[:shift_id],
        176686787,
        54944008,
        "Shift marked automatically by techops dashboard"
      ]
    }
    render json: {
      result: call_uber(req_body)
    }, status: 200
  end

  private

  def call_uber(request_body)
    JSON.parse(RestClient::Request.execute(
      method: :post,
      url: ENV["UBER_URL"],
      payload: request_body.to_json,
      headers: {
        "X-Auth-Token": ENV["API_TOKEN"]
      }
    ))
  end
end
