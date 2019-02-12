From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 5/7] drivers: devfreq: add longer polling interval in
 idle
Date: Tue, 12 Feb 2019 23:23:56 +0100
Message-ID: <1550010238-24002-6-git-send-email-l.luba@partner.samsung.com>
References: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222436eucas1p21eebc80796406787a2ebf9a84ee5b868@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com, joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org, rostedt@goodmis.org, mingo@redhat.com, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch adds new mechanism for devfreq devices which changes polling
interval. The system should sleep longer when the devfreq device is almost
not used. The devfreq framework will not schedule the work too often.
This low-load state is recognised when the device is operating at the lowest
frequency and has low busy_time/total_time factor (< 30%).
When the frequency is different then min, the device is under normal polling
which is the value defined in driver's 'polling_ms'.
When the device is getting more pressure, the framework is able to catch it
based on 'load' in lowest frequency and will start polling more frequently.
The second scenario is when the governor recognised heavy load at minimum
frequency and increases the frequency. The devfreq framework will start
polling in shorter intervals.
The polling interval, when the device is not heavily, can also be changed
from userspace of defined by the driver's author.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c                 | 151 +++++++++++++++++++++++++++---
 drivers/devfreq/governor.h                |   3 +-
 drivers/devfreq/governor_simpleondemand.c |   6 +-
 3 files changed, 145 insertions(+), 15 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index c200b3c..29e99ce 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -29,6 +29,13 @@
 #include <linux/of.h>
 #include "governor.h"
 
+/* The ~30% load threshold used for load calculation (due to fixed point
+ * arithmetic) */
+#define LOAD_THRESHOLD_IN_DEVICE_USAGE (300)
+
+static const
+unsigned int default_polling_idle_ms = CONFIG_DEVFREQ_DEFAULT_POLLING_IDLE_MS;
+
 static struct class *devfreq_class;
 
 /* The list of all device-devfreq governors */
@@ -144,6 +151,38 @@ static int set_freq_table(struct devfreq *devfreq)
 }
 
 /**
+ * devfreq_get_polling_delay() - gets the polling delay for current state
+ * @devfreq:	the devfreq instance.
+ *
+ * Helper function which checks existing device state and returns polling
+ * interval. The function requires the caller holds devfreq->lock.
+ */
+static int devfreq_get_polling_delay(struct devfreq *devfreq)
+{
+	unsigned int scaling_min_freq;
+	unsigned long load;
+
+	lockdep_assert_held(&devfreq->lock);
+
+	/* Check the frequency of the device. If it not the lowest then use
+	 * device's polling_ms interval and job is done. */
+	scaling_min_freq = max(devfreq->scaling_min_freq, devfreq->min_freq);
+	if (scaling_min_freq != devfreq->previous_freq)
+		return devfreq->profile->polling_ms;
+
+	/* The device is running minimum frequency, check the load and if
+	 * the value crosses the threshold, start polling with device's
+	 * polling_ms value. */
+	load = devfreq->last_status.busy_time << 10;
+	load /= devfreq->last_status.total_time;
+
+	if (load > LOAD_THRESHOLD_IN_DEVICE_USAGE)
+		return devfreq->profile->polling_ms;
+	else
+		return devfreq->profile->polling_idle_ms;
+}
+
+/**
  * devfreq_update_status() - Update statistics of devfreq behavior
  * @devfreq:	the devfreq instance
  * @freq:	the update target frequency
@@ -378,14 +417,17 @@ static void devfreq_monitor(struct work_struct *work)
 	int err;
 	struct devfreq *devfreq = container_of(work,
 					struct devfreq, work.work);
+	unsigned int polling_ms;
 
 	mutex_lock(&devfreq->lock);
+	polling_ms = devfreq_get_polling_delay(devfreq);
+
 	err = update_devfreq(devfreq);
 	if (err)
 		dev_err(&devfreq->dev, "dvfs failed with (%d) error\n", err);
 
 	schedule_delayed_work(&devfreq->work,
-			      msecs_to_jiffies(devfreq->profile->polling_ms));
+			      msecs_to_jiffies(polling_ms));
 	mutex_unlock(&devfreq->lock);
 }
 
@@ -401,6 +443,7 @@ static void devfreq_monitor(struct work_struct *work)
 void devfreq_monitor_start(struct devfreq *devfreq)
 {
 	INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
+	/* Start polling with normal (not idle) polling interval. */
 	if (devfreq->profile->polling_ms)
 		schedule_delayed_work(&devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
@@ -464,6 +507,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 	if (!devfreq->stop_polling)
 		goto out;
 
+	/* In resume, normal (not idle) polling interval is used. */
 	if (!delayed_work_pending(&devfreq->work) &&
 			devfreq->profile->polling_ms)
 		schedule_delayed_work(&devfreq->work,
@@ -485,43 +529,60 @@ EXPORT_SYMBOL(devfreq_monitor_resume);
  * devfreq_interval_update() - Update device devfreq monitoring interval
  * @devfreq:    the devfreq instance.
  * @delay:      new polling interval to be set.
+ * @idle:	indicates state for which the new interval is going to be set.
  *
  * Helper function to set new load monitoring polling interval. Function
- * to be called from governor in response to DEVFREQ_GOV_INTERVAL event.
+ * to be called from governor in response to DEVFREQ_GOV_INTERVAL or
+ * DEVFREQ_GOV_IDLE_INTERVAL event.
  */
-void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
+void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay,
+			     bool idle)
 {
-	unsigned int cur_delay = devfreq->profile->polling_ms;
+	unsigned int cur_delay;
 	unsigned int new_delay = *delay;
+	bool dev_in_idle = false;
 
 	mutex_lock(&devfreq->lock);
-	devfreq->profile->polling_ms = new_delay;
 
+	cur_delay = devfreq_get_polling_delay(devfreq);
+	/* check if we are currently in idle state, it will be needed later */
+	if (cur_delay == devfreq->profile->polling_idle_ms)
+		dev_in_idle = true;
+
+	if (idle)
+		devfreq->profile->polling_idle_ms = new_delay;
+	else
+		devfreq->profile->polling_ms = new_delay;
+
+	/* device is in suspend, does not need to do anything more. */
 	if (devfreq->stop_polling)
 		goto out;
 
-	/* if new delay is zero, stop polling */
-	if (!new_delay) {
+	/* if new delay is zero and it is for 'normal' polling,
+	 * then stop polling */
+	if (!new_delay && !idle) {
 		mutex_unlock(&devfreq->lock);
 		cancel_delayed_work_sync(&devfreq->work);
 		return;
 	}
 
-	/* if current delay is zero, start polling with new delay */
-	if (!cur_delay) {
+	/* if current delay is zero and it is not for idle,
+	 * start polling with 'normal' polling interval */
+	if (!cur_delay && !idle) {
 		schedule_delayed_work(&devfreq->work,
-			msecs_to_jiffies(devfreq->profile->polling_ms));
+			msecs_to_jiffies(new_delay));
 		goto out;
 	}
 
-	/* if current delay is greater than new delay, restart polling */
-	if (cur_delay > new_delay) {
+	/* if current delay is greater than new delay and the new polling value
+	 * corresponds to the current state, restart polling */
+	if (cur_delay > new_delay && dev_in_idle == idle) {
 		mutex_unlock(&devfreq->lock);
 		cancel_delayed_work_sync(&devfreq->work);
 		mutex_lock(&devfreq->lock);
 		if (!devfreq->stop_polling)
 			schedule_delayed_work(&devfreq->work,
-			      msecs_to_jiffies(devfreq->profile->polling_ms));
+			      msecs_to_jiffies(new_delay));
 	}
 out:
 	mutex_unlock(&devfreq->lock);
@@ -590,6 +651,24 @@ static void devfreq_dev_release(struct device *dev)
 }
 
 /**
+ * polling_idle_init() - Initialize polling interval for device's low-load.
+ * @df:		the devfreq device which is setup
+ *
+ * The function checks if the driver's code defined the 'polling_idle_ms' and
+ * leaves it or tries to initialise according to the framework's default value
+ * and 'normal' polling interval ('polling_ms').
+ */
+static void polling_idle_init(struct devfreq *df)
+{
+	if (!df->profile->polling_idle_ms)
+		df->profile->polling_idle_ms = default_polling_idle_ms;
+
+	if (df->profile->polling_idle_ms <= df->profile->polling_ms)
+		df->profile->polling_idle_ms = df->profile->polling_ms +
+			default_polling_idle_ms;
+}
+
+/**
  * devfreq_add_device() - Add devfreq feature to the device
  * @dev:	the device to add devfreq feature.
  * @profile:	device-specific profile to run devfreq.
@@ -664,6 +743,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	}
 	devfreq->max_freq = devfreq->scaling_max_freq;
 
+	polling_idle_init(devfreq);
+
 	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
 	atomic_set(&devfreq->suspend_count, 0);
 
@@ -1235,6 +1316,13 @@ static ssize_t polling_interval_store(struct device *dev,
 	if (ret != 1)
 		return -EINVAL;
 
+	mutex_lock(&df->lock);
+	if (df->profile->polling_idle_ms < value) {
+		mutex_unlock(&df->lock);
+		return -EINVAL;
+	}
+	mutex_unlock(&df->lock);
+
 	df->governor->event_handler(df, DEVFREQ_GOV_INTERVAL, &value);
 	ret = count;
 
@@ -1242,6 +1330,42 @@ static ssize_t polling_interval_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(polling_interval);
 
+static ssize_t
+polling_idle_interval_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	return sprintf(buf, "%d\n", to_devfreq(dev)->profile->polling_idle_ms);
+}
+
+static ssize_t polling_idle_interval_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	struct devfreq *df = to_devfreq(dev);
+	unsigned int value;
+	int ret;
+
+	if (!df->governor)
+		return -EINVAL;
+
+	ret = sscanf(buf, "%u", &value);
+	if (ret != 1)
+		return -EINVAL;
+
+	mutex_lock(&df->lock);
+	if (df->profile->polling_ms > value) {
+		mutex_unlock(&df->lock);
+		return -EINVAL;
+	}
+	mutex_unlock(&df->lock);
+
+	df->governor->event_handler(df, DEVFREQ_GOV_IDLE_INTERVAL, &value);
+	ret = count;
+
+	return ret;
+}
+static DEVICE_ATTR_RW(polling_idle_interval);
+
 static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -1408,6 +1532,7 @@ static struct attribute *devfreq_attrs[] = {
 	&dev_attr_available_frequencies.attr,
 	&dev_attr_target_freq.attr,
 	&dev_attr_polling_interval.attr,
+	&dev_attr_polling_idle_interval.attr,
 	&dev_attr_min_freq.attr,
 	&dev_attr_max_freq.attr,
 	&dev_attr_trans_stat.attr,
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index f53339c..fa4f0c5 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -24,6 +24,7 @@
 #define DEVFREQ_GOV_INTERVAL			0x3
 #define DEVFREQ_GOV_SUSPEND			0x4
 #define DEVFREQ_GOV_RESUME			0x5
+#define DEVFREQ_GOV_IDLE_INTERVAL			0x6
 
 #define DEVFREQ_MIN_FREQ			0
 #define DEVFREQ_MAX_FREQ			ULONG_MAX
@@ -62,7 +63,7 @@ extern void devfreq_monitor_stop(struct devfreq *devfreq);
 extern void devfreq_monitor_suspend(struct devfreq *devfreq);
 extern void devfreq_monitor_resume(struct devfreq *devfreq);
 extern void devfreq_interval_update(struct devfreq *devfreq,
-					unsigned int *delay);
+				    unsigned int *delay, bool idle);
 
 extern int devfreq_add_governor(struct devfreq_governor *governor);
 extern int devfreq_remove_governor(struct devfreq_governor *governor);
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index c0417f0..cc1feac 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -100,7 +100,11 @@ static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
 		break;
 
 	case DEVFREQ_GOV_INTERVAL:
-		devfreq_interval_update(devfreq, (unsigned int *)data);
+		devfreq_interval_update(devfreq, (unsigned int *)data, false);
+		break;
+
+	case DEVFREQ_GOV_IDLE_INTERVAL:
+		devfreq_interval_update(devfreq, (unsigned int *)data, true);
 		break;
 
 	case DEVFREQ_GOV_SUSPEND:
-- 
2.7.4
