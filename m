From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v8 3/5] PM / DEVFREQ: add common sysfs interfaces
Date: Wed, 24 Aug 2011 17:22:09 +0900
Message-ID: <1314174131-14194-4-git-send-email-myungjoo.ham@samsung.com>
References: <1314086044-24659-1-git-send-email-myungjoo.ham@samsung.com>
	<1314174131-14194-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1314174131-14194-1-git-send-email-myungjoo.ham@samsung.com>
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
- polling_interval	R: polling interval in ms given with devfreq profile
			W: update polling interval.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

--
Changed from v7
- removed set_freq from the common devfreq interface
- added get_devfreq, a mutex-protected wrapper for find_device_devfreq
(for sysfs interfaces and later with governor-support)
- corrected ABI documentation.

Changed from v6
- poling_interval is writable.

Changed from v5
- updated devferq_update usage.

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
 Documentation/ABI/testing/sysfs-devices-power |   37 ++++++
 drivers/devfreq/devfreq.c                     |  150 +++++++++++++++++++++++++
 2 files changed, 187 insertions(+), 0 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 8ffbc25..57f4591 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -165,3 +165,40 @@ Description:
 
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
+		The /sys/devices/.../power/devfreq_max_freq shows the
+		maximum operable frequency of the corresponding device.
+
+What:		/sys/devices/.../power/devfreq_min_freq
+Date:		July 2011
+Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
+Description:
+		The /sys/devices/.../power/devfreq_min_freq shows the
+		minimum operable frequency of the corresponding device.
+
+What:		/sys/devices/.../power/devfreq_polling_interval
+Date:		July 2011
+Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
+Description:
+		The /sys/devices/.../power/devfreq_polling_interval sets and
+		shows the requested polling interval of the corresponding
+		device. The values are represented in ms. If the value is less
+		than 1 jiffy, it is considered to be 0, which means no polling.
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index df63bdc..5bbece6 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -37,6 +37,8 @@ static struct delayed_work devfreq_work;
 static LIST_HEAD(devfreq_list);
 static DEFINE_MUTEX(devfreq_list_lock);
 
+static struct attribute_group dev_attr_group;
+
 /**
  * find_device_devfreq() - find devfreq struct using device pointer
  * @dev:	device pointer used to lookup device devfreq.
@@ -62,6 +64,22 @@ static struct devfreq *find_device_devfreq(struct device *dev)
 }
 
 /**
+ * get_devfreq() - find devfreq struct. a wrapped find_device_devfreq()
+ *		with mutex protection.
+ * @dev:	device pointer used to lookup device devfreq.
+ */
+static struct devfreq *get_devfreq(struct device *dev)
+{
+	struct devfreq *ret;
+
+	mutex_lock(&devfreq_list_lock);
+	ret = find_device_devfreq(dev);
+	mutex_unlock(&devfreq_list_lock);
+
+	return ret;
+}
+
+/**
  * devfreq_do() - Check the usage profile of a given device and configure
  *		frequency and voltage accordingly
  * @devfreq:	devfreq info of the given device
@@ -149,6 +167,8 @@ static void devfreq_monitor(struct work_struct *work)
 				dev_err(devfreq->dev, "Due to devfreq_do error(%d), devfreq(%s) is removed from the device\n",
 					error, devfreq->governor->name);
 
+				sysfs_unmerge_group(&devfreq->dev->kobj,
+						    &dev_attr_group);
 				list_del(&devfreq->node);
 				kfree(devfreq);
 
@@ -239,6 +259,8 @@ int devfreq_add_device(struct device *dev, struct devfreq_dev_profile *profile,
 		queue_delayed_work(devfreq_wq, &devfreq_work,
 				   devfreq->next_polling);
 	}
+
+	sysfs_merge_group(&dev->kobj, &dev_attr_group);
 out:
 	mutex_unlock(&devfreq_list_lock);
 
@@ -271,6 +293,8 @@ int devfreq_remove_device(struct device *dev)
 		goto out;
 	}
 
+	sysfs_unmerge_group(&dev->kobj, &dev_attr_group);
+
 	list_del(&devfreq->node);
 	srcu_notifier_chain_unregister(nh, &devfreq->nb);
 	kfree(devfreq);
@@ -279,6 +303,132 @@ out:
 	return 0;
 }
 
+static ssize_t show_governor(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct devfreq *df = get_devfreq(dev);
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
+	struct devfreq *df = get_devfreq(dev);
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
+	struct devfreq *df = get_devfreq(dev);
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
+	struct devfreq *df = get_devfreq(dev);
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
+	struct devfreq *df = get_devfreq(dev);
+
+	if (IS_ERR(df))
+		return PTR_ERR(df);
+	if (!df->profile)
+		return -EINVAL;
+
+	return sprintf(buf, "%d\n", df->profile->polling_ms);
+}
+
+static ssize_t store_polling_interval(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct devfreq *df = get_devfreq(dev);
+	unsigned int value;
+	int ret;
+
+	if (IS_ERR(df))
+		return PTR_ERR(df);
+	if (!df->profile)
+		return -EINVAL;
+
+	ret = sscanf(buf, "%u", &value);
+	if (ret != 1)
+		return -EINVAL;
+
+	df->profile->polling_ms = value;
+	df->next_polling = df->polling_jiffies
+			 = msecs_to_jiffies(value);
+
+	mutex_lock(&devfreq_list_lock);
+	if (df->next_polling > 0 && !polling) {
+		polling = true;
+		queue_delayed_work(devfreq_wq, &devfreq_work,
+				   df->next_polling);
+	}
+	mutex_unlock(&devfreq_list_lock);
+
+	return count;
+}
+
+static DEVICE_ATTR(devfreq_governor, 0444, show_governor, NULL);
+static DEVICE_ATTR(devfreq_cur_freq, 0444, show_freq, NULL);
+static DEVICE_ATTR(devfreq_max_freq, 0444, show_max_freq, NULL);
+static DEVICE_ATTR(devfreq_min_freq, 0444, show_min_freq, NULL);
+static DEVICE_ATTR(devfreq_polling_interval, 0644, show_polling_interval,
+		   store_polling_interval);
+static struct attribute *dev_entries[] = {
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
-- 
1.7.4.1
