require 'sinatra/base'

class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end

module DribbbleAPI
  class Base < Sinatra::Base
    get '/*' do
      json_response
    end

    post '/*' do
      json_response
    end

    put '/*' do
      json_response
    end

    delete '/*' do
      json_response
    end

    protected

    def json_file_name
      @json_file_name ||= self.class.name.split('::').last.underscore
    end

    def json_response
      content_type :json
      status status_code
      headers response_headers
      file_name = "#{File.dirname(__FILE__)}/fixtures/#{json_file_name}.json"

      return {}.to_json unless File.exist? file_name

      File.open(file_name, 'rb')
    end

    def response_headers
      {}
    end
  end

  class Found < Base
    def status_code
      200
    end
  end

  class Updated < Found
  end

  class Created < Base
    def status_code
      201
    end
  end

  class Accepted < Base
    def status_code
      202
    end
  end

  class Deleted < Base
    def status_code
      204
    end
  end

  class NoContent < Deleted
  end

  class NotFound < Base
    def status_code
      404
    end
  end

  class Unauthorized < Base
    def status_code
      401
    end
  end

  class Unprocessable < Base
    def status_code
      422
    end

    protected

    def json_response
      content_type :json
      status status_code
      headers response_headers

      {
        message: "Validation failed.",
        errors: [
          { attribute: "user", message: "reached the daily limit of 5 shots" }
        ]
      }.to_json
    end
  end

  class AttachmentsSuccess < Found
  end

  class AttachmentSuccess < Found
  end

  class AttachmentDeleted < Deleted
  end

  class CommentsSuccess < Found
  end

  class CommentSuccess < Found
  end

  class CommentCreated < Created
  end

  class CommentUpdated < Updated
  end

  class CommentDeleted < Deleted
  end

  class CommentLikesSuccess < Found
  end

  class CommentLikeSuccess < Found
  end

  class CommentLikeNotFound < NotFound
  end

  class CommentLikeCreated < Created
  end

  class CommentLikeDeleted < Deleted
  end

  class CurrentUserSuccess < Found
  end

  class BucketSuccess < Found
  end

  class BucketCreated < Created
  end

  class BucketUpdated < Updated
  end

  class BucketDeleted < Deleted
  end

  class BucketsSuccess < Found
  end

  class FollowersSuccess < Found
  end

  class FollowingSuccess < Found
  end

  class UserFollowSuccess < Found
  end

  class UserFollowNotFound < NotFound
  end

  class UserFollowCreated < NoContent
  end

  class UserFollowDeleted < Deleted
  end

  class UserLikesSuccess < Found
  end

  class ProjectSuccess < Found
  end

  class ProjectsSuccess < Found
  end

  class ShotUpdated < Updated
  end

  class ShotDeleted < Deleted
  end

  class ShotSuccess < Found
  end

  class ShotAccepted < Accepted
    def response_headers
      {
        'Location' => 'https://api.dribbble.com/v1/shots/471756'
      }
    end
  end

  class ShotLikeSuccess < Found
  end

  class ShotLikeNotFound < NotFound
  end

  class ShotLikeCreated < Created
  end

  class ShotLikeDeleted < Deleted
  end

  class ShotLikesSuccess < Found
  end

  class ShotsSuccess < Found
  end

  class TeamsSuccess < Found
  end

  class UserSuccess < Found
  end

  class UsersSuccess < Found
  end
end
