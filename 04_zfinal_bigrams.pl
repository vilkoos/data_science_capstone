
use strict; 
use warnings;
use POSIX; # funcution ceil, floor

# *****************************************************
# ********** global vars (+initialisation) ************
# *****************************************************
my $Lcur = "";    # text line currently procesed
my $EOF = 0;      # end of input file (Yes=1,No=0)
my $cnt = 0;      # number of occurances of a word
my $wrd = "";     # the predicted word on the current line
my $prd = "";     # the predictor word on the current line
my $occ = 0;	  # bigram occurances per milion
my $prev = "";    # the word on the previous input line


# *****************************************************
# ****************** mainline *************************
# *****************************************************

r100_init_main();
while ($EOF != 1) 
{
	$cnt = 0;
	while ($prd eq $prev && $EOF != 1) 
	{ 
		if ($cnt < 3 && ($occ*1) >= 5 && $EOF != 1) { r910_print_line()};
		r900_read_line(); 
		$cnt = $cnt +1;
	};
	$prev = $prd;
	#r900_read_line();
};
r110_close_main();


# ****************************************************
# ********** action routines *************************
# ****************************************************

sub r100_init_main
{
	open(INP , "< orderd_bigrams.csv") || die(" file not found" );
	open(OUT , "> twit_best_bigram.csv");
	print(OUT "predictor; word; occPerM\n");
	$Lcur = <INP>;    # read header line
	r900_read_line(); # read frist content line
	$prev = $prd;
}

sub r110_close_main
{
	close(INP);
	close(OUT);
}


sub r910_print_line
{
	print(OUT "$prd; $wrd; $occ\n");
}

sub r900_read_line
{
	$Lcur = <INP>;
	chomp($Lcur);
	$Lcur = trim($Lcur);
	print("$Lcur\n");
	#-------------------
	$prd =  $Lcur;
	$prd =~ s/(.+);(.+);(.+)/$1/;
	$occ =  $Lcur;
	$occ =~ s/(.+);(.+);(.+)/$2/;
	$wrd =  $Lcur;
	$wrd =~ s/(.+);(.+);(.+)/$3/;
	#-------------------
	if (eof == 1) {$EOF = 1};
	#if (eof != 1) {$cnt = $cnt + 1};
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

