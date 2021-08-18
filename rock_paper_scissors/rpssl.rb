VALID_CHOICES = %w(rock paper scissors spock lizard)

WINS = { 'rock' => ['lizard', 'scissors'],
         'paper' => ['rock', 'spock'],
         'scissors' => ['lizard', 'paper'],
         'spock' => ['scissors', 'rock'],
         'lizard' => ['paper', 'spock'] }

def prompt(message)
  Kernel.puts("=> #{message}")
end

def user_input(input)
  case input.downcase
  when 'r'
    'rock'
  when 'p'
    'paper'
  when 'sc'
    'scissors'
  when 'sp'
    'spock'
  when 'l'
    'lizard'
  else
    input
  end
end

def win?(first, second)
  WINS[first].include?(second)
end

def display_result(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("You lost!")
  else
    prompt("It's a tie!")
  end
end

loop do # main loop
  computer_score = 0
  player_score = 0
  round = 1

  loop do
    Kernel.puts("----------ROUND #{round}------------")
    choice = ''
    loop do
      prompt("Choose one: rock(r), paper(p), scissors(sc), spock(sp), or lizard(l)")
      choice = user_input(Kernel.gets().chomp())

      if VALID_CHOICES.include?(choice)
        break
      else
        prompt("That's not a valid choice.")
      end
    end

    computer_choice = VALID_CHOICES.sample()

    Kernel.puts("You chose: #{choice}; Computer chose: #{computer_choice}")

    display_result(choice, computer_choice)

    if win?(choice, computer_choice)
      player_score += 1
    elsif win?(computer_choice, choice)
      computer_score += 1
    end

    break if player_score == 3 || computer_score == 3

    prompt("Current score: player #{player_score} vs computer #{computer_score}")
    Kernel.puts()

    round += 1
  end

  Kernel.puts()
  Kernel.puts("---------GAME FINISHED----------")
  prompt("Final score: player #{player_score} vs computer #{computer_score}")

  if player_score == 3
    prompt("Congratulations! You won the game!")
  else
    prompt("You lost the game. Sorry, better luck next time.")
  end

  Kernel.puts()

  prompt("Do you want to play again?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for playing. Good bye!")
