#!/usr/bin/perl
use strict;
use DBI;
use Tree::Numbered::Tools;

# Print a tree structure in the text file format.
# This example uses a tree with various fields per node.
# The field names are given using the column names from a text file.

# The source
my $filename = 'tree.txt';
my $use_column_names = 1;
my $dbh = DBI->connect("DBI:mysql:database=treetest;host=localhost", 'root', 'mysql01') or die "DBI error: DBI->errstr\n";
my $table = 'treetest';
my $drop = 1;
# The output (the created table and its records)
my $success = Tree::Numbered::Tools->convertFile2DB(
						    filename         => $filename,
						    use_column_names => $use_column_names,
						    dbh              => $dbh,
						    table            => $table,
						    drop             => $drop,
						   );
