defmodule PhoenixApi.RootController do
  use PhoenixApi.Web, :controller

  def index(conn, _params) do
    render conn, info: %{"info" => %{"name" => "PhoenixApi"}}
  end
end
