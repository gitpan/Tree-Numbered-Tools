#!/usr/bin/perl
use strict;
use Tree::Numbered::Tools;

# Print a tree structure in the text file format.
# This example uses a tree with various fields per node.
# The field names are given using the column names from a text file.

# The source
my $filename = 'tree.txt';
my $use_column_names = 1;
my $table = 'treetest';
my $dbs = 'mysql';
my $drop = 1;
# The output
print Tree::Numbered::Tools->convertFile2SQL(
					     filename         => $filename,
					     use_column_names => $use_column_names,
					     table            => $table,
					     dbs              => $dbs,
					     drop             => $drop,
					    );
