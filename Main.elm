import Html exposing (..)
import Html.App as Html
import Html.Events exposing (..)
import Random
import Svg exposing (..)
import Svg.Attributes exposing (..)


main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- init
init : (Model, Cmd Msg)
init =
  (Model 1, Cmd.none)

-- Model

type alias Model =
  {
  dieFace : Int

}

-- Update

type Msg = Roll | NewFace Int

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFace (Random.int 1 6))
    NewFace newFace ->
      (Model newFace, Cmd.none)

-- View

view: Model -> Html Msg
view model =
  div []
    [ h1 [] [ Html.text (toString model.dieFace) ]
    , button [ Html.Events.onClick Roll ] [ Html.text "Roll Die" ]
    , div [] [
      Svg.svg [ x "170", y "170", width "150", height "150"]
      [ rect [ fill "#008d46", width "150", height "150", rx "25"] []
      , rect [ fill "#181818", x "60", y "60", width "25", height "25", rx "55"] []
      ]
    ]
    ]

-- subscriptions
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- functions
