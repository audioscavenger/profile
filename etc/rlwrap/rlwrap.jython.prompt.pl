#!/usr/bin/env perl
# INFO: rlwrap.jython.dictionary.txt is created by buildRlwrapJythonDictionaryFile (init.py)

use lib ($ENV{RLWRAP_FILTERDIR} or ".");
use RlwrapFilter;
use strict;

my $dmgr = $ARGV[0];
my $filter = new RlwrapFilter;
my $name = $filter -> name;

$filter -> help_text("Usage: rlwrap -z $name <command>\n".
                     "replace prompt by current dmgr name\n".
                     "(demonstrates some simple prompt-munging techniques)");

$filter -> prompt_handler (\&munge_prompt);

$filter -> run;


sub munge_prompt {
  my ($prompt) = @_;
  my ($JYTHON_VERSION) = $ENV{JYTHON_VERSION};
  if ($prompt && $filter -> previous_tag == TAG_OUTPUT) {
    return "$JYTHON_VERSION> ";
  } else {
    return $prompt;
  }
}
