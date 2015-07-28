defmodule PhoenixApi.RootView do
  use PhoenixApi.Web, :view

  def render("index.json", %{info: info}) do
    info
  end
end
