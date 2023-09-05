class ReservationLineItem < ApplicationRecord
  belongs_to :reservation
  belongs_to :reservable, polymorphic: true
  belongs_to :creator, class_name: "User"
end
