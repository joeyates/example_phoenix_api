defmodule PhoenixApi.RootControllerTest do
  use ExUnit.Case
  use Phoenix.ConnTest

  @endpoint PhoenixApi.Endpoint

  test "GET /" do
    conn = get conn(), "/"
    assert json_response(conn, 200) == %{"info" => %{"name" => "PhoenixApi"}}
  end
end
