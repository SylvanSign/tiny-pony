class Constructor
  var _id: USize = 0

  fun ref genotype(filename: String, sensor_name: String, actuator_name: String, hidden_layer_densities: Array[USize]) =>
    let s = _create_sensor(sensor_name)
    let a = _create_actuator(actuator_name)
    let output_vl = a.vl
    let layer_densities = hidden_layer_densities.append([output_vl])
    let cx_id = _generate_id()
    let neurons = _create_neuro_layers(cx_id, s, a, layer_densities)


  fun ref _generate_id(): Id =>
    _id = _id + 1

  fun ref _create_sensor(name: String): SensorRecord =>
    SensorRecord.rng(_generate_id())

  fun ref _create_actuator(name: String): ActuatorRecord =>
    ActuatorRecord.pts(_generate_id())

  fun ref _create_neuro_layers(cx_id: Id, s: SensorRecord, a: ActuatorRecord, layer_densities: Array[USize]) =>
    let input_idps = [(s.id, s.vl)]
    let tot_layers = layer_densities.size()
    let fl_neurons = layer_densities.shift()
