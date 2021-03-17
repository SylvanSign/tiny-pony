use "json"
use "files"

actor Main
  new create(env: Env) =>
    try
      for file_name in env.args.slice(1).values() do
        let data = read_file(env, file_name)?
        write_file(env, "new_" + file_name, data)?
      end
    end

  fun read_file(env: Env, file_name: String): Array[U8] ? =>
    let path = FilePath(env.root as AmbientAuth, file_name)?
    match OpenFile(path)
    | let file: File =>
      env.out.print("File size: " + file.size().string())
      let data = Array[U8](file.size())
      while file.errno() is FileOK do
        data.append(file.read(1024))
      end
      env.out.print("Array size: " + data.size().string())
      data
    else
      env.err.print("Error opening file '" + file_name + "'")
      []
    end

  fun write_file(env: Env, file_name: String, data: Array[U8]) ? =>
    let path = FilePath(env.root as AmbientAuth, file_name)?
    let file = File(path)
    file.write(data)
