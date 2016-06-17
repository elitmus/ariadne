require 'redis-namespace'
module DataUtil
  def self.init_redis_cli(redis_obj: nil, app_name:)
    redis_conn = redis_obj
    @redis_cli = Redis::Namespace.new(app_name, :redis => redis_conn)
  end

  def self.get_data_from_redis(id:)
    keys = @redis_cli.keys id
    raise "Data not available for #{app_name}!" if keys.empty?
    keys.compact!
    redis_data = (@redis_cli.mget keys)
    redis_data
  rescue StandardError => e
    puts e
  end

  def self.insert_data_in_redis(options = {})
    options[:time] = Time.now
    redis_data = nil
    @redis_cli.pipelined do
      redis_data = @redis_cli.set options[:id], options.to_json
      @redis_cli.expire(options[:id], (24 * 60 * 60)) # expire a key after 1 day
    end
    redis_data
  end
end
