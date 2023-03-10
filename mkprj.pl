#!/usr/bin/perl
use warnings;
use Time::Piece;

sub clear_screen {
    system("clear");
}
clear_screen();
my $date = localtime->strftime('%Y-%m-%d');
print "*********************************************\n".
"** Make Project script\n".
"*********************************************\n".
"** please offer a name: ";
my $name = <STDIN>;
chomp($name);
$name=~s/ /-/g;
print "** please offer some tags seperated by a space: ";
my $tags = <STDIN>;
chomp($tags);
print "* please offer priority; ";
my $priority = <STDIN>;
chomp($priority);

my $dirStorage = "/home/goblin/Project_archive/$name";
mkdir $dirStorage; #or die "could not create Directory '$dirStorage' $!";
print "** done makeDir\n";
my $projfile = "/home/goblin/Zettel/GoblinKnows/FOREST/04-dataBase/projects/$name.md";
open(my $fh, '>', $projfile) or die "could not open file '$projfile' $!";
print $fh "---\n".
"alias:\n".
"cssclass:\n".
"lastReviewed:\n".
"tags: $tags\n".
"isProject: true\n".
"note:\n".
"priority: $priority\n".
"projCompleted:\n".
"projectMain: $name\n".
"projectType:\n".
"status: planning\n".
"date: $date\n".
"---\n\n".
"# $name\n\n\n\n\n".
"```dataview\n".
"task\n".
"from \"TOOLS\"\n".
"where !completed & projectMain = \"$name\" & type = \"taskList\"\n".
"```\n\n\n".
"[[$name-taskList]]\n".
"[$name folder](file:///home/goblin/Project_archive/$name)\n".
"[This project is licenced using the Gnu GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html)";


close $fh;
print "** done project page\n";
my $taskfile = "/home/goblin/Zettel/GoblinKnows/TOOLS/projectFile_taskLists/$name-taskList.md";
open(my $tf, '>', $taskfile) or die "could not open file '$taskfile' $!";
print $tf "---\n".
"cssstyle:\n".
"isProject: true\n".
"projectMain: $name\n".
"type: taskList\n".
"date: $date\n".
"---\n\n\n".
"# $name-taskList\n".
"[[$name|Link to main project]]";
close $tf;
print "** done taskList page\n";
