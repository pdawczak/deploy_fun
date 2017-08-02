defmodule Deploy.Repo do
  use Ecto.Repo, otp_app: :deploy

  def child_spec(_args) do
    %{id: __MODULE__, start: {__MODULE__, :start_link, []}, type: :supervisor}
  end

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end
end
