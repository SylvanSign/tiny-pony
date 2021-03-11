use "time"
use "random"
use "collections"

actor Main
  new create(env: Env) =>
    let n = SimpleNeuron(env)

actor SimpleNeuron
  let num_weights: USize = 3
  let weights: Array[F64] = Array[F64](num_weights)

  new create(env: Env) =>
    (let sec, let nano) = Time.now()
    let rand = Rand(sec.u64(), nano.u64())

    for i in Range(0, num_weights) do
      weights.push(rand.real() - 0.5)
    end
