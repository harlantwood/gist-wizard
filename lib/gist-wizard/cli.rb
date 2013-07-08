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
      run "mkdir -p #{gists_by_id_dir}", :quiet => true
      run "mkdir -p #{gists_by_name_dir}", :quiet => true

      page = 0
      while (gists = get_gists(page+=1); gists.present?)
        puts "* Gist group #{page}..."

        gists.each do |gist|
          id = gist['id']
          gist_dir = File.join(gists_by_id_dir, id)
          if Dir.exists?(File.join(gist_dir, '.git'))
            git_status = run "cd #{gist_dir} && git status --porcelain", :quiet => true
            if git_status.blank?
              run "cd #{gist_dir} && git pull --quiet", :quiet => true
            else
              warn "non-empty git status in:"
              puts gist_dir
            end
          else
            git_url = "git@gist.github.com:#{id}.git"
            run "git clone --quiet #{git_url} #{gist_dir}"
          end

          name = gist['description'].try(:slug).presence.try(:shellescape) || "gist-#{id}"
          run "ln -sFh #{File.join gists_by_id_dir, id} #{File.join gists_by_name_dir, name}", :quiet => true
        end
      end
    end

    no_tasks do
      def get_gists page
        json = RestClient.get "https://#{@user}:#{@password}@api.github.com/gists?page=#{page}"
        JSON.parse json
      end   
      
      def warn(warning)              
        warning = "WARNING: #{warning}"
        splats = [warning.to_s.size, 80].max
        puts '*' * splats
        puts warning
        puts '*' * splats
      end
    end

  end
end
