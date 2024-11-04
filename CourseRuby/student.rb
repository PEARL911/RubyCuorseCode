require 'date'

class Student
    attr_accessor :surname, :name, :date_of_birth

    @@unique_students = []  

    def initialize(surname, name, date_of_birth)
        self.date_of_birth = Date.parse(date_of_birth)
        @surname = surname
        @name = name 
       
        add_student  
    end
    
    def add_student       
      if @@unique_students.any? { |student| student.surname == @surname && student.name == @name && student.date_of_birth == @date_of_birth }
          raise ArgumentError, "student already exists"
      else
          @@unique_students << self
      end
  end
    
    def date_of_birth=(date)
        if date > Date.today
            raise ArgumentError, "the date cannot be in the future"
        else
            @date_of_birth = date
        end
    end

    def self.all_students
        @@unique_students
    end

    def calculate_age
        had_birthday_this_year = false  
        if @date_of_birth.month < Date.today.month || (@date_of_birth.month == Date.today.month && @date_of_birth.day <= Date.today.day)
          had_birthday_this_year = true
        end 
        years_in_student_age = Date.today.year - @date_of_birth.year
        age = had_birthday_this_year ? years_in_student_age : years_in_student_age - 1
        age
    end

    def remove_student
        self.class.students.delete(self)
    end 
    
    def self.get_students_by_age(age)
        @@unique_students.select { |student| student.calculate_age == age }
    end
    
    def self.get_students_by_name(name)
        @@unique_students.select { |student| student.name == name }
    end

end
