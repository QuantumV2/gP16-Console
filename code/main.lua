commands = {
  help="help",
  sP="sysspecs"
}

colors = 16
colorsPerSprite = 4
maxSprites = 64

xTB=135
yTB=48

lockIPcMsg = true
lockIPcMsgLower = true
waitingtimerIPc = 0


logo = love.graphics.newImage("consoleCrop.png",linear)
cb = love.graphics.newImage("codeButtonBig.png",linear)
drb = love.graphics.newImage("drawButton.png",linear)
tb = love.graphics.newImage("tileButton.png",linear)
sb = love.graphics.newImage("settingsButton.png",linear)

font = love.graphics.newFont("prstart.ttf")

local suit = require 'suit-master'
local utf8 = require 'utf8'

local function validate(input)
  local len = utf8.len(input.text)

  -- allow only lowercase a-z (also no spaces, etc)
  input.text = input.text:gsub("[^a-z]", "")

  -- reset cursor to where it was before charater removal
  input.cursor = input.cursor - (len - utf8.len(input.text))
end

local input = {text = ""}
function love.update(dt)
  if input.text == "leguha" then
    logo = love.graphics.newImage("consoleCrop_leguha.png",linear)
  elseif input.text == "quantumv" then
    logo = love.graphics.newImage("consoleCrop_quantumv.png",linear)
  elseif input.text ~= "leguha" or input.text ~= "quantumv" then
    logo = love.graphics.newImage("consoleCrop.png",linear)
  end
  if lockIPcMsg == false or lockIPcMsgLower == false then
    waitingtimerIPc = waitingtimerIPc + dt
  end
  -- place textbox at (100,100) with with 200px and height 30px
  suit.Input(input, xTB,yTB-10,200,30)
  validate(input)
end

function love.textinput(t)
  suit.textinput(t)
end

function love.keypressed(key)
  suit.keypressed(key)
end

-- if you want IME input, requires a font that can display the characters
function love.textedited(text, start, length)
  suit.textedited(text, start, length)
end



function love.draw()


    if input.text == commands.help then
      love.graphics.print("gP16Micro -- Made by QuantumV 2022\nsysspecs -- Opens system specs", 5, yTB+40)
      --commandOffset()
    end
    if input.text == commands.sP then
      love.graphics.print("System specs: Max colors: " .. colors .. " Max colors per sprite: " .. colorsPerSprite .. "\nMax sprites: " .. maxSprites, 5, yTB+40)
      --commandOffset()
    end
    if yTB ~= 0 then
      love.graphics.print("Insert cmd>", 5, yTB)
    end
    love.graphics.draw(logo, 700, 0)
    love.graphics.print("gP16Micro Started... (Type help for more info)", 5, 12)
    suit.draw()
    love.graphics.setColor(0.9, 0.6, 0) 
    if suit.ImageButton(cb, 15, 500).hit then
      if input.text ~= commands.help or input.text ~= commands.sP then
        lockIPcMsg = false
      else
        lockIPcMsgLower = false
      end
    end
    if suit.ImageButton(drb, 30+64, 500).hit then
      if input.text ~= commands.help or input.text ~= commands.sP then
        lockIPcMsg = false
      else
        lockIPcMsgLower = false
      end
    end
    if suit.ImageButton(tb, 45+128, 500).hit then
      if input.text ~= commands.help or input.text ~= commands.sP then
        lockIPcMsg = false
      else
        lockIPcMsgLower = false
      end
    end
    if suit.ImageButton(sb, 50+192, 500).hit then
      if input.text ~= commands.help or input.text ~= commands.sP then
        lockIPcMsg = false
      else
        lockIPcMsgLower = false
      end
    end
    if lockIPcMsg == false then
      love.graphics.print("This In-Programm feature is not supported in Micro!", 5, yTB+40)
      if waitingtimerIPc > 2 then
        lockIPcMsg = true
        waitingtimerIPc = 0
      end
    end
    if lockIPcMsgLower == false then
      love.graphics.print("This In-Programm feature is not supported in Micro!", 5, yTB+80)
      if waitingtimerIPc > 2 then
        lockIPcMsgLower = true
        waitingtimerIPc = 0
      end
    end
    --love.graphics.rectangle("fill", 10,470, 780,120, 10, 10)

    love.graphics.setColor(255,255,255)
    love.graphics.setFont(font, 16)
    
    love.graphics.print("ToolBar", 15, 475)
    love.graphics.setColor(255,255,255)

end

function commandOffset()

  --drawPrev()
  yTB = yTB + 24
  input.text = ""
end
