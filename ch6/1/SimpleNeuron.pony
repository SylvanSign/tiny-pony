use "time"
use "random"
use "collections"

actor Main
  new create(env: Env) =>
    let n = SimpleNeuron(env)
    n.signal([1; 2; 3])

actor SimpleNeuron
  let _num_weights: USize = 3
  let _weights: Array[F64] = Array[F64](_num_weights)
  let _env: Env

  new create(env: Env) =>
    _env = env
    (let sec, let nano) = Time.now()
    let rand = Rand(sec.u64(), nano.u64())

    for i in Range(0, _num_weights) do
      _weights.push(rand.real() - 0.5)
    end

  be signal(inputs: Array[F64] val) =>
    _env.out.print("Got a signal")
