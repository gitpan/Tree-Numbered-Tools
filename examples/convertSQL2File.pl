#!/usr/bin/perl
use strict;
use DBI;
use Tree::Numbered::Tools;

# Print a tree structure in the text file format.
# This example uses a tree with various fields per node.
# The field names are given using the column names from a text file.

# The source
my $dbh = DBI->connect("DBI:mysql:database=treetest;host=localhost", 'root', 'mysql01') or die "DBI error: DBI->errstr\n";
my $sql = 'SELECT serial AS "Serial", parent AS "Parent", name AS "Name", url as "URL", color AS "Color", permission AS "Permission", visible as "Visible" FROM treetest ORDER BY Serial';
my $first_indent     = 2;
my $level_indent     = 2;
my $column_indent    = 2;
# The output
print Tree::Numbered::Tools->convertSQL2File(
					     dbh           => $dbh,
					     sql           => $sql,
					     first_indent  => $first_indent,
					     level_indent  => $level_indent,
					     column_indent => $column_indent,
					    );
