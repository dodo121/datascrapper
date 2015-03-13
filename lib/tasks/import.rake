desc 'Google search import'
task import: :environment do
  agent = Mechanize.new
  page = agent.get('http://google.com/')
  search_form = page.form('f')
  search_form.q = 'ruby'
  page = agent.submit(search_form)

  query = Query.create!(name: 'first')

  page.links.each do |link|
    if link.href.to_s =~/url.q/
      url = link.href.split(%r{=|&})
      if !url[1].include? "webcache"
        Link.create!(name: link.text, url: url[1], query_id: query.id)
      end
    end
  end
end
