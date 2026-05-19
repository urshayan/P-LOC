use strict;
use warnings;

# get file from command line
my $file = $ARGV[0];

die "Usage: perl ploc.pl <file>\n" unless $file;

open(my $fh, '<', $file) or die "Cannot open file: $!";

#vars
my $total = 0;
my $blank = 0;
my $comment = 0;
my $code = 0;
my %langs = (
    py => "Python",
    pl => "Perl",
    c => "C",
    cpp => "C++",
    js => "JavaScript",
);

#detect the extension
my ($ext) = $file =~ /\.([^.]+)$/;

my $lang = $langs{$ext} || "Just a Text File";

while (my $line = <$fh>){
    $total++;

    # Blank line
    if ($line =~ /^\s*$/ ){ $blank++;}

    #python/perl comments
    elsif (($ext eq "py" || $ext eq "pl") && $line =~ /^\s*#/){
        $comment++;
    }

    #c/c++/js comments
    elsif (($ext eq "c" || $ext eq "cpp" || $ext eq "js") && $line =~ /^\s*\/\//){
        $comment++;
    }

    else { $code++;}
}


    close($fh);

    print "\n";
    print "FILE: $file\n";
    print "LANGUAGE: $lang\n\n";

    print "Total Lines  :       $total\n";
    print "Blank Lines  :       $blank\n";
    print "Comment Lines:       $comment\n";
    print "Code Lines   :       $code\n";

