enum DataState {
  FromDeck
  Modified(String)
}

enum DeckAction {
  ChangeDataState(DataState)
  Generate
  /* TODO : not sure about ParseData */
  ParseData(String)
  /*  */
}

enum TableState {
  Classic
  Discard
}

store Deck {
  state consumedLength = 0
  state current = []
  state dataState = DataState::FromDeck
  state deck = []
  state deckLength = 54 /* TODO : bad calculation */
  state discarded = []
  state drawed = []
  state tableState = TableState::Classic

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
      next { current = ncurr }
      next { dataState = DataState::FromDeck }
      DataErr::No
    } catch Object.Error => error {
      DataErr::Fail("Something went bad when trying to decode")
    }
  } where {
    decCurr = Object.Decode.array(Object.Decode.number)
  }

  fun generate {
    sequence {
      next { deck = DeckHelper.buildDeck() }
      next { current = cards }
    }
  } where {
    cards = Array.range(0, deckLength - 1)
    |> Array.mapWithIndex(
      (i : Number, v : Number) { DeckHelper.rand(deckLength - i) })
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
      Object.Encode.array(current)
      |> Object.Encode.field("curr")
  }

  fun reset {
    /* */
    void
  }




  fun testlogDeck {
    sequence {
      Debug.log(current)
      Debug.log(Array.size(current))
    }
  }

}
