defmodule PhoenixApi.ClimbView do
  use PhoenixApi.Web, :view

  def render("index.json", %{climbs: climbs}) do
    %{data: render_many(climbs, "climb.json")}
  end

  def render("show.json", %{climb: climb}) do
    %{data: render_one(climb, "climb.json")}
  end

  def render("climb.json", %{climb: climb}) do
    %{id: climb.id}
  end
end
