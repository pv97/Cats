require 'byebug'

class CatRentalRequest < ActiveRecord::Base
  REQUEST_STATES = %w{PENDING APPROVED DENIED}
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: { in: REQUEST_STATES,
    message: "%{value} is not a valid request state" }
  validate :overlapping_approved_requests

  belongs_to :cat,
    class_name: :Cat,
    foreign_key: :cat_id,
    primary_key: :id

  def ordered_dates
    if self.start_date > self.end_date
      self.errors[:start_date] << "must be before end date"
      return false
    end
    true
  end

  def overlapping_requests
    self.class.where(
      "end_date > ? AND start_date < ?", self.start_date, self.end_date
    ).where(cat_id: self.cat_id).where.not(id: self.id)
  end

  def overlapping_approved_requests
    return true unless self.status == "APPROVED"
    overlap = overlapping_requests
    approved = overlap.where(status:"APPROVED")
    unless approved.empty?
      self.errors[:cat_id] << "is already booked during that period"
      return false
    end
    true
  end

  def approve!
    begin
      ActiveRecord::Base.transaction do
        self.update!(status: "APPROVED")
        overlapping_requests.each(&:deny!)
      end
    rescue ActiveRecord::RecordInvalid => arri
      return false
    end
    true
  end

  def deny!
    self.update!(status: "DENIED")
  end
end
