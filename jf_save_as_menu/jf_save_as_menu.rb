# Copyright 2017, <jim.foltz@gmail.com>
#
# Permission to use, copy, modify, and distribute this software for any purpose
# and without fee is hereby granted, provided that the above copyright notice
# appear in all copies.

# THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#-----------------------------------------------------------------------------

module JF

   module SaveAsPrevMenu

      PREF_KEY = 'JF\SaveAsPrevMenu'.freeze
      VERSION = '1.0'.freeze

      this_version = Sketchup.version.to_i + 2000
      versions = [3, 4, 5, 6, 7, 8] + (2013..this_version).to_a
      menu = defined?(JF.menu) ? JF.menu() : UI.menu("File")
      menu = menu.add_submenu("JF Save as..")
      versions.reverse.each do |v|
         save_version = const_get("Sketchup::Model::VERSION_#{v}")
         menu.add_item("Version #{v}") {
            begin
               status = Sketchup.active_model.save('', save_version)
               if !status
                  UI.messagebox("Model not saved.")
               end
            rescue ArgumentError => e
               msg = e.message
               UI.messagebox(msg)
            end
         }
      end

   end # module SaveAsPrevious
end # module JF
