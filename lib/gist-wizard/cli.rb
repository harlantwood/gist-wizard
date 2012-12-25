require 'thor'
require 'rest_client'
require 'superstring'
require 'easy_shell'
require 'awesome_print' rescue nil
require 'json'

module GistWizard

  class CLI < Thor

    desc :down, 'Sync gists down from a github account'
    def down
      @user = ENV['GITHUB_USER'] or raise("Please set env var GITHUB_USER")
      @password = ENV['GITHUB_PASS'] or raise("Please set env var GITHUB_PASS")
      gists_by_id_dir = ENV['GISTS_BY_ID_DIR'] or raise("Please set env var GISTS_BY_ID_DIR")
      gists_by_name_dir = ENV['GISTS_BY_NAME_DIR'] or raise("Please set env var GISTS_BY_NAME_DIR")
      gists_by_id_dir = File.expand_path gists_by_id_dir
      gists_by_name_dir = File.expand_path gists_by_name_dir
      run "mkdir -p #{gists_by_id_dir}"
      run "mkdir -p #{gists_by_name_dir}"

      page = 0
      while (gists = get_gists(page+=1); gists.present?)
        puts "* page #{page} *"

        gists.each do |gist|
        #[gists.first].each do |gist|
          id = gist['id']
          gist_dir = File.join(gists_by_id_dir, id)
          if Dir.exists?(File.join(gist_dir, '.git'))
            git_status = run("cd #{gist_dir} && git status --porcelain", :return_result => true, :quiet => true)
            if git_status.blank?
              run "cd #{gist_dir} && git pull --quiet"
            else
              puts "Aborting: non-empty git status in #{gist_dir.inspect}:"
              puts git_status
              exit 1
            end
          else
            git_url = "git@gist.github.com:#{id}.git"
            run "git clone --quiet #{git_url} #{gist_dir}"
          end

          name = gist['description'].try(:slug).presence.try(:shellescape).presence || "gist-#{id}"
          puts "name: #{name.inspect}"
          run "ln -sFhv #{File.join gists_by_id_dir, id} #{File.join gists_by_name_dir, name}"
        end
      end
    end

    no_tasks do
      def get_gists page
        json = RestClient.get "https://#{@user}:#{@password}@api.github.com/gists?page=#{page}"
        JSON.parse json
      end
    end

  end
end
