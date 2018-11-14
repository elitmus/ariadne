module CustomExceptions
  # Exception raised when redis object is not found
  class RedisObjectNotAvailable < StandardError; end
  # Exception raised when App data not available
  class AppDataNotAvailable < StandardError; end
  # Exception raised when data is not available
  class DataNotAvailable < StandardError; end
  # Exception raised when ID is not available
  class IDNotAvailable < StandardError; end
end