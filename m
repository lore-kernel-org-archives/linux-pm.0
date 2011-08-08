From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v5 3/3] PM / DEVFREQ: add sysfs interface
Date: Mon, 08 Aug 2011 18:03:08 +0900
Message-ID: <1312794188-9823-4-git-send-email-myungjoo.ham@samsung.com>
References: <1312794188-9823-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1312794188-9823-1-git-send-email-myungjoo.ham@samsung.com>
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

Device specific sysfs interface /sys/devices/.../power/devfreq_*
- governor	R: name of governor
- cur_freq	R: current frequency
- max_freq	R: maximum operable frequency
- min_freq	R: minimum operable frequency
- set_freq	R: read user specified frequency (0 if not specified yet)
		W: set user specified frequency
- polling_interval	R: polling interval in ms given with devfreq profile

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

--
Changed from v4
- removed system-wide sysfs interface
- removed tickling sysfs interface
- added set_freq for userspace governor (and any other governors that
  require user input)

Changed from v3
- corrected sysfs API usage
- corrected error messages
- moved sysfs entry location
- added sysfs entries

Changed from v2
- add ABI entries for devfreq sysfs interface
---
 Documentation/ABI/testing/sysfs-devices-power |   45 +++++++
 drivers/base/power/devfreq.c                  |  152 +++++++++++++++++++++++++
 2 files changed, 197 insertions(+), 0 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 8ffbc25..6e77604 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -165,3 +165,48 @@ Description:
 
 		Not all drivers support this attribute.  If it isn't supported,
 		attempts to read or write it will yield I/O errors.
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
+What:		/sys/devices/.../power/devfreq_set_freq
+Date:		August 2011
+Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
+Description:
+		The /sys/devices/.../power/devfreq_set_freq sets and shows
+		the user specified desired frequency of the device. The
+		governor may and may not use the value. With the basic
+		governors given with devfreq.c, userspace governor is
+		using the value.
+
+What:		/sys/devices/.../power/devfreq_polling_interval
+Date:		July 2011
+Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
+Description:
+		The /sys/devices/.../power/devfreq_polling_interval shows the
+		requested polling interval of the corresponding device.
diff --git a/drivers/base/power/devfreq.c b/drivers/base/power/devfreq.c
index c53bca9..4f964b7 100644
--- a/drivers/base/power/devfreq.c
+++ b/drivers/base/power/devfreq.c
@@ -42,6 +42,8 @@ static struct delayed_work devfreq_work;
 static LIST_HEAD(devfreq_list);
 static DEFINE_MUTEX(devfreq_list_lock);
 
+static struct attribute_group dev_attr_group;
+
 /**
  * find_device_devfreq() - find devfreq struct using device pointer
  * @dev:	device pointer used to lookup device devfreq.
@@ -138,6 +140,8 @@ static void devfreq_monitor(struct work_struct *work)
 					"devfreq is removed from the device\n",
 					error);
 
+				sysfs_unmerge_group(&devfreq->dev->kobj,
+						    &dev_attr_group);
 				list_del(&devfreq->node);
 				kfree(devfreq);
 
@@ -218,6 +222,8 @@ int devfreq_add_device(struct device *dev, struct devfreq_dev_profile *profile,
 		queue_delayed_work(devfreq_wq, &devfreq_work,
 				   msecs_to_jiffies(devfreq_interval));
 	}
+
+	sysfs_merge_group(&dev->kobj, &dev_attr_group);
 out:
 	mutex_unlock(&devfreq_list_lock);
 
@@ -244,6 +250,8 @@ int devfreq_remove_device(struct device *dev)
 		return -EINVAL;
 	}
 
+	sysfs_unmerge_group(&dev->kobj, &dev_attr_group);
+
 	list_del(&devfreq->node);
 
 	kfree(devfreq);
@@ -278,6 +286,150 @@ out:
 	return err;
 }
 
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
+static ssize_t set_user_frequency(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct devfreq *devfreq;
+	unsigned long wanted;
+	int err = 0;
+
+	sscanf(buf, "%lu", &wanted);
+
+	mutex_lock(&devfreq_list_lock);
+	devfreq = find_device_devfreq(dev);
+
+	if (IS_ERR(devfreq)) {
+		err = PTR_ERR(devfreq);
+		goto out;
+	}
+
+	devfreq->user_set_freq = wanted;
+	err = count;
+out:
+	mutex_unlock(&devfreq_list_lock);
+	if (err >= 0)
+		devfreq_update(dev);
+	return err;
+}
+
+static ssize_t show_user_frequency(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct devfreq *devfreq;
+	int err = 0;
+
+	mutex_lock(&devfreq_list_lock);
+	devfreq = find_device_devfreq(dev);
+
+	if (IS_ERR(devfreq)) {
+		err = PTR_ERR(devfreq);
+		goto out;
+	}
+
+	err = sprintf(buf, "%lu\n", devfreq->user_set_freq);
+out:
+	mutex_unlock(&devfreq_list_lock);
+	return err;
+
+}
+
+static DEVICE_ATTR(devfreq_governor, 0444, show_governor, NULL);
+static DEVICE_ATTR(devfreq_cur_freq, 0444, show_freq, NULL);
+static DEVICE_ATTR(devfreq_max_freq, 0444, show_max_freq, NULL);
+static DEVICE_ATTR(devfreq_min_freq, 0444, show_min_freq, NULL);
+static DEVICE_ATTR(devfreq_polling_interval, 0444, show_polling_interval, NULL);
+static DEVICE_ATTR(devfreq_set_freq, 0644, show_user_frequency,
+		   set_user_frequency);
+static struct attribute *dev_entries[] = {
+	&dev_attr_devfreq_governor.attr,
+	&dev_attr_devfreq_cur_freq.attr,
+	&dev_attr_devfreq_max_freq.attr,
+	&dev_attr_devfreq_min_freq.attr,
+	&dev_attr_devfreq_polling_interval.attr,
+	&dev_attr_devfreq_set_freq.attr,
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
-- 
1.7.4.1
