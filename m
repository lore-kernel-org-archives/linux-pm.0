From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v4 3/3] PM / DEVFREQ: add sysfs interface
 (including user tickling)
Date: Fri, 15 Jul 2011 17:11:50 +0900
Message-ID: <1310717510-19002-4-git-send-email-myungjoo.ham@samsung.com>
References: <1310717510-19002-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1310717510-19002-1-git-send-email-myungjoo.ham@samsung.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

1. System-wide sysfs interface /sys/power/
- tickle_all	R: number of tickle_all execution
		W: tickle all devfreq devices
- min_interval	R: devfreq monitoring base interval in ms
- monitoring	R: shows whether devfreq monitoring is active or
 not.

2. Device specific sysfs interface /sys/devices/.../power/devfreq_*
- tickle	R: number of tickle execution for the device
		W: tickle the device
- governor	R: name of governor
- cur_freq	R: current frequency
- max_freq	R: maximum operable frequency
- min_freq	R: minimum operable frequency
- polling_interval	R: polling interval in ms given with devfreq profile

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

--
Changed from v3
- corrected sysfs API usage
- corrected error messages
- moved sysfs entry location
- added sysfs entries

Changed from v2
- add ABI entries for devfreq sysfs interface
---
 Documentation/ABI/testing/sysfs-devices-power |   50 ++++++
 Documentation/ABI/testing/sysfs-power         |   43 +++++
 drivers/base/power/devfreq.c                  |  232 +++++++++++++++++++++++++
 include/linux/devfreq.h                       |    3 +
 4 files changed, 328 insertions(+), 0 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 8ffbc25..692f845 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -165,3 +165,53 @@ Description:
 
 		Not all drivers support this attribute.  If it isn't supported,
 		attempts to read or write it will yield I/O errors.
+
+What:		/sys/devices/.../power/devfreq_tickle
+Date:		July 2011
+Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
+Description:
+		The /sys/devices/.../power/devfreq_tickle file allows users
+		to force the corresponding device to operate at its maximum
+		operable frequency instaneously and temporarily. After a
+		designated duration has passed, the operating frequency returns
+		to normal. When a user reads the tickle entry, it returns
+		the number of tickle executions for the device. When a user
+		writes to the tickle entry with the tickle duration in ms,
+		the effect of device tickling is held for the designated
+		duration. Note that the duration is rounded-up by
+		the value DEVFREQ_INTERVAL defined in devfreq.c
+
+What:		/sys/devices/.../power/devfreq_governor
+Date:		July 2011
+Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
+Description:
+		The /sys/devices/.../power/devfreq_governor shows the name
+		of the governor used by the corresponding device.
+
+What:		/sys/devices/.../power/devfreq_cur_freq
+Date:		July 2011
+Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
+Description:
+		The /sys/devices/.../power/devfreq_cur_freq shows the current
+		frequency of the corresponding device.
+
+What:		/sys/devices/.../power/devfreq_max_freq
+Date:		July 2011
+Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
+Description:
+		The /sys/devices/.../power/devfreq_cur_freq shows the
+		maximum operable frequency of the corresponding device.
+
+What:		/sys/devices/.../power/devfreq_min_freq
+Date:		July 2011
+Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
+Description:
+		The /sys/devices/.../power/devfreq_cur_freq shows the
+		minimum operable frequency of the corresponding device.
+
+What:		/sys/devices/.../power/devfreq_polling_interval
+Date:		July 2011
+Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
+Description:
+		The /sys/devices/.../power/devfreq_polling_interval shows the
+		requested polling interval of the corresponding device.
diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index b464d12..4d8434b 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -172,3 +172,46 @@ Description:
 
 		Reading from this file will display the current value, which is
 		set to 1 MB by default.
+
+What:		/sys/power/devfreq/
+Date:		May 2011
+Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
+Description:
+		The /sys/power/devfreq directory will contain files that will
+		provide a unified interface to the DEVFREQ, a generic DVFS
+		(dynamic voltage and frequency scaling) framework.
+
+What:		/sys/power/devfreq/tickle_all
+Date:		May 2011
+Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
+Description:
+		The /sys/power/devfreq/tickle_all file allows user space to
+		force every device with DEVFREQ to operate at the maximum
+		frequency of the device instaneously and temporarily. After
+		a designated delay has passed, the operating frequency returns
+		to normal. If a user reads the tickle_all entry, it returns
+		the number of tickle_all executions. When writing to the
+		tickle_all entry, the user should supply with the duration of
+		tickle in ms (the "designated delay" mentioned before). Then,
+		the effect of tickle_all will hold for the denoted duration.
+		Note that the duration is rounded by the monitoring period
+		defined by DEVFREQ_INTERVAL in /drivers/base/power/devfreq.c.
+
+What:		/sys/power/devfreq/min_interval
+Date:		May 2011
+Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
+Description:
+		The /sys/power/devfreq/min_interval file shows the monitoring
+		period defined by DEVFREQ_INTERVAL in
+		/drivers/base/power/devfreq.c. The duration of device tickling
+		is rounded-up by DEVFREQ_INTERVAL.
+
+What:		/sys/power/devfreq/monitoring
+Date:		May 2011
+Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
+Description:
+		The /sys/power/devfreq/monitoring file shows whether DEVFREQ
+		is periodically monitoring. Periodic monitoring is activated
+		if there is a device that wants periodic monitoring for DVFS or
+		there is a device that is tickled (and the tickling duration is
+		not yet expired).
diff --git a/drivers/base/power/devfreq.c b/drivers/base/power/devfreq.c
index e5a73aa..a62e757 100644
--- a/drivers/base/power/devfreq.c
+++ b/drivers/base/power/devfreq.c
@@ -40,6 +40,9 @@ static struct delayed_work devfreq_work;
 static LIST_HEAD(devfreq_list);
 static DEFINE_MUTEX(devfreq_list_lock);
 
+static struct kobject *devfreq_kobj;
+static struct attribute_group dev_attr_group;
+
 /**
  * find_device_devfreq() - find devfreq struct using device pointer
  * @dev:	device pointer used to lookup device devfreq.
@@ -151,6 +154,8 @@ static void devfreq_monitor(struct work_struct *work)
 					"devfreq is removed from the device\n",
 					error);
 
+				sysfs_remove_group(&devfreq->dev->kobj,
+						   &dev_attr_group);
 				list_del(&devfreq->node);
 				kfree(devfreq);
 
@@ -218,6 +223,8 @@ int devfreq_add_device(struct device *dev, struct devfreq_dev_profile *profile,
 		queue_delayed_work(devfreq_wq, &devfreq_work,
 				   msecs_to_jiffies(DEVFREQ_INTERVAL));
 	}
+
+	sysfs_merge_group(&dev->kobj, &dev_attr_group);
 out:
 	mutex_unlock(&devfreq_list_lock);
 
@@ -244,6 +251,8 @@ int devfreq_remove_device(struct device *dev)
 		return -EINVAL;
 	}
 
+	sysfs_unmerge_group(&dev->kobj, &dev_attr_group);
+
 	list_del(&devfreq->node);
 
 	kfree(devfreq);
@@ -378,6 +387,215 @@ int devfreq_tickle_device(struct device *dev, unsigned long duration_ms)
 	return err;
 }
 
+static int num_tickle_all;
+
+static ssize_t tickle_all_store(struct kobject *kobj,
+				struct kobj_attribute *attr, const char *buf,
+				size_t count)
+{
+	int duration = 0;
+	struct devfreq *tmp;
+	unsigned long delay;
+
+	sscanf(buf, "%d", &duration);
+	if (duration < DEVFREQ_INTERVAL)
+		duration = DEVFREQ_INTERVAL;
+
+	delay = DIV_ROUND_UP(duration, DEVFREQ_INTERVAL);
+
+	mutex_lock(&devfreq_list_lock);
+	list_for_each_entry(tmp, &devfreq_list, node) {
+		_devfreq_tickle_device(tmp, delay);
+	}
+	mutex_unlock(&devfreq_list_lock);
+
+	num_tickle_all++;
+	return count;
+}
+
+static ssize_t tickle_all_show(struct kobject *kobj,
+				   struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", num_tickle_all);
+}
+
+static ssize_t min_interval_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", DEVFREQ_INTERVAL);
+}
+
+static ssize_t monitoring_show(struct kobject *kobj,
+			       struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", polling ? 1 : 0);
+}
+
+static struct kobj_attribute tickle_all_attr = {
+	.attr = {
+		.name = "tickle_all",
+		.mode = 0644,
+	},
+	.show = tickle_all_show,
+	.store = tickle_all_store,
+};
+static struct kobj_attribute min_interval_attr = {
+	.attr = {
+		.name = "min_interval",
+		.mode = 0444,
+	},
+	.show = min_interval_show,
+};
+static struct kobj_attribute monitoring_attr = {
+	.attr = {
+		.name = "monitoring",
+		.mode = 0444,
+	},
+	.show = monitoring_show,
+};
+static struct attribute *devfreq_entries[] = {
+	&tickle_all_attr.attr,
+	&min_interval_attr.attr,
+	&monitoring_attr.attr,
+	NULL,
+};
+static struct attribute_group devfreq_attr_group = {
+	.name	= NULL,
+	.attrs	= devfreq_entries,
+};
+
+static ssize_t tickle(struct device *dev, struct device_attribute *attr,
+		      const char *buf, size_t count)
+{
+	int duration;
+	struct devfreq *df;
+	unsigned long delay;
+
+	sscanf(buf, "%d", &duration);
+	if (duration < DEVFREQ_INTERVAL)
+		duration = DEVFREQ_INTERVAL;
+
+	if (unlikely(IS_ERR_OR_NULL(dev))) {
+		pr_err("%s: Null or invalid device.\n", __func__);
+		return -EINVAL;
+	}
+
+	delay = DIV_ROUND_UP(duration, DEVFREQ_INTERVAL);
+
+	mutex_lock(&devfreq_list_lock);
+	df = find_device_devfreq(dev);
+	_devfreq_tickle_device(df, delay);
+	mutex_unlock(&devfreq_list_lock);
+
+	return count;
+}
+
+static ssize_t show_num_tickle(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct devfreq *df = find_device_devfreq(dev);
+
+	if (!IS_ERR(df))
+		return sprintf(buf, "%d\n", df->num_tickle);
+
+	return PTR_ERR(df);
+}
+
+static ssize_t show_governor(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct devfreq *df = find_device_devfreq(dev);
+
+	if (IS_ERR(df))
+		return PTR_ERR(df);
+	if (!df->governor)
+		return -EINVAL;
+
+	return sprintf(buf, "%s\n", df->governor->name);
+}
+
+static ssize_t show_freq(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct devfreq *df = find_device_devfreq(dev);
+
+	if (IS_ERR(df))
+		return PTR_ERR(df);
+
+	return sprintf(buf, "%lu\n", df->previous_freq);
+}
+
+static ssize_t show_max_freq(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct devfreq *df = find_device_devfreq(dev);
+	unsigned long freq = ULONG_MAX;
+	struct opp *opp;
+
+	if (IS_ERR(df))
+		return PTR_ERR(df);
+	if (!df->dev)
+		return -EINVAL;
+
+	opp = opp_find_freq_floor(df->dev, &freq);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
+	return sprintf(buf, "%lu\n", freq);
+}
+
+static ssize_t show_min_freq(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct devfreq *df = find_device_devfreq(dev);
+	unsigned long freq = 0;
+	struct opp *opp;
+
+	if (IS_ERR(df))
+		return PTR_ERR(df);
+	if (!df->dev)
+		return -EINVAL;
+
+	opp = opp_find_freq_ceil(df->dev, &freq);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
+	return sprintf(buf, "%lu\n", freq);
+}
+
+static ssize_t show_polling_interval(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct devfreq *df = find_device_devfreq(dev);
+
+	if (IS_ERR(df))
+		return PTR_ERR(df);
+	if (!df->profile)
+		return -EINVAL;
+
+	return sprintf(buf, "%d\n", df->profile->polling_ms);
+}
+
+static DEVICE_ATTR(devfreq_tickle, 0644, show_num_tickle, tickle);
+static DEVICE_ATTR(devfreq_governor, 0444, show_governor, NULL);
+static DEVICE_ATTR(devfreq_cur_freq, 0444, show_freq, NULL);
+static DEVICE_ATTR(devfreq_max_freq, 0444, show_max_freq, NULL);
+static DEVICE_ATTR(devfreq_min_freq, 0444, show_min_freq, NULL);
+static DEVICE_ATTR(devfreq_polling_interval, 0444, show_polling_interval, NULL);
+static struct attribute *dev_entries[] = {
+	&dev_attr_devfreq_tickle.attr,
+	&dev_attr_devfreq_governor.attr,
+	&dev_attr_devfreq_cur_freq.attr,
+	&dev_attr_devfreq_max_freq.attr,
+	&dev_attr_devfreq_min_freq.attr,
+	&dev_attr_devfreq_polling_interval.attr,
+	NULL,
+};
+static struct attribute_group dev_attr_group = {
+	.name	= power_group_name,
+	.attrs	= dev_entries,
+};
+
 /**
  * devfreq_init() - Initialize data structure for devfreq framework and
  *		  start polling registered devfreq devices.
@@ -389,6 +607,20 @@ static int __init devfreq_init(void)
 	polling = false;
 	devfreq_wq = create_freezable_workqueue("devfreq_wq");
 	INIT_DELAYED_WORK_DEFERRABLE(&devfreq_work, devfreq_monitor);
+
+#ifdef CONFIG_PM
+	/* Create sysfs */
+	devfreq_kobj = kobject_create_and_add("devfreq", power_kobj);
+	if (!devfreq_kobj) {
+		pr_err("Unable to create devfreq kobject.\n");
+		goto out;
+	}
+	if (sysfs_create_group(devfreq_kobj, &devfreq_attr_group)) {
+		pr_err("Unable to create devfreq sysfs entries.\n");
+		goto out;
+	}
+#endif
+out:
 	mutex_unlock(&devfreq_list_lock);
 
 	devfreq_monitor(&devfreq_work.work);
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index baa074c..f6e4e3b 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -62,6 +62,7 @@ struct devfreq_governor {
  *		at each executino of devfreq_monitor, tickle is decremented.
  *		User may tickle a device-devfreq in order to set maximum
  *		frequency instaneously with some guaranteed duration.
+ * @num_tickle	number of tickle calls.
  *
  * This structure stores the DEVFREQ information for a give device.
  */
@@ -75,6 +76,8 @@ struct devfreq {
 	unsigned long previous_freq;
 	unsigned int next_polling;
 	unsigned int tickle;
+
+	unsigned int num_tickle;
 };
 
 #if defined(CONFIG_PM_DEVFREQ)
-- 
1.7.4.1
