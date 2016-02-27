defmodule ExIntercom.Base do
  @items_per_page 20

  def request(url) do
    {:ok, response} = HTTPoison.get(url, headers, authenticate)
    response.body
  end

  def paginate_params(endpoint, pages) do
    endpoint <> "?per_page=#{@items_per_page}&page=#{pages}"
  end

  defp authenticate do
    {intercom_app_id, intercom_app_key} = get_credentials

    [
      hackney: [
        basic_auth: {
          intercom_app_id,
          intercom_app_key
        }
      ]
    ]
  end

  defp get_credentials do
    {
      Application.get_env(
        :exintercom,
        :intercom_app_id,
        System.get_env("INTERCOM_APP_ID")
      ),

      Application.get_env(
        :exintercom,
        :intercom_app_id,
        System.get_env("INTERCOM_APP_KEY")
      )
    }
  end

  defp headers do
    [{"accept", "application/json"}]
  end
end
