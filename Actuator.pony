actor Actuator
  let _out: OutStream

  new create(out: OutStream) =>
    _out = out

  be forward(signal: Array[F64] val) =>
    let msg = "****Acting****\n Using " + Inspect(signal) + " to act on environment"
    _out.print(msg)
