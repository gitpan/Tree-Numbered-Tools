#!/usr/bin/perl -w
use strict;
use DBI;
use Tree::Numbered::Tools;

# Demo for the convertSQL2File() method, converts an SQL SELECT statement into file format.

# Help message
sub usage
  {
    print "\n";
    print "Usage:\n";
    print "$0 mysql [database [user [password]]]\n";
    print "or\n";
    print "$0 pgsql [database [user [password]]]\n";
    print "Examples:\n";
    print "$0 mysql test root mysecret\n";
    print "$0 pgsql test pgsql mysecret\n";
    print "\n";
    exit 1;
  }

# Check for command line argument.
my $dbs = $ARGV[0] || usage;
my $user = '';
my $password = '';
my $database = '';
my $dbh_string = '';
SWITCH: for ($dbs) {
  # MySQL
  /^mysql$/i        && do {
    $database = $ARGV[1] || 'test';
    $user = $ARGV[2] || 'root';
    $password = $ARGV[3] || '';
    $dbh_string = "DBI:mysql:database=$database;host=localhost";
    last SWITCH;
  };
  # PgSQL
  /^postgres$|^PostgreSQL$|^pgsql$|^pg$/i         && do {
    $database = $ARGV[1] || 'test';
    $user = $ARGV[2] || 'pgsql';
    $password = $ARGV[3] || '';
    $dbh_string = "DBI:Pg:database=$database;host=localhost";
    last SWITCH;
  };
  # DEFAULT
  print STDERR "Database server type '$dbs' is not supported.";
  usage;
}

# The DB handle
my $dbh = DBI->connect($dbh_string, $user, $password) or die "DBI error: DBI->errstr\n";

# The source
my $sql = "SELECT serial, parent AS 'Parent', name AS 'Name', url as 'URL', color AS 'Color', permission AS 'Permission', visible as 'Visible' FROM treetest ORDER BY Serial";

# The output
my $first_indent     = 2;
my $level_indent     = 2;
my $column_indent    = 2;
print Tree::Numbered::Tools->convertSQL2File(
					     dbh           => $dbh,
					     sql           => $sql,
					     first_indent  => $first_indent,
					     level_indent  => $level_indent,
					     column_indent => $column_indent,
					    );
