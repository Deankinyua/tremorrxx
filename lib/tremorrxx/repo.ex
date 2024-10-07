defmodule Tremorrxx.Repo do
  use Ecto.Repo,
    otp_app: :tremorrxx,
    adapter: Ecto.Adapters.Postgres
end
