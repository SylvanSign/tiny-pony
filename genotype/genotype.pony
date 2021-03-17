use "json"
use "files"

actor Main
  new create(env: Env) =>
    try
      for file_name in env.args.slice(1).values() do
        let data = read_file(env, file_name)?
        write_file(env, file_name, data)?
      end
    end

  fun read_file(env: Env, file_name: String): Array[U8] val ? =>
    let path = FilePath(env.root as AmbientAuth, file_name)?
    recover val
      let file = File(path)
      let data = Array[U8](file.size())
      while file.errno() is FileOK do
        data.append(file.read(1024))
      end
      data
    end

  fun write_file(env: Env, file_name: String, data: Array[U8] val) ? =>
    let path = FilePath(env.root as AmbientAuth, file_name)?
    let file = File(path)
    let doc = JsonDoc
    doc.parse(String.from_array(data))?
    let pretty = doc.string(where indent="  ", pretty_print=true)
    env.out.print(pretty)
    file.set_length(0)
    file.write(pretty)
