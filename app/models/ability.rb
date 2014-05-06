class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/bryanrite/cancancan/wiki/Defining-Abilities

    user ||= User.new

    if user.role? :admin
        can :manage, :all
    elsif user.role? :instructor
        can :read, Camp
        can :read, Instructor
        can :read, Curriculum
        can :read, Location

        can :update, Instructor do |instructor|  
          instructor.id == user.instructor_id
        end
        can :update, User do |u|  
          u.id == user.id
        end
        can :edit, Instructor do |instructor|  
          instructor.id == user.instructor_id
        end
        can :edit, User do |u|  
          u.id == user.id
        end

        # only allow instructor to read students of their camp
        can :show, Student do |student|
          camps_students_ids = user.instructor.camps.map{|c| c.students.map{|s| s.id}}.flatten
          camps_students_ids.include?(student.id)
        end
    else
        can :read, Camp
        can :read, Instructor
        can :read, Location
        can :read, Curriculum
    end

  end
end
