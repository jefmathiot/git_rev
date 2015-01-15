require 'spec_helper'
require 'fileutils'

describe GitRev::Sha do

  before do
    @tmpdir=Dir.mktmpdir
  end

  after do
    FileUtils.rm_rf(@tmpdir)
  end

  let(:sha) do
    subject.new( repository: @tmpdir)
  end

  let(:no_cache) do
    subject.new( repository: @tmpdir, cache: false)
  end

  def self.assert_revisions(update_method)

    def assert_and_update(subject, method)
      subject.full.must_equal revision
      send method, "b" * 40
    end

    it 'enables the cache by default' do
      assert_and_update(sha, update_method)
      sha.full.must_equal revision
    end

    it 'disables the cache' do
      assert_and_update(no_cache, update_method)
      no_cache.full.wont_equal revision
    end

    it 'provides the hash in short format' do
      sha.short.must_equal "aaaaaaa"
    end

  end

  it 'raises unless a git repository' do
    ex = ->{ sha }.must_raise RuntimeError
    ex.message.must_equal "Not a git repository #{@tmpdir}"
  end

  it 'defaults to the current directory' do
    subject.new.short.must_equal `git describe --always`.chomp
  end

  describe 'with a fake git repository' do

    before do
      @gitdir=FileUtils.mkdir_p(File.join(@tmpdir, '.git'))
      FileUtils.mkdir_p(File.join(@gitdir, 'refs/heads'))
    end

    let(:revision) do
      "a" * 7 + "b" * 33
    end

    def overwrite(path, contents)
      File.delete(path) if File.exists?(path)
      File.open(path, 'wb') do |f|
        f.write contents
      end
    end

    def write_head(contents)
      overwrite File.join(@gitdir, 'HEAD'), contents
    end

    def write_master_ref(revision)
      overwrite File.join(@gitdir, 'refs/heads/master'), revision
    end

    describe 'on a branch' do

      before do
        write_head "ref: refs/heads/master"
        write_master_ref revision
      end

      assert_revisions :write_master_ref

    end

    describe 'on a detached HEAD' do

      before do
        write_head revision
      end

      assert_revisions :write_head

    end

  end

end
