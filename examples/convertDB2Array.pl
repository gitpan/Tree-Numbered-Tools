#!/usr/bin/perl
use strict;
use DBI;
use Tree::Numbered::Tools;

# Print a tree structure in the text file format.
# This example uses a tree with various fields per node.
# The field names are given using the column names from a text file.

# The source
my $dbh = DBI->connect("DBI:mysql:database=treetest;host=localhost", 'root', 'mysql01') or die "DBI error: DBI->errstr\n";
my $table = 'treetest';
# The output
print Tree::Numbered::Tools->convertDB2Array(
					     dbh           => $dbh,
					     table         => $table,
					    );
