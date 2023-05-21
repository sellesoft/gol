with Ada.Text_IO;

package Common is
	procedure print(Item: String) renames Ada.Text_IO.Put;
    procedure println(Item: String) renames Ada.Text_IO.Put_Line;
	
	--@param chance out of 100
	function random(chance: Integer) return Boolean;
end Common;