use "time"
use "random"
use "collections"

class RandGenerator
  embed _rand: Rand ref

  new iso create() =>
    (let sec, let nano) = Time.now()
    _rand = Rand(sec.u64(), nano.u64())

  fun iso weights(num: USize): Array[F64] val =>
    (consume this)._reals(num, -0.5)

  fun iso signal(num: USize): Array[F64] val =>
    _reals(num)

  fun iso _reals(num: USize, bias: F64 = 0): Array[F64] val =>
    var ws: Array[F64] = Array[F64](num)
    for i in Range(0, num) do
      ws.push(_rand.real() + bias)
    end
    recover val ws end
