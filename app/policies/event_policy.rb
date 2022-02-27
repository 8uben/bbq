class EventPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def show?
    record.pincode.blank? || update?
  end
end
