require 'nokogiri'
doc2020 = File.open("laereplan2020.xml") { |f| Nokogiri::XML(f) }
doc2021 = File.open("laereplan2021.xml") { |f| Nokogiri::XML(f) }
lp2020 = doc2020.xpath("//lareplanurl")

lp2020.each do |node2020| 
  lp2020 = node2020.text.strip
  node2021 = doc2021.at("lareplanurl:contains(\"#{lp2020}\")")
  if(!node2021)
    puts lp2020
  end
end