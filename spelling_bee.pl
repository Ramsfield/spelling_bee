#!/usr/bin/perl
use strict;

# Get letters from user
print "What is the required letter?: ";
my $req = <>;
chomp $req;
print "Required is $req\n";

my @letters;
print "What are the other 6 letters?:\n";

my @a = (1..6);
for(@a) {
	print "Letter $_: ";
	$letters[$_] = <>;
	chomp $letters[$_];
}

print "Other Letters: @letters\n";

#Open the dictionary
open(FH, '<', "english-words/words_alpha.txt") or die $!;

#Find words that are valid
my @valid_words;
my $idx = 0;

my $contains = "$req";
for(@letters) {
	$contains = "$contains"."$_";
}
print "Contains: $contains\n";
while(<FH>) {
	my $word = $_;
	$word =~ s/\s//g; #Remove all whitespace from the word
	#Make sure word contains only our letters
	if($word =~ m/^[$contains]+$/i) {
		#Make sure word contains the required letter
		if($word =~ m/$req/) {
			@valid_words[$idx++] = $word;
		}
	}
}

close(FH);

#Sort array by size
#(Currently using Bubble sort. Maybe use a better algorithm. Or don't this gets ran once a day)

my $arrsize = @valid_words;
my $swapped; #Optimized bubble sort!
for(my $i=0; $i < $arrsize - 1; $i++) {
	$swapped = 0;
	for(my $j=0; $j < $arrsize -$i - 1; $j++) {
		if(length($valid_words[$j]) < length($valid_words[$j + 1])) {
			my $temp = $valid_words[$j];
			$valid_words[$j] = $valid_words[$j+1];
			$valid_words[$j+1] = $temp;
			$swapped = 1;
		}
	}
	if ($swapped == 0) {
		last;
	}
}

print "\nValid Words:\n";
for(@valid_words) {
	print "$_\n";
}
