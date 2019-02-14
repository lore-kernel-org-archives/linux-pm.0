From: Harry Pan <harry.pan@intel.com>
Subject: [PATCH v3] PM / suspend: measure the time of filesystem syncing
Date: Thu, 14 Feb 2019 19:15:43 +0800
Message-ID: <20190214111543.22137-1-harry.pan@intel.com>
References: <20190206154214.576-1-harry.pan@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206154214.576-1-harry.pan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: gs0622@gmail.com, Harry Pan <harry.pan@intel.com>, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch gives the reader an intuitive metric of the time cost by
the kernel issuing a filesystem sync during suspend; although developer
can guess by the timestamp of next log or enable the ftrace power event
for manual calculation, this manner is easier to read and benefits the
automatic script.

v2: simplify the variables, apply the simplest form of ktime API.
v3: reduce conditional compilation, rectify profiling in better syntax

Signed-off-by: Harry Pan <harry.pan@intel.com>
---
 kernel/power/suspend.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 0bd595a0b610..4844fc6a796d 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -568,13 +568,20 @@ static int enter_state(suspend_state_t state)
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
+		unsigned int elapsed_msecs;
+
+		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
+		pr_info("Syncing filesystems ... ");
+		start = ktime_get();
+		ksys_sync();
+		elapsed_msecs = ktime_to_ms(ktime_sub(ktime_get(), start));
+		pr_cont("(elapsed %d.%03d seconds) done.\n",
+			elapsed_msecs / MSEC_PER_SEC,
+			elapsed_msecs % MSEC_PER_SEC);
+		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
+	}
 
 	pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state]);
 	pm_suspend_clear_flags();
-- 
2.18.1
