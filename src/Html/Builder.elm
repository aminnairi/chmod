module Html.Builder exposing (Element, build, new, withAttribute, withChild, withText)

import Html exposing (Attribute, Html)


type alias Element message =
    { name : String
    , attributes : List (Attribute message)
    , children : List (Html message)
    }


new : String -> Element message
new name =
    { name = name
    , attributes = []
    , children = []
    }


withAttribute : Attribute message -> Element message -> Element message
withAttribute attribute element =
    { name = element.name
    , attributes = element.attributes ++ [ attribute ]
    , children = element.children
    }


withChild : Html message -> Element message -> Element message
withChild child element =
    { name = element.name
    , attributes = element.attributes
    , children = element.children ++ [ child ]
    }


withText : String -> Element message -> Element message
withText text element =
    { name = element.name
    , attributes = element.attributes
    , children = element.children ++ [ Html.text text ]
    }


build : Element message -> Html message
build element =
    Html.node element.name element.attributes element.children
