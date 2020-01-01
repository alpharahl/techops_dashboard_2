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
        "Shift marked automatically by techops dashboard on account #{params[:user]}"
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

  def get_user_from_barcode
    req_body = {
      method: 'barcode.lookup_attendee_from_barcode',
      params: [params[:barcode]]
    }
    render json: {
      result: call_uber(req_body)
    }, status: 200
  end

  def admin_login
    # "/accounts/login", data={"email": email, "password": password, "original_location": "homepage"})
    RestClient::Request.execute(
      method: :post,
      url: "https://onsite.reggie.magfest.org/accounts/login",
      data: {
        email: params[:email],
        password: params[:password],
        original_location: "homepage"
      }
    ) do |response, request, result|
      Rails.logger.info("response #{response.code}, request: #{request.inspect}, result: #{result.inspect}")
      render status: response.code, text: result
    end
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
