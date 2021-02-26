require 'nokogiri'
doc2020 = File.open("laereplan2020.xml") { |f| Nokogiri::XML(f) }
doc2021 = File.open("laereplan2021.xml") { |f| Nokogiri::XML(f) }
lp2020 = doc2020.xpath("//fag")
lp2021 = doc2021.xpath("//fag")


fag2021hash = { }

lp2021.each do |node2021| 
  fag2021 = node2021.attr("navn").scan(/\(([^\)]*)/)[0][0].strip
  fag2021hash[fag2021] = fag2021
end

lp2020.each do |node2020| 
  fag2020navn = node2020.attr("navn").scan(/\(([^\)]*)/)
  if(fag2020navn.length > 0)
    fag2020 = fag2020navn[0][0].strip
    if(!fag2021hash.key(fag2020))
      puts fag2020
    end
  end
end


