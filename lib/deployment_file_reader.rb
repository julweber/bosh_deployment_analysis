require 'yaml'
require 'pp'
require 'erb'
require 'pp'

def load_yml(file_path)
  manifest_raw = File.read file_path
  erb = ERB.new manifest_raw
  YAML.load erb.result
end

def get_disk_pools(manifest_hash)
  manifest_hash['disk_pools']
end

def get_disk_pool(manifest_hash, disk_pool_name)
  get_disk_pools(manifest_hash).select { |dp| dp['name'] == disk_pool_name }.first
end

def get_resource_pools(manifest_hash)
  manifest_hash['resource_pools']
end

def get_jobs_with_instances(manifest_hash)
  manifest_hash['jobs'].select {|job| job['instances'] > 0 }
end

def get_properties(manifest_hash)
  manifest_hash['properties']
end
