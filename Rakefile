require 'csv'
require 'fileutils'
require 'net/http'

namespace :clips do
  desc 'Download all clips for specified user and create a playlist'
  task :playlist, [:username] do |_task, args|
    username = args.username

    CSV.foreach('data.csv', headers: true) do |row|
      next unless row[1].casecmp(username).zero?

      clip_date = row[0]
      clip_url = row[2]

      sanitized_clip_date = "#{clip_date.gsub(/\W/, '')}.mp4"

      directory = File.join('clips', username)

      puts 'Downloading clip...'
      download(clip_url, directory, sanitized_clip_date)

      puts 'Adding to playlist...'
      append_to_playlist(clip_url, directory)
    end

    puts 'Done!'
  end
end

private

def download(url, directory, filename)
  FileUtils.mkdir_p(directory)
  filename_with_path = File.join(directory, filename)

  uri = URI(url)
  Net::HTTP.start(uri.host, uri.port) do |http|
    request = Net::HTTP::Get.new(uri)

    http.request(request) do |response|
      open(filename_with_path, 'w') do |io|
        response.read_body do |chunk|
          io.write(chunk)
        end
      end
    end
  end
end

def append_to_playlist(url, directory)
  filename_with_path = File.join(directory, '_playlist.m3u')

  open(filename_with_path, 'a') do |io|
    io.puts(url)
  end
end
