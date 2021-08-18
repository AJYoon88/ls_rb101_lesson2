# ask the user for two numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the result

require 'yaml'
MESSAGES = YAML.load_file('calculator_msgs.yml')

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  num.to_i.to_s == num
end

def number?(num)
  integer?(num) || float?(num)
end

def integer?(num)
  num.to_i.to_s == num
end

def float?(num)
  num.to_f.to_s == num
end

def operation_to_message(op, lang)
  x = case op
      when '1'
        message('add', lang)
      when '2'
        message('subt', lang)
      when '3'
        message('mult', lang)
      when '4'
        message('div', lang)
      end
  x
end

def message(msg, lang = 'en')
  MESSAGES[lang][msg]
end

prompt(message('language'))

lang_input = ''
loop do
  lang_input = Kernel.gets().chomp()

  if lang_input == "1" || lang_input == "2"
    break
  else
    prompt(message('valid_lang'))
  end
end

case lang_input
when "1"
  lang = "en"
when "2"
  lang = "kor"
end

prompt(message('welcome', lang))

name = ''

loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt(message('valid_name', lang))
  else
    break
  end
end

prompt(message('greet', lang) + "#{name}!")

loop do # main loop
  number1 = ''
  loop do
    prompt(message('first_num', lang))
    number1 = Kernel.gets().chomp()
    if valid_number?(number1)
      break
    else
      prompt(message('invalid_num', lang))
    end
  end

  number2 = ''
  loop do
    prompt(message('second_num', lang))
    number2 = Kernel.gets().chomp()
    if valid_number?(number2)
      break
    else
      prompt(message('invalid_num', lang))
    end
  end

  prompt(message('opt', lang))

  operator = ''
  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(message('invalid_op', lang))
    end
  end

  prompt(operation_to_message(operator, lang) + message('calc', lang))

  result = case operator
           when '1'
             number1.to_i() + number2.to_i()
           when '2'
             number1.to_i - number2.to_i
           when '3'
             number1.to_i * number2.to_i
           when '4'
             number1.to_f / number2.to_f
           end

  prompt(message('result', lang) + result.to_s)
  prompt(message('repeat', lang))
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt(message('thanks', lang))