// @ts-ignore
import { Elm } from "./Main.elm"

const font = document.createElement("link")
const stylesheet = document.createElement("link")

font.setAttribute("rel", "stylesheet")
font.setAttribute("href", "https://fonts.googleapis.com/css2?family=Fira+Mono:wght@400;500;700&family=Lora:wght@400;500;600;700&family=Roboto:wght@100;300;400;500;700;900&display=swap")

stylesheet.setAttribute("rel", "stylesheet")
stylesheet.setAttribute("href", "/chmod/index.css")

document.head.appendChild(font)
document.head.appendChild(stylesheet)

const elmElement = document.getElementById("elm")

if (!(elmElement instanceof HTMLDivElement)) {
  throw new Error("Elm element is not found in the current DOM!")
}

const main = Elm.Main.init({
  node: elmElement
})

main.ports.vibrate.subscribe(() => {
  window.navigator.vibrate(50)
})

main.ports.copy.subscribe(content => {
  window.navigator.permissions.query({
    // @ts-ignore
    name: "clipboard-write"
  }).then(({state}) => {
    if (state !== "granted") {
      return Promise.reject(new Error(""))
    }

    window.navigator.clipboard.writeText(content)
  }).then(() => {
    alert("Copied to clipboard!")
  }).catch((error) => {
    console.error(error)
    alert("Failed to copy to clipboard...")
  })
})
