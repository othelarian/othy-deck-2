enum DeckAction {
  ChangeDataState(DataState)
  Generate
  /* TODO : not sure about ParseData */
  ParseData(String)
  /*  */
}

module DeckHelper {
  fun rand (v : Number) : Number {
    Math.random() * v
    |> Math.floor()
  }
}

enum DataState {
  FromDeck
  Modified(String)
}

store Deck {
  state curr = []
  state dataState = DataState::FromDeck

  fun actOn(action : DeckAction) {
    case (action) {
      DeckAction::ChangeDataState newState  =>
        if (dataState != newState) {
          next { dataState = newState }
        } else { sequence { void } }
      DeckAction::Generate =>
        sequence {
          res = Window.confirm("Are you sure about generating a new deck?")
          reset()
          generate()
          void
        } catch String => e { void }
      DeckAction::ParseData data =>
        sequence { void }
    }
  }

  fun decodeJson (v : Object) : DataErr {
    try {
      ncurr =
        Object.Decode.field("curr", decCurr, v)
      next { curr = ncurr }
      next { dataState = DataState::FromDeck }
      DataErr::No
    } catch Object.Error => error {
      DataErr::Fail("Something went bad when trying to decode")
    }
  } where {
    decCurr = Object.Decode.array(Object.Decode.number)
  }

  fun generate {
    next { curr = cards }
  } where {
    lgth = 14 /* TODO : modify the lgth */
    cards = Array.range(0, 14)
    |> Array.mapWithIndex(
      (i : Number, v : Number) { DeckHelper.rand(lgth - (i - 1)) })
  }

  fun printData : String {
    case (dataState) {
      DataState::FromDeck => printToJson()
      DataState::Modified v => v
    }
  }

  fun printToJson : String {
    [jsonCurr]
    |> Object.Encode.object()
    |> Json.stringify()
  } where {
    jsonCurr =
      Object.Encode.array(curr)
      |> Object.Encode.field("curr")
  }

  fun reset {
    /* */
    void
  }




  fun testlogDeck {
    Debug.log(curr)
  }

}
