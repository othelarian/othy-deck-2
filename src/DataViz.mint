enum DataErr {
  No
  Fail(String)
}

component DataViz {
  connect Deck exposing { actOn, dataState, decodeJson, printData }

  state areaval = ""
  state err = DataErr::No

  get borderColor {
    case (err) {
      DataErr::No => "white"
      DataErr::Fail v => "red"
    }
  }

  fun cancelMod (e : Html.Event) {
    sequence {
      deckAction(DeckAction::ChangeDataState(DataState::FromDeck), e)
      next { areaval = printData() }
      next { err = DataErr::No }
    }
  }

  fun componentDidMount : Promise(Never, Void) {
    next { areaval = printData() }
  }

  fun deckAction (action : DeckAction, e : Html.Event) { actOn(action) }

  fun genNewDeck (e : Html.Event) {
    sequence {
      deckAction(DeckAction::Generate, e)
      next { areaval = printData() }
    }
  }

  fun loadFromFile (e : Html.Event) {
    sequence {
      file = File.select("")
      fl = File.readAsString(file)
      case (Json.parse(fl)) {
        Maybe::Just v => case (decodeJson(v)) {
          DataErr::No => Window.alert("File successfully loaded!")
          DataErr::Fail e => Window.alert(e)
        }
        Maybe::Nothing =>
          Window.alert("Unable to parse the file! Are you sure it's the right file?")
      }
    }
  }

  fun loadFromTxtArea (e : Html.Event) {
    sequence {
      next { err = DataErr::No }
      case (Json.parse(areaval)) {
        Maybe::Just v =>
          next { err = decodeJson(v) }
        Maybe::Nothing =>
          next { err = DataErr::Fail("Malformed JSON detected") }
      }
    }
  }

  fun saveInFile (e : Html.Event) {
    `
    (() => {
      var blob = new Blob([#{areaval}], {type: 'text/plain'});
      var e = document.createEvent("MouseEvents");
      var a = document.createElement("a");
      a.download = "save_deck.json";
      a.href = window.URL.createObjectURL(blob);
      a.dataset.downloadurl = ["text/plain", a.download, a.href].join(':');
      e.initEvent('click', true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
      a.dispatchEvent(e);
    })()
    `
  }

  fun textareaChanged (e : Html.Event) {
    sequence {
      next { areaval = Dom.getValue(e.target) }
      deckAction(DeckAction::ChangeDataState(DataState::Modified(areaval)), e)
    }
  }

  style inp {
    border: 2px solid #{borderColor};
  }

  fun render {
    <div class="dataviz">
      case (dataState) {
        DataState::FromDeck =>
          <div class="first-line">
            <button onClick={genNewDeck}>"Generate a new deck"</button>
            <button onClick={loadFromFile}>"Load from file"</button>
            <button onClick={saveInFile}>"Save in a file"</button>
          </div>
        DataState::Modified v =>
          <div class="first-line">
            <button onClick={cancelMod}>"Cancel modification"</button>
            <button onClick={loadFromTxtArea}>"Parse the entry"</button>
          </div>
      }
      case (err) {
        DataErr::No => <></>
        DataErr::Fail v => <div class="err"><{v}></div>
      }
      <textarea::inp onInput={textareaChanged} value={areaval}/>
    </div>
  }
}