* Converts sounds from [Mute Annoying WoW Sounds](https://www.curseforge.com/wow/addons/mute-wow-sounds) to FileDataIDs.
* See [MuteAnnoying](https://github.com/ketho-wow/MuteAnnoying) for the WoW addon.

#### Getting FileDataIDs from your Sound\ folder (Windows)
1. `muteannoyingwowsounds.lua`: Run the [PowerShell script](https://github.com/ketho-wow/MuteAnnoying-Converter/blob/master/src/muteannoyingwowsounds.ps1) in your **Sound**\ folder.
    * Turn the results into a Lua table.  
      `(.*)` → `\t"$1",`

2. (optional) `listfile.lua`: Download the [listfile](https://wow.tools/files/) from wow.tools.
    * Filter it to .ogg sounds only and turn it into a Lua table.  
      `^(?!.*\.ogg*).+$\n` → (empty) [*stackoverflow*](https://stackoverflow.com/questions/7024214/how-to-use-a-regular-expression-to-remove-lines-without-a-word)  
      `.*\.meta\n` → (empty)

3. Run `main.lua` ([Lua 5.2+](http://luabinaries.sourceforge.net/download.html))

* Output:
    * `MuteAnnoying.lua`: Example addon with FDIDs (and unused sound path).
    * `missing.lua`: Sound paths that failed to match a FDID.
    * `MuteSoundFile_soundList.lua`: FDIDs you can paste into [MuteSoundFile](https://www.curseforge.com/wow/addons/mutesoundfile)'s savedvariables.

*Note: I'm a novice with this stuff myself as you can see* 😋
