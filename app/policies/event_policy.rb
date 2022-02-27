class EventPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.present?
  end

  def show?
    record.pincode.blank? || update?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :user, :scope
  end
end
