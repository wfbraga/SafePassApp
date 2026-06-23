class EntryPolicy < ApplicationPolicy
  def show?
    record.user == user || record.shared_users.include?(user)
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      Entry.where(user: user).or(
        Entry.joins(:shares).where(shares: { user: user })
      )
    end
  end
end
