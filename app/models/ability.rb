class Ability
    include CanCan::Ability

  def initialize(user)

    user ||= User.new #guest user (not logged in)

    can :read, :all

    return unless user.present?
    
    can [:read, :update], :all, user: user
    
    return unless user.admin?
    
    can :manage, :all


    alias_action :create, :read, :update, :delete, :to => :crud

    can :crud, Post do |post|
        user == post.user
      end
  
    can :crud, Comment do |comment|
        user == comment.user 
    end
  
    end
end
