# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Exmail.Repo.insert!(%Exmail.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Exmail.Repo.insert!(Ecto.Changeset.change(%Exmail.User.Model{},  [email: "yatender@gmail.com", name: "yatender gmail"]) )
Exmail.Repo.insert!(Ecto.Changeset.change(%Exmail.User.Model{},  [email: "yatender@getvokal.com", name: "yatender getvokal"]) )
Exmail.Repo.insert!(Ecto.Changeset.change(%Exmail.User.Model{},  [email: "jeet@gmail.com", name: "jeet gmail"] ))

