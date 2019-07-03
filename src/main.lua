-- need Lua 5.3 for tables this big
-- only .ogg files https://wow.tools/files/
local listfile = require("listfile")
-- dumped with powershell https://www.curseforge.com/wow/addons/mute-wow-sounds
local MuteAnnoyingWowSounds = require("muteannoyingwowsounds")

-- reverse lookup table
local revListFile = {}
for k, v in pairs(listfile) do
	revListFile[v] = k
end

local function WriteMuteAnnoying(file)
	file:write('local sounds = {\n')
	for _, v in pairs(MuteAnnoyingWowSounds) do
		local fdid = revListFile[v:lower()]
		if fdid then
			file:write(string.format('\t[%d] = "%s",\n', fdid, v))
		end
	end
	file:write([[
}

for fdid in pairs(sounds) do
	MuteSoundFile(fdid)
end
]])
	return file
end

local numFound, numMissing = 0, 0

local function WriteMuteSoundFile(file)
	-- MuteSoundFile addon savedvariables
	-- Im confused why Funkydude uses file paths instead of fdids as keys
	file:write('\t\t\t["soundList"] = {\n')
	for _, v in pairs(MuteAnnoyingWowSounds) do
		local fdid = revListFile[v:lower()]
		if fdid then
			file:write(string.format('\t\t\t\t["%s"] = %d,\n', v, fdid))
			numFound = numFound + 1
		end
	end
	file:write('\t\t\t},\n')
	return file
end

local function WriteMissing(file)
	for _, v in pairs(MuteAnnoyingWowSounds) do
		local fdid = revListFile[v:lower()]
		if not fdid then
			file:write(string.format('%s\n', v))
			numMissing = numMissing + 1
		end
	end
	return file
end

local annoying = io.open("../output/MuteAnnoying/MuteAnnoying.lua", "w")
WriteMuteAnnoying(annoying):close()

local msf = io.open("../output/MuteSoundFile_soundList.lua", "w")
WriteMuteSoundFile(msf):close()

local missing = io.open("../output/missing.lua", "w")
WriteMissing(missing):close()

print("sizeAnnoying", #MuteAnnoyingWowSounds)
print("numFound", numFound)
print("numMissing", numMissing)
