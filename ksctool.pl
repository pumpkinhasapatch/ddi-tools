#!/usr/bin/env perl
use warnings;
use experimental 'smartmatch';
use strict;
use utf8;
use Data::Dumper;
use Scalar::Util qw(looks_like_number);
use open qw( :std :encoding(UTF-8) );
use Encode qw(decode encode);
#use Clipboard; <-- Older line, not needed now.

my $option = $ARGV[0];
my $filename = $ARGV[1];

sub dec_uint
{
    my ($data, $sz) = (shift, shift);
    my $res = 0;

    # Fix strings
    for my $c (0..scalar @$data-1)
    {
    	$data->[$c] = ord($data->[$c]) unless (looks_like_number($data->[$c]));
    }

    for my $c (0..scalar @$data-1)
    {
    	$res |= ($data->[$c] << ($c*8));
    }

    return $res;
}

# Reads bytes and returns the length
sub bread
{
	my ($FH, $size, $dont_number) = (shift, shift, shift);
	my $tmp;
	my $ret_size = read($FH, $tmp, $size);
	
	$tmp = [split('', $tmp)];
	unless ($dont_number)
	{
		foreach my $c (0..scalar @$tmp-1)
		{
			$tmp->[$c] = ord($tmp->[$c]);
		}
	}
	
	die "read size of $size didn't match bread size!" unless $size == $ret_size;
	return $tmp;
}

sub unmoonrune
{
	Encode::decode("cp932", shift);
}

sub loop_nullterm_strings
{
	my $FH = shift;
	my $strings = [];
	my $str;
	my $cur;
	
	my $nullcnt = 0;
	my $doublenull = 0;
	while ($doublenull != 2)
	{
		
		read($FH, $cur, 1);
		$cur = ord($cur);
		if ($cur != 0)
		{
			$nullcnt = 0;
			$str .= chr($cur);
		}
		else {
			$nullcnt++;
			$doublenull++ if ($nullcnt == 2);
			last if (!$str && $doublenull == 2);
			# Do something with str
			chomp($str) if $str;
			$str = Encode::decode("cp932",$str);
			push(@$strings, $str);
			#print $str . "\n";
			$str = undef;
		}
	}
	
	return $strings;
}

sub parse_messages
{
	my ($FH, $end) = @_;
	my $c;
	my $buffer;
	my $strings = [];
	
	my $NAB = sub { read($FH, $c, 1); ${$_[0]}++; $c; };
	
	for (my $i = 0; $i <= $end;)
	{
		$NAB->(\$i);
		if (ord($c) == 0x48)
		{
			$NAB->(\$i);
			if (ord($c) == 0x82)
			{	
				# Probably japanese...
				$buffer = $c;
				while (1)
				{
					$NAB->(\$i);
					last if ord($c) == 0;
					$buffer .= $c;
				}
			}
		}
		if ($buffer)
		{
			push @$strings, unmoonrune($buffer);
			$buffer = undef;
		}
		
	}
	
	return $strings;
}

sub format_strings
{
	my ($filename, $strings) = (shift, shift);
	
	open(my $R, '>', $filename) or die $!;
	
	for my $str (@$strings)
	{
		if ($str)
		{
			$str =~ s/\R/<LR>/g;
			$str =~ s/�@/♥/g;
			print $R "\"$str\"=" . "\n";
		}
	}
	
	close($R);
}

open(my $FH, '+<:raw', $filename) or die $!;
print("Opened file $filename...\n");

if ($option eq "x" || $option eq "extract")
{
	die "Not a KSC" unless bread($FH, 4) ~~ [75, 83, 67, 0];
	# Skip first 8 bytes
	seek($FH, 4, 1);
	my $x = bread($FH, 4);
	my $nulltermstr_offset = dec_uint($x, 4);
	# Seek to this position
	seek($FH, $nulltermstr_offset, 0);
	# Skip header info that we don't really know about
	
	# BEGIN nullterm section
	seek($FH, 45, 1);
	format_strings("dialogue.txt", loop_nullterm_strings($FH));
	# END nullterm section
	
	# BEGIN message section
	#?
	seek($FH, 16, 0);
	format_strings("messages.txt", parse_messages($FH, $nulltermstr_offset));
	# END message section
	
	#print FH pack('s>', 0x1111);
}
elsif ($option eq "i" || $option eq "inject" || $option eq "pack" ||
       $option eq "read")
{
	open(my $info, "messages.txt") or die "Could not open: $!";

	my $x = 0;
	while (my $line = <$info>)
	{
		$line =~ s/.*=(.*)$/$1/g;
		die "Line at $x is not translated! Aborting." if $line eq "\n" || !$line;
		print $line;
		last if $. == 2;
	}
}
elsif ($option eq "debug")
{
	die "Not a KSC" unless bread($FH, 4) ~~ [75, 83, 67, 0];
	# Skip first 8 bytes
	seek($FH, 4, 1);
	my $x = bread($FH, 4);
	my $nulltermstr_offset = dec_uint($x, 4);
	# Seek to this position
	seek($FH, $nulltermstr_offset, 0);
	# Skip header info that we don't really know about
	seek($FH, 45, 1);
	loop_nullterm_strings($FH);
	# Loop until we hit something...
	
	print $FH "Hello world\0=^)";
	# Skip over 
	while (bread($FH, 1)->[0] == 0) {}
	seek($FH, -1, 1);
	
	my $res;
	for (my $i = 0; $i < 10500; $i++)
	{
		$res = bread($FH, 4);
		#print Dumper $res;
		if ($res->[3] == 0x20)
		{
			print(".");
			seek($FH, -4, 1);
			print $FH pack('N', 0x00000020);
			#print $FH "lole";
			#print $FH 0x00;
			#seek($FH, 1, 1);
		}
		elsif ($res->[3] == 0xB0)
		{
			print(".");
			seek($FH, -4, 1);
			print $FH pack('N', 0x630F03B0);
			#print $FH "lole";
			#print $FH 0x00;
			#seek($FH, 1, 1);
		}
	}
	print "\n";
}


close($FH);
