component Table {
  connect Deck exposing {
    actOn, consumedLength, deckLength, discarded,
    drawed, tableState
  }

  fun deckAction (action : DeckAction, e : Html.Event) { actOn(action) }

  fun draw {
    /*  */
    Debug.log("draw called, but nothing happen")
    /*  */
  }

  fun whatToShow : Array(CardValue) {
    case (tableState) {
      TableState::Classic => drawed
      TableState::Discard => discarded
    }
  }

  /* --- STYLES -------------------------------------- */

  style deckStyle {
    if (consumedLength < deckLength) {
      background: white;
    } else {
      background: none;
    }
  }

  /* --- FINAL RENDER -------------------------------- */

  fun render {
    <div class="table">
      <div class="first-line">
        <button onclick={ deckAction(DeckAction::Generate) }>"Generate a new deck"</button>
      </div>
      <div class="table-first-line">
        case (tableState) {
          TableState::Classic =>
            <>
              <div::deckStyle class="card deck-block">
                <button onClick={draw}>"Draw"</button>
              </div>
              <div class="card discard-block">
                if (Array.isEmpty(discarded)) {
                  <span class="no-discard">"Nothing discarded right now"</span>
                } else {
                  <span>"THERE IS SOMETHING!"</span>
                }
              </div>
            </>
          TableState::Discard =>
           <div>"looking into discarded"</div>
        }
      </div>
      <div class="table-show-zone">
        for (aCard of whatToShow()) { <Card config={aCard} /> }
      </div>
    </div>
  }
}
