#!/usr/bin/perl
use strict;
use Tree::Numbered::Tools;

# Demo for the readFile() method using column names.

my $filename = 'tree.txt';
my $use_column_names = 0;
my $tree = Tree::Numbered::Tools->readFile(
					   filename         => $filename,
					   use_column_names => $use_column_names,
					  );

# Get the column names
my @column_names = $tree->getColumnNames(
					 filename => $filename,
					);
# Print the tree
# The root node, which is not included in the text file.
my $root = $tree->getSubTree(1);
print 1, " ", $root->getValue, "\n";
# The tree itself, as defined in the text file.
foreach ($tree->listChildNumbers) {
  print $_, " ", join(' -- ', $tree->follow($_,"Value")), "\n";
}

# Print details about a node
my $node = 7;
print "\nDetails about node $node:\n";
foreach my $column (@column_names) {
  my @values = $tree->follow($node, $column);
  print  "$column: ", pop(@values), "\n";
}

# An alternative way to get details about a node
print "\nSame details, another way:\n";
my $subtree = $tree->getSubTree($node);
foreach my $column (@column_names) {
  my $code = '$subtree->get'.$column;
  my $value = eval $code;
  print  "$column: $value\n";
}

