enum LogState {
  LogOn
  LogOff
}

component Main {
  connect ShowTime exposing { showed }
  connect Deck exposing { generate, testlogDeck }

  state logState = LogState::LogOn

  fun componentDidMount : Promise(Never, Void) {
    sequence { generate() }
  }

  fun testlog {
    testlogDeck()
  }

  fun render : Html {
    <>
      <ShowSelector/>
      case (showed) {
        Show::Table => <Table/>
        Show::Data => <DataViz/>
        Show::Settings => <Settings/>
      }
      case (logState) {
        LogState::LogOn => <button onClick={testlog}>"log"</button>
        LogState::LogOff => <></>
      }
    </>
  }
}
