# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: isuxportal/resources/contestant.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("isuxportal/resources/contestant.proto", :syntax => :proto3) do
    add_message "isuxportal.proto.resources.Contestant" do
      optional :id, :int64, 1
      optional :team_id, :int64, 2
      optional :name, :string, 3
      optional :contestant_detail, :message, 7, "isuxportal.proto.resources.Contestant.ContestantDetail"
    end
    add_message "isuxportal.proto.resources.Contestant.ContestantDetail" do
      optional :github_login, :string, 1
      optional :discord_tag, :string, 2
      optional :is_student, :bool, 3
      optional :avatar_url, :string, 4
      optional :github_id, :string, 16
      optional :discord_id, :string, 17
    end
  end
end

module Isuxportal
  module Proto
    module Resources
      Contestant = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("isuxportal.proto.resources.Contestant").msgclass
      Contestant::ContestantDetail = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("isuxportal.proto.resources.Contestant.ContestantDetail").msgclass
    end
  end
end
