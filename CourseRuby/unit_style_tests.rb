require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../CourseRuby/student'

Minitest::Reporters.use! [
  Minitest::Reporters::HtmlReporter.new(
    reports_dir: 'student_test/unit_test/reports',
    clean:false,
    add_timestamp: true
  )
]

class StudentTest < Minitest::Test
  def setup
    Student.class_variable_set(:@@unique_students, []) 
    
    @student1 = Student.new("Bednov", "Ilya", '2000-11-09') 
    @student2 = Student.new("Churchill", "Varya", '2004-04-01') 
    @student3 = Student.new("Kaidash", "Maxim", '2001-08-12') 
  end

  def test_add_student
    assert_includes Student.all_students, @student1
  end

  def test_add_student_with_future_data
    assert_raises(ArgumentError) {student5 = Student.new("Cactotax", "Rodion", '2045-11-09')} 
  end

  def test_add_student_duplicate
    assert_raises(ArgumentError) {student6 = Student.new("Kaidash", "Maxim", '2001-08-12') } 
  end

  def test_calculate_age
    assert_equal 23, @student1.calculate_age
  end 
  
  def test_get_students_by_age
      assert_equal 2, Student.get_students_by_age(23).size
  end

  def test_get_students_by_name
    assert_equal 1, Student.get_students_by_name("Maxim").size
  end
end 