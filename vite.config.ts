import { defineConfig } from "vite"
import elm from "vite-plugin-elm"

export default defineConfig({
  plugins: [
    elm()
  ],
  root: "src",
  base: "/chmod/",
  build: {
    outDir: "../docs",
    emptyOutDir: true
  },
  server: {
    port: Number(process.env["SERVER_PORT"]),
    host: process.env["SERVER_HOST"]
  },
  preview: {
    port: Number(process.env["SERVER_PORT"]),
    host: process.env["SERVER_HOST"]
  }
})
