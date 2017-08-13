defmodule ProtoResponseTest do
  use ExUnit.Case

  import Phoenix.ConnTest
  import Plug.Conn
  import ProtoResponse

  test "when response is valid" do
    resp = Proto.M.new(text: "test") |> Proto.M.encode()
    conn = build_conn() |> put_resp_content_type("application/x-protobuf") |> send_resp(200, resp)

    assert %Proto.M{text: "test"} = proto_response(conn, 200, Proto.M)
  end

  test "raise when response can't be decoded" do
    conn = build_conn() |> put_resp_content_type("application/x-protobuf") |> send_resp(200, "test")

    assert_raise(
      RuntimeError,
      "could not decode Protobuf body",
      fn -> proto_response(conn, 200, Proto.M) end
    )
  end

  test "raise when response status is incorrect" do
    conn = build_conn() |> put_resp_content_type("application/x-protobuf") |> send_resp(400, "")

    assert_raise(
      RuntimeError,
      "expected response with status 200, got: 400, with body:\n",
      fn -> proto_response(conn, 200, Proto.M) end
    )
  end

  test "raise when content-type is missing" do
    resp = Proto.M.new(text: "test") |> Proto.M.encode()
    conn = build_conn() |> send_resp(200, resp)

    assert_raise(
      RuntimeError,
      "no content-type was set, expected a protobuf response",
      fn -> proto_response(conn, 200, Proto.M) end
    )
  end

  test "raise when content-type is invalid" do
    resp = Proto.M.new(text: "test") |> Proto.M.encode()
    conn = build_conn() |> put_resp_content_type("application/json") |> send_resp(200, resp)

    assert_raise(
      RuntimeError,
      "expected content-type for protobuf, got: \"application/json; charset=utf-8\"",
      fn -> proto_response(conn, 200, Proto.M) end
    )
  end

  test "checks status code before headers" do
    conn = build_conn() |> send_resp(400, "")

    assert_raise(
      RuntimeError,
      "expected response with status 200, got: 400, with body:\n",
      fn -> proto_response(conn, 200, Proto.M) end
    )
  end
end
