#!/usr/bin/perl
use strict;
use DBI;
use Tree::Numbered::Tools;

# Demo for the raedSQL() method, reading from a PgSQL database.

# The DB handle
my $dbh = DBI->connect("dbi:Pg:dbname=treetest", "postgres", "pgsecret") or die "DBI error: DBI->errstr\n";

# The SQL statement
# Easy mapping to columns using the SQL 'AS' syntax

# GOOD, works both on MySQL and  on PgSQL
###my $sql = 'SELECT serial AS "Serial", parent AS "Parent", name AS "Name", url as "URL", color AS "Color", permission AS "Permission", visible as "Visible" FROM treetest ORDER BY Serial';

# BAD, does not work on PgSQL
###my $sql = "SELECT serial AS Serial, parent AS Parent, name AS Name, url as URL, color AS Color, permission AS Permission, visible as Visible FROM treetest ORDER BY Serial";

# BAD, does not work on PgSQL
###my $sql = "SELECT serial AS 'Serial', parent AS 'Parent', name AS 'Name', url AS 'URL' FROM treetest ORDER BY Serial";

# REALLY BAD SQL statement. But working anyway. The readSQL() adds double quotes properly.
# Easy mapping to columns using the SQL 'AS' syntax
my $sql = 'SELECT serial AS Serial, parent AS Parent, name AS "Name", url AS "URL" , color AS "MyColor", permission AS \'MyPermission\', visible AS "Visible" FROM treetest ORDER BY Serial';

# Get the tree
my $tree = Tree::Numbered::Tools->readSQL(
					  dbh => $dbh,
					  sql => $sql,
					 );

# Print the tree
print "Nodes:\n";
foreach ($tree->listChildNumbers) {
  print $_, " ", join(' -- ', $tree->follow($_,"Name")), "\n";
}

# Print column names
print "\nSQL statement columns:\n", join(' ', $tree->getColumnNames()), "\n";

# # # Print details about a node
print "\nDetails about node 7:\n";
my @name7 = $tree->follow(7,'Name');
my @url7 = $tree->follow(7,'URL');
print  "Name: ", pop(@name7), "\n";
print  "URL: ", pop(@url7), "\n";
