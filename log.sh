#=================================
# ***Logging command ouptut as it is without altering it. (Keep Leading spaces)***
# I want this output:
# $ free -m
#               total        used        free      shared  buff/cache   available
# Mem:          16265       11421        4619          17         223        4713
# Swap:          8196         775        7420

# Appened to a date stamp:
# 20200916-09:54:21-0400:               total        used        free      shared  buff/cache   available
# 20200916-09:54:21-0400: Mem:          16265       11421        4619          17         223        4713
# 20200916-09:54:21-0400: Swap:          8196         775        7420

# *Log to STDOUT
log() { while IFS= read -r line; do printf '%s\n' "$(date "+%Y%m%d-%H:%M:%S.%N%z"): $line"; done; };

# *or just output to a file defined in "LOGFILE".
log2file() { LOGFILE=$1; while IFS= read -r line; do printf '%s\n' "$(date "+%Y%m%d-%H:%M:%S.%N%z"): $line" >> $LOGFILE; done; };

# *or STDOUT and a file defined in "LOGFILE".
logand2file() { LOGFILE=$1; while IFS= read -r line; do printf '%s\n' "$(date "+%Y%m%d-%H:%M:%S.%N%z"): $line" | tee -a "$LOGFILE"; done; };

# *log Example.
free -m |& log; # The '|&' logs ERRORS and STDOUT. Also handles leading spaces.
cd nothere |& log; # See ERRORS here.

# *log2file Example
free -m |& log2file /tmp/[CASE_NUMBER].log;

# *logand2file Example
free -m |& logand2file /tmp/[CASE_NUMBER].log;

# OR
# *or just output to a file defined in "LOGFILE".
LOGFILE=/tmp/[CASE_NUMBER-or-whatever].log;
log2file() { LOGFILE=$1; while IFS= read -r line; do printf '%s\n' "$(date "+%Y%m%d-%H:%M:%S.%N%z"): $line" >> $LOGFILE; done; };

# *or STDOUT and a file defined in "LOGFILE".
LOGFILE=/tmp/[CASE_NUMBER-or-whatever].log;
logand2file() { while IFS= read -r line; do printf '%s\n' "$(date "+%Y%m%d-%H:%M:%S.%N%z"): $line" | tee -a "$LOGFILE"; done; };

# *log2file Example
free -m |& log2file;

# *logand2file Example
free -m |& logand2file;

# Just make a BASH wrapper and call your script like I called "free".