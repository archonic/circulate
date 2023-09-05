class Reservation < ApplicationRecord
  enum status: {
    requested: "requested",
    approved: "approved",
    rejected: "rejected",
    replaced: "replaced",
    cancelled: "cancelled",
    fulfilled: "fulfilled"
  }, _default: :requested

  validates :status, inclusion: {in: RenewalRequest.statuses.keys}

  belongs_to :reserver, class_name: "User"
  has_many :line_items, class_name: "ReservationLineItem"
end
