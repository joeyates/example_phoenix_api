defmodule PhoenixApi.ErrorViewTest do
  use PhoenixApi.ConnCase, async: true

  import Phoenix.View

  test "renders 404.json" do
    json = render_to_string(PhoenixApi.ErrorView, "404.json", [])
    result = Poison.Parser.parse!(json)
    assert result["status"] == 404
    assert result["message"] == "Page not found"
  end

  test "render 500.json" do
    json = render_to_string(PhoenixApi.ErrorView, "500.json", [])
    result = Poison.Parser.parse!(json)
    assert result["status"] == 500
    assert result["message"] == "Internal server error"
  end

  test "render any other" do
    json = render_to_string(PhoenixApi.ErrorView, "999.json", [])
    result = Poison.Parser.parse!(json)
    assert result["status"] == 500
    assert result["message"] == "Internal server error"
  end
end
