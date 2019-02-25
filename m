From: Harry Pan <harry.pan@intel.com>
Subject: [PATCH v7 2/2] PM / sleep: measure the time of filesystems syncing
Date: Mon, 25 Feb 2019 17:44:23 +0800
Message-ID: <20190225094422.5492-2-harry.pan@intel.com>
References: <20190224061753.17638-2-harry.pan@intel.com>
 <20190225094422.5492-1-harry.pan@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190225094422.5492-1-harry.pan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: harry.pan@intel.com, gs0622@gmail.com, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch gives the reader an intuitive metric of the time cost by
the kernel issuing filesystems sync during system sleep; although
developer can guess by the timestamp of next log or enable the ftrace
power event for manual calculation, this manner is easier to read and
benefits the automation script.

v1 to v5: context discussion
v6: split patches logically in code refactor and sync profile
v7: improve 32/64 bit machine compatibility

Signed-off-by: Harry Pan <harry.pan@intel.com>
---
 kernel/power/main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index a8a8e6ec57e6..eea3d65eb960 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -54,9 +54,15 @@ EXPORT_SYMBOL_GPL(unlock_system_sleep);
 
 void ksys_sync_helper(void)
 {
-	pr_info("Syncing filesystems ... ");
+	ktime_t start;
+	long elapsed_msecs;
+
+	start = ktime_get();
 	ksys_sync();
-	pr_cont("done.\n");
+	elapsed_msecs = ktime_to_ms(ktime_sub(ktime_get(), start));
+	pr_info("Filesystems sync: %ld.%03ld seconds\n",
+		elapsed_msecs / MSEC_PER_SEC,
+		elapsed_msecs % MSEC_PER_SEC);
 }
 EXPORT_SYMBOL_GPL(ksys_sync_helper);
 
-- 
2.18.1
