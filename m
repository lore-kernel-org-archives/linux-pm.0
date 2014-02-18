From: Chuansheng Liu <chuansheng.liu@intel.com>
Subject: [PATCH v4 5/5] PM / sleep: Asynchronous threads for suspend_late
Date: Tue, 18 Feb 2014 10:28:48 +0800
Message-ID: <1392690528-10024-6-git-send-email-chuansheng.liu@intel.com>
References: <y>
 <1392690528-10024-1-git-send-email-chuansheng.liu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392690528-10024-1-git-send-email-chuansheng.liu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, gregkh@linuxfoundation.org, len.brown@intel.com, pavel@ucw.cz
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, zhuangzhi.li@intel.com, chuansheng.liu@intel.com
List-Id: linux-pm@vger.kernel.org

In analogy with commits 5af84b82701a and 97df8c12995, using
asynchronous threads can improve the overall suspend_late
time significantly.

This patch is for suspend_late phase.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
---
 drivers/base/power/main.c | 66 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 12 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 9335b32..42355e4 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1127,16 +1127,26 @@ static int dpm_suspend_noirq(pm_message_t state)
  *
  * Runtime PM is disabled for @dev while this function is being executed.
  */
-static int device_suspend_late(struct device *dev, pm_message_t state)
+static int __device_suspend_late(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
 	char *info = NULL;
-	int error;
+	int error = 0;
 
 	__pm_runtime_disable(dev, false);
 
+	if (async_error)
+		goto Complete;
+
+	if (pm_wakeup_pending()) {
+		async_error = -EBUSY;
+		goto Complete;
+	}
+
 	if (dev->power.syscore)
-		return 0;
+		goto Complete;
+
+	dpm_wait_for_children(dev, async);
 
 	if (dev->pm_domain) {
 		info = "late power domain ";
@@ -1160,10 +1170,40 @@ static int device_suspend_late(struct device *dev, pm_message_t state)
 	error = dpm_run_callback(callback, dev, state, info);
 	if (!error)
 		dev->power.is_late_suspended = true;
+	else
+		async_error = error;
 
+Complete:
+	complete_all(&dev->power.completion);
 	return error;
 }
 
+static void async_suspend_late(void *data, async_cookie_t cookie)
+{
+	struct device *dev = (struct device *)data;
+	int error;
+
+	error = __device_suspend_late(dev, pm_transition, true);
+	if (error) {
+		dpm_save_failed_dev(dev_name(dev));
+		pm_dev_err(dev, pm_transition, " async", error);
+	}
+	put_device(dev);
+}
+
+static int device_suspend_late(struct device *dev)
+{
+	reinit_completion(&dev->power.completion);
+
+	if (pm_async_enabled && dev->power.async_suspend) {
+		get_device(dev);
+		async_schedule(async_suspend_late, dev);
+		return 0;
+	}
+
+	return __device_suspend_late(dev, pm_transition, false);
+}
+
 /**
  * dpm_suspend_late - Execute "late suspend" callbacks for all devices.
  * @state: PM transition of the system being carried out.
@@ -1174,19 +1214,20 @@ static int dpm_suspend_late(pm_message_t state)
 	int error = 0;
 
 	mutex_lock(&dpm_list_mtx);
+	pm_transition = state;
+	async_error = 0;
+
 	while (!list_empty(&dpm_suspended_list)) {
 		struct device *dev = to_device(dpm_suspended_list.prev);
 
 		get_device(dev);
 		mutex_unlock(&dpm_list_mtx);
 
-		error = device_suspend_late(dev, state);
+		error = device_suspend_late(dev);
 
 		mutex_lock(&dpm_list_mtx);
 		if (error) {
 			pm_dev_err(dev, state, " late", error);
-			suspend_stats.failed_suspend_late++;
-			dpm_save_failed_step(SUSPEND_SUSPEND_LATE);
 			dpm_save_failed_dev(dev_name(dev));
 			put_device(dev);
 			break;
@@ -1195,17 +1236,18 @@ static int dpm_suspend_late(pm_message_t state)
 			list_move(&dev->power.entry, &dpm_late_early_list);
 		put_device(dev);
 
-		if (pm_wakeup_pending()) {
-			error = -EBUSY;
+		if (async_error)
 			break;
-		}
 	}
 	mutex_unlock(&dpm_list_mtx);
-	if (error)
+	async_synchronize_full();
+	if (error) {
+		suspend_stats.failed_suspend_late++;
+		dpm_save_failed_step(SUSPEND_SUSPEND_LATE);
 		dpm_resume_early(resume_event(state));
-	else
+	} else {
 		dpm_show_time(starttime, state, "late");
-
+	}
 	return error;
 }
 
-- 
1.9.rc0
