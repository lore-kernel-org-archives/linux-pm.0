From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/7] tools/power turbostat: graceful fail on garbage input
Date: Wed, 14 Nov 2012 15:43:19 -0500
Message-ID: <d91bb17c2a874493603c4d99db305d8caf2d180c.1352925508.git.len.brown@intel.com>
References: <1352925804-6746-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352925804-6746-1-git-send-email-lenb@kernel.org>
In-Reply-To: <39300ffb9b6666714c60735cf854e1280e4e75f4.1352925508.git.len.brown@intel.com>
References: <39300ffb9b6666714c60735cf854e1280e4e75f4.1352925508.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

When invald MSR's are specified on the command line,
turbostat should simply print an error and exit.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 9942dee..ea095ab 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -206,8 +206,10 @@ int get_msr(int cpu, off_t offset, unsigned long long *msr)
 	retval = pread(fd, msr, sizeof *msr, offset);
 	close(fd);
 
-	if (retval != sizeof *msr)
+	if (retval != sizeof *msr) {
+		fprintf(stderr, "%s offset 0x%zx read failed\n", pathname, offset);
 		return -1;
+	}
 
 	return 0;
 }
@@ -1101,7 +1103,9 @@ void turbostat_loop()
 
 restart:
 	retval = for_all_cpus(get_counters, EVEN_COUNTERS);
-	if (retval) {
+	if (retval < -1) {
+		exit(retval);
+	} else if (retval == -1) {
 		re_initialize();
 		goto restart;
 	}
@@ -1114,7 +1118,9 @@ restart:
 		}
 		sleep(interval_sec);
 		retval = for_all_cpus(get_counters, ODD_COUNTERS);
-		if (retval) {
+		if (retval < -1) {
+			exit(retval);
+		} else if (retval == -1) {
 			re_initialize();
 			goto restart;
 		}
@@ -1126,7 +1132,9 @@ restart:
 		flush_stdout();
 		sleep(interval_sec);
 		retval = for_all_cpus(get_counters, EVEN_COUNTERS);
-		if (retval) {
+		if (retval < -1) {
+			exit(retval);
+		} else if (retval == -1) {
 			re_initialize();
 			goto restart;
 		}
@@ -1545,8 +1553,11 @@ void turbostat_init()
 int fork_it(char **argv)
 {
 	pid_t child_pid;
+	int status;
 
-	for_all_cpus(get_counters, EVEN_COUNTERS);
+	status = for_all_cpus(get_counters, EVEN_COUNTERS);
+	if (status)
+		exit(status);
 	/* clear affinity side-effect of get_counters() */
 	sched_setaffinity(0, cpu_present_setsize, cpu_present_set);
 	gettimeofday(&tv_even, (struct timezone *)NULL);
@@ -1556,7 +1567,6 @@ int fork_it(char **argv)
 		/* child */
 		execvp(argv[0], argv);
 	} else {
-		int status;
 
 		/* parent */
 		if (child_pid == -1) {
@@ -1568,7 +1578,7 @@ int fork_it(char **argv)
 		signal(SIGQUIT, SIG_IGN);
 		if (waitpid(child_pid, &status, 0) == -1) {
 			perror("wait");
-			exit(1);
+			exit(status);
 		}
 	}
 	/*
@@ -1585,7 +1595,7 @@ int fork_it(char **argv)
 
 	fprintf(stderr, "%.6f sec\n", tv_delta.tv_sec + tv_delta.tv_usec/1000000.0);
 
-	return 0;
+	return status;
 }
 
 void cmdline(int argc, char **argv)
-- 
1.8.0
