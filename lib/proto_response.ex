defmodule ProtoResponse do

  @doc """
  Helper function similar to `Phoenix.ConnTest.json_response/2`, but for
  protobufs.

  Asserts the given status code, that we have an application/x-protobuf
  response and returns the decoded protobuf.

  Doesn't validate decoded protobuf corectness.
  If wrong protobuf module is provided it may still pass unless protobuf
  library makes decode/1 function to fail.

  Tested with `exprotobuf` and `protobuf` packages, but it should work
  with any solution that creates module with `decode/1` function.

  Example:

      test "valid response", %{conn: conn} do
        #...

        assert proto_response(conn, 200, ProtoModule.ProtoMessage)
      end
  """
  def proto_response(conn, code, proto) do
    response = Phoenix.ConnTest.response(conn, code)

    case Plug.Conn.get_resp_header(conn, "content-type") |> List.first do
      "application/x-protobuf" <> _ ->
        :ok
      nil ->
        raise RuntimeError, message: "no content-type was set, expected a protobuf response"
      other ->
        raise RuntimeError, message: "expected content-type for protobuf, got: \"#{other}\""
    end

    try do
      %{__struct__: ^proto} = response |> proto.decode()
    rescue
      _ ->
        raise RuntimeError, message: "could not decode Protobuf body"
    end
  end
end
