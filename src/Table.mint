component Table {
  connect Deck exposing { actOn, discarded, tableState }

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
      case (tableState) {
        TableState::Classic =>
          <div class="table-first-line">
            <div class="card deck-block">
              <button onClick={draw}>"Draw"</button>
            </div>
            <div class="card discard-block">
              case (discarded) {
                Maybe::Nothing =>
                  <span class="no-discard">"Nothing discarded right now"</span>
                Maybe::Just dis =>
                  <span>"THERE IS SOMETHING!"</span>
              }
            </div>
          </div>
        TableState::Discard =>
          <div>"looking into discarded"</div>
      }
    </div>
  }
}
