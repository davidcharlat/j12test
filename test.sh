errorExit()
{
  echo "$1";
  exit 1;
}

USER_BUILD=$1;
FL=%s\n

# BUILD
let "n = 0"
if [ -f j12/ex00/Makefile ]
then
	cp -r j12/ex00/ ex00/
	cd ex00/
	make -s all || errorExit "Error: compilation failed"
	if [ -f ft_display_file ]
	then 
		echo "ft_display_file: compilation OK"
		make -s clean || errorExit "Error: failed to make clean"
		if [ -f ft*.o ]
		then
			errorExit "Error: failed to delete .o files"
		fi
		make -s fclean || errorExit "Error: failed to make fclean"
		if [ -f ft_display_file ]
		then
			errorExit "Error: failed to delete ft_dipslay_file"
		fi
		make -s all || errorExit "Error: all failed"
		OUTPUT=$(./ft_display_file 2>&1);
		if [ "$OUTPUT" = "File name missing." ]
		then
			echo "tested with no file name"
			OUTPUT=$(./ft_display_file Makefile ft_display_file.c 2>&1);
			if [ "$OUTPUT" = "Too many arguments." ]
			then
			echo "tested with too many arguments"
				OUTPUT=$(./ft_display_file ../exemple1);
				if [ "$OUTPUT" = "azertyuiop" ]
				then
					echo "received '$OUTPUT' : file correctly displayed"
					if [ $n -eq 0 ]
					then	
						let "n = n + 1"
					fi
				else
					errorExit "file not displayed correctly"
				fi
			else
				errorExit "wrong output while too many arguments"
			fi
		else
			errorExit "wrong output while filename is missing:'\n' received: "$OUTPUT"'\n' expecting File name missing.'\n' "
		fi
	else 
		errorExit "Error: failed to create ft_dipslay_file" 
	fi
	make -s fclean
	echo "ex00 OK"
	echo ""
	cd ..
	rm -r ex00/
fi
if [ -f j12/ex01/Makefile ]
then
	cp -r j12/ex01/ ex01/
	cd ex01/
	make -s all || errorExit "Error: compilation failed"
	if [ -f ft_cat ]
	then 
		echo "ft_cat: compilation OK"
		make -s clean || errorExit "Error: failed to make clean"
		if [ -f ft*.o ]
		then
			errorExit "Error: failed to delete .o files"
		fi
		make -s fclean || errorExit "Error: failed to make fclean"
		if [ -f ft_cat ]
		then
			errorExit "Error: failed to delete ft_cat"
		fi
		make -s all || errorExit "Error: all failed"
		OUTPUT="`./ft_cat ../exemple1`";
		if [ "$OUTPUT" = "azertyuiop" ]
		then
			echo "tested with one file name"
			OUTPUT="`./ft_cat ../exemple1 ../exemple2`";
			if [ "$OUTPUT" = 'azertyuiop
qsdfghjklm' ]
			then
				echo "tested with 2 args"
				OUTPUT=$(./ft_cat ../exemple1 exemple3 2>&1);
				if [ "$OUTPUT" = "azertyuiop
cat: exemple3: Aucun fichier ou dossier de ce type" ] || [ "$OUTPUT" = "azertyuiop
cat: exemple3: No such file or directory" ]
				then
					echo "expected and received '$OUTPUT'"
					echo "OK while one arg doesn't matching any file"
					OUTPUT=$(./ft_cat ../exem*mple1 2>&1);
					echo "output : $OUTPUT"
					if [ "$OUTPUT" = "cat: '../exem*mple1': Aucun fichier ou dossier de ce type" ] || [ "$OUTPUT" = "cat: '../exem*mple1': No such file or directory" ]
					then
						echo "expected and received '$OUTPUT'"
						echo "OK when joker (*) is used"
						if [ $n -eq 1 ]
						then	
							let "n = n + 1"
						fi
					else
						errorExit "Wrong output while * is used"
					fi
				else
					errorExit "Wrong output while one arg don't match any file"
				fi
			else
				errorExit "2 files not correctly displayed"
			fi
		else
			errorExit "file not correctly displayed"
		fi
	else 
		errorExit "Error: failed to create ft_cat" 
	fi
	make -s fclean
	echo "ex01 OK"
	echo ""
	cd ..
	rm -r ex01/
fi
if [ -f j12/ex02/Makefile ]
then
	cp -r j12/ex02/ ex02/
	cd ex02/
	make -s all || errorExit "Error: compilation failed"
	if [ -f ft_tail ]
	then 
		echo "ft_tail: compilation OK"
		make -s clean || errorExit "Error: failed to make clean"
		if [ -f ft*.o ]
		then
			errorExit "Error: failed to delete .o files"
		fi
		make -s fclean || errorExit "Error: failed to make fclean"
		if [ -f ft_tail ]
		then
			errorExit "Error: failed to delete ft_tail"
		fi
		make -s all || errorExit "Error: all failed"
		OUTPUT="`./ft_tail -c -4 ../exemple1`";
		echo "tested ./ft_tail -c -4 ../exemple1, received $OUTPUT"
		if [ "$OUTPUT" = "iop" ]
		then
			echo "OK"
			OUTPUT="`./ft_tail -c 4 ../exemple*`";
			echo "testing ./ft_tail -c 4 ../exemple* ; received : $OUTPUT"
			if [ "$OUTPUT" = "==> ../exemple1 <==
iop

==> ../exemple2 <==
klm" ]
			then
				echo "OK"
				OUTPUT=$(./ft_tail -c 4 ../exemple3 2>&1);
				if [ "$OUTPUT" = "tail: can't open '../exemple3' in reading mode: No such file or directory" ] || [ "$OUTPUT" = "tail: impossible d'ouvrir '../../j12test/exemple3' en lecture: Aucun fichier ou dossier de ce type" ]
				then
					echo "expected and received '$OUTPUT'"
					echo "OK while arg doesn't match any file"
					OUTPUT=$(./ft_tail -c +4 ../exemple1);
					echo "testing ./ft_tail -c +4 ../exemple1"
					if [ "$OUTPUT" = "rtyuiop" ]
					then
						echo "expected and received '$OUTPUT'"
						echo "OK when '+' is used"
						if [ $n -eq 2 ]
						then	
							let "n = n + 1"
						fi
					else
						errorExit "Wrong output while '+' is used"
					fi
				else
					errorExit "Wrong output while one arg don't match any file"
				fi
			else
				errorExit "2 files not correctly displayed with no sign '+' nor '-'"
			fi
		else
			errorExit "file not correctly displayed with sign '-'"
		fi
	else 
		errorExit "Error: failed to create ft_tail" 
	fi
	make -s fclean
	echo "ex02 OK"
	echo ""
	cd ..
	rm -r ex02/
fi
if [ -f j12/ex03/Makefile ]
then
	cp -r j12/ex03/ ex03/
	cd ex03/
	make -s all || errorExit "Error: compilation failed"
	if [ -f ft_hexdump ]
	then 
		echo "ft_hexdump: compilation OK"
		make -s clean || errorExit "Error: failed to make clean"
		if [ -f ft*.o ]
		then
			errorExit "Error: failed to delete .o files"
		fi
		make -s fclean || errorExit "Error: failed to make fclean"
		if [ -f ft_hexdump ]
		then
			errorExit "Error: failed to delete ft_hexdump"
		fi
		make -s all || errorExit "Error: all failed"
		OUTPUT="`./ft_hexdump -C ../exemple1 ../exemple2`";
		OUTPUTBIS="`hexdump -C ../exemple1 ../exemple2`";
		echo "tested ./ft_hexdump -C ../exemple1 ../exemple2"
		echo "expected: $OUTPUTBIS"
		echo "received: $OUTPUT"
		if [ "$OUTPUT" = "$OUTPUTBIS" ]
		then
			echo "OK"
		else
			errorExit "wrong output with 2 args"
		fi	
		OUTPUT=$(./ft_hexdump -C ../exemple3 2>&1);
		echo "testing an arg doesn't matching any file:"
		echo "expected 'hexdump: ../exemple3: No such file or directory'"
		echo "received '$OUTPUT'"
		if [ "$OUTPUT" = "hexdump: ../exemple3: No such file or directory" ]
		then
			echo "OK"
		else
			errorExit "wrong output as arg doesn't match any file"
		fi
		OUTPUT="`./ft_hexdump -C ../exemple1 ../exemple3`";
		OUTPUTBIS="`hexdump -C ../exemple1 ../exemple3`";
		echo "tested ./ft_hexdump -C with an existing file and a non existing file"
		echo "expected: $OUTPUTBIS"
		echo "received: $OUTPUT"
		if [ "$OUTPUT" = "$OUTPUTBIS" ]
		then
			echo "OK"
		else
			errorExit "wrong output"
		fi
		OUTPUT="`./ft_hexdump -C ../exemple3 ../exemple1`";
		OUTPUTBIS="`hexdump -C ../exemple3 ../exemple1`";
		echo "tested ./ft_hexdump -C with a non existing file and an existing file"
		echo "expected: $OUTPUTBIS"
		echo "received: $OUTPUT"
		if [ "$OUTPUT" = "$OUTPUTBIS" ]
		then
			echo "OK"
		else
			errorExit "wrong output"
		fi
		OUTPUT="`cat ../exemple1 | ./ft_hexdump -C`";
		OUTPUTBIS="`cat ../exemple1 | hexdump -C`";
		echo "testing if ft_hexdump with no arg but stdin"
		echo "expected: $OUTPUTBIS"
		echo "received: $OUTPUT"
		if [ "$OUTPUT" = "$OUTPUTBIS" ]
		then
			echo "OK"
		else
			errorExit "wrong output"
		fi
		
		OUTPUT="`./ft_hexdump -C ../forstar`";
		OUTPUTBIS="`hexdump -C ../forstar`";
		echo "testing if same lines are escaped"
		echo "expected: $OUTPUTBIS"
		echo "received: $OUTPUT"
		if [ "$OUTPUT" = "$OUTPUTBIS" ]
		then
			echo "OK"
		else
			errorExit "wrong output"
		fi	
		if [ $n -eq 3 ]
		then	
			let "n = n + 1"
		fi
					
	else 
		errorExit "Error: failed to create ft_hexdump" 
	fi
	make -s fclean
	echo "ex03 OK"
	echo ""
	cd ..
	rm -r ex03/
fi

echo "resultat = $n"

exit 0


