#!/usr/bin/perl
use strict;
use DBI;
use Tree::Numbered::Tools;

# Demo for the readDB() method.
# Run outputDB-mysql.pl or outputDB-pgsql.pl before running this demo to create the table 'treetest'.

# The DB handle
# MySQL
my $dbh = DBI->connect("DBI:mysql:database=treetest;host=localhost", 'root', 'mysecret') or die "DBI error: DBI->errstr\n";
# PgSQL
#my $dbh = DBI->connect("dbi:Pg:dbname=treetest", "postgres", "pgsecret") or die "DBI error: DBI->errstr\n";

# The source table
my $table = "treetest";

# Get the tree
my $tree = Tree::Numbered::Tools->readDB(
					 dbh => $dbh,
					 table => $table,
					 );

# Print the tree
foreach ($tree->listChildNumbers) {
  print $_, " ", join(' -- ', $tree->follow($_,"name")), "\n";
}

# Print column names
print "\nDatabase table columns:\n", join(' ', $tree->getColumnNames()), "\n";

# # # Print details about a node
print "\nDetails about node 7:\n";
my @name7 = $tree->follow(7,'name');
my @url7 = $tree->follow(7,'url');
print  "name: ", pop(@name7), "\n";
print  "url: ", pop(@url7), "\n";

