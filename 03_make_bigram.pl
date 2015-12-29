
use strict; 
use warnings;
use POSIX; # funcution ceil, floor

# *****************************************************
# ********** global vars (+initialisation) ************
# *****************************************************
my $Lcur = "";      # corpus text line currently procesed
my $Lprv = "";      # previous read corpus text line
my $EOF = 0;        # end of input corpus file (Yes=1,No=0)
my $cnt = 0;        # number of occurances of a word
my $occPerM = 0;    # number of times a words occurs per milion words
my $wrd = "";       # the word itself
our %wordCount = (); # hash to count word occurrences

# *****************************************************
# ****************** mainline *************************
# *****************************************************

r100_init_main();
while ($EOF != 1) 
{
	r900_read_line();
	r200_process_line();
}
r110_close_main();

# ****************************************************
# ********** action routines *************************
# ****************************************************


sub r100_init_main
{
	#-- read in the wordCount hash ------------------
	open(WRD , "< goodwords.csv") || die(" file not found" );
	r101_read_wordCount();
	close(WRD);
	#-- open in and output --------------------------
	open(INP , "< twit_train01.txt") || die(" file not found" );
	open(OUT , "> bigrams.txt");
	#-- read the first word -------------------------
	r900_read_line();
}

sub r101_read_wordCount
{
	my $count = 0;
	my $xword = "";
	if ($EOF != 1) {$Lcur = <WRD>}; # read header line
	$Lcur = <WRD>;
	if (eof == 1) {$EOF = 1};
	while ($EOF != 1) 
    {
		$xword = $Lcur;
		$xword =~ s/(.+);(.+)/$2/g;
		$xword = trim($xword);
		#---------------------------
		$count = $Lcur;
		$count =~ s/(.+);(.+)/$1/g;
		$count = trim($count);
		#---------------------------
		$wordCount{$xword} = $count;
		#---------------------------
		$Lcur = <WRD>;
		if (eof == 1) {$EOF = 1};
	}
	$EOF = 0; # reset EOF
}

sub r110_close_main
{
	close(INP);
	close(OUT);
}

sub r200_process_line
{
	if (exists($wordCount{$Lcur}) && $Lcur ne "-" && $Lprv ne "-") 
	{
		print(OUT "$Lprv ; $Lcur\n");
	}
}

sub r900_read_line
{
	$Lprv = $Lcur;
	$Lcur = <INP>;
	chomp($Lcur);
	$Lcur = trim($Lcur);
	if (eof == 1) {$EOF = 1};
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

