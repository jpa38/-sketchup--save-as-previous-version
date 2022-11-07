# Creator : JPA

# Permission to use, copy, modify, and distribute this software for any purpose
# and without fee is hereby granted, provided that the above copyright notice
# appear in all copies.

# THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#-----------------------------------------------------------------------------

# LINK SUPPORT
# https://ruby.sketchup.com/Sketchup/Model.html#save-instance_method
# https://forums.sketchup.com/t/save-a-file-with-a-predefined-name/93597/2
# https://ruby.sketchup.com/UI.html#savepanel-class_method
# Template extension
# https://github.com/SketchUp/sketchup-ruby-api-tutorials/blob/main/tutorials/01_hello_cube/tut_hello_cube.rb


# HOW TO INSTALL ?
# rbz files can be installed manually ➜ https://help.sketchup.com/en/extension-warehouse/adding-extensions-sketchup#install-manual
# rb files need to be copied in specific folder :
#   - Windows: C:\Users\%USERNAME%\AppData\Roaming\SketchUp\SketchUp 2016\SketchUp\Plugins (or SketchUp 2015, etc.)
#   - Mac: ~/Library/Application Support/SketchUp/SketchUp 2016/Extensions (or SketchUp 2015, etc.)
#   - Linux: ~/.config/Sketchup/Sketchup 2016/Extensions (or SketchUp 2015, etc.)


# HOW TO CHANGE VERSION ?
# You can find specific writing command in this link => https://ruby.sketchup.com/Sketchup/Model.html


# HOW TO USE ?
# You need to save your sketchup file first one. If you have an version on your disk, to save, just hit :
#
# - File ➜ SaveAs..2018
#


module JPA
    module SaveAs2018_menu

        ex = SketchupExtension.new('SaveAs2018_menu', 'tut_savesas2018_menu/main')
        ex.description = 'Save Sketchup file as 2018 Version when hit File => SaveAs..2018'
        ex.version     = '1.0.0'
        ex.copyright   = 'MIT License © 2022'
        ex.creator     = 'JPA'

        
        
        # Create a command object.
        save_version = "Sketchup::Model::VERSION_2018"
        cmdSv2018 = UI::Command.new("SaveAs2018") {
        #   UI.messagebox("My Command2")
        }
        # Text displayed in sketchup
        cmdSv2018.menu_text = "SaveAs..2018"
        # Action when hit button
        cmdSv2018.set_validation_proc {
            begin
                Sketchup.active_model.save('', Sketchup::Model::VERSION_2018)
            rescue Exception => error
                filepath = UI.savepanel("Save as…", File.expand_path("~"),"newFile.skp")
                Sketchup.active_model.save(filepath, Sketchup::Model::VERSION_2018)
            end
        }
        # Add choice in File.
        UI.menu("File").add_item(cmdSv2018)

    end
end
