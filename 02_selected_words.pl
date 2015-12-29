
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
	open(INP , "< twit_monogram_500_desc.txt") || die(" file not found" );
	open(OUT , "> twit_selected_words.csv");
#	print(OUT "cnt; occPerM; word\n");
	print(OUT "occPerM; word\n");
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
	$Lcur2 =~ s/(.+);(.*)/$1/;	
	$cnt = trim($Lcur2);
	# -- get the word ------------
	my $Lcur3 = $Lcur;
	$Lcur3 =~ s/(.+);(.*)/$2/;	
	$wrd = trim($Lcur3); 
	# -- calc occPerM ------------
	$occPerM = floor( 1000000*($cnt/$tot) );
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
#	print(OUT "$cnt; $occPerM; $wrd\n");
	print(OUT "$occPerM; $wrd\n");
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

