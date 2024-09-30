local jumpCount = 0
local lastJumpTime = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local player = PlayerPedId()

        if IsPedOnFoot(player) and not IsPedFalling(player) and not IsPedRagdoll(player) then
            if IsControlJustPressed(1, 22) then -- Zıplama tuşu (Space)
                local currentTime = GetGameTimer() / 1000

                -- Zıplama aralığını kontrol et
                if currentTime - lastJumpTime <= Config.jumpCooldown then
                    jumpCount = jumpCount + 1
                else
                    jumpCount = 1
                end

                lastJumpTime = currentTime

                -- Eğer zıplama sayısı max sınırını geçerse karakteri düşür
                if jumpCount > Config.maxJumps then
                    SetPedToRagdoll(player, Config.fallTime, Config.fallTime, 0, false, false, false) -- Karakteri yere düşür
                    Citizen.Wait(Config.fallTime) -- Karakterin düşme süresi
                    jumpCount = 0 -- Zıplama sayısını sıfırla
                end
            end
        else
            if IsPedOnFoot(player) and not IsPedFalling(player) then
                jumpCount = 0
            end
        end
    end
end)
