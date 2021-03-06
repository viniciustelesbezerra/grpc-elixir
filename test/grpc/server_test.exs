defmodule GRPC.ServerTest do
  use ExUnit.Case, async: true

  defmodule Greeter.Service do
    use GRPC.Service, name: "hello"
  end

  defmodule Greeter.Server do
    use GRPC.Server, service: Greeter.Service
  end

  test "stop/2 works" do
    assert {%{"hello" => GRPC.ServerTest.Greeter.Server}} =
             GRPC.Server.stop(Greeter.Server, adapter: GRPC.Test.ServerAdapter)
  end

  test "stream_send/2 works" do
    stream = %GRPC.Server.Stream{adapter: GRPC.Test.ServerAdapter, marshal: & &1}
    response = <<1, 2, 3, 4, 5, 6, 7, 8>>
    assert %GRPC.Server.Stream{} = GRPC.Server.stream_send(stream, response)
  end
end
