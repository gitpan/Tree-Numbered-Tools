#!/usr/bin/perl -w
use strict;
use Test::More 'no_plan';
use Tree::Numbered::Tools;

my $filename = 'tree.txt';
my $arrayref = [
		[qw(serial parent name url)],
		[1, 0, 'ROOT', 'ROOT'],
		[2, 1, 'File', 'file.pl'],
		[3, 2, 'New', 'file-new.pl'],
		[4, 3, 'Window', 'file-new-window.pl'],
		[5, 3, 'Template', 'file-new-template.pl'],
		[6, 2, 'Open', 'file-open.pl'],
		[7, 2, 'Save', 'file-save.pl'],
		[8, 2, 'Close', 'file-close.pl'],
		[9, 2, 'Exit', 'file-exit.pl'],
		[10, 1, 'Edit', 'edit.pl'],
		[11, 10, 'Undo', 'edit-undo.pl'],
		[12, 10, 'Cut', 'edit-cut.pl'],
		[13, 10, 'Copy', 'edit-copy.pl'],
		[14, 10, 'Paste', 'edit-paste.pl'],
		[15, 10, 'Find', 'edit-find.pl'],
		[16, 1, 'View', 'view.pl'],
		[17, 16, 'Toolbars', 'view-toolbars.pl'],
		[18, 17, 'Navigation', 'view-toolbars-navigation.pl'],
		[19, 17, 'Location', 'view-toolbars-location.pl'],
		[20, 17, 'Personal', 'view-toolbars-personal.pl'],
		[21, 16, 'Reload', 'view-reload.pl'],
		[22, 16, 'Source', 'view-source.pl'],
	       ];
my $first_indent     = 2;
my $level_indent     = 2;
my $column_indent    = 2;
my $table = 'treetest';

my $tree = Tree::Numbered::Tools->readFile(
					   filename         => $filename,
					   use_column_names => 1,
					  );
ok( defined $tree,              'readFile() returned an object' );
ok( $tree->isa('Tree::Numbered::Tools'),   "  and it's a Tree::Numbered::Tools object" );
ok( $tree->isa('Tree::Numbered'),   "  and it's also a Tree::Numbered object" );
my $tree2 = Tree::Numbered::Tools->readArray(
					     arrayref         => $arrayref,
					     use_column_names => 1,
					    );
ok( defined $tree,              'readArray() returned an object' );
ok( $tree->isa('Tree::Numbered::Tools'),   "  and it's a Tree::Numbered::Tools object" );
ok( $tree->isa('Tree::Numbered'),   "  and it's also a Tree::Numbered object" );
SKIP: {
  skip 'because we cannot test readSQL() without a database handle', 1;
};
SKIP: {
  skip 'because we cannot test readDB() without a database handle', 1;
};
my $output = $tree->outputFile(
			       first_indent     => $first_indent,
			       level_indent     => $level_indent,
			       column_indent    => $column_indent,
			      );
ok( $output,   'outputFile() returned some output' );
$output = '';
$output = $tree->outputArray();
ok( $output,   'outputArray() returned some output' );
$output = '';
$output = $tree->outputSQL(
			   table => $table,
			   dbs   => 'PgSQL',
			   drop  => 1,
			  );
ok( $output,   'outputSQL() returned some output' );
SKIP: {
  skip 'because we cannot test outputDB() without a database handle', 1;
};
my @column_names = $tree->getColumnNames();
ok( scalar(@column_names),   'getColumnNames() returned some columns for a tree created from a file' );
@column_names = ();
@column_names = $tree2->getColumnNames();
ok( scalar(@column_names),   'getColumnNames() returned some columns for a tree created from an array' );
my $source_type = $tree->getSourceType();
ok( ($source_type eq 'File'),   'getSourceType() returned "File" for a tree created from a file' );
my $source_type2 = $tree2->getSourceType();
ok( ($source_type2 eq 'Array'),   'getSourceType() returned "Array" for a tree created from an array' );
my $source_name = $tree->getSourceName();
ok( ($source_name eq $filename),   'getSourceName() returned "'.$source_name.'" as the source name for a tree created from a file' );
my $source_name2 = $tree2->getSourceName();
ok( (!defined($source_name2)),   'getSourceName() returned "undef" as the source name for a tree created from an array (yes, that\'s ok :-)' );
