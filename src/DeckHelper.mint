enum CardValue {
  SuitCard(Suit, SuitValue)
  SpecialCard(SpecialValue)
}

enum Suit {
  Club
  Diamond
  Heart
  Spade
}

enum SuitValue {
  Ace
  Two
  Three
  Four
  Five
  Six
  Seven
  Eight
  Nine
  Ten
  Jack
  Queen
  King
}

enum SpecialValue {
  RedJoker
  BlackJoker
}

module DeckHelper {
  fun buildDeck () : Array(CardValue) {
    []
    |> Array.push(suitList(Suit::Spade))
    |> Array.push(suitList(Suit::Heart))
    |> Array.push(suitList(Suit::Club))
    |> Array.push(suitList(Suit::Diamond))
    |> Array.push(specialList())
    |> Array.concat()
  }

  fun rand (v : Number) : Number {
    Math.random() * v
    |> Math.floor()
  }

  fun specialList : Array(CardValue) {
    []
    |> Array.push(CardValue::SpecialCard(SpecialValue::BlackJoker))
    |> Array.push(CardValue::SpecialCard(SpecialValue::RedJoker))
  }

  fun suitList (suit : Suit) : Array(CardValue) {
    []
    |> Array.push(CardValue::SuitCard(suit, SuitValue::Ace))
    |> Array.push(CardValue::SuitCard(suit, SuitValue::Two))
    |> Array.push(CardValue::SuitCard(suit, SuitValue::Three))
    |> Array.push(CardValue::SuitCard(suit, SuitValue::Four))
    |> Array.push(CardValue::SuitCard(suit, SuitValue::Five))
    |> Array.push(CardValue::SuitCard(suit, SuitValue::Six))
    |> Array.push(CardValue::SuitCard(suit, SuitValue::Seven))
    |> Array.push(CardValue::SuitCard(suit, SuitValue::Eight))
    |> Array.push(CardValue::SuitCard(suit, SuitValue::Nine))
    |> Array.push(CardValue::SuitCard(suit, SuitValue::Ten))
    |> Array.push(CardValue::SuitCard(suit, SuitValue::Jack))
    |> Array.push(CardValue::SuitCard(suit, SuitValue::Queen))
    |> Array.push(CardValue::SuitCard(suit, SuitValue::King))
  }
}
