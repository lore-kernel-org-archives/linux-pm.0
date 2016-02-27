From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/16] tools/power turbostat: allow sub-sec intervals
Date: Sat, 27 Feb 2016 04:01:00 -0500
Message-ID: <24781860a144a6792cb7697307f36b4486b611da.1456563103.git.len.brown@intel.com>
References: <1456563670-23282-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f193.google.com ([209.85.160.193]:34216 "EHLO
	mail-yk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756219AbcB0JBz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Feb 2016 04:01:55 -0500
Received: by mail-yk0-f193.google.com with SMTP id z7so2782438yka.1
        for <linux-pm@vger.kernel.org>; Sat, 27 Feb 2016 01:01:54 -0800 (PST)
In-Reply-To: <1456563670-23282-1-git-send-email-lenb@kernel.org>
In-Reply-To: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
References: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

turbostat -i interval_sec

will sample and display statistics every interval_sec.
interval_sec used to be a whole number of seconds,
but now we accept a decimal, as small as 0.001 sec (1 ms).

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 |  2 +-
 tools/power/x86/turbostat/turbostat.c | 20 ++++++++++++++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 622db68..8a9727b 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -34,7 +34,7 @@ name as necessary to disambiguate it from others is necessary.  Note that option
 \fB--debug\fP displays additional system configuration information.  Invoking this parameter
 more than once may also enable internal turbostat debug information.
 .PP
-\fB--interval seconds\fP overrides the default 5-second measurement interval.
+\fB--interval decimal_seconds\fP overrides the default 5.0 second measurement interval.
 .PP
 \fB--help\fP displays usage for the most common parameters.
 .PP
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index c600340..e411cc4 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -38,12 +38,13 @@
 #include <string.h>
 #include <ctype.h>
 #include <sched.h>
+#include <time.h>
 #include <cpuid.h>
 #include <linux/capability.h>
 #include <errno.h>
 
 char *proc_stat = "/proc/stat";
-unsigned int interval_sec = 5;
+struct timespec interval_ts = {5, 0};
 unsigned int debug;
 unsigned int rapl_joules;
 unsigned int summary_only;
@@ -1728,7 +1729,7 @@ restart:
 			re_initialize();
 			goto restart;
 		}
-		sleep(interval_sec);
+		nanosleep(&interval_ts, NULL);
 		retval = for_all_cpus(get_counters, ODD_COUNTERS);
 		if (retval < -1) {
 			exit(retval);
@@ -1742,7 +1743,7 @@ restart:
 		compute_average(EVEN_COUNTERS);
 		format_all_counters(EVEN_COUNTERS);
 		flush_stdout();
-		sleep(interval_sec);
+		nanosleep(&interval_ts, NULL);
 		retval = for_all_cpus(get_counters, EVEN_COUNTERS);
 		if (retval < -1) {
 			exit(retval);
@@ -3347,7 +3348,18 @@ void cmdline(int argc, char **argv)
 			help();
 			exit(1);
 		case 'i':
-			interval_sec = atoi(optarg);
+			{
+				double interval = strtod(optarg, NULL);
+
+				if (interval < 0.001) {
+					fprintf(stderr, "interval %f seconds is too small\n",
+						interval);
+					exit(2);
+				}
+
+				interval_ts.tv_sec = interval;
+				interval_ts.tv_nsec = (interval - interval_ts.tv_sec) * 1000000000;
+			}
 			break;
 		case 'J':
 			rapl_joules++;
-- 
2.7.1.339.g0233b80

