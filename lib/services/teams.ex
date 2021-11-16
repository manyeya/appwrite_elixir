defmodule AppwriteElixir.Services.Teams do
  alias AppwriteElixir.Generics
  alias Jason

  @host Application.get_env(:appwrite_elixir, :host)

  @moduledoc """
  The Teams service allows you to group users of your project and
  to enable them to share read and write access to your project resources, such as database documents or storage files.
  Each user who creates a team becomes the team owner and can delegate the ownership role by inviting a new team member.
  Only team owners can invite new users to their team.
  """

  @typedoc """
  $id: Team ID.

  name: Team name.

  dateCreated: Team creation date in Unix timestamp.

  sum: Total sum of team members.
  """
  @type team_object :: %{
          id: String.t(),
          name: String.t(),
          dateCreated: integer(),
          sum: integer()
        }

  @type membership_object :: %{
          id: String.t(),
          userId: String.t(),
          teamId: String.t(),
          name: String.t(),
          email: String.t(),
          invited: integer(),
          joined: integer(),
          confirm: boolean(),
          roles: [
            String.t()
          ]
        }

  @type team_object_list :: [
          sum: integer(),
          teams: [
            team_object
          ]
        ]
  @type membership_object_list :: [
          sum: integer(),
          memberships: [
            membership_object
          ]
        ]
  @doc """
  Create a new team. The user who creates the team will automatically be assigned as the owner of the team.
  The team owner can invite new members, who will be able add new owners and update or delete the team from your project.
  """
  @spec create_team(String.t(), []) :: team_object
  def create_team(name, roles \\ []) do
    payload =
      Jason.encode!(%{
        name: name,
        roles: roles
      })

    Generics.post("http://#{@host}/v1/teams", payload)
  end

  @doc """
  Get a list of all of the project's teams. You can use the query params to filter your results.
  """
  @spec get_all_teams(String.t(), integer(), integer(), String.t()) :: team_object_list()
  def get_all_teams(search \\ "", limit \\ 25, offset \\ 0, orderType \\ "ASC") do
    Generics.get(
      "http://#{@host}/v1/teams?search=#{search}&limit=#{limit}&offset=#{offset}&orderType=#{orderType}"
    )
  end

  @doc """
  Get a team by its unique ID. All team members have read access for this resource.
  """
  @spec get_team(String.t()) :: team_object()
  def get_team(teamId) do
    Generics.get("http://#{@host}/v1/teams/#{teamId}")
  end

  @doc """
  Update a team by its unique ID. Only team owners have write access for this resource.
  """
  @spec update_team(String.t(), String.t()) :: team_object()
  def update_team(teamId, name) do
    payload =
      Jason.encode!(%{
        name: name
      })

    Generics.put("http://#{@host}/v1/teams/#{teamId}", payload)
  end

  @doc """
  Delete a team by its unique ID. Only team owners have write access for this resource.
  """
  @spec delete_team(String.t()) :: nil
  def delete_team(teamId) do
    Generics.delete("http://#{@host}/v1/teams/#{teamId}")
  end

  @doc """
  Creates team membership by team ID,email,user roles,redirect url and name
  """
  @spec create_team_membership(String.t(), String.t(), [...], String.t(), String.t()) ::
          membership_object()
  def create_team_membership(teamId, email, roles, url, name \\ "") do
    payload =
      Jason.encode!(%{
        email: email,
        roles: roles,
        url: url,
        name: name
      })

    Generics.post("http://#{@host}/v1/teams/#{teamId}/memberships", payload)
  end

  @doc """
  Update membership roles by team ID,membership ID,user roles
  """
  @spec update_team_membership_roles(String.t(), String.t(), [...]) :: membership_object()
  def update_team_membership_roles(teamId, membershipId, roles) do
    payload =
      Jason.encode!(%{
        roles: roles
      })

    Generics.put("http://#{@host}/v1/teams/#{teamId}/memberships/#{membershipId}", payload)
  end

  @doc """
  Get a team members by the team unique ID. All team members have read access for this list of resources.
  You can use the query params to filter your results.
  """
  @spec get_team_members(String.t(), String.t(), integer(), integer(), String.t()) ::
          membership_object_list()
  def get_team_members(teamId, search \\ "", limit \\ 25, offset \\ 0, orderType \\ "ASC") do
    Generics.get(
      "http://#{@host}/v1/teams/#{teamId}/memberships?search=#{search}&limit=#{limit}&offset=#{offset}&orderType=#{orderType}"
    )
  end

  @doc """
  Update Team Membership Status by Team unique ID,Membership ID,User unique ID and Secret key.
  """
  @spec update_team_membership_status(String.t(), String.t(), String.t(), String.t()) ::
          membership_object()
  def update_team_membership_status(teamId, membershipId, userId, secretKey) do
    payload =
      Jason.encode!(%{
        userId: userId,
        secretKey: secretKey
      })

    Generics.patch(
      "http://#{@host}/v1/teams/#{teamId}/memberships/#{membershipId}/status",
      payload
    )
  end

  @doc """
  Delete Team Membership by Team unique ID and Membership ID.
  """
  @spec delete_team_membership(String.t(), String.t()) :: nil
  def delete_team_membership(teamId, membershipId) do
    Generics.delete("http://#{@host}/v1/teams/#{teamId}/memberships/#{membershipId}")
  end
end
