require_relative './release_job.rb'

# Represents a BOSH release
class Release
  attr_reader :name, :path, :jobs, :release_jobs, :jobs_directory, :specs

  # @path [String] full path to the release base directory
  def initialize(path)
    @jobs_directory = "#{path}/jobs/"
    job_directories = Dir["#{jobs_directory}*"]
    @jobs = job_directories.map { |j| { name: j.sub(jobs_directory, ''), path: j } }

    @release_jobs = jobs.map do |job_hash|
      ReleaseJob.create_from_path job_hash[:name], job_hash[:path]
    end
  end

  def all_job_properties
    job_properties = {}

    @release_jobs.each do |s|
      s.properties.each do |p|
        property_name = p.first
        description = p.last["description"]
        job_name = s.name
        default = p.last["default"]

        if job_properties[property_name].nil?
          job_properties[property_name] = {jobs: [job_name], default: default, description: description}
        else
          job_properties[property_name][:jobs] << job_name
          if job_properties[property_name][:default].nil?
            job_properties[property_name][:default] = default unless default.nil?
          end
          if job_properties[property_name][:description].nil?
            job_properties[property_name][:description] = default unless description.nil?
          end
        end
      end
    end
    job_properties.sort
  end

  def optional_job_properties
    all_job_properties.select { |k,v| !v[:default].nil? }
  end

  def required_job_properties
    all_job_properties.select { |k,v| v[:default].nil? }
  end

  def job_properties_count
    all_job_properties.count
  end

  def required_job_properties_count
    required_job_properties.count
  end

  def optional_job_properties_count
    optional_job_properties.count
  end
end
