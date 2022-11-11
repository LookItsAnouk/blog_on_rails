class Ability
    include CanCan::Ability

  def initialize(user)

    user ||= User.new #guest user (not logged in)

    if user.admin?
        can :manage, :all
    elsif user.present?
        can :create, :update, :destroy, :all
    else
        can :read, :all
    end



    alias_action :create, :read, :update, :delete, :to => :crud

    can :crud, Post do |post|
        user == post.user
      end
  
    can :crud, Comment do |comment|
        user == comment.user 
    end
  
    end
end
