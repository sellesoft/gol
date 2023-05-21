with Ada.Numerics.Discrete_Random;

package body Common is
	function random(chance: Integer) return Boolean is
		type RandomRange is new Integer range 1..100;
		package RandInt is new Ada.Numerics.Discrete_Random(RandomRange); use RandInt;
		g: Generator;
		r: RandomRange;
	begin
		if chance = 100 then
			return True;
		elsif chance = 0 then
			return False;
		else
			reset(g); --reset every time?
			r := random(g);
			return Integer(r) < chance; --might be one off?
		end if;
	end random;
end Common;