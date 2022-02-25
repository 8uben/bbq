class EventPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def show?
    update?
  end

  def edit?
    update?
  end

  def update?
    user_is_owner?(record)
  end

  def destroy?
    update?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  private

  def user_is_owner?(event)
    user.present? && (event.try(:user) == user)
  end
end
