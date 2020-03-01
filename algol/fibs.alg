PROC output = (INT n)VOID: (
  print(whole(n, 0));
  print(new line)
);

INT prev2 := 0, prev1 := 1;

output(prev2);
output(prev1);

INT current := prev2 + prev1;

FOR i FROM 3 TO 7 DO
  current := prev2 + prev1;
  prev2 := prev1;
  prev1 := current;
  output(current)
OD
