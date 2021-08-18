# Get loan amount
# Get Annual Percentage Rate (APR)
# Get loan duration. (in month)
# convert the APR to monthly interest (APR/12)
# monthly_payment = loan_amount * (monthly_interest / ( 1 - ( 1 + monehtly_interest)**(-loan_duration)))

require 'yaml'
MESSAGES = YAML.load_file('morg_calc_msgs.yml')

def prompt(yml_key)
  ">> " + MESSAGES[yml_key]
end

def valid_num?(input)
  input.to_i.to_s == input || input.to_f.to_s == input
end

loop do # main loop of the calculator

  # Get loan amount
  loan_amount = ''

  Kernel.puts(prompt('msg_amount'))

  loop do
    loan_amount = Kernel.gets().chomp()
    if valid_num?(loan_amount)
      break
    else
      Kernel.puts(prompt('msg_valid_amount'))
    end
  end

  # Get APR and save it as a monthly rate.
  monthly_rate = ''

  Kernel.puts(prompt('msg_apr'))

  loop do
    apr = Kernel.gets().chomp()
    if valid_num?(apr)
      monthly_rate = (apr.to_f / 12) / 100
      break
    else
      Kernel.puts(prompt('msg_valid_apr'))
    end
  end

  # Get loan duration in years and save it in months.
  monthly_duration = ''

  Kernel.puts(prompt('msg_duration'))

  loop do
    yearly_duration = Kernel.gets().chomp()
    if valid_num?(yearly_duration)
      monthly_duration = yearly_duration.to_i * 12
      break
    else
      Kernel.puts(prompt('msg_valid_dur'))
    end
  end

  # Calculate monthly payment
  monthly_payment =
    loan_amount.to_f *
    (monthly_rate / (1 - (1 + monthly_rate)**(- monthly_duration)))

  Kernel.puts(prompt('msg_result') + monthly_payment.round(2).to_s + ".")
  Kernel.puts()
  Kernel.puts(prompt('msg_repeat'))
  repeat_input = Kernel.gets().chomp()

  break unless repeat_input.downcase == 'y' || repeat_input.downcase == 'yes'
end

Kernel.puts(prompt('msg_thx'))
