module Jekyll
  class PostSeriesTag < Liquid::Tag
    
    def render(context)
      current_series = context.registers[:page]["series"]
      unless current_series.nil?
        posts = context.registers[:site].posts.map do |post|
          if !post.data["series"].nil? && post.data["series"] == current_series
            post
          end
        end.compact

        idx = posts.find_index { |p| p.id == context.registers[:page]["id"] } + 1

        <<-TEXT
<div class="post-series">
  <h1>This post is <strong>Part #{idx}</strong> in a <strong>#{posts.size}-Part</strong> series.</h1>
  <ol>
  #{posts.each_with_index.map do |p, i|
      if (i + 1) == idx
        "<li>Part #{i + 1}: #{p.data["title"]}</li>"
      else
        "<li><a href=\"#{p.url}\">Part #{i + 1}: #{p.data["title"]}</a></li>"
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
