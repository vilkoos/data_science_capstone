
use strict; 
use warnings;
use POSIX; # funcution ceil, floor

# *****************************************************
# ********** global vars (+initialisation) ************
# *****************************************************
my $Lcur = "";    # text line currently procesed
my $Lprv = "";    # previous red text line
my $EOF = 0;      # end of input file (Yes=1,No=0)
my $cnt = 0;      # number of occurances of a word
my $tot = 0;      # total number of words in input file

# *****************************************************
# ****************** mainline *************************
# *****************************************************

r100_init_main();
while ($EOF != 1) 
{
	while ($Lcur eq $Lprv) { r900_read_line(); }
	r210_close_block();
}
r110_close_main();

# ****************************************************
# ********** action routines *************************
# ****************************************************


sub r100_init_main
{
	open(INP , "< twit_test01_sorted.txt") || die(" file not found" );
	open(OUT , "> twit_monogram_500.txt");
	$Lcur = "aabbcczzxx"; # becomes Lprv in r900
	$cnt = 0;
	$tot = 0;
	r900_read_line();
}

sub r110_close_main
{
	print(OUT "\ntotal = $tot");
	close(INP);
	close(OUT);
}

sub r210_close_block
{
	if ($cnt >= 1000000) {print(OUT "-$cnt       ;  $Lprv \n") ; goto GOON} ;
	if ($cnt >=  100000) {print(OUT "--$cnt      ;  $Lprv \n") ; goto GOON} ;
	if ($cnt >=   10000) {print(OUT "---$cnt     ;  $Lprv \n") ; goto GOON} ;
	if ($cnt >=    1000) {print(OUT "----$cnt    ;  $Lprv \n") ; goto GOON} ;
	if ($cnt >=     500) {print(OUT "-----$cnt   ;  $Lprv \n") ; goto GOON} ;
    GOON: 
	if ($cnt >= 500) {$tot = $tot + $cnt};
	$cnt = 0;
	r900_read_line();
}

sub r900_read_line
{
	$Lprv = $Lcur;
	$Lcur = <INP>;
	chomp($Lcur);
	$Lcur = trim($Lcur);
	while ($Lcur eq "-") 
		{ $Lcur = <INP>; 
	      chomp($Lcur);
		  $Lcur = trim($Lcur);
		}; # ignore lines with -
	if (eof == 1) {$EOF = 1};
	if (eof != 1) {$cnt = $cnt + 1};
}

# ****************************************************
# ********** aux routines *************************
# ****************************************************

sub trim
{
	my $outStr = "";
	my $trimStr = $_[0];
	$trimStr =~ s/^\s+//;
	$trimStr =~ s/\s+$//;
	$outStr = $trimStr;
}

