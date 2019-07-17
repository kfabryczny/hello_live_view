defmodule HelloLiveViewWeb.UserIndexTest do
  use HelloLiveViewWeb.LiveViewCase
  alias HelloLiveView.{Accounts, Fixtures}

  @view HelloLiveViewWeb.UserIndex

  test "created user will show up on the view", %{conn: conn} do
    {:ok, view, html} = live(conn, Routes.live_path(conn, @view))
    user = Fixtures.user_fixture()
    refute html =~ user.username
    assert render(view) =~ ~s(<a href="#{Routes.live_path(conn, HelloLiveViewWeb.UserShow, user)}">#{user.username}</a>)
  end

  test "deleted user will not show up on the view", %{conn: conn} do
    user = Fixtures.user_fixture()
    {:ok, view, html} = live(conn, Routes.live_path(conn, @view))
    assert html =~ user.username
    Accounts.delete_user(user)
    refute render(view) =~ user.username
  end

  test "updated user will show updates on the view", %{conn: conn} do
    user = Fixtures.user_fixture()
    {:ok, view, html} = live(conn, Routes.live_path(conn, @view))
    assert html =~ user.username
    updated_username = "newusername"
    {:ok, _user} = Accounts.update_user(user, %{username: updated_username})
    html = render(view)
    assert html =~ updated_username
    refute html =~ user.username
  end
end
