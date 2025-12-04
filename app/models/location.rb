class Location < ApplicationRecord
  has_many :stops
  has_many :manifests_as_original, class_name: 'Manifest', foreign_key: 'original_location_id'
  has_many :manifests_as_destination, class_name: 'Manifest', foreign_key: 'destination_location_id'
end
