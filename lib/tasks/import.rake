desc 'Google search import'
task import: :environment do
  agent = Mechanize.new
  agent.user_agent_alias = 'Mac Firefox'
  page = agent.get('http://google.com/')
  search_form = page.form('f')
  search_form.q = 'car'
  page = agent.submit(search_form)

  query = Query.create!(name: 'first')

  page.search('.g').each do |p|
    a_html_tag = p.at('a').to_s
    next if a_html_tag.include? 'images'
    clean_name = strip(a_html_tag)
    clean_url = a_html_tag.split(%r{=|&})
    Link.create(name: clean_name, url: clean_url[2], short_description: strip(p.css('.st').to_s), query_id: query.id)
  end
end

def strip(string)
  ActionController::Base.helpers.strip_tags(string)
end
