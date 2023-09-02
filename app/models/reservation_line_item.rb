class ReservationLineItem < ApplicationRecord
  belongs_to :reservation
  belongs_to :reservable, polymorphic: true
end
