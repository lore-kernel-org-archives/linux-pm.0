From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] thermal: Add debugfs support for cooling devices
Date: Thu,  4 Jan 2018 12:32:04 +0530
Message-ID: <0b1810c1dfae6a3ddadeffb60669f3108a02d860.1515049019.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This implements the debugfs interface for thermal cooling devices and
exposes some pretty useful statistics. These statistics have proven to
be quite useful specially while doing benchmarks related to the task
scheduler, where we want to make sure that nothing has disrupted the
test, specially the cooling device which may have put constraints on the
CPUs. The information exposed here tells us to what extent the CPUs were
constrained by the thermal framework.

The read-only "transitions" file is per cooling device and it shows the
total number of cooling state transitions the device has gone through
since the time the cooling device is registered or the time when
statistics were reset last.

The read-only "time_in_state/stateN" file is per cooling state and it
shows the time spent by the device in the respective cooling state.

The write-only "reset" file is used to reset the statistics.

This is how the directory structure looks like for a single cooling
device:

$ ls -R /sys/kernel/debug/thermal/
/sys/kernel/debug/thermal/:
cooling_device0

/sys/kernel/debug/thermal/cooling_device0:
reset  time_in_state_ms  transitions

/sys/kernel/debug/thermal/cooling_device0/time_in_state_ms:
state0  state1  state2  state3

This is tested on ARM 32-bit Hisilicon hikey620 board running Ubuntu and
ARM 64-bit Hisilicon hikey960 board running Android.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/Makefile          |   1 +
 drivers/thermal/thermal_core.c    |   6 ++
 drivers/thermal/thermal_core.h    |  18 ++++
 drivers/thermal/thermal_debugfs.c | 167 ++++++++++++++++++++++++++++++++++++++
 drivers/thermal/thermal_helpers.c |   5 +-
 drivers/thermal/thermal_sysfs.c   |   1 +
 include/linux/thermal.h           |   1 +
 7 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/thermal_debugfs.c

diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 610344eb3e03..629f74e73871 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_THERMAL)		+= thermal_sys.o
 thermal_sys-y			+= thermal_core.o thermal_sysfs.o \
 					thermal_helpers.o
+obj-$(CONFIG_DEBUG_FS)		+= thermal_debugfs.o
 
 # interface to/from other layers providing sensors
 thermal_sys-$(CONFIG_THERMAL_HWMON)		+= thermal_hwmon.o
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2b1b0ba393a4..bcc34648580f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -997,6 +997,8 @@ __thermal_cooling_device_register(struct device_node *np,
 						   THERMAL_EVENT_UNSPECIFIED);
 	mutex_unlock(&thermal_list_lock);
 
+	thermal_cooling_device_setup_debugfs(cdev);
+
 	return cdev;
 }
 
@@ -1104,6 +1106,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 
 	mutex_unlock(&thermal_list_lock);
 
+	thermal_cooling_device_remove_debugfs(cdev);
 	ida_simple_remove(&thermal_cdev_ida, cdev->id);
 	device_unregister(&cdev->device);
 }
@@ -1544,6 +1547,8 @@ static int __init thermal_init(void)
 		pr_warn("Thermal: Can not register suspend notifier, return %d\n",
 			result);
 
+	thermal_debugfs_register();
+
 	return 0;
 
 exit_netlink:
@@ -1563,6 +1568,7 @@ static int __init thermal_init(void)
 
 static void __exit thermal_exit(void)
 {
+	thermal_debugfs_unregister();
 	unregister_pm_notifier(&thermal_pm_nb);
 	of_thermal_destroy_zones();
 	genetlink_exit();
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 27e3b1df7360..3a8d50aa32dc 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -151,4 +151,22 @@ of_thermal_get_trip_points(struct thermal_zone_device *tz)
 }
 #endif
 
+#ifdef CONFIG_DEBUG_FS
+void thermal_debugfs_register(void);
+void thermal_debugfs_unregister(void);
+void thermal_cooling_device_setup_debugfs(struct thermal_cooling_device *cdev);
+void thermal_cooling_device_remove_debugfs(struct thermal_cooling_device *cdev);
+void thermal_cooling_device_debugfs_update(struct thermal_cooling_device *cdev,
+					   unsigned long new_state);
+#else
+static inline void thermal_debugfs_register(void) {}
+static inline void thermal_debugfs_unregister(void) {}
+static inline void
+thermal_cooling_device_setup_debugfs(struct thermal_cooling_device *cdev) {}
+static inline void
+thermal_cooling_device_remove_debugfs(struct thermal_cooling_device *cdev) {}
+static inline void
+thermal_cooling_device_debugfs_update(struct thermal_cooling_device *cdev,
+				      unsigned long new_state) {}
+#endif /* debugfs */
 #endif /* __THERMAL_CORE_H__ */
diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_debugfs.c
new file mode 100644
index 000000000000..077684197250
--- /dev/null
+++ b/drivers/thermal/thermal_debugfs.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Manages debugfs interface for thermal devices.
+ *
+ * Copyright (C) 2018 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+#include <linux/device.h>
+#include <linux/debugfs.h>
+#include <linux/ktime.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include "thermal_core.h"
+
+struct cooling_time_in_state {
+	ktime_t time;
+	struct cooling_dev_debugfs_data *data;
+};
+
+struct cooling_dev_debugfs_data {
+	struct dentry *dentry;
+	unsigned int total_trans;
+	unsigned long state;
+	unsigned long max_states;
+	ktime_t last_time;
+	struct cooling_time_in_state *time_in_state;
+};
+
+static struct dentry *rootdir;
+static DEFINE_SPINLOCK(lock);
+
+static void update_time_in_state(struct cooling_dev_debugfs_data *data)
+{
+	ktime_t now = ktime_get(), delta;
+
+	delta = ktime_sub(now, data->last_time);
+	data->time_in_state[data->state].time =
+		ktime_add(data->time_in_state[data->state].time, delta);
+	data->last_time = now;
+}
+
+void thermal_cooling_device_debugfs_update(struct thermal_cooling_device *cdev,
+					   unsigned long new_state)
+{
+	struct cooling_dev_debugfs_data *data = cdev->debugfs;
+
+	if (!data)
+		return;
+
+	spin_lock(&lock);
+	update_time_in_state(data);
+	data->state = new_state;
+	data->total_trans++;
+	spin_unlock(&lock);
+}
+
+static int read_time_in_state(void *ptr, u64 *val)
+{
+	struct cooling_time_in_state *time_in_state = ptr;
+
+	spin_lock(&lock);
+	update_time_in_state(time_in_state->data);
+	*val = ktime_to_ms(time_in_state->time);
+	spin_unlock(&lock);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(time_in_state_fops, read_time_in_state, NULL, "%llu\n");
+
+static int reset_stats(void *ptr, u64 val)
+{
+	struct cooling_dev_debugfs_data *data = ptr;
+	int i;
+
+	spin_lock(&lock);
+
+	data->total_trans = 0;
+	data->last_time = ktime_get();
+
+	for (i = 0; i < data->max_states; i++)
+		data->time_in_state[i].time = ktime_set(0, 0);
+
+	spin_unlock(&lock);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(reset_fops, NULL, reset_stats, "%llu\n");
+
+void thermal_cooling_device_setup_debugfs(struct thermal_cooling_device *cdev)
+{
+	struct cooling_dev_debugfs_data *data;
+	struct dentry *dentry;
+	unsigned long states;
+	int ret, size, i;
+	char name[NAME_MAX];
+
+	ret = cdev->ops->get_max_state(cdev, &states);
+	if (ret)
+		return;
+
+	size = sizeof(*data);
+	size += sizeof(*data->time_in_state) * states;
+
+	data = kzalloc(size, GFP_KERNEL);
+	if (!data)
+		return;
+
+	data->time_in_state = (struct cooling_time_in_state *)(data + 1);
+	cdev->debugfs = data;
+	data->last_time = ktime_get();
+	data->max_states = states;
+
+	data->dentry = debugfs_create_dir(dev_name(&cdev->device), rootdir);
+	if (!data->dentry)
+		goto free_data;
+
+	debugfs_create_file_unsafe("reset", 0666, data->dentry, data, &reset_fops);
+	debugfs_create_u32("transitions", 0444, data->dentry,
+			   &data->total_trans);
+
+	dentry = debugfs_create_dir("time_in_state_ms", data->dentry);
+	if (!dentry)
+		goto free_data_dentry;
+
+	for (i = 0; i < states; i++) {
+		data->time_in_state[i].data = data;
+		snprintf(name, NAME_MAX, "state%u", i);
+		debugfs_create_file_unsafe(name, 0444, dentry,
+					   &data->time_in_state[i],
+					   &time_in_state_fops);
+	}
+
+	return;
+
+free_data_dentry:
+	debugfs_remove_recursive(data->dentry);
+free_data:
+	kfree(data);
+	cdev->debugfs = NULL;
+}
+
+void thermal_cooling_device_remove_debugfs(struct thermal_cooling_device *cdev)
+{
+	struct cooling_dev_debugfs_data *data = cdev->debugfs;
+
+	if (!data)
+		return;
+
+	debugfs_remove_recursive(data->dentry);
+	kfree(data);
+	cdev->debugfs = NULL;
+}
+
+void thermal_debugfs_register(void)
+{
+	rootdir = debugfs_create_dir("thermal", NULL);
+}
+
+void thermal_debugfs_unregister(void)
+{
+	debugfs_remove_recursive(rootdir);
+	rootdir = NULL;
+}
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 8cdf75adcce1..8cfb2f4e7ea3 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -187,7 +187,10 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 		if (instance->target > target)
 			target = instance->target;
 	}
-	cdev->ops->set_cur_state(cdev, target);
+
+	if (!cdev->ops->set_cur_state(cdev, target))
+		thermal_cooling_device_debugfs_update(cdev, target);
+
 	cdev->updated = true;
 	mutex_unlock(&cdev->lock);
 	trace_cdev_update(cdev, target);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index fb80c96d8f73..be997ce3f32d 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -722,6 +722,7 @@ thermal_cooling_device_cur_state_store(struct device *dev,
 	result = cdev->ops->set_cur_state(cdev, state);
 	if (result)
 		return result;
+	thermal_cooling_device_debugfs_update(cdev, state);
 	return count;
 }
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 8c5302374eaa..338d165cefef 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -148,6 +148,7 @@ struct thermal_cooling_device {
 	struct device device;
 	struct device_node *np;
 	void *devdata;
+	void *debugfs;
 	const struct thermal_cooling_device_ops *ops;
 	bool updated; /* true if the cooling device does not need update */
 	struct mutex lock; /* protect thermal_instances list */
-- 
2.15.0.194.g9af6a3dea062
