defmodule ProtoResponse do
  def proto_response(conn, code, proto) do
    response = Phoenix.ConnTest.response(conn, code)

    case Plug.Conn.get_resp_header(conn, "content-type") |> List.first do
      "application/x-protobuf" <> _ ->
        :ok
      nil ->
        raise RuntimeError, message: "no content-type was set, expected a protobuf response"
      other ->
        raise RuntimeError, message: "expected content-type for json, got: \"#{other}\""
    end

    try do
      %{__struct__: ^proto} = response |> proto.decode()
    rescue
      _ ->
        raise RuntimeError, message: "could not decode Protobuf body"
    end
  end
end
