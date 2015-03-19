class GoogleSearch
  include Sidekiq::Worker

  def perform(query_term, user_id, refresh_time)
    agent = Mechanize.new
    page = agent.get('http://google.com/')
    search_form = page.form('f')
    search_form.q = query_term
    page = agent.submit(search_form)

    query = Query.where("name = ?",  query_term.downcase).first_or_create(name: query_term.downcase, user_id: user_id)

    page.search('.g').to_enum.with_index(1).each do |p, index|
      a_html_tag = p.at('a').to_s
      next if a_html_tag.include? 'images'
      clean_name = strip(a_html_tag)
      clean_url = a_html_tag.split(%r{=|&})
      position = Position.new(number: index)
      position.link = Link.where("url = ?", clean_url[2]).first_or_create(name: clean_name, url: clean_url[2], short_description: strip(p.css('.st').to_s), query_id: query.id)
      position.link.check_seo_change
      position.save!
    end
    #GoogleSearch.perform_in(refresh_time.to_i.minutes, query_term, user_id, refresh_time)
  end

  def strip(string)
    ActionController::Base.helpers.strip_tags(string)
  end
end
