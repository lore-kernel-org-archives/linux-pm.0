From: Len Brown <lenb@kernel.org>
Subject: [PATCH 6/7] tools/power turbostat: prevent infinite loop on migration error path
Date: Wed, 14 Nov 2012 15:43:23 -0500
Message-ID: <883d5d681f426eb42ad65d805cfc138dea986b6c.1352925508.git.len.brown@intel.com>
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

Turbostat assumed if it can't migrate to a CPU, then the CPU
must have gone off-line and turbostat should re-initialize
with the new topology.

But if turbostat can not migrate because it is restricted by
a cpuset, then it will fail to migrate even after re-initialization,
resulting in an infinite loop.

Spit out a warning when we can't migrate
and endure only 2 re-initialize cycles in a row
before giving up and exiting.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 3c063a0..77e76b1 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -656,8 +656,10 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 {
 	int cpu = t->cpu_id;
 
-	if (cpu_migrate(cpu))
+	if (cpu_migrate(cpu)) {
+		fprintf(stderr, "Could not migrate to CPU %d\n", cpu);
 		return -1;
+	}
 
 	t->tsc = rdtsc();	/* we are running on local CPU of interest */
 
@@ -1088,15 +1090,22 @@ int mark_cpu_present(int cpu)
 void turbostat_loop()
 {
 	int retval;
+	int restarted = 0;
 
 restart:
+	restarted++;
+
 	retval = for_all_cpus(get_counters, EVEN_COUNTERS);
 	if (retval < -1) {
 		exit(retval);
 	} else if (retval == -1) {
+		if (restarted > 1) {
+			exit(retval);
+		}
 		re_initialize();
 		goto restart;
 	}
+	restarted = 0;
 	gettimeofday(&tv_even, (struct timezone *)NULL);
 
 	while (1) {
-- 
1.8.0
