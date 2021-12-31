--================================================================================================
--==                                VARIABLES - DO NOT EDIT                                     ==
--================================================================================================
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
	local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
	local group = xPlayer.getGroup()

	if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
		TriggerClientEvent('bank:result', _source, "error", "Montant invalide.")
	else
		xPlayer.removeMoney(amount)
		xPlayer.addAccountMoney('bank', tonumber(amount))
		TriggerClientEvent('bank:result', _source, "success", "Dépot effectué.")
		if (amount > 50000) and (group == "user") then
			TriggerEvent('DiscordBot:ToDiscord', 'bank', GetPlayerName(_source), GetPlayerName(_source).." vient de déposer : "..amount.."$\nGroupe du joueur : "..group.."\n CHEAT POTENTIEL !", 'steam', 0, false, false)
		elseif (amount > 50000) and (group ~= "user") then
			TriggerEvent('DiscordBot:ToDiscord', 'bank', GetPlayerName(_source), GetPlayerName(_source).." vient de déposer : "..amount.."$\nGroupe du joueur : "..group, 'steam', 0, false, false)
		end
	end
end)


RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local group = xPlayer.getGroup()
	local base = 0
	amount = tonumber(amount)
	base = xPlayer.getAccount('bank').money
	if amount == nil or amount <= 0 or amount > base then
		TriggerClientEvent('bank:result', _source, "error", "Montant invalide.")
	else
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addMoney(amount)
		TriggerClientEvent('bank:result', _source, "success", "Retrait effectué.")
		if (amount > 50000) and (group == "user") then
			TriggerEvent('DiscordBot:ToDiscord', 'bank', GetPlayerName(_source), GetPlayerName(_source).." vient de retirer : "..amount.."$\nGroupe du joueur : "..group.."\n CHEAT POTENTIEL !", 'steam', 0, false, false)
		elseif (amount > 50000) and (group ~= "user") then
			TriggerEvent('DiscordBot:ToDiscord', 'bank', GetPlayerName(_source), GetPlayerName(_source).." vient de retirer : "..amount.."$\nGroupe du joueur : "..group, 'steam', 0, false, false)
		end
	end
end)

RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	balance = xPlayer.getAccount('bank').money
	TriggerClientEvent('currentbalance1', _source, balance)
end)


RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(to, amountt)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(to)
	local group = xPlayer.getGroup()
	local balance = 0

	if(zPlayer == nil or zPlayer == -1) then
		TriggerClientEvent('bank:result', _source, "error", "Destinataire introuvable.")
	else
		balance = xPlayer.getAccount('bank').money
		zbalance = zPlayer.getAccount('bank').money
		
		if tonumber(_source) == tonumber(to) then
			TriggerClientEvent('bank:result', _source, "error", "Vous ne pouvez pas faire de transfert à vous même.")
		else
			if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
				TriggerClientEvent('bank:result', _source, "error", "Vous n'avez pas assez d'argent en banque.")
			else
				xPlayer.removeAccountMoney('bank', tonumber(amountt))
				zPlayer.addAccountMoney('bank', tonumber(amountt))
				TriggerClientEvent('bank:result', _source, "success", "Transfert effectué.")
				if (amountt > 50000) and (group == "user") then
					TriggerEvent('DiscordBot:ToDiscord', 'bank', GetPlayerName(_source), GetPlayerName(_source).." vient de transférer : "..amount.."$ à "..GetPlayerName(to).."\nGroupe du joueur : "..group.."\n@everyone CHEAT POTENTIEL !", 'steam', 0, false, false)
				elseif (amountt > 50000) and (group ~= "user") then
					TriggerEvent('DiscordBot:ToDiscord', 'bank', GetPlayerName(_source), GetPlayerName(_source).." vient de transférer : "..amountt.."$ à "..GetPlayerName(to).."\nGroupe du joueur : "..group, 'steam', 0, false, false)			
				end
			end
		end
	end
end)





