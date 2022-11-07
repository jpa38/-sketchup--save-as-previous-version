# Creator : JPA

# Permission to use, copy, modify, and distribute this software for any purpose
# and without fee is hereby granted, provided that the above copyright notice
# appear in all copies.

# THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#-----------------------------------------------------------------------------

# https://ruby.sketchup.com/Sketchup/Model.html#save-instance_method
# https://forums.sketchup.com/t/save-a-file-with-a-predefined-name/93597/2
# https://ruby.sketchup.com/UI.html#savepanel-class_method
# https://stackoverflow.com/questions/32246092/onsavemodel-observer-in-ruby-sketchup-causes-infinite-loop


# HOW TO INSTALL ?
# rbz files can be installed manually (link) : https://help.sketchup.com/en/extension-warehouse/adding-extensions-sketchup#install-manual
# rb files need to be copied in specific folder :
#   - Windows: C:\Users\%USERNAME%\AppData\Roaming\SketchUp\SketchUp 2016\SketchUp\Plugins (or SketchUp 2015, etc.)
#   - Mac: ~/Library/Application Support/SketchUp/SketchUp 2016/Extensions (or SketchUp 2015, etc.)
#   - Linux: ~/.config/Sketchup/Sketchup 2016/Extensions (or SketchUp 2015, etc.)


# HOW TO CHANGE VERSION ?
# You can find specific writing command in this link => https://ruby.sketchup.com/Sketchup/Model.html


# HOW TO USE ?
# You just have to forget this plugin, just press :
#
# - File ➜ Save
# Or
# - Press Ctrl + S



module JPA

    def self.saveAs2018Auto
      Sketchup.active_model.add_observer(SaveAs2018AutoModelObserver.new)
    end

    class SaveAs2018AutoModelObserver < Sketchup::ModelObserver
      def onSaveModel(model)
        puts "onSaveModel" + model.to_s
        JPA.saveModel()
      end
    end

    def self.saveModel()
      return if @saving
  
      puts "saveModel()"
      model = Sketchup.active_model
  
        begin
            @saving = true
            Sketchup.active_model.save('', Sketchup::Model::VERSION_2018)
        rescue Exception => error
            @saving = true
            filepath = UI.savepanel("Save as…", File.expand_path("~"),"newFile.skp")
            Sketchup.active_model.save(filepath, Sketchup::Model::VERSION_2018)
        end # begin

  
      @saving = true

    ensure
      # Just in case model.export should raise an exception we guarranty the flag
      # is reset.
      @saving = false

    end #!savemodel
  
  end
  
  JPA.saveAs2018Auto() 

