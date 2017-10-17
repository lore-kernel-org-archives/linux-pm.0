From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/1] Revert "tools/power turbostat: stop migrating, unless '-m'"
Date: Tue, 17 Oct 2017 16:00:02 -0400
Message-ID: <a94c49e6b0d4da98d8c79e22cad313bf092d5886.1508270356.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

This reverts commit c91fc8519d87715a3a173475ea3778794c139996.

That change caused a C6 and PC6 residency regression on large idle systems.

Users also complained about new output indicating jitter:

turbostat: cpu6 jitter 3794 9142

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: <stable@vger.kernel.org> # v4.13
---
 tools/power/x86/turbostat/turbostat.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 0dafba2c1e7d..bd9c6b31a504 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -92,7 +92,6 @@ unsigned int do_ring_perf_limit_reasons;
 unsigned int crystal_hz;
 unsigned long long tsc_hz;
 int base_cpu;
-int do_migrate;
 double discover_bclk(unsigned int family, unsigned int model);
 unsigned int has_hwp;	/* IA32_PM_ENABLE, IA32_HWP_CAPABILITIES */
 			/* IA32_HWP_REQUEST, IA32_HWP_STATUS */
@@ -303,9 +302,6 @@ int for_all_cpus(int (func)(struct thread_data *, struct core_data *, struct pkg
 
 int cpu_migrate(int cpu)
 {
-	if (!do_migrate)
-		return 0;
-
 	CPU_ZERO_S(cpu_affinity_setsize, cpu_affinity_set);
 	CPU_SET_S(cpu, cpu_affinity_setsize, cpu_affinity_set);
 	if (sched_setaffinity(0, cpu_affinity_setsize, cpu_affinity_set) == -1)
@@ -5007,7 +5003,6 @@ void cmdline(int argc, char **argv)
 		{"hide",	required_argument,	0, 'H'},	// meh, -h taken by --help
 		{"Joules",	no_argument,		0, 'J'},
 		{"list",	no_argument,		0, 'l'},
-		{"migrate",	no_argument,		0, 'm'},
 		{"out",		required_argument,	0, 'o'},
 		{"quiet",	no_argument,		0, 'q'},
 		{"show",	required_argument,	0, 's'},
@@ -5019,7 +5014,7 @@ void cmdline(int argc, char **argv)
 
 	progname = argv[0];
 
-	while ((opt = getopt_long_only(argc, argv, "+C:c:Ddhi:Jmo:qST:v",
+	while ((opt = getopt_long_only(argc, argv, "+C:c:Ddhi:JM:m:o:qST:v",
 				long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'a':
@@ -5062,9 +5057,6 @@ void cmdline(int argc, char **argv)
 			list_header_only++;
 			quiet++;
 			break;
-		case 'm':
-			do_migrate = 1;
-			break;
 		case 'o':
 			outf = fopen_or_die(optarg, "w");
 			break;
-- 
2.14.0-rc0
