
use strict; 
use warnings;
use POSIX; # funcution ceil, floor

# *****************************************************
# ********** global vars (+initialisation) ************
# *****************************************************
my $Lcur = "";    # text line currently procesed
my $EOF = 0;      # end of input file (Yes=1,No=0)
my $outLine = ""; # outputline
my $cnt = 0;
my $toss = 0;


# *****************************************************
# ****************** mainline *************************
# *****************************************************
open(INP , "< en_US.twitter.txt") || die(" file not found" );
open(OUT , "> twit_train01.txt");
open(OUT2, "> twit_test01.txt");
r100readLine();
while ($EOF != 1) 
    {
	 r010procesLine();
	 if ($outLine ne "") {r200printLine()} ;
	 r100readLine();
	}
close(INP);
close(OUT);
close(OUT2);

# ******* cleaning logic here *****************************

sub r010procesLine
{
	$Lcur = trim($Lcur);       # trim leading and trailing spaces
	$Lcur = lc($Lcur);         # letters to lowercase
	$Lcur =~ s/[^a-z\ \']//g;  # remove all chars except a-z, space and '
	$Lcur =~ s/([a-z])\'([a-z])/$1\"$2/g; # change ' between to letters to "
	$Lcur =~ s/\'//g;          # remove all other '
	$Lcur =~ s/\"/\'/g;	       # change " back to '
	$Lcur = trim($Lcur);       # trim leading and trailing spaces
    $Lcur =~ s/\ \ \ \ /\ /g;  # make double spaces one space
    $Lcur =~ s/\ \ \ /\ /g;    # make double spaces one space
    $Lcur =~ s/\ \ /\ /g;      # make double spaces one space
	$Lcur =~ s/\ /\n/g;        # put each word on one line
	$outLine = $Lcur;
}

# ****************************************************
# ********** action routines *************************
# ****************************************************

sub r100readLine
{
	$Lcur = <INP>;
	chomp($Lcur);
	$Lcur = trim($Lcur);
	if (eof == 1) {$EOF = 1}
}

#-------------

sub r200printLine
{
	$toss = rand();
	if ($toss <= 0.5) {print(OUT  "$outLine\n-\n")};
	if ($toss >  0.5) {print(OUT2 "$outLine\n-\n")};
#	if ($cnt < 1000) { print(OUT "$outLine\n-\n"); $cnt = $cnt + 1};
}

#-------------

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

