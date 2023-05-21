--with Ada.Command_Line;
with World; use World;
--with Common; use Common;

procedure gol is
	--package cli renames Ada.Command_Line;
begin
	println("Starting Life...");
	print_world;
	sim;
	print_world;
	
end gol;