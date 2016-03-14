require_relative './deployment_file_reader.rb'

class ReleaseJob
  attr_accessor :name, :path, :description, :templates, :packages, :properties

  def self.create_from_path(job_name, job_path)
    ReleaseJob.new job_name, job_path
  end

  def initialize(job_name, job_path)
    self.name = job_name
    self.path = job_path
    parse_spec_file spec_file_location
  end

  def to_s
    "#{name} \n #{path} \n #{description}"
  end

  def spec_file_location
    spec_file_location_from_path(path)
  end

  private

  def parse_spec_file(spec_file)
    spec = load_yml spec_file
    self.description = spec['description']
    self.templates = spec['templates']
    self.packages = spec['packages']
    self.properties = spec['properties']
  end

  def spec_file_location_from_path(path)
    "#{path}/spec"
  end
end
