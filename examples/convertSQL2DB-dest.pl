#!/usr/bin/perl
use strict;
use DBI;
use Tree::Numbered::Tools;

# Reads records using an SQL statement from a database table, and stores it in another database.
# This may be convienient migrating a MySQL table to a PostgreSQL table, for example.

# The source
my $dbh = DBI->connect("DBI:mysql:database=treetest;host=localhost", 'root', 'mysql01') or die "DBI error: DBI->errstr\n";
my $sql = 'SELECT serial AS "Serial", parent AS "Parent", name AS "Name", url as "URL", color AS "Color", permission AS "Permission", visible as "Visible" FROM treetest ORDER BY Serial';
# The destination (a different database handle)
my $dbh_dest = DBI->connect("dbi:Pg:dbname=treetest", "postgres", "postgres") or die "DBI error: DBI->errstr\n";
my $table = 'treetest2';
my $drop = 1;
# The output (the created table and its records in a different destination database)
my $success = Tree::Numbered::Tools->convertSQL2DB(
						   dbh           => $dbh,
						   sql           => $sql,
						   dbh_dest      => $dbh_dest,
						   table         => $table,
						   drop          => $drop,
						  );
