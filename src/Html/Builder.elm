module Html.Builder exposing (Element, build, button, div, h1, h2, h3, hr, input, label, new, withAttribute, withChecked, withChild, withClass, withFor, withId, withOnCheck, withOnClick, withOnInput, withText, withType, withValue)

import Html exposing (Attribute, Html)
import Html.Attributes
import Html.Events


type alias Element message =
    { name : String
    , attributes : List (Attribute message)
    , children : List (Html message)
    }



-- Element


new : String -> Element message
new name =
    { name = name
    , attributes = []
    , children = []
    }


div : Element message
div =
    { name = "div"
    , attributes = []
    , children = []
    }


h1 : Element message
h1 =
    { name = "h1"
    , attributes = []
    , children = []
    }


h2 : Element message
h2 =
    { name = "h2"
    , attributes = []
    , children = []
    }


h3 : Element message
h3 =
    { name = "h3"
    , attributes = []
    , children = []
    }


hr : Element message
hr =
    { name = "hr"
    , attributes = []
    , children = []
    }


button : Element message
button =
    { name = "button"
    , attributes = []
    , children = []
    }


label : Element message
label =
    { name = "label"
    , attributes = []
    , children = []
    }


input : Element message
input =
    { name = "input"
    , attributes = []
    , children = []
    }



-- Attributes


withAttribute : Attribute message -> Element message -> Element message
withAttribute attribute element =
    { name = element.name
    , attributes = element.attributes ++ [ attribute ]
    , children = element.children
    }


withText : String -> Element message -> Element message
withText text element =
    { name = element.name
    , attributes = element.attributes
    , children = element.children ++ [ Html.text text ]
    }


withClass : String -> Element message -> Element message
withClass class element =
    { name = element.name
    , attributes = element.attributes ++ [ Html.Attributes.class class ]
    , children = element.children
    }


withId : String -> Element message -> Element message
withId id element =
    { name = element.name
    , attributes = element.attributes ++ [ Html.Attributes.id id ]
    , children = element.children
    }


withFor : String -> Element message -> Element message
withFor for element =
    { name = element.name
    , attributes = element.attributes ++ [ Html.Attributes.for for ]
    , children = element.children
    }


withType : String -> Element message -> Element message
withType type_ element =
    { name = element.name
    , attributes = element.attributes ++ [ Html.Attributes.type_ type_ ]
    , children = element.children
    }


withValue : String -> Element message -> Element message
withValue value element =
    { name = element.name
    , attributes = element.attributes ++ [ Html.Attributes.value value ]
    , children = element.children
    }


withChecked : Bool -> Element message -> Element message
withChecked checked element =
    { name = element.name
    , attributes = element.attributes ++ [ Html.Attributes.checked checked ]
    , children = element.children
    }



-- Events


withOnClick : message -> Element message -> Element message
withOnClick message element =
    { name = element.name
    , attributes = element.attributes ++ [ Html.Events.onClick message ]
    , children = element.children
    }


withOnInput : (String -> message) -> Element message -> Element message
withOnInput message element =
    { name = element.name
    , attributes = element.attributes ++ [ Html.Events.onInput message ]
    , children = element.children
    }


withOnCheck : (Bool -> message) -> Element message -> Element message
withOnCheck message element =
    { name = element.name
    , attributes = element.attributes ++ [ Html.Events.onCheck message ]
    , children = element.children
    }



-- Children


withChild : Html message -> Element message -> Element message
withChild child element =
    { name = element.name
    , attributes = element.attributes
    , children = element.children ++ [ child ]
    }



-- Build


build : Element message -> Html message
build element =
    Html.node element.name element.attributes element.children
