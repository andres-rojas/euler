#!/usr/bin/env ruby

# Poker hands
# Problem 54
# In the card game poker, a hand consists of five cards and are ranked, from lowest to highest, in the following way:

# High Card: Highest value card.
# One Pair: Two cards of the same value.
# Two Pairs: Two different pairs.
# Three of a Kind: Three cards of the same value.
# Straight: All cards are consecutive values.
# Flush: All cards of the same suit.
# Full House: Three of a kind and a pair.
# Four of a Kind: Four cards of the same value.
# Straight Flush: All cards are consecutive values of same suit.
# Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
# The cards are valued in the order:
# 2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.

# If two players have the same ranked hands then the rank made up of the highest value wins; for example, a pair of eights beats a pair of fives (see example 1 below). But if two ranks tie, for example, both players have a pair of queens, then highest cards in each hand are compared (see example 4 below); if the highest cards tie then the next highest cards are compared, and so on.

# Consider the following five hands dealt to two players:

# Hand    Player 1    Player 2    Winner
# 1   5H 5C 6S 7S KD
# Pair of Fives
#   2C 3S 8S 8D TD
# Pair of Eights
#   Player 2
# 2   5D 8C 9S JS AC
# Highest card Ace
#   2C 5C 7D 8S QH
# Highest card Queen
#   Player 1
# 3   2D 9C AS AH AC
# Three Aces
#   3D 6D 7D TD QD
# Flush with Diamonds
#   Player 2
# 4   4D 6S 9H QH QC
# Pair of Queens
# Highest card Nine
#   3D 6D 7H QD QS
# Pair of Queens
# Highest card Seven
#   Player 1
# 5   2H 2D 4C 4D 4S
# Full House
# With Three Fours
#   3C 3D 3S 9S 9D
# Full House
# with Three Threes
#   Player 1
# The file, poker.txt, contains one-thousand random hands dealt to two players. Each line of the file contains ten cards (separated by a single space): the first five are Player 1's cards and the last five are Player 2's cards. You can assume that all hands are valid (no invalid characters or repeated cards), each player's hand is in no specific order, and in each hand there is a clear winner.
#
# How many hands does Player 1 win?
#
#
#

# T J Q K A

def sortRanks(ranks)
  sorted = []

  ranks.each do |c|
    if (c =~ /[0-9]/)
      sorted << c.to_i
    else
      case c
      when 'T'
        sorted << 10
      when 'J'
        sorted << 11
      when 'Q'
        sorted << 12
      when 'K'
        sorted << 13
      when 'A'
        sorted << 14
      end
    end
  end

  sorted.sort
end

def Ranks(hand)
  hand.map { |c| c[0] }
end

def Suits(hand)
  hand.map { |c| c[1] }
end

def allSuitsMatch(hand)
  suits = Suits(hand)
  suit = suits[0]
  suitMatch = true

  suits.each do |s|
    unless s == suit
      suitMatch = false
      break
    end
  end

  suitMatch
end

def RoyalFlush(hand)
  if sortRanks(Ranks(hand)) == [10, 11, 12, 13, 14]
    allSuitsMatch(hand)
    # suits = Suits(hand)
    # suit = suits[0]
    # suitMatch = true

    # suits.each do |s|
    #   unless s == suit
    #     suitMatch = false
    #     break
    #   end
    # end

    # suitMatch
  else
    false
  end
end

def StraightFlush(hand)
  if allSuitsMatch(hand)
    ranks = sortRanks(Ranks(hand))
    ranks.each_index do |i|
      break if i == ranks.size - 1
      return false unless (ranks[i] - ranks[i + 1] ==  -1)
    end
    true
  else
    false
  end
end

def FourKind(hand)
end

def FullHouse(hand)
end

def Flush(hand)
end

def Straight(hand)
end

def ThreeKind(hand)
end

def TwoPairs(hand)
end

def OnePair(hand)
end

def HighCard(hand)
end

player1 = []
player2 = []

# File.open('p054_poker.txt').each do |l|
File.open('poker_test.txt').each do |l|
  hands = l.split(' ')
  player1 << hands[0..4]
  player2 << hands[5..9]
end

player1Won = 0

player1.each_index do |i|
  if RoyalFlush(player1[i])
    player1Won += 1 unless RoyalFlush(player2[i])
  else StraightFlush(player1[i])
    unless RoyalFlush(player2[i])
      player1Won +=1 if sortRanks(Ranks(player1[i]))[-1] > sortRanks(Ranks(player2[i]))[-1]
  end
end

puts "Player 1 won #{player1Won} hands!"