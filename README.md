# ProtoResponse

Asserts the given status code, that we have an application/x-protobuf response and returns the decoded Protobuf

## Installation

```elixir
def deps do
  [{:proto_response, "~> 0.1.0"}]
end
```

## Usage

```elixir
test "valid response", %{conn: conn} do
  #...

  assert proto_response(conn, 200, ProtoModule.ProtoMessage)
end
```
