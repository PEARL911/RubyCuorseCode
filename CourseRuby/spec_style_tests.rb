require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../CourseRuby/student'

Minitest::Reporters.use! [
  Minitest::Reporters::HtmlReporter.new(
    reports_dir: 'student_test/spec_test/reports',
    clean:false,
    add_timestamp: true
  )
]

describe Student do

  before do
    Student.class_variable_set(:@@unique_students, [])
    @student1 = Student.new("Bednov", "Ilya", '2000-11-09') 
    @student2 = Student.new("Churchill", "Varya", '2004-04-01') 
    @student3 = Student.new("Kaidash", "Maxim", '2001-08-12') 
  end

  describe "initialization" do 
    it 'add student' do
      expect(@student1.name).must_equal "Ilya"
      expect(@student1.surname).must_equal "Bednov"
      expect(@student1.date_of_birth).must_equal Date.parse("2000-11-09")
    end
  end 

  describe "add student" do 
    it 'future data' do    
      expect(proc {Student.new("Cactotax", "Rodion", '2045-11-09')}).must_raise ArgumentError
    end
  end 

  describe "add student" do 
    it 'duplicate' do
      expect(proc {Student.new("Kaidash", "Maxim", '2001-08-12')}).must_raise ArgumentError
    end
  end 

  describe "calculate age" do 
    it 'student current age' do
      expect(23).must_equal @student1.calculate_age
    end
  end 

  describe "get students by age" do 
    it 'students by age' do
      expect(2).must_equal Student.get_students_by_age(23).size
    end
  end 

  describe "get students by name" do 
    it 'students by name' do
      expect(1).must_equal Student.get_students_by_name("Maxim").size
    end
  end 
end