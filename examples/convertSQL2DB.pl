#!/usr/bin/perl
use strict;
use DBI;
use Tree::Numbered::Tools;

# Reads records using an SQL statement from a database table, and uses the same destination database.
# To use  a different database as destination check the example 'convertSQL2DB-dest.pl'.

# The source
my $dbh = DBI->connect("DBI:mysql:database=treetest;host=localhost", 'root', 'mysql01') or die "DBI error: DBI->errstr\n";
my $sql = 'SELECT serial AS "Serial", parent AS "Parent", name AS "Name", url as "URL", color AS "Color", permission AS "Permission", visible as "Visible" FROM treetest ORDER BY Serial';
my $table = 'treetest2';
my $drop = 1;
# The output (the created table and its records in the same destination database)
my $success = Tree::Numbered::Tools->convertSQL2DB(
						   dbh           => $dbh,
						   sql           => $sql,
						   table         => $table,
						   drop          => $drop,
						  );
