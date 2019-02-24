From: Harry Pan <harry.pan@intel.com>
Subject: [PATCH v6 2/2] PM / sleep: measure the time of filesystems syncing
Date: Sun, 24 Feb 2019 14:17:54 +0800
Message-ID: <20190224061753.17638-2-harry.pan@intel.com>
References: <20190222154904.6260-1-harry.pan@intel.com>
 <20190224061753.17638-1-harry.pan@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190224061753.17638-1-harry.pan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: harry.pan@intel.com, gs0622@gmail.com, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch gives the reader an intuitive metric of the time cost by
the kernel issuing filesystems sync during system sleep; although
developer can guess by the timestamp of next log or enable the ftrace
power event for manual calculation, this manner is easier to read and
benefits the automation script.

Signed-off-by: Harry Pan <harry.pan@intel.com>
---
 kernel/power/main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index a8a8e6ec57e6..a08dcc743f31 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -54,9 +54,15 @@ EXPORT_SYMBOL_GPL(unlock_system_sleep);
 
 void ksys_sync_helper(void)
 {
-	pr_info("Syncing filesystems ... ");
+	ktime_t start;
+	s64 elapsed_msecs;
+
+	start = ktime_get();
 	ksys_sync();
-	pr_cont("done.\n");
+	elapsed_msecs = ktime_to_ms(ktime_sub(ktime_get(), start));
+	pr_info("Filesystems sync: %lld.%03lld seconds\n",
+		elapsed_msecs / MSEC_PER_SEC,
+		elapsed_msecs % MSEC_PER_SEC);
 }
 EXPORT_SYMBOL_GPL(ksys_sync_helper);
 
-- 
2.18.1
