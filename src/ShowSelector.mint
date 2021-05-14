enum Show {
  Table
  Data
  Settings
}

store ShowTime {
  state showed : Show = Show::Table

  fun changeShow(show : Show) { next { showed = show } }
}

component ShowSelector {
  connect ShowTime exposing { showed, changeShow }

  fun showToName (show : Show) : String {
    case (show) {
      Show::Table => "The table"
      Show::Data => "Save & Data"
      Show::Settings => "Settings"
    }
  }

  fun switchShow (show : Show, e : Html.Event) { changeShow(show) }

  fun btn (show : Show) : Html {
    if (show == showed) {
      <button class="selected"><{ showToName(show) }></button>
    } else {
      <button class="unselected" onClick={switchShow(show)}>
      <{ showToName(show) }>
      </button>
    }
  }

  fun render : Html {
    <div class="header">
      for (show of shows) { btn(show) }
    </div>
  } where {
    shows = [Show::Table, Show::Data, Show::Settings]
  }
}