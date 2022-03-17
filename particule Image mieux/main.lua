img = {}
--img.imag = love.graphics.newImage("image/rick.png")
img.data = love.image.newImageData("image/H.png")
img.w = img.data:getWidth()
img.h = img.data:getHeight()
img.pas = 5 --[[ resolution /!\ les grandes images avec une haute resolution font cracher l'ordi 
              plus c'est petit, plus la resolution est haute
              plus la resolution * la taille est grande plus l'image est noir (et vis versa)
]]
img.zoom = 1 -- taille 
if img.zoom >= 1 then
font = love.graphics.setNewFont(img.pas*img.zoom)
else 
font = love.graphics.setNewFont(img.pas)
end 
love.graphics.setFont(font)
--love.graphics.setBackgroundColor(0,0,0,1) --pour modifier le fond /!\ il faut aussi modifier la couleur du texte

popixelve = {}

bordel = false
popixel = {}
popixel = popixelve
vx = 0
vy = 0 

concentration = 0

function love.load()
  love.window.setMode(img.w*img.zoom,img.h*img.zoom)
end 

for i = 0, img.w-1, img.pas do 
    for j = 0,img.h-1, img.pas do
    r,g,b,a = img.data:getPixel(i,j)
     if a > 0 then
      popixelve[#popixelve+1] = {r,g,b,a,i*img.zoom,j*img.zoom-1}
    end
  end 
end 
  
function love.update(dt)
  if bordel then
    local randb = math.random(-2,2)
    for i = 1,#popixel do
      randb = math.random(-2,2)
      switchTable(popixel[i],5,popixel[i][5] + randb)
      randb = math.random(-2,2)
      switchTable(popixel[i],6,popixel[i][6] + randb)
    end
    concentration = 0
  else
    local randv = math.random(2,20)
    for i = 1,#popixel do
      
      randv = math.random(2,20)
      vx = (popixelve[i][5] - popixel[i][5])/randv
      love.graphics.print(vx,0,0)
      switchTable(popixel[i],5,popixel[i][5] + vx )
       
      randv = math.random(2,20)
      vy = (popixelve[i][6] - popixel[i][6])/randv
      switchTable(popixel[i],6,popixel[i][6] + vy)
    end
    concentration = concentration + 0.1
    if img.pas <= 3 then 
      if concentration > 20 then
        bordel = true
        concentration = 0
      end 
    else 
      if concentration > 80 then
        bordel = true
        concentration = 0
      end
    end 
  end 
  
end 


function love.draw()
  
  for i = 1, #popixelve do 
      dessin(popixelve[i][1],popixelve[i][2],popixelve[i][3],popixelve[i][4],popixel[i][5],popixel[i][6])
  end 
  
end 

function love.keypressed(key)
  if key == "z" then
  bordel = true
  
  local rand = math.random(0,img.w*img.zoom)
    for i = 1,#popixel do
      rand = math.random(0,img.w*img.zoom)
      switchTable(popixel[i],5,rand)
      rand = math.random(0,img.h*img.zoom)
      switchTable(popixel[i],6,rand)
    end
  end 
  
  if key == "space" then
  bordel = false
  concentration = 0
  popixelve = {}
  for i = 0, img.w-1, img.pas do 
    for j = 0,img.h-1, img.pas do
    r,g,b,a = img.data:getPixel(i,j)
     if a > 0 then
      popixelve[#popixelve+1] = {r,g,b,a,i*img.zoom,j*img.zoom-1}
      end
    end 
  end 
  
  
  end
  
end

function dessin(r,g,b,a,x,y)
  --love.graphics.setColor(1,0,0,1)
  --love.graphics.setColor(r,g,b,a)  -- pour mettre la couleur 
  local chr = ""
  local listchr = {".","-","*","%","#"} -- {"#","%","*","-","."} -- revers color N&B
  if r+g+b <=0.1 then 
    chr = " "
  else
    for i = 1,#listchr do
      if r+g+b <= i*3/#listchr and r+g+b > (i-1)*3/#listchr then
       chr = listchr[i]
      end
    end 
  end
  
--  elseif r+g+b <= 3/5 then 
--    chr = "."
--  elseif r+g+b <= 2*3/5 then
--    chr = "-"
--  elseif r+g+b <= 3*3/5  then
--    chr = "/" 
--  elseif r+g+b <= 4*3/5  then
--    chr = "%"
--  elseif r+g+b <= 3 then
--    chr = "#"
--  end
  love.graphics.print(chr,x,y)
  --love.graphics.rectangle("fill",x,y,img.pas*img.zoom,img.pas*img.zoom)
end 
-- .,-*:;§%@#


function switchTable(table,p,nv) 
  table[p] = nil
  table[p] = nv
end 

