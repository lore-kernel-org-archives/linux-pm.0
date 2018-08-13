From: Rishabh Bhatnagar <rishabhb@quicinc.com>
Subject: [PATCH v1] dd: Invoke one probe retry cycle after some initcall levels
Date: Mon, 13 Aug 2018 10:39:49 -0700
Message-ID: <1534181989-22536-1-git-send-email-rishabhb@quicinc.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael@kernel.org
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, psodagud@codeaurora.org, ckadabi@codeaurora.org, tsoni@codeaurora.org, linux-pm@vger.kernel.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>, Vikram Mulukutla <markivx@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

From: Rishabh Bhatnagar <rishabhb@codeaurora.org>

Drivers that are registered at an initcall level may have to
wait until late_init before the probe deferral mechanism can
retry their probe functions. It is possible that their
dependencies were resolved much earlier, in some cases even
before the next initcall level. Invoke one probe retry cycle
at every _sync initcall level after subsys initcall, allowing
these drivers to be probed earlier.
To give an example many Qualcomm drivers are dependent on the 
regulator and bus driver. Both the regulator and bus driver 
are probed in the subsys_initcall level. Now the probe of bus 
driver requires regulator to be working. If the probe of bus 
driver happens before regulator, then bus driver's probe will 
be deferred and all other device's probes which depend on bus 
driver will also be deferred.
The impact of this problem is reduced if we have this patch.

Signed-off-by: Vikram Mulukutla <markivx@codeaurora.org>
Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---

Changes since v0:
 * Remove arch_initcall_sync(deferred_probe_initcall) from patch. This is not
   really needed as none of the devices are re-probed in arch_initcall_sync
   level.

 drivers/base/dd.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 1435d72..9aa41aa 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -224,23 +224,43 @@ void device_unblock_probing(void)
 	driver_deferred_probe_trigger();
 }
 
+static void enable_trigger_defer_cycle(void)
+{
+	driver_deferred_probe_enable = true;
+	driver_deferred_probe_trigger();
+	/*
+	 * Sort as many dependencies as possible before the next initcall
+	 * level
+	 */
+	flush_work(&deferred_probe_work);
+}
+
 /**
  * deferred_probe_initcall() - Enable probing of deferred devices
  *
  * We don't want to get in the way when the bulk of drivers are getting probed.
  * Instead, this initcall makes sure that deferred probing is delayed until
- * late_initcall time.
+ * all the registered initcall functions at a particular level are completed.
+ * This function is invoked at every *_initcall_sync level.
  */
 static int deferred_probe_initcall(void)
 {
-	driver_deferred_probe_enable = true;
-	driver_deferred_probe_trigger();
-	/* Sort as many dependencies as possible before exiting initcalls */
-	flush_work(&deferred_probe_work);
+	enable_trigger_defer_cycle();
+	driver_deferred_probe_enable = false;
+	return 0;
+}
+subsys_initcall_sync(deferred_probe_initcall);
+fs_initcall_sync(deferred_probe_initcall);
+device_initcall_sync(deferred_probe_initcall);
+
+static int deferred_probe_enable_fn(void)
+{
+	/* Enable deferred probing for all time */
+	enable_trigger_defer_cycle();
 	initcalls_done = true;
 	return 0;
 }
-late_initcall(deferred_probe_initcall);
+late_initcall(deferred_probe_enable_fn);
 
 /**
  * device_is_bound() - Check if device is bound to a driver
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
