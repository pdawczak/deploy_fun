defmodule DeployWeb.PageController do
  use DeployWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
