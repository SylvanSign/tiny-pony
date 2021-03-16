actor Main
  new create(env: Env) =>
    let rand = RandGenerator
    let out = env.out

    let actuator = Actuator(out)
    let neuron = Neuron(out, rand.weights(3), actuator)
    let sensor = Sensor(out, consume rand, neuron)
    let cortex = Cortex(out, sensor)

    cortex.sense_think_act()
