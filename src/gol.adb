with Ada.Text_IO;
with World; use World;
with Common; use Common;

procedure gol is
	tick: Integer := 0;
begin
	println("Starting Life...");
	
	loop
		println("Tick: " & Integer'Image(tick));
		print_world;
		
		declare
			input: String := Ada.Text_IO.Get_Line; --wait for newline input
		begin
			simulate;
			tick := tick + 1;
		end;
	end loop;
end gol;