#!/usr/bin/perl
use strict;
use DBI;
use Tree::Numbered::Tools;

# Demo for the outputDB() method using a PgSQL database.
# Create a PgSQL database called 'treetest' before running this demo.

# The source
my $filename = 'tree.txt';
my $use_column_names = 1;

# Create the tree object
my $tree = Tree::Numbered::Tools->readFile(
					   filename         => $filename,
					   use_column_names => $use_column_names,
					 );

# The DB handle
my $dbh = DBI->connect("dbi:Pg:dbname=treetest", "postgres", "pgsecret") or die "DBI error: DBI->errstr\n";

# Create the database table and indexes, insert records.
# The SQL syntax used depends on the database driver used.
# Currently only MySQL and PgSQL are supported/tested.

# NOTE: MySQL supports a conditional DROP TABLE adding IF EXISTS, which is not supported by PostgreSQL.
# Thus, the DROP TABLE statement will fail on PostreSQL if the table doesn't exist, and the following CREATE TABLE will obviously fail if the PostgreSQL table already exists.
# So using PostgreSQL, set $drop only if you know you have an existing table.

my $table = 'treetest';
my $success = $tree->outputDB(
			      dbh   => $dbh,
			      table => $table,
			      drop  => 1,
			     );
