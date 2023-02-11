require 'set'

file_path = ARGV[0]

raise unless File.exist? file_path

jce_struct_name = Set.new
IO.foreach(file_path) do |line|
    trim_line = line.strip
    next unless trim_line.start_with? ("struct") or trim_line.start_with? 'enum'
    line_array = trim_line.split(" ")
    name = line_array.at(1)
    if name then
        jce_struct_name.add(name)
    end
end

if jce_struct_name then
    result_file = File.join(File.dirname(file_path),File.basename(file_path,".*") + 'result.txt')
    if File.exist? result_file then
        File.delete result_file
    end

    File.open(result_file,'w') do |file|
        jce_struct_name.each { |name|
            file.puts(name)
        }
    end
    system 'open ./'
end
