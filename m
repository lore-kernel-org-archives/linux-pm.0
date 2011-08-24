From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v8 5/5] PM / DEVFREQ: add basic governors
Date: Wed, 24 Aug 2011 17:22:11 +0900
Message-ID: <1314174131-14194-6-git-send-email-myungjoo.ham@samsung.com>
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

Four CPUFREQ-like governors are provided as examples.

powersave: use the lowest frequency possible. The user (device) should
set the polling_ms as 0 because polling is useless for this governor.

performance: use the highest freqeuncy possible. The user (device)
should set the polling_ms as 0 because polling is useless for this
governor.

userspace: use the user specified frequency stored at
devfreq.user_set_freq. With sysfs support in the following patch, a user
may set the value with the sysfs interface.

simple_ondemand: simplified version of CPUFREQ's ONDEMAND governor.

When a user updates OPP entries (enable/disable/add), OPP framework
automatically notifies DEVFREQ to update operating frequency
accordingly. Thus, DEVFREQ users (device drivers) do not need to update
DEVFREQ manually with OPP entry updates or set polling_ms for powersave
, performance, userspace, or any other "static" governors.

Note that these are given only as basic examples for governors and any
devices with DEVFREQ may implement their own governors with the drivers
and use them.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

---
Changed from v7
- Userspace uses its own sysfs interface.

Changed from v5
- Seperated governor files from devfreq.c
- Allow simple ondemand to be tuned for each device
---
 Documentation/ABI/testing/sysfs-devices-power |    9 ++
 drivers/devfreq/Kconfig                       |   36 ++++++++
 drivers/devfreq/Makefile                      |    4 +
 drivers/devfreq/governor_performance.c        |   24 +++++
 drivers/devfreq/governor_powersave.c          |   24 +++++
 drivers/devfreq/governor_simpleondemand.c     |   88 ++++++++++++++++++
 drivers/devfreq/governor_userspace.c          |  119 +++++++++++++++++++++++++
 include/linux/devfreq.h                       |   41 +++++++++
 8 files changed, 345 insertions(+), 0 deletions(-)
 create mode 100644 drivers/devfreq/governor_performance.c
 create mode 100644 drivers/devfreq/governor_powersave.c
 create mode 100644 drivers/devfreq/governor_simpleondemand.c
 create mode 100644 drivers/devfreq/governor_userspace.c

diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 57f4591..c7f6977 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -202,3 +202,12 @@ Description:
 		shows the requested polling interval of the corresponding
 		device. The values are represented in ms. If the value is less
 		than 1 jiffy, it is considered to be 0, which means no polling.
+
+What:		/sys/devices/.../power/devfreq_userspace_set_freq
+Date:		August 2011
+Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
+Description:
+		The /sys/devices/.../power/devfreq_userspace_set_freq sets
+		and shows the user specified frequency in kHz. This sysfs
+		entry is created and managed by userspace DEVFREQ governor.
+		If other governors are used, it won't be supported.
diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 1fb42de..643b055 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -34,6 +34,42 @@ menuconfig PM_DEVFREQ
 
 if PM_DEVFREQ
 
+comment "DEVFREQ Governors"
+
+config DEVFREQ_GOV_SIMPLE_ONDEMAND
+	bool "Simple Ondemand"
+	help
+	  Chooses frequency based on the recent load on the device. Works
+	  similar as ONDEMAND governor of CPUFREQ does. A device with
+	  Simple-Ondemand should be able to provide busy/total counter
+	  values that imply the usage rate. A device may provide tuned
+	  values to the governor with data field at devfreq_add_device().
+
+config DEVFREQ_GOV_PERFORMANCE
+	bool "Performance"
+	help
+	  Sets the frequency at the maximum available frequency.
+	  This governor always returns UINT_MAX as frequency so that
+	  the DEVFREQ framework returns the highest frequency available
+	  at any time.
+
+config DEVFREQ_GOV_POWERSAVE
+	bool "Powersave"
+	help
+	  Sets the frequency at the minimum available frequency.
+	  This governor always returns 0 as frequency so that
+	  the DEVFREQ framework returns the lowest frequency available
+	  at any time.
+
+config DEVFREQ_GOV_USERSPACE
+	bool "Userspace"
+	help
+	  Sets the frequency at the user specified one.
+	  This governor returns the user configured frequency if there
+	  has been an input to /sys/devices/.../power/devfreq_set_freq.
+	  Otherwise, the governor does not change the frequnecy
+	  given at the initialization.
+
 comment "DEVFREQ Drivers"
 
 endif # PM_DEVFREQ
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 168934a..4564a89 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -1 +1,5 @@
 obj-$(CONFIG_PM_DEVFREQ)	+= devfreq.o
+obj-$(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)	+= governor_simpleondemand.o
+obj-$(CONFIG_DEVFREQ_GOV_PERFORMANCE)	+= governor_performance.o
+obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+= governor_powersave.o
+obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
new file mode 100644
index 0000000..c47eff8
--- /dev/null
+++ b/drivers/devfreq/governor_performance.c
@@ -0,0 +1,24 @@
+/*
+ *  linux/drivers/devfreq/governor_performance.c
+ *
+ *  Copyright (C) 2011 Samsung Electronics
+ *	MyungJoo Ham <myungjoo.ham@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/devfreq.h>
+
+static int devfreq_performance_func(struct devfreq *df,
+				    unsigned long *freq)
+{
+	*freq = UINT_MAX; /* devfreq_do will run "floor" */
+	return 0;
+}
+
+struct devfreq_governor devfreq_performance = {
+	.name = "performance",
+	.get_target_freq = devfreq_performance_func,
+};
diff --git a/drivers/devfreq/governor_powersave.c b/drivers/devfreq/governor_powersave.c
new file mode 100644
index 0000000..4f128d8
--- /dev/null
+++ b/drivers/devfreq/governor_powersave.c
@@ -0,0 +1,24 @@
+/*
+ *  linux/drivers/devfreq/governor_powersave.c
+ *
+ *  Copyright (C) 2011 Samsung Electronics
+ *	MyungJoo Ham <myungjoo.ham@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/devfreq.h>
+
+static int devfreq_powersave_func(struct devfreq *df,
+				  unsigned long *freq)
+{
+	*freq = 0; /* devfreq_do will run "ceiling" to 0 */
+	return 0;
+}
+
+struct devfreq_governor devfreq_powersave = {
+	.name = "powersave",
+	.get_target_freq = devfreq_powersave_func,
+};
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
new file mode 100644
index 0000000..18fe8be
--- /dev/null
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -0,0 +1,88 @@
+/*
+ *  linux/drivers/devfreq/governor_simpleondemand.c
+ *
+ *  Copyright (C) 2011 Samsung Electronics
+ *	MyungJoo Ham <myungjoo.ham@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/errno.h>
+#include <linux/devfreq.h>
+#include <linux/math64.h>
+
+/* Default constants for DevFreq-Simple-Ondemand (DFSO) */
+#define DFSO_UPTHRESHOLD	(90)
+#define DFSO_DOWNDIFFERENCTIAL	(5)
+static int devfreq_simple_ondemand_func(struct devfreq *df,
+					unsigned long *freq)
+{
+	struct devfreq_dev_status stat;
+	int err = df->profile->get_dev_status(df->dev, &stat);
+	unsigned long long a, b;
+	unsigned int dfso_upthreshold = DFSO_UPTHRESHOLD;
+	unsigned int dfso_downdifferential = DFSO_DOWNDIFFERENCTIAL;
+	struct devfreq_simple_ondemand_data *data = df->data;
+
+	if (err)
+		return err;
+
+	if (data) {
+		if (data->upthreshold)
+			dfso_upthreshold = data->upthreshold;
+		if (data->downdifferential)
+			dfso_downdifferential = data->downdifferential;
+	}
+	if (dfso_upthreshold > 100 ||
+	    dfso_upthreshold < dfso_downdifferential)
+		return -EINVAL;
+
+	/* Assume MAX if it is going to be divided by zero */
+	if (stat.total_time == 0) {
+		*freq = UINT_MAX;
+		return 0;
+	}
+
+	/* Prevent overflow */
+	if (stat.busy_time >= (1 << 24) || stat.total_time >= (1 << 24)) {
+		stat.busy_time >>= 7;
+		stat.total_time >>= 7;
+	}
+
+	/* Set MAX if it's busy enough */
+	if (stat.busy_time * 100 >
+	    stat.total_time * dfso_upthreshold) {
+		*freq = UINT_MAX;
+		return 0;
+	}
+
+	/* Set MAX if we do not know the initial frequency */
+	if (stat.current_frequency == 0) {
+		*freq = UINT_MAX;
+		return 0;
+	}
+
+	/* Keep the current frequency */
+	if (stat.busy_time * 100 >
+	    stat.total_time * (dfso_upthreshold - dfso_downdifferential)) {
+		*freq = stat.current_frequency;
+		return 0;
+	}
+
+	/* Set the desired frequency based on the load */
+	a = stat.busy_time;
+	a *= stat.current_frequency;
+	b = div_u64(a, stat.total_time);
+	b *= 100;
+	b = div_u64(b, (dfso_upthreshold - dfso_downdifferential / 2));
+	*freq = (unsigned long) b;
+
+	return 0;
+}
+
+struct devfreq_governor devfreq_simple_ondemand = {
+	.name = "simple_ondemand",
+	.get_target_freq = devfreq_simple_ondemand_func,
+};
diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
new file mode 100644
index 0000000..53a4574
--- /dev/null
+++ b/drivers/devfreq/governor_userspace.c
@@ -0,0 +1,119 @@
+/*
+ *  linux/drivers/devfreq/governor_simpleondemand.c
+ *
+ *  Copyright (C) 2011 Samsung Electronics
+ *	MyungJoo Ham <myungjoo.ham@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/devfreq.h>
+#include <linux/pm.h>
+#include "governor.h"
+
+struct userspace_data {
+	unsigned long user_frequency;
+	bool valid;
+};
+
+static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
+{
+	struct userspace_data *data = df->data;
+
+	if (!data->valid)
+		*freq = df->previous_freq; /* No user freq specified yet */
+	else
+		*freq = data->user_frequency;
+	return 0;
+}
+
+static ssize_t store_freq(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct devfreq *devfreq = get_devfreq(dev);
+	struct userspace_data *data;
+	unsigned long wanted;
+	int err = 0;
+
+	if (IS_ERR(devfreq)) {
+		err = PTR_ERR(devfreq);
+		goto out;
+	}
+	data = devfreq->data;
+
+	sscanf(buf, "%lu", &wanted);
+	data->user_frequency = wanted;
+	data->valid = true;
+	err = update_devfreq(devfreq);
+	if (err == 0)
+		err = count;
+out:
+	return err;
+}
+
+static ssize_t show_freq(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct devfreq *devfreq = get_devfreq(dev);
+	struct userspace_data *data;
+	int err = 0;
+
+	if (IS_ERR(devfreq)) {
+		err = PTR_ERR(devfreq);
+		goto out;
+	}
+	data = devfreq->data;
+
+	if (data->valid)
+		err = sprintf(buf, "%lu\n", data->user_frequency);
+	else
+		err = sprintf(buf, "undefined\n");
+out:
+	return err;
+}
+
+static DEVICE_ATTR(devfreq_userspace_set_freq, 0644, show_freq, store_freq);
+static struct attribute *dev_entries[] = {
+	&dev_attr_devfreq_userspace_set_freq.attr,
+	NULL,
+};
+static struct attribute_group dev_attr_group = {
+	.name	= power_group_name,
+	.attrs	= dev_entries,
+};
+
+static int userspace_init(struct devfreq *devfreq)
+{
+	int err = 0;
+	struct userspace_data *data = kzalloc(sizeof(struct userspace_data),
+					      GFP_KERNEL);
+
+	if (!data) {
+		err = -ENOMEM;
+		goto out;
+	}
+	data->valid = false;
+	devfreq->data = data;
+
+	sysfs_merge_group(&devfreq->dev->kobj, &dev_attr_group);
+out:
+	return err;
+}
+
+static void userspace_exit(struct devfreq *devfreq)
+{
+	sysfs_unmerge_group(&devfreq->dev->kobj, &dev_attr_group);
+	kfree(devfreq->data);
+	devfreq->data = NULL;
+}
+
+struct devfreq_governor devfreq_userspace = {
+	.name = "userspace",
+	.get_target_freq = devfreq_userspace_func,
+	.init = userspace_init,
+	.exit = userspace_exit,
+};
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index fdc6916..cbafcdf 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -13,6 +13,7 @@
 #ifndef __LINUX_DEVFREQ_H__
 #define __LINUX_DEVFREQ_H__
 
+#include <linux/opp.h>
 #include <linux/notifier.h>
 
 #define DEVFREQ_NAME_LEN 16
@@ -65,6 +66,8 @@ struct devfreq_governor {
  *			"devfreq_monitor" executions to reevaluate
  *			frequency/voltage of the device. Set by
  *			profile's polling_ms interval.
+ * @user_set_freq	User specified adequete frequency value (thru sysfs
+ *		interface). Governors may and may not use this value.
  * @data	Private data of the governor. The devfreq framework does not
  *		touch this.
  *
@@ -82,6 +85,7 @@ struct devfreq {
 	unsigned long previous_freq;
 	unsigned int next_polling;
 
+	unsigned long user_set_freq; /* governors may ignore this. */
 	void *data; /* private data for governors */
 };
 
@@ -91,6 +95,37 @@ extern int devfreq_add_device(struct device *dev,
 			   struct devfreq_governor *governor,
 			   void *data);
 extern int devfreq_remove_device(struct device *dev);
+
+#ifdef CONFIG_DEVFREQ_GOV_POWERSAVE
+extern struct devfreq_governor devfreq_powersave;
+#endif
+#ifdef CONFIG_DEVFREQ_GOV_PERFORMANCE
+extern struct devfreq_governor devfreq_performance;
+#endif
+#ifdef CONFIG_DEVFREQ_GOV_USERSPACE
+extern struct devfreq_governor devfreq_userspace;
+#endif
+#ifdef CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND
+extern struct devfreq_governor devfreq_simple_ondemand;
+/**
+ * struct devfreq_simple_ondemand_data - void *data fed to struct devfreq
+ *	and devfreq_add_device
+ * @ upthreshold	If the load is over this value, the frequency jumps.
+ *			Specify 0 to use the default. Valid value = 0 to 100.
+ * @ downdifferential	If the load is under upthreshold - downdifferential,
+ *			the governor may consider slowing the frequency down.
+ *			Specify 0 to use the default. Valid value = 0 to 100.
+ *			downdifferential < upthreshold must hold.
+ *
+ * If the fed devfreq_simple_ondemand_data pointer is NULL to the governor,
+ * the governor uses the default values.
+ */
+struct devfreq_simple_ondemand_data {
+	unsigned int upthreshold;
+	unsigned int downdifferential;
+};
+#endif
+
 #else /* !CONFIG_PM_DEVFREQ */
 static int devfreq_add_device(struct device *dev,
 			   struct devfreq_dev_profile *profile,
@@ -104,6 +139,12 @@ static int devfreq_remove_device(struct device *dev)
 {
 	return 0;
 }
+
+#define devfreq_powersave	NULL
+#define devfreq_performance	NULL
+#define devfreq_userspace	NULL
+#define devfreq_simple_ondemand	NULL
+
 #endif /* CONFIG_PM_DEVFREQ */
 
 #endif /* __LINUX_DEVFREQ_H__ */
-- 
1.7.4.1
