require "pry"

class Runner
  def self.run
    until (@instruction = gets.chomp) == "quit"
      puts execute_instruction(@instruction)
    end
  end

  def self.instructions
    {
      :S                => :students_command,
      :Student          => :students_command,
      :T                => :students_by_teacher_command,
      :Teacher          => :students_by_teacher_command,
      :C                => :students_by_classroom_command,
      :Classroom        => :students_by_classroom_command,
      :G                => :students_by_grade_command,
      :Grade            => :students_by_grade_command,
      :CT               => :teachers_by_classroom_command,
      :ClassroomTeacher => :teachers_by_classroom_command,
      :GT               => :teachers_by_grade_command,
      :GradeTeacher     => :teachers_by_grade_command,
    }
  end

  def self.noop(argument)
    "Don't know what to do with argument #{argument}. Try one of #{instructions.keys}."
  end

  def self.execute_instruction(instruction)
    send(*parse_instruction(instruction))
  end

  def self.parse_instruction(user_instruction)
    components  = user_instruction.split(" ")
    instruction = instructions[components.shift.to_sym]
    argument    = components.join(" ")

    if instruction.nil?
      instruction = :noop
      argument    = user_instruction
    end

    return instruction, argument
  end

  def self.command(command, *arguments, &block)
    results = self.send(command, *arguments)

    return "No results." if results.empty?
    return results.map(&block).join("\n")
  end

  def self.students_command(last_name)
    command(:students, last_name) do |student|
      "#{student.last_name}, #{student.first_name}, #{student.grade}, #{student.classroom}"
    end
  end

  def self.students_by_teacher_command(last_name)
    command(:students_by_teacher, last_name) do |student|
      "#{student.last_name}, #{student.first_name}"
    end
  end

  def self.students_by_classroom_command(last_name)
    command(:students_by_classroom, last_name) do |student|
      "#{student.last_name}, #{student.first_name}"
    end
  end

  def self.students_by_grade_command(grade)
    command(:students_by_grade, grade) do |student|
      "#{student.last_name}, #{student.first_name}, #{student.grade}, #{student.classroom}"
    end
  end

  def self.teachers_by_classroom_command(classroom)
    command(:teachers_by_classroom, classroom) do |teacher|
      "#{teacher.last_name}, #{teacher.first_name}, #{teacher.classroom}"
    end
  end

  def self.teachers_by_grade_command(grade)
    command(:teachers_by_grade, grade) do |teacher|
      "#{teacher.last_name}, #{teacher.first_name}, #{teacher.classroom}"
    end
  end

  def self.students(last_name)
    Models::Student.where(:last_name => last_name)
  end

  def self.students_by_teacher(last_name)
    teachers  = Models::Teacher.where(:last_name => last_name)
    classroom = teachers.first.classroom
    Models::Student.where(:classroom => classroom)
  end

  def self.students_by_teacher(last_name)
    teachers  = Models::Teacher.where(:last_name => last_name)
    students_by_classroom(teachers.first.classroom)
  end

  def self.students_by_classroom(classroom)
    Models::Student.where(:classroom => classroom)
  end

  def self.students_by_grade(grade)
    Models::Student.where(:grade => grade)
  end

  def self.teachers_by_classroom(classroom)
    Models::Teacher.where(:classroom => classroom)
  end

  def self.teachers_by_grade(grade)
    students = Models::Student.where(:grade => grade)

    students.map(&:classroom).map do |classroom|
      Models::Teacher.where(:classroom => classroom)
    end.flatten.uniq do |teacher|
      teacher.id
    end
  end
end
