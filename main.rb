require 'HTTParty'
require 'dotenv/load'
require 'launchy'

def check_args(arg0, arg1)
  if (ARGV[0].nil? || ARGV[0].strip == '')
    puts "\n+++> error. please enter query and page number arguments"
    puts "+++> ruby main.rb [query] [page-number]\n\n\n"
    raise '+++> try again'
  end

  if (ARGV[1].nil? || ARGV[1].strip == '' || !(ARGV[1].to_i > 0) )
    puts "\n+++> error. please enter query and page number arguments"
    puts "+++> ruby main.rb [query] [page-number]\n\n\n"
    raise '+++> try again'
  end
end

def compose_filename(query, page)
  "#{query}_page_#{page}.txt"
end

def save_to_file(data, query, page)
  dir = "#{File.dirname(__FILE__)}"
  filename = compose_filename(query, page)
  filepath = "#{File.dirname(__FILE__)}/data/#{filename}"

  output = ''
  data.each do |x|
    output += x + "\n"
  end
  File.open filepath, 'w' do |f|
    f.write output
  end
end

check_args(ARGV[0], ARGV[1])

query = ARGV[0]
page = ARGV[1]
url = "https://api.unsplash.com/search/photos?page=#{page}&query=#{query}&client_id=#{ENV['CLIENT_ID']}"
response = HTTParty.get(url)
data = JSON.parse(response.body)

total = data['total']
total_pages = data['total_pages']
results = data['results']
small_urls = results.map{|item| item.dig('urls', 'small')}
# pp small_urls

save_to_file(small_urls, query, page)
puts "+++> total: #{total}"
puts "+++> total_pages: #{total_pages}\n"
puts "+++> done. file created: #{compose_filename(query, page)}\n\n"

filename = compose_filename(query, page)
filepath = "#{File.dirname(__FILE__)}/data/#{filename}"
IO.foreach(filepath) do |line|
  Launchy.open(line)
end
