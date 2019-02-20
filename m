From: Harry Pan <harry.pan@intel.com>
Subject: [PATCH v4] PM / suspend: measure the time of filesystem syncing
Date: Thu, 21 Feb 2019 00:12:22 +0800
Message-ID: <20190220161222.632-1-harry.pan@intel.com>
References: <20190214111543.22137-1-harry.pan@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214111543.22137-1-harry.pan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: gs0622@gmail.com, Harry Pan <harry.pan@intel.com>, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch gives the reader an intuitive metric of the time cost by
the kernel issuing a filesystem sync during suspend; although developer
can guess by the timestamp of next log or enable the ftrace power event
for manual calculation, this manner is easier to read and benefits the
automatic script.

v2: simplify the variables, apply the simplest form of ktime API.
v3: reduce conditional compilation, rectify profiling in better syntax
v4: avoid interposition, profile on hibernation, rectify printk format

Signed-off-by: Harry Pan <harry.pan@intel.com>
---
 kernel/power/hibernate.c |  9 +++++++--
 kernel/power/suspend.c   | 20 +++++++++++++-------
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index abef759de7c8..387703907827 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -688,6 +688,8 @@ int hibernate(void)
 {
 	int error, nr_calls = 0;
 	bool snapshot_test = false;
+	ktime_t start;
+	s64 elapsed_msecs;
 
 	if (!hibernation_available()) {
 		pm_pr_dbg("Hibernation not available.\n");
@@ -709,9 +711,12 @@ int hibernate(void)
 		goto Exit;
 	}
 
-	pr_info("Syncing filesystems ... \n");
+	start = ktime_get();
 	ksys_sync();
-	pr_info("done.\n");
+	elapsed_msecs = ktime_to_ms(ktime_sub(ktime_get(), start));
+	pr_info("Filesystems sync: %lld.%03lld seconds\n",
+		elapsed_msecs / MSEC_PER_SEC,
+		elapsed_msecs % MSEC_PER_SEC);
 
 	error = freeze_processes();
 	if (error)
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 0bd595a0b610..7fb5ba1314d3 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -568,13 +568,19 @@ static int enter_state(suspend_state_t state)
 	if (state == PM_SUSPEND_TO_IDLE)
 		s2idle_begin();
 
-#ifndef CONFIG_SUSPEND_SKIP_SYNC
-	trace_suspend_resume(TPS("sync_filesystems"), 0, true);
-	pr_info("Syncing filesystems ... ");
-	ksys_sync();
-	pr_cont("done.\n");
-	trace_suspend_resume(TPS("sync_filesystems"), 0, false);
-#endif
+	if (!IS_ENABLED(CONFIG_SUSPEND_SKIP_SYNC)) {
+		ktime_t start;
+		s64 elapsed_msecs;
+
+		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
+		start = ktime_get();
+		ksys_sync();
+		elapsed_msecs = ktime_to_ms(ktime_sub(ktime_get(), start));
+		pr_info("Filesystems sync: %lld.%03lld seconds\n",
+			elapsed_msecs / MSEC_PER_SEC,
+			elapsed_msecs % MSEC_PER_SEC);
+		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
+	}
 
 	pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state]);
 	pm_suspend_clear_flags();
-- 
2.18.1
