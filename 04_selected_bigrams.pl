
use strict; 
use warnings;
use POSIX; # funcution ceil, floor

# *****************************************************
# ********** global vars (+initialisation) ************
# *****************************************************
my $Lcur = "";    # text line currently procesed
my $Lprv = "";    # previous red text line
my $EOF = 0;      # end of input file (Yes=1,No=0)
my $tot = 0;      # total number of words in input file
my $cnt = 0;      # number of occurances of a word
my $occPerM = 0;  # number of times a words occurs per milion words
my $wrd = "";     # the word itself
my $prd = "";     # the predictor word

# *****************************************************
# ****************** mainline *************************
# *****************************************************

r100_init_main();
while ($EOF != 1) 
{
	r900_read_line();
	r200_process_line();
	r910_write_line();
}
r110_close_main();

# ****************************************************
# ********** action routines *************************
# ****************************************************


sub r100_init_main
{
	open(INP , "< bigrams_sorted_gt10_desc.txt") || die(" file not found" );
	open(OUT , "> twit_selected_bigrams.csv");
#	print(OUT "cnt; occPerM; word\n");
	print(OUT "predictor; occPerM; word\n");
	r900_read_line();
	$Lcur =~ s/total = (.*)/$1/g;
	$Lcur = trim($Lcur);
	$tot = $Lcur;
}

sub r110_close_main
{
	close(INP);
	close(OUT);
}

sub r200_process_line
{
	# -- get the count -----------
	my $Lcur2 = $Lcur;
	$Lcur2 =~ s/-//g;
	$Lcur2 =~ s/(.+);(.*);(.*)/$1/;	
	$cnt = trim($Lcur2);
	# -- get the predictor ------------
	my $Lcur3 = $Lcur;
	$Lcur3 =~ s/(.+);(.*);(.*)/$2/;	
	$prd = trim($Lcur3); 
	# -- get the word ------------
	my $Lcur4 = $Lcur;
	$Lcur4 =~ s/(.+);(.*);(.*)/$3/;	
	$wrd = trim($Lcur4); 
	# -- calc occPerM ------------
	$occPerM = ceil( 1000000*($cnt/$tot) );
}

sub r900_read_line
{
	$Lcur = <INP>;
	chomp($Lcur);
	$Lcur = trim($Lcur);
	if (eof == 1) {$EOF = 1};
}

sub r910_write_line
{
#	print(OUT "$cnt; $occPerM; $wrd; $prd\n");
	print(OUT "$prd; $occPerM; $wrd\n");
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

