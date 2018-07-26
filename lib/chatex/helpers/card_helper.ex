defmodule Chatex.Helpers.CardHelper do
  @moduledoc """
  Helper facilitar crear google chat cards.
  """

  @doc """
  https://developers.google.com/hangouts/chat/reference/message-formats/cards#buttons
  """
  @spec button(String.t, String.t, String.t) :: map
  @spec button(String.t, String.t, String.t, list) :: map
  def button("text", text, redirect) do
    %{textButton: %{text: text, onClick: %{openLink: %{url: redirect}}}}
  end
  def button("icon", name, redirect) do
    %{imageButton: %{icon: name, onClick: %{openLink: %{url: redirect}}}}
  end
  def button("image", icon, redirect) do
    %{imageButton: %{iconUrl: icon, onClick: %{openLink: %{url: redirect}}}}
  end
  def button("text", text, action, parameters) do
    %{textButton: %{text: text, onClick: %{
      action: %{actionMethodName: action, parameters: parameters}}
    }}
  end

  @doc """
  Ayuda a establer como se representará en el chat una lista de botones.
  """
  @spec buttons_display(String.t, list) :: map | list
  def buttons_display("inline", buttons) do
    %{buttons: Enum.map(buttons, fn button -> button end)}
  end
  def buttons_display("block", buttons) do
    Enum.map(buttons, fn button -> %{buttons: [button]} end)
  end
  def buttons_display("widget", buttons) do
    Enum.map(buttons, fn button -> %{widgets: [%{buttons: [button]}]} end)
  end

  @doc """
  https://developers.google.com/hangouts/chat/reference/message-formats/cards#headers
  """
  @spec header(String.t, String.t, String.t, String.t) :: map
  def header(title, subtitle \\ nil, image \\ nil, style \\ "IMAGE") do
    %{title: title, subtitle: subtitle, imageUrl: image, imageStyle: style}
  end
end
