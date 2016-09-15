# ## Student
# * `Student#initialize` should take a first and last name.
# * `Student#name` should return the concatenation of the student's
#   first and last name.
# * `Student#courses` should return a list of the `Course`s in which
#   the student is enrolled.
# * `Student#enroll` should take a `Course` object, add it to the
#   student's list of courses, and update the `Course`'s list of
#   enrolled students.
#     * `enroll` should ignore attempts to re-enroll a student.
# * `Student#course_load` should return a hash of departments to # of
#   credits the student is taking in that department.

class Student
  attr_accessor :first_name,:last_name,:courses

  def initialize(first,last)
    @first_name = first
    @last_name = last
    @courses = []
  end

  def name
    @first_name + " " + @last_name
  end

  def has_conflict?(new_course )
    @courses.each do |course|
      return true if course.conflicts_with?(new_course)
    end
    false
  end

  def enroll(course)
    raise Exception.new("course conflicts with already enrolled course") if has_conflict?(course)
    if (!@courses.include? course) && (!course.students.include? self)
      @courses << course
      course.students << self
    end
  end

  def course_load
    h = Hash.new(0)
    @courses.each do |course|
      h[course.department] += course.credits
    end
    h
  end


end
