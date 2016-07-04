import Html exposing (..)
import Html.Attributes exposing (style, class)
import Html.App as Html
import Html.Events exposing (..)
import Random
import Svg exposing (svg, rect)
import Svg.Attributes exposing (x, y, width, height, fill, rx)



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
    [ style
      [ ("text-align", "center")
      , ("margin-top", "50px")
      ]
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
        svgStyle
        [ dieBase model.dieColor
        , pip "middle" "center"
        ]
    2 ->
      Svg.svg
        svgStyle
        [ dieBase model.dieColor
        , pip "top" "left"
        , pip "bottom" "right"
        ]
    3 ->
      Svg.svg
        svgStyle
        [ dieBase model.dieColor
        , pip "top" "left"
        , pip "middle" "center"
        , pip "bottom" "right"
        ]
    4 ->
      Svg.svg
        svgStyle
        [ dieBase model.dieColor
        , pip "top" "left"
        , pip "bottom" "left"
        , pip "top" "right"
        , pip "bottom" "right"
        ]
    5 ->
      Svg.svg
        svgStyle
        [ dieBase model.dieColor
        , pip "top" "left"
        , pip "bottom" "left"
        , pip "middle" "center"
        , pip "top" "right"
        , pip "bottom" "right"
        ]
    6 ->
      Svg.svg
        svgStyle
        [ dieBase model.dieColor
        , pip "top" "left"
        , pip "middle" "left"
        , pip "bottom" "left"
        , pip "top" "right"
        , pip "middle" "right"
        , pip "bottom" "right"
        ]
    _ ->
      Svg.svg [] []

transformVertical : String -> String
transformVertical vertical =
  case vertical of
    "top" ->
      "30"
    "middle" ->
      "60"
    "bottom" ->
      "90"
    _ ->
      "0"

transformHorizontal : String -> String
transformHorizontal horizontal =
  case horizontal of
    "left" ->
      "30"
    "center" ->
      "60"
    "right" ->
      "90"
    _ ->
      "0"

dieBase : String -> Html.Html msg
dieBase color =
  rect [ fill color, width "150", height "150", rx "25"] []

pip : String -> String -> Html.Html msg
pip vertical horizontal =
  rect
    [ fill "#181818"
    , x (transformHorizontal horizontal)
    , y (transformVertical vertical)
    , width "25"
    , height "25"
    , rx "55"
    ]
    []

svgStyle : List (Svg.Attribute a)
svgStyle =
  [ x "170", y "170", width "150", height "150" ]

buttonStyle : String -> Html.Attribute msg
buttonStyle color =
  style
    [ ("backgroundColor", color)
    , ("height", "30px")
    , ("width", "30px")
    , ("display", "inline-block")
    , ("margin-left", "5px")
    ]
