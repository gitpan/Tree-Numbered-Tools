#!/usr/bin/perl
use strict;
use DBI;
use Tree::Numbered::Tools;

# Demo for the outputDB() method using a MySQL database.
# Create a MySQL database called 'treetest' before running this demo.

# The source
my $filename = 'tree.txt';
my $use_column_names = 1;

# Create the tree object
my $tree = Tree::Numbered::Tools->readFile(
					   filename         => $filename,
					   use_column_names => $use_column_names,
					 );

# The DB handle
my $dbh = DBI->connect("DBI:mysql:database=treetest;host=localhost", 'root', 'mysecret') or die "DBI error: DBI->errstr\n";

# Create the database table and indexes, insert records.
# The SQL syntax used depends on the database driver used.
# Currently only MySQL and PgSQL are supported/tested.
# The MySQL "DROP TABLE 'mytable IF EXISTS" statement is used to drop a possibly existing table, so $drop can always be set for MySQL, even if the table doesn't exist. 
my $table = 'treetest';
my $success = $tree->outputDB(
			      dbh   => $dbh,
			      table => $table,
			      drop  => 1,
			     );
