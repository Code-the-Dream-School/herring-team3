class Ability
  # Defines the abilities that users have
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    case user.role
    when "admin"
      admin_abilities
    when "teacher"
      teacher_abilities(user)
    when "speaker"
      speaker_abilities(user)
    else # Default abilities for guest or regular users
      user_abilities(user)
    end
  end

  private

  # Abilities shared across all users (guest and logged-in)
  def shared_abilities
    can :read, Kit
    can :read, KitItem
    can :create, Contact
  end

  # Abilities for regular users (non-guest)
  def user_abilities(user)
    shared_abilities
    can :read, User
    can :update, User, id: user.id
    can :profile, User
    can :create, Donation, user_id: user.id
    can :read, Donation, user_id: user.id
    cannot :update, Donation
  end

  # Abilities for teachers
  def teacher_abilities(user)
    user_abilities(user)
    can :create, Order
    can :read, Order, user_id: user.id
    can :update, Order, user_id: user.id
    can :read, Event
    can :read, Availability
    can :read, Booking, order: { user_id: user.id }
    can :create, Booking
    can :update, Booking
  end

  # Abilities for speakers
  def speaker_abilities(user)
    user_abilities(user)
    can :read, Booking, event: { speaker_id: user.id }
    can :manage, Booking
    can :manage, Event, speaker_id: user.id
    can :update, Booking, event: { speaker_id: user.id }
    can :manage, Availability, speaker_id: user.id
  end

  # Abilities for admin
  def admin_abilities
    can :manage, :all
  end
end
