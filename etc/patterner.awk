# patterner.awk : will replace "{[[:alnum:]]}" found by matching "${[[:alnum:]]}" exported shell variable
# patterner.awk is kind of an ancestor of gomplate that works with {{Env.VARNAME}}
# parameters: $Debug, $Verbose will print messages to sdterr
BEGIN { found = 1; matched = 1; Verbose = "false"; Debug = ENVIRON["Debug"]; if (Debug == "true") {Verbose = true; printf "--- template=%s\n",ARGV[1] > "/dev/tty";} }
{
  # http://stackoverflow.com/questions/15745046/need-sed-or-awk-script-to-do-strlen-optimization
  if (match($0,/{[[:alnum:]_]*}/)) {
    NbVar = 1;
    Nb = split ($0, line, "{");
    # for each variable of the line,
    for ( i=2 ; i<=Nb ; ++i ) {
      split (line[i],var,"}");
      VARR[NbVar] = var[1];
      VAR[found] = VARR[NbVar];
      # replace {variable} by ${variable} only if ${variable} is exported and found
      valueFromEnv=ENVIRON[VARR[NbVar]]
      if (valueFromEnv != "" ) {
        if (valueFromEnv == "\\n" ) { gsub("{" var[1] "}", "\n"); }
        else {
          # bellow is the evaluation of any found "${variable}"
          while (valueFromEnv ~ /\$\{[^}]+\}/ && valueFromEnv !~ /\./) {
            if (Debug == "true") {print "valueFromEnv1="valueFromEnv > "/dev/tty";}
            p=split(valueFromEnv, split1, "}"); p=split(split1[1], split2, "\\${")
            valueToEval=split2[2];
            if (Debug == "true") {print "valueFromEnv2="valueToEval > "/dev/tty";}
            valueFromEnv=sprintf("%s%s%s",split2[1],ENVIRON[valueToEval],split1[2]);
            if (Debug == "true") {print "valueFromEnv3="valueFromEnv > "/dev/tty";}
          }
          # bellow is the heart of this script: replacement of {variable}
          gsub("{" var[1] "}", valueFromEnv);
        }
        matched++;
      }
      if (Debug == "true") {
        printf "var[1]=%s NbVar=%s VARR[NbVar]=%s found=%s VAR[found]=%s ENVIRON[VARR[NbVar]]=%s\n",var[1],NbVar,VARR[NbVar],found-1,VAR[found-1],ENVIRON[VARR[NbVar]] > "/dev/tty";
      }
      NbVar++;
      found++;
    }
  }
  print
}
END { if (Verbose == "true") {
    print ENVIRON["END"]"------------------------------------" > "/dev/tty";
    if (Debug == "true") {
      for ( k=1 ; k<found ; ++k ) {
        if (ENVIRON[VAR[k]] == "") {color=ENVIRON["y"]} else {color=ENVIRON["g"]};
        printf "%s %s = %s%s\n",color,VAR[k],ENVIRON["HIGH"],ENVIRON[VAR[k]] > "/dev/tty";
      }
    }
    printf "%s patterner.awk : %3s variables found\n",ENVIRON["w"],found-1 > "/dev/tty";
    printf "%s patterner.awk : %3s matchs\n",ENVIRON["W"],matched-1 > "/dev/tty";
    print ENVIRON["END"]"------------------------------------" > "/dev/tty";
  }
}

