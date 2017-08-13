if System.get_env("PROTOBUF_PACKAGE") == "exprotobuf" do
  defmodule Proto do
    use Protobuf, "
      message M {
        string text = 1;
      }
    "
  end
end

if System.get_env("PROTOBUF_PACKAGE") == "protobuf" do
  defmodule Proto.M do
    use Protobuf

    defstruct [:text]

    field :text, 1, optional: true, type: :string
  end
end
