From: Harry Pan <harry.pan@intel.com>
Subject: [PATCH] PM / suspend: measure the time of filesystem syncing
Date: Sun,  3 Feb 2019 13:20:07 +0800
Message-ID: <20190203052007.27392-1-harry.pan@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: gs0622@gmail.com, Harry Pan <harry.pan@intel.com>, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch gives the reader an intuitive metric of the time cost by
the kernel issuing a filesystem sync during suspend; although developer
can guess by the timestamp of next log or enable the ftrace power event
for manual calculation, this manner is easier to read and benefits the
automatic script.

Signed-off-by: Harry Pan <harry.pan@intel.com>
---
 kernel/power/suspend.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 0bd595a0b610..f3b7c64f2242 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -550,6 +550,8 @@ static void suspend_finish(void)
 static int enter_state(suspend_state_t state)
 {
 	int error;
+	ktime_t start, end, elapsed;
+	unsigned int elapsed_msecs;
 
 	trace_suspend_resume(TPS("suspend_enter"), state, true);
 	if (state == PM_SUSPEND_TO_IDLE) {
@@ -570,9 +572,14 @@ static int enter_state(suspend_state_t state)
 
 #ifndef CONFIG_SUSPEND_SKIP_SYNC
 	trace_suspend_resume(TPS("sync_filesystems"), 0, true);
+	start = ktime_get_boottime();
 	pr_info("Syncing filesystems ... ");
 	ksys_sync();
-	pr_cont("done.\n");
+	end = ktime_get_boottime();
+	elapsed = ktime_sub(end, start);
+	elapsed_msecs = ktime_to_ms(elapsed);
+	pr_cont("(elapsed %d.%03d seconds) done.\n", elapsed_msecs / 1000,
+		elapsed_msecs % 1000);
 	trace_suspend_resume(TPS("sync_filesystems"), 0, false);
 #endif
 
-- 
2.18.1
