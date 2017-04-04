defmodule Proto do
  use Protobuf, "
    message M {
      string text = 1;
    }
  "
end
