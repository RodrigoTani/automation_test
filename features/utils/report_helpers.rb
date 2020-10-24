require 'json'

# report Helpers
class ReportHelpers
  def self.delete_failed_tests
    file_list = Dir['*.json']
    file_list.each do |json_file_name|
      if File.file?(json_file_name)
        failed_scenario = []
        file = File.read(json_file_name)
        unless file.empty?
          json = JSON.parse(file)
          json.each do |scenario|
            scenario['elements'].each do |element|
              element['steps'].each do |step|
                if step['result']['status'] == 'failed'
                  puts "deletado cenário: #{element['name']}"
                  failed_scenario << scenario
                end
              end
            end
          end
          new_json = json - failed_scenario
          File.open(json_file_name, 'w') do |f|
            f.write(new_json.to_json)
          end
        end
      else
        puts "Log de execução: #{[json_file_name]} encontrado! Nenhum cenário foi deletado."
      end
    end
  end

  def self.join_parallel_failed_tests
    file_list = Dir['*.txt']
    output_file = ''
    file_list.each do |txt_file|
      if File.file?(txt_file)
        file = File.read(txt_file)
        output_file << file << ' ' unless file.empty?
      end
    end
    File.open('cucumber_failures_parallel.txt', 'w') do |f|
      f.write(output_file)
    end
  end
end
