class Reservation < ApplicationRecord
  enum status: {
    requested: "requested",
    approved: "approved",
    rejected: "rejected",
    changed: "changed"
  }

  validates :status, inclusion: {in: RenewalRequest.statuses.keys}

  belongs_to :reserved_by, class_name: User
end
