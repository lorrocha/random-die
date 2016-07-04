import Html exposing (..)
import Html.Attributes exposing (style)
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
  (initialModel, Cmd.none)

-- Model

type alias Model =
  { dieFace : Int
  , dieColor : String
  }

initialModel : Model
initialModel =
  { dieFace = 1
  , dieColor = "#ff0000"
  }

-- Update

type Msg = Roll | NewFace Int | ChangeColor String

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFace (Random.int 1 6))
    NewFace newFace ->
      { model | dieFace = newFace } ! []
    ChangeColor color ->
      { model | dieColor = color } ! []

-- View

view: Model -> Html Msg
view model =
  div
    [ Html.Attributes.style [("text-align", "center")
                            ,("margin-top", "50px")]
    ]
    [ div []
      [ renderDie model ]
    , div [class "colors"]
      [ div [buttonStyle "#ff0000", onClick (ChangeColor "#ff0000")] []
      , div [buttonStyle "#3863ff", onClick (ChangeColor "#3863ff")] []
      , div [buttonStyle "#01a536", onClick (ChangeColor "#01a536")] []
      ]
    , button [ onClick Roll ] [ Html.text "Roll Die" ]
    ]

-- subscriptions
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- functions

renderDie : Model -> Html.Html msg
renderDie model =
  case model.dieFace of
    1 ->
      Svg.svg
        [ x "170", y "170", width "150", height "150"]
        [ rect [ fill model.dieColor, width "150", height "150", rx "25"] []
        , rect [ fill "#181818", x "60", y "60", width "25", height "25", rx "55"] [] ]
    2 ->
      Svg.svg
        [ x "170", y "170", width "150", height "150"]
        [ rect [ fill model.dieColor, width "150", height "150", rx "25"] []
        , rect [ fill "#181818", x "90", y "90", width "25", height "25", rx "55"] []
        , rect [ fill "#181818", x "30", y "30", width "25", height "25", rx "55"] [] ]
    3 ->
      Svg.svg
        [ x "170", y "170", width "150", height "150"]
        [ rect [ fill model.dieColor, width "150", height "150", rx "25"] []
        , rect [ fill "#181818", x "90", y "90", width "25", height "25", rx "55"] []
        , rect [ fill "#181818", x "60", y "60", width "25", height "25", rx "55"] []
        , rect [ fill "#181818", x "30", y "30", width "25", height "25", rx "55"] [] ]
    4 ->
      Svg.svg
        [ x "170", y "170", width "150", height "150"]
        [ rect [ fill model.dieColor, width "150", height "150", rx "25"] []
        , rect [ fill "#181818", x "30", y "30", width "25", height "25", rx "55"] []
        , rect [ fill "#181818", x "30", y "90", width "25", height "25", rx "55"] []
        , rect [ fill "#181818", x "90", y "30", width "25", height "25", rx "55"] []
        , rect [ fill "#181818", x "90", y "90", width "25", height "25", rx "55"] [] ]
    5 ->
      Svg.svg
        [ x "170", y "170", width "150", height "150"]
        [ rect [ fill model.dieColor, width "150", height "150", rx "25"] []
        , rect [ fill "#181818", x "30", y "30", width "25", height "25", rx "55"] []
        , rect [ fill "#181818", x "30", y "90", width "25", height "25", rx "55"] []
        , rect [ fill "#181818", x "60", y "60", width "25", height "25", rx "55"] []
        , rect [ fill "#181818", x "90", y "30", width "25", height "25", rx "55"] []
        , rect [ fill "#181818", x "90", y "90", width "25", height "25", rx "55"] [] ]
    6 ->
      Svg.svg
        [ x "170", y "170", width "150", height "150"]
        [ rect [ fill model.dieColor, width "150", height "150", rx "25"] []
        , rect [ fill "#181818", x "30", y "30", width "25", height "25", rx "55"] []
        , rect [ fill "#181818", x "30", y "60", width "25", height "25", rx "55"] []
        , rect [ fill "#181818", x "30", y "90", width "25", height "25", rx "55"] []
        , rect [ fill "#181818", x "90", y "30", width "25", height "25", rx "55"] []
        , rect [ fill "#181818", x "90", y "60", width "25", height "25", rx "55"] []
        , rect [ fill "#181818", x "90", y "90", width "25", height "25", rx "55"] [] ]
    _ ->
      Svg.svg [] []

buttonStyle : String -> Html.Attribute msg
buttonStyle color =
  Html.Attributes.style
    [ ("backgroundColor", color)
    , ("height", "30px")
    , ("width", "30px")
    , ("display", "inline-block")
    , ("margin-left", "5px")
    ]
