use "files"

actor Main
  new create(env: Env) =>
    try
      for file_name in env.args.slice(1).values() do
        let path = FilePath(env.root as AmbientAuth, file_name)?
        match OpenFile(path)
        | let file: File =>
          let contents = recover val
            let cs = Array[U8](file.size())
            while file.errno() is FileOK do
              cs.append(file.read(1024))
            end
            cs
          end
          env.out.print(String.from_array(contents))
        else
          env.err.print("Error opening file '" + file_name + "'")
        end
      end
    end
