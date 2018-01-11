From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2] thermal: Add cooling device's statistics in sysfs
Date: Thu, 11 Jan 2018 14:46:06 +0530
Message-ID: <88a57e29b2d35f65aa94cfb18c61e2280fd47ea0.1515662107.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40328 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752978AbeAKJQL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jan 2018 04:16:11 -0500
Received: by mail-pf0-f194.google.com with SMTP id i66so1212923pfd.7
        for <linux-pm@vger.kernel.org>; Thu, 11 Jan 2018 01:16:10 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

This extends the sysfs interface for thermal cooling devices and exposes
some pretty useful statistics. These statistics have proven to be quite
useful specially while doing benchmarks related to the task scheduler,
where we want to make sure that nothing has disrupted the test,
specially the cooling device which may have put constraints on the CPUs.
The information exposed here tells us to what extent the CPUs were
constrained by the thermal framework.

The read-only "total_trans" file shows the total number of cooling state
transitions the device has gone through since the time the cooling
device is registered or the time when statistics were reset last.

The read-only "time_in_state_ms" file shows the time spent by the device
in the respective cooling states.

The write-only "reset" file is used to reset the statistics.

This is how the directory structure looks like for a single cooling
device:

$ ls -R /sys/class/thermal/cooling_device0/
/sys/class/thermal/cooling_device0/:
cur_state  max_state  power  stats  subsystem  type  uevent

/sys/class/thermal/cooling_device0/power:
autosuspend_delay_ms  runtime_active_time  runtime_suspended_time
control               runtime_status

/sys/class/thermal/cooling_device0/stats:
reset  time_in_state_ms  total_trans

This is tested on ARM 32-bit Hisilicon hikey620 board running Ubuntu and
ARM 64-bit Hisilicon hikey960 board running Android.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2:
- Move to sysfs from debugfs

 drivers/thermal/thermal_core.c    |   3 +-
 drivers/thermal/thermal_core.h    |   3 +
 drivers/thermal/thermal_helpers.c |   5 +-
 drivers/thermal/thermal_sysfs.c   | 145 ++++++++++++++++++++++++++++++++++++++
 include/linux/thermal.h           |   1 +
 5 files changed, 155 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2b1b0ba393a4..2cc4ae57484e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -972,8 +972,8 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->ops = ops;
 	cdev->updated = false;
 	cdev->device.class = &thermal_class;
-	thermal_cooling_device_setup_sysfs(cdev);
 	cdev->devdata = devdata;
+	thermal_cooling_device_setup_sysfs(cdev);
 	dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
 	result = device_register(&cdev->device);
 	if (result) {
@@ -1106,6 +1106,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 
 	ida_simple_remove(&thermal_cdev_ida, cdev->id);
 	device_unregister(&cdev->device);
+	thermal_cooling_device_remove_sysfs(cdev);
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
 
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 27e3b1df7360..f6eb01e99816 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -73,6 +73,9 @@ int thermal_build_list_of_policies(char *buf);
 int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
 void thermal_zone_destroy_device_groups(struct thermal_zone_device *);
 void thermal_cooling_device_setup_sysfs(struct thermal_cooling_device *);
+void thermal_cooling_device_remove_sysfs(struct thermal_cooling_device *cdev);
+void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
+					 unsigned long new_state);
 /* used only at binding time */
 ssize_t
 thermal_cooling_device_trip_point_show(struct device *,
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 8cdf75adcce1..eb03d7e099bb 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -187,7 +187,10 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 		if (instance->target > target)
 			target = instance->target;
 	}
-	cdev->ops->set_cur_state(cdev, target);
+
+	if (!cdev->ops->set_cur_state(cdev, target))
+		thermal_cooling_device_stats_update(cdev, target);
+
 	cdev->updated = true;
 	mutex_unlock(&cdev->lock);
 	trace_cdev_update(cdev, target);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index ba81c9080f6e..4bb3bc999d3c 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -666,6 +666,121 @@ void thermal_zone_destroy_device_groups(struct thermal_zone_device *tz)
 }
 
 /* sys I/F for cooling device */
+struct cooling_dev_stats {
+	spinlock_t lock;
+	unsigned int total_trans;
+	unsigned long state;
+	unsigned long max_states;
+	ktime_t last_time;
+	ktime_t *time_in_state;
+};
+
+static void update_time_in_state(struct cooling_dev_stats *stats)
+{
+	ktime_t now = ktime_get(), delta;
+
+	delta = ktime_sub(now, stats->last_time);
+	stats->time_in_state[stats->state] =
+		ktime_add(stats->time_in_state[stats->state], delta);
+	stats->last_time = now;
+}
+
+void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
+					 unsigned long new_state)
+{
+	struct cooling_dev_stats *stats = cdev->stats;
+
+	spin_lock(&stats->lock);
+
+	if (stats->state == new_state)
+		goto unlock;
+
+	update_time_in_state(stats);
+	stats->state = new_state;
+	stats->total_trans++;
+
+unlock:
+	spin_unlock(&stats->lock);
+}
+
+static ssize_t
+thermal_cooling_device_total_trans_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct thermal_cooling_device *cdev = to_cooling_device(dev);
+	struct cooling_dev_stats *stats = cdev->stats;
+	int ret;
+
+	spin_lock(&stats->lock);
+	ret = sprintf(buf, "%u\n", stats->total_trans);
+	spin_unlock(&stats->lock);
+
+	return ret;
+}
+
+static ssize_t
+thermal_cooling_device_time_in_state_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct thermal_cooling_device *cdev = to_cooling_device(dev);
+	struct cooling_dev_stats *stats = cdev->stats;
+	ssize_t len = 0;
+	int i;
+
+	spin_lock(&stats->lock);
+	update_time_in_state(stats);
+
+	for (i = 0; i < stats->max_states; i++) {
+		len += sprintf(buf + len, "state%u\t%llu\n", i,
+			       ktime_to_ms(stats->time_in_state[i]));
+	}
+	spin_unlock(&stats->lock);
+
+	return len;
+}
+
+static ssize_t
+thermal_cooling_device_reset_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct thermal_cooling_device *cdev = to_cooling_device(dev);
+	struct cooling_dev_stats *stats = cdev->stats;
+	int i;
+
+	spin_lock(&stats->lock);
+
+	stats->total_trans = 0;
+	stats->last_time = ktime_get();
+
+	for (i = 0; i < stats->max_states; i++)
+		stats->time_in_state[i] = ktime_set(0, 0);
+
+	spin_unlock(&stats->lock);
+
+	return count;
+}
+
+static DEVICE_ATTR(total_trans, 0444, thermal_cooling_device_total_trans_show,
+		   NULL);
+static DEVICE_ATTR(time_in_state_ms, 0444,
+		   thermal_cooling_device_time_in_state_show, NULL);
+static DEVICE_ATTR(reset, 0200, NULL, thermal_cooling_device_reset_store);
+
+static struct attribute *cooling_device_stats_attrs[] = {
+	&dev_attr_total_trans.attr,
+	&dev_attr_time_in_state_ms.attr,
+	&dev_attr_reset.attr,
+	NULL
+};
+
+static const struct attribute_group cooling_device_stats_attr_group = {
+	.attrs = cooling_device_stats_attrs,
+	.name = "stats"
+};
+
 static ssize_t
 thermal_cooling_device_type_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
@@ -721,6 +836,7 @@ thermal_cooling_device_cur_state_store(struct device *dev,
 	result = cdev->ops->set_cur_state(cdev, state);
 	if (result)
 		return result;
+	thermal_cooling_device_stats_update(cdev, state);
 	return count;
 }
 
@@ -745,14 +861,43 @@ static const struct attribute_group cooling_device_attr_group = {
 
 static const struct attribute_group *cooling_device_attr_groups[] = {
 	&cooling_device_attr_group,
+	&cooling_device_stats_attr_group,
 	NULL,
 };
 
 void thermal_cooling_device_setup_sysfs(struct thermal_cooling_device *cdev)
 {
+	struct cooling_dev_stats *stats;
+	unsigned long states;
+	int ret, size;
+
+	ret = cdev->ops->get_max_state(cdev, &states);
+	if (ret)
+		return;
+
+	size = sizeof(*stats);
+	size += sizeof(*stats->time_in_state) * states;
+
+	stats = kzalloc(size, GFP_KERNEL);
+	if (!stats)
+		return;
+
+	stats->time_in_state = (ktime_t *)(stats + 1);
+	cdev->stats = stats;
+	stats->last_time = ktime_get();
+	stats->max_states = states;
+	cdev->stats = stats;
+
+	spin_lock_init(&stats->lock);
 	cdev->device.groups = cooling_device_attr_groups;
 }
 
+void thermal_cooling_device_remove_sysfs(struct thermal_cooling_device *cdev)
+{
+	kfree(cdev->stats);
+	cdev->stats = NULL;
+}
+
 /* these helper will be used only at the time of bindig */
 ssize_t
 thermal_cooling_device_trip_point_show(struct device *dev,
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 8c5302374eaa..7834be668d80 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -148,6 +148,7 @@ struct thermal_cooling_device {
 	struct device device;
 	struct device_node *np;
 	void *devdata;
+	void *stats;
 	const struct thermal_cooling_device_ops *ops;
 	bool updated; /* true if the cooling device does not need update */
 	struct mutex lock; /* protect thermal_instances list */
-- 
2.15.0.194.g9af6a3dea062
