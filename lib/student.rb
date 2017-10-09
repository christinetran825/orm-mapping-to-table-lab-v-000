class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(id=nil, name, grade)
    @id = id
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      )
      SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute(DROP TABLE students)
  end

  def save
    sql <<- SQL
      INSERT INTO students(name, grade)
      VALUES (?, ?)
      SQL

    DB[:conn].execute(sql)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

end

#
#   describe "#save" do
#     it 'saves an instance of the Student class to the database' do
#       Student.create_table
#       josh.save
#       expect(josh.id).to eq(1)
#       expect(DB[:conn].execute("SELECT * FROM students")).to eq([[1, "Josh", "9th"]])
#     end
#   end
#
#   describe ".create" do
#     before(:each) do
#       Student.create_table
#     end
#     it 'takes in a hash of attributes and uses metaprogramming to create a new student object. Then it uses the #save method to save that student to the database' do
#       Student.create(name: "Sally", grade: "10th")
#       expect(DB[:conn].execute("SELECT * FROM students")).to eq([[1, "Sally", "10th"]])
#     end
#     it 'returns the new object that it instantiated' do
#       student = Student.create(name: "Josh", grade: "9th")
#       expect(student).to be_a(Student)
#       expect(student.name).to eq("Josh")
#       expect(student.grade).to eq("9th")
#     end
#   end
# end
