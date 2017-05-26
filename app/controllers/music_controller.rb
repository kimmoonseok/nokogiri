class MusicController < ApplicationController
  def index
    
    
    require 'open-uri'
    doc = Nokogiri::HTML(open("http://www.melon.com/chart/index.htm"))
    rank_array = Array.new
    name_array = Array.new
    image_array = Array.new
    if Music.count == 0
    #순위
    doc.css('div.wrap.right_none > span.rank').each do |y|
    rank_array.push(y.text().delete "\t" "\n")
    end
    
    #제목
    doc.css('div.wrap_song_info > div.ellipsis > span > strong > a').each do |y|
    name_array.push(y.text().delete "\t" "\n")
    end
    
    #이미지
    doc.css('div.wrap').each do |x|
      count = 0
      x.css('a > img').each do |y|
        if count>0
          break
        else
          image_array.push(y.attr('src'))
          count += 1
        end
      end
      
    end
      count = rank_array.length
      for i in (0..count-1)
      music = Music.new
      music.rank = rank_array[i]
      music.name = name_array[i]
      music.imge = image_array[i]
      music.save
      end
    end
    @music = Music.all
  end
  
  def edit
    @one_music = Music.find(params[:music_id])
  end

  def update
    @one_music = Music.find(params[:music_id])
    @one_music.rank = params[:rank]
    @one_music.name = params[:name]
    @one_music.save
    redirect_to :root
  end

  def destroy
    @one_music = Music.find(params[:music_id])
    @one_music.destroy
    redirect_to :root
  end
end