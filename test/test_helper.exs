ExUnit.start

Mix.Task.run "ecto.create", ~w(-r ConnectionCard.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r ConnectionCard.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(ConnectionCard.Repo)

