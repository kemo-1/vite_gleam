import gleam/int
import lustre
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/event

// MAIN ------------------------------------------------------------------------

pub fn main() {
  let app = lustre.simple(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", 0)

  Nil
}

// MODEL -----------------------------------------------------------------------

type Model =
  Int

fn init(initial_count: Int) -> Model {
  case initial_count < 0 {
    True -> 0
    False -> initial_count
  }
}

// UPDATE ----------------------------------------------------------------------

pub opaque type Msg {
  Incr
  Decr
}

fn update(model: Model, msg: Msg) -> Model {
  case msg {
    Incr -> model + 1
    Decr -> model - 1
  }
}

// VIEW ------------------------------------------------------------------------

fn view(model: Model) -> Element(Msg) {
  let styles = [#("width", "25px"), #("height", "100px")]
  let count = int.to_string(model)

  html.div([attribute.styles(styles)], [
    html.div([], [
      html.button([event.on_click(Incr)], [element.text("+")]),
      html.p([attribute.styles([#("text-align", "center")])], [
        element.text(count),
      ]),
      html.button([event.on_click(Decr)], [element.text("-")]),
    ]),
  ])
}
