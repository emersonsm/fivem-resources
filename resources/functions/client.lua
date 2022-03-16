function Draw3DText(str, x, y, z)
    SetTextScale(0.0, 0.35)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetDrawOrigin(x, y, z)
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(str)
    DrawText()
end

function Draw2DText(content, font, colour, scale, x, y)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(colour[1],colour[2],colour[3], 255)
    SetTextEntry("STRING")
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    AddTextComponentString(content)
    EndTextCommandDisplayText(x, y)
end

function ShowMoneyHud(operation, amount, time)
    local screenPosX = 0.920
    local screenPosY = 0.102
    if operation and time then
        if time then
            local timer = GetGameTimer()
            while (GetGameTimer() - timer < (time * 1000)) do
                Citizen.Wait(0)
                if operation == 'inc' then
                    local moneyinctext = "~g~<font face='PricedownGTAVInt'>+ $ ~w~" .. amount .. "</font>";
                    Draw2DText(moneyinctext, 2, {255, 255, 255}, 0.5, screenPosX, screenPosY + 0.030)
                elseif operation == 'dec' then
                    local moneydectext = "~r~<font face='PricedownGTAVInt'>- $ ~w~" .. amount .. "</font>";
                    Draw2DText(moneydectext, 2, {255, 255, 255}, 0.5, screenPosX, screenPosY + 0.030)
                end
            end
        else
            if operation == 'inc' then
                local moneyinctext = "~g~<font face='PricedownGTAVInt'>+ $ ~w~" .. amount .. "</font>";
                Draw2DText(moneyinctext, 2, {255, 255, 255}, 0.5, screenPosX, screenPosY + 0.030)
            elseif operation == 'dec' then
                local moneydectext = "~r~<font face='PricedownGTAVInt'>- $ ~w~" .. amount .. "</font>";
                Draw2DText(moneydectext, 2, {255, 255, 255}, 0.5, screenPosX, screenPosY + 0.030)
            end
        end
    end
end