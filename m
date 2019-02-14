From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/4] PM / devfreq: Track overall load monitor state instead of 'stop_polling'
Date: Wed, 13 Feb 2019 17:30:39 -0800
Message-ID: <20190214013042.254790-2-mka@chromium.org>
References: <20190214013042.254790-1-mka@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214013042.254790-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Lukasz Luba <l.luba@partner.samsung.com>
Cc: Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

The field ->stop_polling indicates whether load monitoring should be/is
stopped, it is set in devfreq_monitor_suspend(). Change the variable to
hold the general state of load monitoring (stopped, running, suspended).
Besides improving readability of conditions involving the field and this
prepares the terrain for moving some duplicated code from the governors
into the devfreq core.

Hold the devfreq lock in devfreq_monitor_start/stop() to ensure proper
synchronization.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/devfreq/devfreq.c | 34 +++++++++++++++++++++++++---------
 include/linux/devfreq.h   |  4 ++--
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0ae3de76833b7..1d3a43f8b3a10 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -29,6 +29,10 @@
 #include <linux/of.h>
 #include "governor.h"
 
+#define DEVFREQ_MONITOR_STOPPED		0
+#define DEVFREQ_MONITOR_RUNNING		1
+#define DEVFREQ_MONITOR_SUSPENDED	2
+
 static struct class *devfreq_class;
 
 /*
@@ -407,10 +411,17 @@ static void devfreq_monitor(struct work_struct *work)
  */
 void devfreq_monitor_start(struct devfreq *devfreq)
 {
-	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
-	if (devfreq->profile->polling_ms)
+	mutex_lock(&devfreq->lock);
+
+	if (devfreq->profile->polling_ms) {
+		INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
 		queue_delayed_work(devfreq_wq, &devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
+
+		devfreq->monitor_state = DEVFREQ_MONITOR_RUNNING;
+	}
+
+	mutex_unlock(&devfreq->lock);
 }
 EXPORT_SYMBOL(devfreq_monitor_start);
 
@@ -425,6 +436,10 @@ EXPORT_SYMBOL(devfreq_monitor_start);
 void devfreq_monitor_stop(struct devfreq *devfreq)
 {
 	cancel_delayed_work_sync(&devfreq->work);
+
+	mutex_lock(&devfreq->lock);
+	devfreq->monitor_state = DEVFREQ_MONITOR_STOPPED;
+	mutex_unlock(&devfreq->lock);
 }
 EXPORT_SYMBOL(devfreq_monitor_stop);
 
@@ -443,13 +458,13 @@ EXPORT_SYMBOL(devfreq_monitor_stop);
 void devfreq_monitor_suspend(struct devfreq *devfreq)
 {
 	mutex_lock(&devfreq->lock);
-	if (devfreq->stop_polling) {
+	if (devfreq->monitor_state != DEVFREQ_MONITOR_RUNNING) {
 		mutex_unlock(&devfreq->lock);
 		return;
 	}
 
 	devfreq_update_status(devfreq, devfreq->previous_freq);
-	devfreq->stop_polling = true;
+	devfreq->monitor_state = DEVFREQ_MONITOR_SUSPENDED;
 	mutex_unlock(&devfreq->lock);
 	cancel_delayed_work_sync(&devfreq->work);
 }
@@ -468,7 +483,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 	unsigned long freq;
 
 	mutex_lock(&devfreq->lock);
-	if (!devfreq->stop_polling)
+	if (devfreq->monitor_state == DEVFREQ_MONITOR_STOPPED)
 		goto out;
 
 	if (!delayed_work_pending(&devfreq->work) &&
@@ -477,7 +492,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 			msecs_to_jiffies(devfreq->profile->polling_ms));
 
 	devfreq->last_stat_updated = jiffies;
-	devfreq->stop_polling = false;
+	devfreq->monitor_state = DEVFREQ_MONITOR_RUNNING;
 
 	if (devfreq->profile->get_cur_freq &&
 		!devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq))
@@ -504,13 +519,14 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
 	mutex_lock(&devfreq->lock);
 	devfreq->profile->polling_ms = new_delay;
 
-	if (devfreq->stop_polling)
+	if (devfreq->monitor_state == DEVFREQ_MONITOR_SUSPENDED)
 		goto out;
 
 	/* if new delay is zero, stop polling */
 	if (!new_delay) {
 		mutex_unlock(&devfreq->lock);
 		cancel_delayed_work_sync(&devfreq->work);
+		devfreq->monitor_state == DEVFREQ_MONITOR_STOPPED;
 		return;
 	}
 
@@ -526,7 +542,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
 		mutex_unlock(&devfreq->lock);
 		cancel_delayed_work_sync(&devfreq->work);
 		mutex_lock(&devfreq->lock);
-		if (!devfreq->stop_polling)
+		if (devfreq->monitor_state != DEVFREQ_MONITOR_SUSPENDED)
 			queue_delayed_work(devfreq_wq, &devfreq->work,
 			      msecs_to_jiffies(devfreq->profile->polling_ms));
 	}
@@ -1372,7 +1388,7 @@ static ssize_t trans_stat_show(struct device *dev,
 	int i, j;
 	unsigned int max_state = devfreq->profile->max_state;
 
-	if (!devfreq->stop_polling &&
+	if ((devfreq->monitor_state == DEVFREQ_MONITOR_RUNNING) &&
 			devfreq_update_status(devfreq, devfreq->previous_freq))
 		return 0;
 	if (max_state == 0)
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index fbffa74bfc1bb..0a618bbb8b294 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -130,7 +130,7 @@ struct devfreq_dev_profile {
  * @max_freq:	Limit maximum frequency requested by user (0: none)
  * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
  * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
- * @stop_polling:	 devfreq polling status of a device.
+ * @monitor_state:	State of the load monitor.
  * @suspend_freq:	 frequency of a device set during suspend phase.
  * @resume_freq:	 frequency of a device set in resume phase.
  * @suspend_count:	 suspend requests counter for a device.
@@ -168,7 +168,7 @@ struct devfreq {
 	unsigned long max_freq;
 	unsigned long scaling_min_freq;
 	unsigned long scaling_max_freq;
-	bool stop_polling;
+	int monitor_state;
 
 	unsigned long suspend_freq;
 	unsigned long resume_freq;
-- 
2.20.1.791.gb4d0f1c61a-goog
