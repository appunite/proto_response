[![Build Status](https://travis-ci.org/amatalai/proto_response.svg?branch=master)](https://travis-ci.org/amatalai/proto_response)
[![Hex.pm](https://img.shields.io/hexpm/v/proto_response.svg?style=flat&colorB=6B4D90)](https://hex.pm/packages/proto_response)
[![Hex.pm](https://img.shields.io/hexpm/dt/proto_response.svg?style=flat)](https://hex.pm/packages/proto_response)
# ProtoResponse

Asserts the given status code, that we have an application/x-protobuf response and returns the decoded Protobuf

## Installation

```elixir
def deps do
  [{:proto_response, "~> 0.2.0"}]
end
```

## Usage

```elixir
test "valid response", %{conn: conn} do
  #...

  assert proto_response(conn, 200, ProtoModule.ProtoMessage)
end
```

## License

  Copyright 2017 Tobiasz @amatalai Małecki <tobiasz.malecki@appunite.com>

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
