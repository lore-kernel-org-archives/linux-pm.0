From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v6-resubmit of 2/4] PM: Introduce DEVFREQ:
 generic DVFS framework with device-specific OPPs
Date: Fri, 19 Aug 2011 17:30:09 +0900
Message-ID: <1313742609-3446-1-git-send-email-myungjoo.ham@samsung.com>
References: <CAJOA=zPyG5Yn1bBR1sPxhsEh=n_+_4+whGWy4fKEzNbTvUvhkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <CAJOA=zPyG5Yn1bBR1sPxhsEh=n_+_4+whGWy4fKEzNbTvUvhkA@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, Mike Turquette <mturquette@ti.com>
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

With OPPs, a device may have multiple operable frequency and voltage
sets. However, there can be multiple possible operable sets and a system
will need to choose one from them. In order to reduce the power
consumption (by reducing frequency and voltage) without affecting the
performance too much, a Dynamic Voltage and Frequency Scaling (DVFS)
scheme may be used.

This patch introduces the DVFS capability to non-CPU devices with OPPs.
DVFS is a techique whereby the frequency and supplied voltage of a
device is adjusted on-the-fly. DVFS usually sets the frequency as low
as possible with given conditions (such as QoS assurance) and adjusts
voltage according to the chosen frequency in order to reduce power
consumption and heat dissipation.

The generic DVFS for devices, DEVFREQ, may appear quite similar with
/drivers/cpufreq.  However, CPUFREQ does not allow to have multiple
devices registered and is not suitable to have multiple heterogenous
devices with different (but simple) governors.

Normally, DVFS mechanism controls frequency based on the demand for
the device, and then, chooses voltage based on the chosen frequency.
DEVFREQ also controls the frequency based on the governor's frequency
recommendation and let OPP pick up the pair of frequency and voltage
based on the recommended frequency. Then, the chosen OPP is passed to
device driver's "target" callback.

When PM QoS is going to be used with the DEVFREQ device, the device
driver should enable OPPs that are appropriate with the current PM QoS
requests. In order to do so, the device driver may call opp_enable and
opp_disable at the notifier callback of PM QoS so that PM QoS's
update_target() call enables the appropriate OPPs. Note that at least
one of OPPs should be enabled at any time; be careful when there is a
transition.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

---
The test code with board support for Exynos4-NURI is at
http://git.infradead.org/users/kmpark/linux-2.6-samsung/shortlog/refs/heads/devfreq

---
Thank you for your valuable comments, Rafael, Greg, Pavel, Colin, Mike,
and Kevin.

Changes at v6-resubmit from v6
- Use jiffy directly instead of ktime
- Be prepared for profile->polling_ms changes (not supported fully at
  this stage)

Changes from v5
- Uses OPP availability change notifier
- Removed devfreq_interval. Uses one jiffy instead. DEVFREQ adjusts
  polling interval based on the interval requirement of DEVFREQ
  devices.
- Moved devfreq to /drivers/devfreq to accomodate devfreq-related files
  including governors and devfreq drivers.
- Coding style revised.
- Updated devfreq_add_device interface to get tunable values.

Changed from v4
- Removed tickle, which is a duplicated feature; PM QoS can do the same.
- Allow to extend polling interval if devices have longer polling intervals.
- Relocated private data of governors.
- Removed system-wide sysfs

Changed from v3
- In kerneldoc comments, DEVFREQ has ben replaced by devfreq
- Revised removing devfreq entries with error mechanism
- Added and revised comments
- Removed unnecessary codes
- Allow to give a name to a governor
- Bugfix: a tickle call may cancel an older tickle call that is still in
  effect.

Changed from v2
- Code style revised and cleaned up.
- Remove DEVFREQ entries that incur errors except for EAGAIN
- Bug fixed: tickle for devices without polling governors

Changes from v1(RFC)
- Rename: DVFS --> DEVFREQ
- Revised governor design
	. Governor receives the whole struct devfreq
	. Governor should gather usage information (thru get_dev_status) itself
- Periodic monitoring runs only when needed.
- DEVFREQ no more deals with voltage information directly
- Removed some printks.
- Some cosmetics update
- Use freezable_wq.
---
 drivers/Kconfig           |    2 +
 drivers/Makefile          |    2 +
 drivers/devfreq/Kconfig   |   39 ++++++
 drivers/devfreq/Makefile  |    1 +
 drivers/devfreq/devfreq.c |  312 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/devfreq.h   |  111 ++++++++++++++++
 6 files changed, 467 insertions(+), 0 deletions(-)
 create mode 100644 drivers/devfreq/Kconfig
 create mode 100644 drivers/devfreq/Makefile
 create mode 100644 drivers/devfreq/devfreq.c
 create mode 100644 include/linux/devfreq.h

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 95b9e7e..a1efd75 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -130,4 +130,6 @@ source "drivers/iommu/Kconfig"
 
 source "drivers/virt/Kconfig"
 
+source "drivers/devfreq/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 7fa433a..97c957b 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -127,3 +127,5 @@ obj-$(CONFIG_IOMMU_SUPPORT)	+= iommu/
 
 # Virtualization drivers
 obj-$(CONFIG_VIRT_DRIVERS)	+= virt/
+
+obj-$(CONFIG_PM_DEVFREQ)	+= devfreq/
diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
new file mode 100644
index 0000000..1fb42de
--- /dev/null
+++ b/drivers/devfreq/Kconfig
@@ -0,0 +1,39 @@
+config ARCH_HAS_DEVFREQ
+	bool
+	depends on ARCH_HAS_OPP
+	help
+	  Denotes that the architecture supports DEVFREQ. If the architecture
+	  supports multiple OPP entries per device and the frequency of the
+	  devices with OPPs may be altered dynamically, the architecture
+	  supports DEVFREQ.
+
+menuconfig PM_DEVFREQ
+	bool "Generic Dynamic Voltage and Frequency Scaling (DVFS) support"
+	depends on PM_OPP && ARCH_HAS_DEVFREQ
+	help
+	  With OPP support, a device may have a list of frequencies and
+	  voltages available. DEVFREQ, a generic DVFS framework can be
+	  registered for a device with OPP support in order to let the
+	  governor provided to DEVFREQ choose an operating frequency
+	  based on the OPP's list and the policy given with DEVFREQ.
+
+	  Each device may have its own governor and policy. DEVFREQ can
+	  reevaluate the device state periodically and/or based on the
+	  OPP list changes (each frequency/voltage pair in OPP may be
+	  disabled or enabled).
+
+	  Like some CPUs with CPUFREQ, a device may have multiple clocks.
+	  However, because the clock frequencies of a single device are
+	  determined by the single device's state, an instance of DEVFREQ
+	  is attached to a single device and returns a "representative"
+	  clock frequency from the OPP of the device, which is also attached
+	  to a device by 1-to-1. The device registering DEVFREQ takes the
+	  responsiblity to "interpret" the frequency listed in OPP and
+	  to set its every clock accordingly with the "target" callback
+	  given to DEVFREQ.
+
+if PM_DEVFREQ
+
+comment "DEVFREQ Drivers"
+
+endif # PM_DEVFREQ
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
new file mode 100644
index 0000000..168934a
--- /dev/null
+++ b/drivers/devfreq/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_PM_DEVFREQ)	+= devfreq.o
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
new file mode 100644
index 0000000..af848ffa
--- /dev/null
+++ b/drivers/devfreq/devfreq.c
@@ -0,0 +1,312 @@
+/*
+ * devfreq: Generic Dynamic Voltage and Frequency Scaling (DVFS) Framework
+ *	    for Non-CPU Devices Based on OPP.
+ *
+ * Copyright (C) 2011 Samsung Electronics
+ *	MyungJoo Ham <myungjoo.ham@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/opp.h>
+#include <linux/devfreq.h>
+#include <linux/workqueue.h>
+#include <linux/platform_device.h>
+#include <linux/list.h>
+#include <linux/printk.h>
+#include <linux/hrtimer.h>
+
+/*
+ * devfreq_work periodically monitors every registered device.
+ * The minimum polling interval is one jiffy. The polling interval is
+ * determined by the minimum polling period among all polling devfreq
+ * devices. The resolution of polling interval is one jiffy.
+ */
+static bool polling;
+static struct workqueue_struct *devfreq_wq;
+static struct delayed_work devfreq_work;
+
+/* The list of all device-devfreq */
+static LIST_HEAD(devfreq_list);
+static DEFINE_MUTEX(devfreq_list_lock);
+
+/**
+ * find_device_devfreq() - find devfreq struct using device pointer
+ * @dev:	device pointer used to lookup device devfreq.
+ *
+ * Search the list of device devfreqs and return the matched device's
+ * devfreq info. devfreq_list_lock should be held by the caller.
+ */
+static struct devfreq *find_device_devfreq(struct device *dev)
+{
+	struct devfreq *tmp_devfreq;
+
+	if (unlikely(IS_ERR_OR_NULL(dev))) {
+		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	list_for_each_entry(tmp_devfreq, &devfreq_list, node) {
+		if (tmp_devfreq->dev == dev)
+			return tmp_devfreq;
+	}
+
+	return ERR_PTR(-ENODEV);
+}
+
+/**
+ * devfreq_do() - Check the usage profile of a given device and configure
+ *		frequency and voltage accordingly
+ * @devfreq:	devfreq info of the given device
+ */
+static int devfreq_do(struct devfreq *devfreq)
+{
+	struct opp *opp;
+	unsigned long freq;
+	int err;
+
+	err = devfreq->governor->get_target_freq(devfreq, &freq);
+	if (err)
+		return err;
+
+	opp = opp_find_freq_ceil(devfreq->dev, &freq);
+	if (opp == ERR_PTR(-ENODEV))
+		opp = opp_find_freq_floor(devfreq->dev, &freq);
+
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
+	if (devfreq->previous_freq == freq)
+		return 0;
+
+	err = devfreq->profile->target(devfreq->dev, opp);
+	if (err)
+		return err;
+
+	devfreq->previous_freq = freq;
+	return 0;
+}
+
+/**
+ * devfreq_update() - Notify that the device OPP has been changed.
+ * @dev:	the device whose OPP has been changed.
+ */
+static int devfreq_update(struct notifier_block *nb, unsigned long type,
+			  void *devp)
+{
+	struct devfreq *devfreq;
+	int err = 0;
+
+	mutex_lock(&devfreq_list_lock);
+	devfreq = container_of(nb, struct devfreq, nb);
+	/* Reevaluate the proper frequency */
+	err = devfreq_do(devfreq);
+	mutex_unlock(&devfreq_list_lock);
+	return err;
+}
+
+/**
+ * devfreq_monitor() - Periodically run devfreq_do()
+ * @work: the work struct used to run devfreq_monitor periodically.
+ *
+ */
+static void devfreq_monitor(struct work_struct *work)
+{
+	static unsigned long last_polled_at;
+	struct devfreq *devfreq, *tmp;
+	int error;
+	int jiffies_passed;
+	unsigned long next_jiffies = ULONG_MAX, now = jiffies;
+
+	/* Initially last_polled_at = 0, polling every device at bootup */
+	jiffies_passed = now - last_polled_at;
+	last_polled_at = now;
+
+	if (jiffies_passed == 0)
+		jiffies_passed = 1;
+	if (jiffies_passed < 0) /* "Infinite Timeout" */
+		jiffies_passed = INT_MAX;
+
+	mutex_lock(&devfreq_list_lock);
+
+	list_for_each_entry_safe(devfreq, tmp, &devfreq_list, node) {
+		/* Reflect the changes in profile->polling_ms */
+		if (devfreq->polling_ms != devfreq->profile->polling_ms) {
+			devfreq->polling_ms = devfreq->profile->polling_ms;
+			devfreq->polling_jiffies = msecs_to_jiffies(
+					devfreq->polling_ms);
+			if (devfreq->next_polling == 0 &&
+			    devfreq->polling_jiffies)
+				devfreq->next_polling = 1; /* Poll Now */
+			else if (devfreq->polling_jiffies == 0)
+				devfreq->next_polling = 0; /* Stop Polling */
+		}
+		if (devfreq->next_polling == 0)
+			continue;
+
+		/*
+		 * Reduce more next_polling if devfreq_wq took an extra
+		 * delay. (i.e., CPU has been idled.)
+		 */
+		if (devfreq->next_polling <= jiffies_passed) {
+			error = devfreq_do(devfreq);
+
+			/* Remove a devfreq with an error. */
+			if (error && error != -EAGAIN) {
+				dev_err(devfreq->dev, "Due to devfreq_do error(%d), devfreq(%s) is removed from the device\n",
+					error, devfreq->governor->name);
+
+				list_del(&devfreq->node);
+				kfree(devfreq);
+
+				continue;
+			}
+			devfreq->next_polling = devfreq->polling_jiffies;
+
+			/* No more polling required (polling_ms changed) */
+			if (devfreq->next_polling == 0)
+				continue;
+		} else {
+			devfreq->next_polling -= jiffies_passed;
+		}
+
+		next_jiffies = (next_jiffies > devfreq->next_polling) ?
+				devfreq->next_polling : next_jiffies;
+	}
+
+	if (next_jiffies > 0 && next_jiffies < ULONG_MAX) {
+		polling = true;
+		queue_delayed_work(devfreq_wq, &devfreq_work, next_jiffies);
+	} else {
+		polling = false;
+	}
+
+	mutex_unlock(&devfreq_list_lock);
+}
+
+/**
+ * devfreq_add_device() - Add devfreq feature to the device
+ * @dev:	the device to add devfreq feature.
+ * @profile:	device-specific profile to run devfreq.
+ * @governor:	the policy to choose frequency.
+ * @data:	private data for the governor. The devfreq framework does not
+ *		touch this value.
+ */
+int devfreq_add_device(struct device *dev, struct devfreq_dev_profile *profile,
+		       struct devfreq_governor *governor, void *data)
+{
+	struct devfreq *devfreq;
+	struct srcu_notifier_head *nh;
+	int err = 0;
+
+	if (!dev || !profile || !governor) {
+		dev_err(dev, "%s: Invalid parameters.\n", __func__);
+		return -EINVAL;
+	}
+
+	mutex_lock(&devfreq_list_lock);
+
+	devfreq = find_device_devfreq(dev);
+	if (!IS_ERR(devfreq)) {
+		dev_err(dev, "%s: Unable to create devfreq for the device. It already has one.\n", __func__);
+		err = -EINVAL;
+		goto out;
+	}
+
+	devfreq = kzalloc(sizeof(struct devfreq), GFP_KERNEL);
+	if (!devfreq) {
+		dev_err(dev, "%s: Unable to create devfreq for the device\n",
+			__func__);
+		err = -ENOMEM;
+		goto out;
+	}
+
+	devfreq->dev = dev;
+	devfreq->profile = profile;
+	devfreq->governor = governor;
+	devfreq->polling_ms = profile->polling_ms;
+	devfreq->next_polling = devfreq->polling_jiffies
+			      = msecs_to_jiffies(devfreq->polling_ms);
+	devfreq->previous_freq = profile->initial_freq;
+	devfreq->data = data;
+
+	devfreq->nb.notifier_call = devfreq_update;
+	nh = opp_get_notifier(dev);
+	if (IS_ERR(nh)) {
+		err = PTR_ERR(nh);
+		goto out;
+	}
+	err = srcu_notifier_chain_register(nh, &devfreq->nb);
+	if (err)
+		goto out;
+
+	list_add(&devfreq->node, &devfreq_list);
+
+	if (devfreq_wq && devfreq->next_polling && !polling) {
+		polling = true;
+		queue_delayed_work(devfreq_wq, &devfreq_work,
+				   devfreq->next_polling);
+	}
+out:
+	mutex_unlock(&devfreq_list_lock);
+
+	return err;
+}
+
+/**
+ * devfreq_remove_device() - Remove devfreq feature from a device.
+ * @device:	the device to remove devfreq feature.
+ */
+int devfreq_remove_device(struct device *dev)
+{
+	struct devfreq *devfreq;
+	struct srcu_notifier_head *nh;
+	int err = 0;
+
+	if (!dev)
+		return -EINVAL;
+
+	mutex_lock(&devfreq_list_lock);
+	devfreq = find_device_devfreq(dev);
+	if (IS_ERR(devfreq)) {
+		err = PTR_ERR(devfreq);
+		goto out;
+	}
+
+	nh = opp_get_notifier(dev);
+	if (IS_ERR(nh)) {
+		err = PTR_ERR(nh);
+		goto out;
+	}
+
+	list_del(&devfreq->node);
+	srcu_notifier_chain_unregister(nh, &devfreq->nb);
+	kfree(devfreq);
+out:
+	mutex_unlock(&devfreq_list_lock);
+	return 0;
+}
+
+/**
+ * devfreq_init() - Initialize data structure for devfreq framework and
+ *		  start polling registered devfreq devices.
+ */
+static int __init devfreq_init(void)
+{
+	mutex_lock(&devfreq_list_lock);
+	polling = false;
+	devfreq_wq = create_freezable_workqueue("devfreq_wq");
+	INIT_DELAYED_WORK_DEFERRABLE(&devfreq_work, devfreq_monitor);
+	mutex_unlock(&devfreq_list_lock);
+
+	devfreq_monitor(&devfreq_work.work);
+	return 0;
+}
+late_initcall(devfreq_init);
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
new file mode 100644
index 0000000..18e94cb
--- /dev/null
+++ b/include/linux/devfreq.h
@@ -0,0 +1,111 @@
+/*
+ * devfreq: Generic Dynamic Voltage and Frequency Scaling (DVFS) Framework
+ *	    for Non-CPU Devices Based on OPP.
+ *
+ * Copyright (C) 2011 Samsung Electronics
+ *	MyungJoo Ham <myungjoo.ham@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_DEVFREQ_H__
+#define __LINUX_DEVFREQ_H__
+
+#include <linux/notifier.h>
+
+#define DEVFREQ_NAME_LEN 16
+
+struct devfreq;
+struct devfreq_dev_status {
+	/* both since the last measure */
+	unsigned long total_time;
+	unsigned long busy_time;
+	unsigned long current_frequency;
+};
+
+struct devfreq_dev_profile {
+	unsigned long max_freq; /* may be larger than the actual value */
+	unsigned long initial_freq;
+	int polling_ms;	/* 0 for at opp change only */
+
+	int (*target)(struct device *dev, struct opp *opp);
+	int (*get_dev_status)(struct device *dev,
+			      struct devfreq_dev_status *stat);
+};
+
+/**
+ * struct devfreq_governor - Devfreq policy governor
+ * @name		Governor's name
+ * @get_target_freq	Returns desired operating frequency for the device.
+ *			Basically, get_target_freq will run
+ *			devfreq_dev_profile.get_dev_status() to get the
+ *			status of the device (load = busy_time / total_time).
+ */
+struct devfreq_governor {
+	char name[DEVFREQ_NAME_LEN];
+	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
+};
+
+/**
+ * struct devfreq - Device devfreq structure
+ * @node	list node - contains the devices with devfreq that have been
+ *		registered.
+ * @dev		device pointer
+ * @profile	device-specific devfreq profile
+ * @governor	method how to choose frequency based on the usage.
+ * @nb		notifier block registered to the corresponding OPP to get
+ *		notified for frequency availability updates.
+ * @polling_jiffies	interval in jiffies.
+ * @polling_ms		interval in ms. to compare with profile's polling_ms
+ *			and update polling_jiffies if the device has changed
+ *			the polling interval.
+ * @previous_freq	previously configured frequency value.
+ * @next_polling	the number of remaining jiffies to poll with
+ *			"devfreq_monitor" executions to reevaluate
+ *			frequency/voltage of the device. Set by
+ *			profile's polling_ms interval.
+ * @data	Private data of the governor. The devfreq framework does not
+ *		touch this.
+ *
+ * This structure stores the devfreq information for a give device.
+ */
+struct devfreq {
+	struct list_head node;
+
+	struct device *dev;
+	struct devfreq_dev_profile *profile;
+	struct devfreq_governor *governor;
+	struct notifier_block nb;
+
+	unsigned long polling_jiffies;
+	int polling_ms;
+	unsigned long previous_freq;
+	unsigned int next_polling;
+
+	void *data; /* private data for governors */
+};
+
+#if defined(CONFIG_PM_DEVFREQ)
+extern int devfreq_add_device(struct device *dev,
+			   struct devfreq_dev_profile *profile,
+			   struct devfreq_governor *governor,
+			   void *data);
+extern int devfreq_remove_device(struct device *dev);
+#else /* !CONFIG_PM_DEVFREQ */
+static int devfreq_add_device(struct device *dev,
+			   struct devfreq_dev_profile *profile,
+			   struct devfreq_governor *governor,
+			   void *data)
+{
+	return 0;
+}
+
+static int devfreq_remove_device(struct device *dev)
+{
+	return 0;
+}
+#endif /* CONFIG_PM_DEVFREQ */
+
+#endif /* __LINUX_DEVFREQ_H__ */
-- 
1.7.4.1
