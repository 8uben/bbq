class UserPolicy < ApplicationPolicy
  def show?
    true
  end

  def edit?
    update?
  end

  def update?
    user_is_owner?(record)
  end

  private

  def user_is_owner?(user_record)
    user_record == user
  end
end
