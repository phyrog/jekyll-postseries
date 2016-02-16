module Jekyll
  class PostSeriesTag < Liquid::Tag
    
    def render(context)
      site = context.registers[:site]
      page = context.registers[:page]
      current_series = page["series"]
      type = page["collection"]
      puts site
      unless current_series.nil?
        collection = site.collections[type].map do |item|
          if item.data["series"] && item.data["series"] == current_series
            item
          end
        end.compact

        idx = collection.find_index { |p| p.id == page["id"] } + 1

        <<-TEXT
<div class="post-series">
  <h1>This is <strong>Part #{idx}</strong> in a <strong>#{collection.size}-Part</strong> series.</h1>
  <ol>
  #{collection.each_with_index.map do |item, i|
      if (i + 1) == idx
        "<li>Part #{i + 1}: #{item.data["title"]}</li>"
      else
        "<li><a href=\"#{item.url}\">Part #{i + 1}: #{item.data["title"]}</a></li>"
      end
  end .join("") }
  </ol>
</div>
        TEXT
      end
    end
  end
end

Liquid::Template.register_tag('post_series', Jekyll::PostSeriesTag)
