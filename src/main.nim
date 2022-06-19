import std/strformat
import ./raylib/raylib

type Bunny = ref object
  position: Vector2
  speed: Vector2
  color: Color

const WIDTH = 800
const HEIGHT = 600
const TOTAL = 500000
const MAX = 1000

InitWindow(WIDTH, HEIGHT, "Bunny Mark")
SetTargetFPS(60)

let texture = LoadTexture("./wabbit_alpha.png")
let textureWidth = texture.width / 2
let textureHeight = texture.height / 2

var bunnies: array[TOTAL, Bunny]
var count = 0

while not WindowShouldClose():
  if IsMouseButtonDown(MOUSE_LEFT_BUTTON):
    for i in 0..<MAX:
      if count < TOTAL:
        bunnies[count] = Bunny(
          position: GetMousePosition(),
          speed: Vector2(x: float32(GetRandomValue(-250, 250)), y: float32(GetRandomValue(-250, 250))),
          color: Color(
            r: cast[uint8](GetRandomValue(80, 250)),
            g: cast[uint8](GetRandomValue(80, 250)),
            b: cast[uint8](GetRandomValue(80, 250)),
            a: 255
          )
        )
        inc(count)

  for i in 0..<count:
    bunnies[i].position.x += bunnies[i].speed.x
    bunnies[i].position.y += bunnies[i].speed.y

    if bunnies[i].position.x + textureWidth > WIDTH or bunnies[i].position.x + textureWidth < 0:
      bunnies[i].speed.x *= -1
    if bunnies[i].position.y + textureHeight > HEIGHT or bunnies[i].position.y + textureHeight - 40 < 0:
      bunnies[i].speed.y *= -1

  BeginDrawing()
  ClearBackground(WHITE)

  for i in 0..<count:
    DrawTexture(texture, int32(bunnies[i].position.x), int32(bunnies[i].position.y), bunnies[i].color)

  DrawRectangle(0, 0, WIDTH, 40, BLACK)
  DrawFPS(10, 10)
  DrawText((&"Count: {count}").cstring, 120, 10, 20, GREEN)
  EndDrawing()

CloseWindow()