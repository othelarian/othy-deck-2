component Card {
  connect Deck exposing { tableState }

  property config : CardValue

  fun renderSuitValue (suit : Suit, value : SuitValue) : Html {
    valueToStr(value, suitToStr(suit))
  } where {
    suitToStr = (suit : Suit) : String {
      case (suit) {
        Suit::Club => "♣"
        Suit::Diamond => "♦"
        Suit::Heart => "♥"
        Suit::Spade => "♠"
      }
    }
    valueToStr = (value : SuitValue, suitStr : String) : Html {
      case (value) {
        SuitValue::Ace => <span class="ace"><{suitStr}></span>
        SuitValue::Two => <span class="big"><{suitStr}><br /><{suitStr}></span>
        SuitValue::Three =>
          <span class="big"><{suitStr}><br /><{suitStr}>"  "<{suitStr}></span>
        SuitValue::Four =>
          <span class="big">
            <{suitStr}>"  "<{suitStr}><br />
            <{suitStr}>"  "<{suitStr}>
          </span>
        SuitValue::Five =>
          <span class="medium">
            <{suitStr}>"  "<{suitStr}><br />
            <{suitStr}><br />
            <{suitStr}>"  "<{suitStr}>
          </span>
        SuitValue::Six =>
          <span class="medium">
            <{suitStr}>"  "<{suitStr}><br />
            <{suitStr}>"  "<{suitStr}><br />
            <{suitStr}>"  "<{suitStr}>
          </span>
        SuitValue::Seven =>
          <span class="medium">
            <{suitStr}>"  "<{suitStr}><br />
            <{suitStr}>"  "<{suitStr}>"  "<{suitStr}><br />
            <{suitStr}>"  "<{suitStr}>
          </span>
        SuitValue::Eight =>
          <span class="medium">
            <{suitStr}>"  "<{suitStr}>"  "<{suitStr}><br />
            <{suitStr}>"  "<{suitStr}><br />
            <{suitStr}>"  "<{suitStr}>"  "<{suitStr}>
          </span>
        SuitValue::Nine =>
          <span class="medium">
            <{suitStr}>"  "<{suitStr}>"  "<{suitStr}><br />
            <{suitStr}>"  "<{suitStr}>"  "<{suitStr}><br />
            <{suitStr}>"  "<{suitStr}>"  "<{suitStr}>
          </span>
        SuitValue::Ten =>
          <span class="medium">
            <{suitStr}>"  "<{suitStr}>"  "<{suitStr}>"  "<{suitStr}><br />
            <{suitStr}>"  "<{suitStr}><br />
            <{suitStr}>"  "<{suitStr}>"  "<{suitStr}>"  "<{suitStr}>
          </span>
        SuitValue::Jack => figureToStr("Jack", suitStr)
        SuitValue::Queen => figureToStr("Queen", suitStr)
        SuitValue::King => figureToStr("King", suitStr)
      }
    }
    figureToStr = (figure : String, suitStr : String) : Html {
      <span class="figure">
        <{figure}><br />
        <span class="figure-suit"><{suitStr}></span>
      </span>
    }
  }

  fun renderSpecialValue (value : SpecialValue) : Html {
    case (value) {
      SpecialValue::RedJoker =>
        <span class="medium">"Red"<br />"♦♥"<br />"Joker"</span>
      SpecialValue::BlackJoker =>
        <span class="medium">"Black"<br />"♣♠"<br />"Joker"</span>
    }
  }

  fun render {
    <div class="card">
      case (config) {
        CardValue::SuitCard suit value => renderSuitValue(suit, value)
        CardValue::SpecialCard value => renderSpecialValue(value)
      }
      <span class="card-btn">
        case (tableState) {
          TableState::Classic => <button>"(classic)"</button>
          TableState::Discard => <button>"(discard)"</button>
        }
      </span>
    </div>
  }
}
