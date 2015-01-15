module GitRev
  class Sha

    def initialize(options={})
      repository = options[:repository] || Dir.pwd
      cache = options.has_key?(:cache) ? options[:cache] : true
      @repository=File.expand_path(repository)
      @cache = cache
      ensure_repository!
    end

    def full
      cached? && @revision || load_revision
    end

    def short
      full[0, 7]
    end

    private

    def cached?
      !!@cache
    end

    def git_repository?
      File.directory?(git_directory)
    end

    def git_directory
      File.join(@repository, '.git')
    end

    def ensure_repository!
      raise "Not a git repository #{@repository}" unless git_repository?
    end

    def load_revision
      head=File.read(File.join(git_directory, 'HEAD')).chomp
      # Detached head
      if sha1?(head)
        @revision = head
      else
        @revision = ref(head)
      end
    end

    def sha1?(subject)
      /^[0-9a-f]{40}$/ =~ subject
    end

    def ref(head)
      ref = head.scan(/^ref:\s+(.*)$/).first
      File.read(File.join(git_directory, ref)).chomp
    end

  end
end
