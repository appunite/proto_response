defmodule ProtoResponse do
  defmacro proto_response(conn, code, proto) do
    proto = Macro.expand(proto, __CALLER__)

    quote bind_quoted: [conn: conn, code: code, proto: proto] do
      case Plug.Conn.get_resp_header(conn, "content-type") |> List.first do
        "application/x-protobuf" <> _ ->
          :ok
        nil ->
          raise RuntimeError, message: "no content-type was set, expected a protobuf response"
        other ->
          raise RuntimeError, message: "expected content-type for json, got: \"#{other}\""
      end

      response = Phoenix.ConnTest.response(conn, code)

      try do
        %{__struct__: ^proto} = response |> proto.decode()
      rescue
        _ ->
          raise RuntimeError, message: "could not decode Protobuf body"
      end
    end
  end
end
