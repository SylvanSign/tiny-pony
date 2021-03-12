use "time"
use "random"
use "collections"

actor Main
  new create(env: Env) =>
    (let sec, let nano) = Time.now()
    let rand = Rand(sec.u64(), nano.u64())

    var w: Array[F64] iso = recover Array[F64](3) end
    for i in Range(0, 3) do
      w.push(rand.real() - 0.5)
    end
    let n1 = SimpleNeuron(env, recover val consume w end)
    n1.signal([1; 2])

    w = recover Array[F64](3) end
    for i in Range(0, 3) do
      w.push(rand.real() - 0.5)
    end
    let n2 = SimpleNeuron(env, recover val consume w end)
    n2.signal([1; 2])

actor SimpleNeuron
  let _env: Env
  let _weights: Array[F64] val

  new create(env: Env, weights: Array[F64] val) =>
    _env = env
    _weights = weights

  be signal(input: Array[F64] val) =>
    _env.out.print("****Processing****")
    _env.out.print(" Input: " + _inspect(input))
    _env.out.print(" Using Weights: " + _inspect(_weights))
    let dot_product: F64 = _dot(input, _weights)
    let output: Array[F64] val = [dot_product.tanh()]
    _env.out.print("Output: " + _inspect(output))

  fun _dot(input: Array[F64] val, weights: Array[F64] val): F64 =>
    var result: F64 = 0
    for i in Range(0, input.size()) do
      try result = result + (input(i)? * weights(i)?) end
    end
    try result = result + weights(weights.size() - 1)? end
    result

  fun _inspect(arr: Array[F64] val): String =>
    "; ".join(arr.values())
