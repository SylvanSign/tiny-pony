actor Sensor
  let _out: OutStream
  let _rand: RandGenerator
  let _neuron: Neuron

  new create(out: OutStream, rand: RandGenerator iso, neuron: Neuron) =>
    _out = out
    _rand = consume rand
    _neuron = neuron

  be sync() =>
    let signal = _rand.signal(2)
    let msg = "****Sensing****\n Signal from environment " + Inspect(signal)
    _out.print(msg)
    _neuron.forward(signal)
