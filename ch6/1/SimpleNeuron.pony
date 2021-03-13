use "time"
use "random"
use "collections"

actor Main
  new create(env: Env) =>
    (let sec, let nano) = Time.now()
    let rand = Rand(sec.u64(), nano.u64())
    let out = env.out

    for i in Range(0, 100) do
      SimpleNeuron(out, _weights(rand)).signal([1; 2])
    end

  fun _weights(rand: Rand): Array[F64] val =>
    var ws: Array[F64] iso = recover Array[F64](3) end
    for i in Range(0, 3) do
      ws.push(rand.real() - 0.5)
    end
    ws

actor SimpleNeuron
  let _out: OutStream
  let _weights: Array[F64] val

  new create(out: OutStream, weights: Array[F64] val) =>
    _out = out
    _weights = weights

  be signal(input: Array[F64] val) =>
    let dot_product: F64 = _dot(input, _weights)
    let output: Array[F64] val = [dot_product.tanh()]
    let str = "****Processing****\n" +
              " Input: " + _inspect(input) + "\n" +
              " Using Weights: " + _inspect(_weights) + "\n" +
              "Output: " + _inspect(output)
    _out.print(str)

  fun _dot(input: Array[F64] val, weights: Array[F64] val): F64 =>
    var result: F64 = 0
    for i in Range(0, input.size()) do
      try result = result + (input(i)? * weights(i)?) end
    end
    try result = result + weights(weights.size() - 1)? end
    result

  fun _inspect(arr: Array[F64] val): String =>
    "; ".join(arr.values())
