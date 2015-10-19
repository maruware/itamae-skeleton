require 'thor'
require 'pathname'

module ItamaeSkeleton
  class CLI < Thor
    desc 'init', 'generate itamae skeleton'
    def init
      template_dir = File.expand_path('../template', __FILE__)
      FileUtils.copy_entry(template_dir, '.')
    end

    desc 'destroy', 'delete itamae skeleton'
    def destroy
      template_dir = File.expand_path('../template', __FILE__)
      destroy_proc(template_dir, template_dir)
    end

    private
    def destroy_proc(base_dir, dir)
      Dir::glob("#{dir}/*").each do |path|
        rel_path = Pathname.new(path).relative_path_from(Pathname.new(base_dir))
        if FileTest.directory?(path)
          destroy_proc(base_dir, path)
          if dir_empty?(rel_path)
            Dir.delete(rel_path)
          end
        else
          if File.exist?(rel_path)
            File.delete(rel_path)
          end
        end
      end
    end

    def dir_empty?(dir)
      Dir::glob("#{dir}/{*, .*}").empty?
    end
  end
end