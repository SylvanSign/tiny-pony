actor Cortex
  let _out: OutStream
  let _sensor: Sensor

  new create(out: OutStream, sensor: Sensor) =>
    _out = out
    _sensor = sensor

  be sense_think_act() =>
    _sensor.sync()
