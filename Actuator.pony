actor Actuator
  let _out: OutStream

  new create(out: OutStream) =>
    _out = out

  be forward(signal: Array[F64] iso) =>
    let msg = "****Acting****\n Using " + Inspect(consume signal) + " to act on environment"
    _out.print(msg)
