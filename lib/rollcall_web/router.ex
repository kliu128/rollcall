defmodule RollcallWeb.Router do
  use RollcallWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {RollcallWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Unauthenticated pages
  scope "/", RollcallWeb do
    pipe_through :browser

    get "/", PageController, :index

    scope "/auth" do
      get "/signout", AuthController, :signout
      get "/:provider", AuthController, :request
      get "/:provider/callback", AuthController, :callback
    end
  end

  # Authenticated pages
  scope "/", RollcallWeb do
    pipe_through :browser

    live "/events", EventLive.Index, :index
    live "/events/new", EventLive.New, :new
    live "/events/:id/edit", EventLive.Index, :edit

    live "/events/:id", EventLive.Show, :show
    live "/events/:id/show/edit", EventLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", RollcallWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: RollcallWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
