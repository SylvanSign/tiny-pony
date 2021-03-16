use "time"
use "random"
use "collections"

class RandGenerator
  embed _rand: Rand iso

  new iso create() =>
    _rand = recover
      (let sec, let nano) = Time.now()
      Rand(sec.u64(), nano.u64())
    end

  fun ref weights(num: USize): Array[F64] val =>
    _reals(num, -0.5)

  fun ref signal(num: USize): Array[F64] val =>
    _reals(num)

  fun ref _reals(num: USize, bias: F64 = 0): Array[F64] val =>
    recover val
      var ws: Array[F64] = Array[F64](num)
      for i in Range(0, num) do
        ws.push(_rand.real() + bias)
      end
      ws
    end
