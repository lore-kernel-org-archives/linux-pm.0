From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/4] PM / core: Introduce dpm_async_fn() helper
Date: Sat, 16 Mar 2019 00:59:25 -0400
Message-ID: <20190316045928.31934-2-tiny.windzz@gmail.com>
References: <20190316045928.31934-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190316045928.31934-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

When we want to execute device pm functions asynchronously, we'll
do the following for the device:

  1) reinit_completion(&dev->power.completion);
  2) Check if the device enables asynchronous suspend.
  3) If necessary, execute the corresponding function asynchronously.

There are a lot of such repeated operations here, in fact we can avoid
this. So introduce dpm_async_fn() to have better code readability and
reuse.

And use this function to do some cleanup.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/base/power/main.c | 62 +++++++++++++++------------------------
 1 file changed, 23 insertions(+), 39 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index eddb54057ed6..cb44bb6b2b66 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -706,6 +706,19 @@ static bool is_async(struct device *dev)
 		&& !pm_trace_is_enabled();
 }
 
+static bool dpm_async_fn(struct device *dev, async_func_t func)
+{
+	reinit_completion(&dev->power.completion);
+
+	if (is_async(dev)) {
+		get_device(dev);
+		async_schedule(func, dev);
+		return true;
+	}
+
+	return false;
+}
+
 static void async_resume_noirq(void *data, async_cookie_t cookie)
 {
 	struct device *dev = (struct device *)data;
@@ -732,13 +745,8 @@ void dpm_noirq_resume_devices(pm_message_t state)
 	 * in case the starting of async threads is
 	 * delayed by non-async resuming devices.
 	 */
-	list_for_each_entry(dev, &dpm_noirq_list, power.entry) {
-		reinit_completion(&dev->power.completion);
-		if (is_async(dev)) {
-			get_device(dev);
-			async_schedule_dev(async_resume_noirq, dev);
-		}
-	}
+	list_for_each_entry(dev, &dpm_noirq_list, power.entry)
+		dpm_async_fn(dev, async_resume_noirq);
 
 	while (!list_empty(&dpm_noirq_list)) {
 		dev = to_device(dpm_noirq_list.next);
@@ -889,13 +897,8 @@ void dpm_resume_early(pm_message_t state)
 	 * in case the starting of async threads is
 	 * delayed by non-async resuming devices.
 	 */
-	list_for_each_entry(dev, &dpm_late_early_list, power.entry) {
-		reinit_completion(&dev->power.completion);
-		if (is_async(dev)) {
-			get_device(dev);
-			async_schedule_dev(async_resume_early, dev);
-		}
-	}
+	list_for_each_entry(dev, &dpm_late_early_list, power.entry)
+		dpm_async_fn(dev, async_resume_early);
 
 	while (!list_empty(&dpm_late_early_list)) {
 		dev = to_device(dpm_late_early_list.next);
@@ -1053,13 +1056,8 @@ void dpm_resume(pm_message_t state)
 	pm_transition = state;
 	async_error = 0;
 
-	list_for_each_entry(dev, &dpm_suspended_list, power.entry) {
-		reinit_completion(&dev->power.completion);
-		if (is_async(dev)) {
-			get_device(dev);
-			async_schedule_dev(async_resume, dev);
-		}
-	}
+	list_for_each_entry(dev, &dpm_suspended_list, power.entry)
+		dpm_async_fn(dev, async_resume);
 
 	while (!list_empty(&dpm_suspended_list)) {
 		dev = to_device(dpm_suspended_list.next);
@@ -1373,13 +1371,9 @@ static void async_suspend_noirq(void *data, async_cookie_t cookie)
 
 static int device_suspend_noirq(struct device *dev)
 {
-	reinit_completion(&dev->power.completion);
-
-	if (is_async(dev)) {
-		get_device(dev);
-		async_schedule_dev(async_suspend_noirq, dev);
+	if (dpm_async_fn(dev, async_suspend_noirq))
 		return 0;
-	}
+
 	return __device_suspend_noirq(dev, pm_transition, false);
 }
 
@@ -1576,13 +1570,8 @@ static void async_suspend_late(void *data, async_cookie_t cookie)
 
 static int device_suspend_late(struct device *dev)
 {
-	reinit_completion(&dev->power.completion);
-
-	if (is_async(dev)) {
-		get_device(dev);
-		async_schedule_dev(async_suspend_late, dev);
+	if (dpm_async_fn(dev, async_suspend_late))
 		return 0;
-	}
 
 	return __device_suspend_late(dev, pm_transition, false);
 }
@@ -1842,13 +1831,8 @@ static void async_suspend(void *data, async_cookie_t cookie)
 
 static int device_suspend(struct device *dev)
 {
-	reinit_completion(&dev->power.completion);
-
-	if (is_async(dev)) {
-		get_device(dev);
-		async_schedule_dev(async_suspend, dev);
+	if (dpm_async_fn(dev, async_suspend))
 		return 0;
-	}
 
 	return __device_suspend(dev, pm_transition, false);
 }
-- 
2.17.0
