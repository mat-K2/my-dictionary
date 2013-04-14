class Scrapinger
  def self.search(search_word)
    agent = Mechanize.new
    page = agent.get('http://dic.yahoo.co.jp/')
    yahoo_form = page.form('sbn')
    yahoo_form.radiobuttons_with(:value => "1")[0].check
    yahoo_form.p = search_word
    page = agent.submit(yahoo_form, yahoo_form.buttons.first)
    page.search(".content-detail")
  end
end
