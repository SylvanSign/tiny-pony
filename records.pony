type Id is USize

class SensorRecord
  let id: Id
  let name: String
  let vl: USize
  let fanout_neurons: Array[Neuron] = []

  new rng(id': Id) =>
    id = id'
    name = "rng"
    vl = 2

class ActuatorRecord
  let id: Id
  let name: String
  let vl: USize
  let fanin_ids: Array[Neuron] = []

  new pts(id': Id) =>
    id = id'
    name = "pts"
    vl = 1

type AF is {(F64): F64}
class NeuronRecord
  let id: Id
  let af: AF
  let vl: USize
  let fanout_neurons: Array[Neuron] = []

  new create(id': Id, af': AF, vl': USize) =>
    id = id'
    af = af'
    vl = vl'
