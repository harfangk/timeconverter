defmodule Timeconverter do
  @moduledoc """
  Documentation for Timeconverter.
  """
  
  def convert_datetime(%{"format" => format, "time" => time}) do
    case format do
      "to_unix" -> iso8601_to_unix(time)
      "to_iso8601" -> unix_to_iso8601(time)
      _ -> {:error, ~s{Format should be either "to_unix" or "to_iso8601"}}
    end
  end
  def convert_datetime(%{}), do: {:error, ~s{time and format parameters should be specified. Format should be either "to_unix" or "to_iso8601", and time should be in either of those formats.} }

  defp iso8601_to_unix(time) do
    valid_iso8601 = ~r/^(?:[0-9]\d{3}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1\d|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[1-9]\d(?:0[48]|[2468][048]|[13579][26])|(?:[2468][048]|[13579][26])00)-02-29)T(?:[01]\d|2[0-3]):[0-5]\d:[0-5]\d(?:Z|[+-][01]\d:[0-5]\d)$/
    case Regex.match?(valid_iso8601, time) do
      true -> {:ok, time |> DateTime.from_iso8601() |> elem(1) |> DateTime.to_unix()}
      _    -> {:error, ~s{Invalid format for iso8601 input. Should be like "2015-01-17T21:23:02+00:00"}}
    end
  end

  defp unix_to_iso8601(time) do
    valid_unix = ~r/^[-+]?\d+$/
    case Regex.match?(valid_unix, time) do
      true -> {:ok, time |> String.to_integer() |> DateTime.from_unix!() |> DateTime.to_iso8601()}
      _    -> {:error, ~s{Invalid format for unix input. Should be like "1464096368"}}
    end
  end
end
