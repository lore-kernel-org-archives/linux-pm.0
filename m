From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/5] tools/power turbostat: stop migrating, unless '-m'
Date: Sat, 24 Jun 2017 20:12:59 -0700
Message-ID: <c91fc8519d87715a3a173475ea3778794c139996.1498359826.git.len.brown@intel.com>
References: <1498360381-10293-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34294 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbdFYDNL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Jun 2017 23:13:11 -0400
Received: by mail-qk0-f196.google.com with SMTP id 91so5113157qkq.1
        for <linux-pm@vger.kernel.org>; Sat, 24 Jun 2017 20:13:10 -0700 (PDT)
In-Reply-To: <1498360381-10293-1-git-send-email-lenb@kernel.org>
In-Reply-To: <a99d87306f83d2a97c8c7e854b6583c4037ecf75.1498359826.git.len.brown@intel.com>
References: <a99d87306f83d2a97c8c7e854b6583c4037ecf75.1498359826.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Turbostat has the capability to set its own affinity to
each CPU so that its MSR accesses are on the local CPU.

However, using the in-kernel cross-call in  the msr driver
tends to be less invasive, so do that -- by-default.
'-m' remains to get the old behaviour.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 6f7c64a..1a3a5b4 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -92,6 +92,7 @@ unsigned int do_ring_perf_limit_reasons;
 unsigned int crystal_hz;
 unsigned long long tsc_hz;
 int base_cpu;
+int do_migrate;
 double discover_bclk(unsigned int family, unsigned int model);
 unsigned int has_hwp;	/* IA32_PM_ENABLE, IA32_HWP_CAPABILITIES */
 			/* IA32_HWP_REQUEST, IA32_HWP_STATUS */
@@ -302,6 +303,9 @@ int for_all_cpus(int (func)(struct thread_data *, struct core_data *, struct pkg
 
 int cpu_migrate(int cpu)
 {
+	if (!do_migrate)
+		return 0;
+
 	CPU_ZERO_S(cpu_affinity_setsize, cpu_affinity_set);
 	CPU_SET_S(cpu, cpu_affinity_setsize, cpu_affinity_set);
 	if (sched_setaffinity(0, cpu_affinity_setsize, cpu_affinity_set) == -1)
@@ -5000,6 +5004,7 @@ void cmdline(int argc, char **argv)
 		{"hide",	required_argument,	0, 'H'},	// meh, -h taken by --help
 		{"Joules",	no_argument,		0, 'J'},
 		{"list",	no_argument,		0, 'l'},
+		{"migrate",	no_argument,		0, 'm'},
 		{"out",		required_argument,	0, 'o'},
 		{"quiet",	no_argument,		0, 'q'},
 		{"show",	required_argument,	0, 's'},
@@ -5011,7 +5016,7 @@ void cmdline(int argc, char **argv)
 
 	progname = argv[0];
 
-	while ((opt = getopt_long_only(argc, argv, "+C:c:Ddhi:JM:m:o:qST:v",
+	while ((opt = getopt_long_only(argc, argv, "+C:c:Ddhi:Jmo:qST:v",
 				long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'a':
@@ -5054,6 +5059,9 @@ void cmdline(int argc, char **argv)
 			list_header_only++;
 			quiet++;
 			break;
+		case 'm':
+			do_migrate = 1;
+			break;
 		case 'o':
 			outf = fopen_or_die(optarg, "w");
 			break;
-- 
2.7.4
