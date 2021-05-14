component Table {
  connect Deck exposing { actOn }

  fun deckAction (action : DeckAction, e : Html.Event) { actOn(action) }

  fun draw {
    /*  */
    Debug.log("draw called, but nothing happen")
    /*  */
  }

  fun render {
    <div class="table">
      <div class="first-line">
        <button onclick={ deckAction(DeckAction::Generate) }>"Generate a new deck"</button>
      </div>
      <div class="deck-block">
        <button onClick={draw}>"Draw"</button>
      </div>
    </div>
  }
}
