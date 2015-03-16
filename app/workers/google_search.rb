class GoogleSearch
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly.minute_of_hour(0,15,30,45) }

  def perform(query_term)
    agent = Mechanize.new
    page = agent.get('http://google.com/')
    search_form = page.form('f')
    search_form.q = query_term
    page = agent.submit(search_form)

    query = Query.where(name: query_term.downcase).first_or_create!

    page.search('.g').each do |p|
      a_html_tag = p.at('a').to_s
      next if a_html_tag.include? 'images'
      clean_name = strip(a_html_tag)
      clean_url = a_html_tag.split(%r{=|&})
      Link.where(url: clean_url[2]).first_or_create(name: clean_name, short_description: strip(p.css('.st').to_s), query_id: query.id)
    end
  end

  def strip(string)
    ActionController::Base.helpers.strip_tags(string)
  end
end
