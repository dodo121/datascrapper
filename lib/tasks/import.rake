desc 'Google search import'
task import: :environment do
  agent = Mechanize.new
  agent.user_agent_alias = 'Mac Firefox'
  page = agent.get('http://google.com/')
  search_form = page.form('f')
  search_form.q = 'car'
  page = agent.submit(search_form)

  query = Query.create!(name: 'first')

  page.search('.g a').each do |p|
   clean_name = ActionController::Base.helpers.strip_tags(p.to_s)
   next if clean_name == 'Podobne' || clean_name == 'Kopia' ||  clean_name.empty? || clean_name.include?("Obrazy")
   clean_url = p.attributes['href'].to_s.split(%r{=|&})
   Link.create(name: clean_name, url: clean_url[1], query_id: query.id)
  end

end
