use "collections"

actor Neuron
  let _out: OutStream
  let _weights: Array[F64] val
  let _actuator: Actuator

  new create(out: OutStream, weights: Array[F64] val, actuator: Actuator) =>
    _out = out
    _weights = weights
    _actuator = actuator

  be forward(input: Array[F64] val) =>
    let dot_product = _dot(input, _weights)
    let output = [dot_product.tanh()]
    let msg = "****Thinking****\n" +
              " Input: " + Inspect(input) + "\n" +
              " With Weights: " + Inspect(_weights) + "\n" +
              "Output: " + Inspect(output)
    _out.print(msg)
    _actuator.forward(output)

  fun _dot(input: Array[F64] box, weights: Array[F64] box): F64 =>
    var result: F64 = 0
    for i in Range(0, input.size()) do
      try result = result + (input(i)? * weights(i)?) end
    end
    try result = result + weights(weights.size() - 1)? end
    result
