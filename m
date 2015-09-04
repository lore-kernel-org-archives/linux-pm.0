From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 5/6] PM / OPP: Move cpu specific code to opp/cpu.c
Date: Fri,  4 Sep 2015 13:47:26 +0530
Message-ID: <aded473010f24c779e9ca4a25ee467042943f8be.1441354424.git.viresh.kumar@linaro.org>
References: <cover.1441354424.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1441354424.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1441354424.git.viresh.kumar@linaro.org>
References: <cover.1441354424.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, Anand Moon <moon.linux@yahoo.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Move cpu device specific code out of generic opp library, and add it to
cpu.c.

Along with that, create a core-internal opp.h header, which will be used
to share structures and function prototypes within opp core.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 276 +-----------------------------------------
 drivers/base/power/opp/cpu.c  | 160 +++++++++++++++++++++++-
 drivers/base/power/opp/opp.h  | 143 ++++++++++++++++++++++
 3 files changed, 304 insertions(+), 275 deletions(-)
 create mode 100644 drivers/base/power/opp/opp.h

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index f42ffa517156..f475deb4170b 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -11,131 +11,14 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/cpu.h>
-#include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/device.h>
-#include <linux/list.h>
-#include <linux/rculist.h>
-#include <linux/rcupdate.h>
-#include <linux/pm_opp.h>
 #include <linux/of.h>
 #include <linux/export.h>
 
-/*
- * Internal data structure organization with the OPP layer library is as
- * follows:
- * dev_opp_list (root)
- *	|- device 1 (represents voltage domain 1)
- *	|	|- opp 1 (availability, freq, voltage)
- *	|	|- opp 2 ..
- *	...	...
- *	|	`- opp n ..
- *	|- device 2 (represents the next voltage domain)
- *	...
- *	`- device m (represents mth voltage domain)
- * device 1, 2.. are represented by dev_opp structure while each opp
- * is represented by the opp structure.
- */
-
-/**
- * struct dev_pm_opp - Generic OPP description structure
- * @node:	opp list node. The nodes are maintained throughout the lifetime
- *		of boot. It is expected only an optimal set of OPPs are
- *		added to the library by the SoC framework.
- *		RCU usage: opp list is traversed with RCU locks. node
- *		modification is possible realtime, hence the modifications
- *		are protected by the dev_opp_list_lock for integrity.
- *		IMPORTANT: the opp nodes should be maintained in increasing
- *		order.
- * @dynamic:	not-created from static DT entries.
- * @available:	true/false - marks if this OPP as available or not
- * @turbo:	true if turbo (boost) OPP
- * @rate:	Frequency in hertz
- * @u_volt:	Target voltage in microvolts corresponding to this OPP
- * @u_volt_min:	Minimum voltage in microvolts corresponding to this OPP
- * @u_volt_max:	Maximum voltage in microvolts corresponding to this OPP
- * @u_amp:	Maximum current drawn by the device in microamperes
- * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
- *		frequency from any other OPP's frequency.
- * @dev_opp:	points back to the device_opp struct this opp belongs to
- * @rcu_head:	RCU callback head used for deferred freeing
- * @np:		OPP's device node.
- *
- * This structure stores the OPP information for a given device.
- */
-struct dev_pm_opp {
-	struct list_head node;
-
-	bool available;
-	bool dynamic;
-	bool turbo;
-	unsigned long rate;
-
-	unsigned long u_volt;
-	unsigned long u_volt_min;
-	unsigned long u_volt_max;
-	unsigned long u_amp;
-	unsigned long clock_latency_ns;
-
-	struct device_opp *dev_opp;
-	struct rcu_head rcu_head;
-
-	struct device_node *np;
-};
-
-/**
- * struct device_list_opp - devices managed by 'struct device_opp'
- * @node:	list node
- * @dev:	device to which the struct object belongs
- * @rcu_head:	RCU callback head used for deferred freeing
- *
- * This is an internal data structure maintaining the list of devices that are
- * managed by 'struct device_opp'.
- */
-struct device_list_opp {
-	struct list_head node;
-	const struct device *dev;
-	struct rcu_head rcu_head;
-};
-
-/**
- * struct device_opp - Device opp structure
- * @node:	list node - contains the devices with OPPs that
- *		have been registered. Nodes once added are not modified in this
- *		list.
- *		RCU usage: nodes are not modified in the list of device_opp,
- *		however addition is possible and is secured by dev_opp_list_lock
- * @srcu_head:	notifier head to notify the OPP availability changes.
- * @rcu_head:	RCU callback head used for deferred freeing
- * @dev_list:	list of devices that share these OPPs
- * @opp_list:	list of opps
- * @np:		struct device_node pointer for opp's DT node.
- * @shared_opp: OPP is shared between multiple devices.
- *
- * This is an internal data structure maintaining the link to opps attached to
- * a device. This structure is not meant to be shared to users as it is
- * meant for book keeping and private to OPP library.
- *
- * Because the opp structures can be used from both rcu and srcu readers, we
- * need to wait for the grace period of both of them before freeing any
- * resources. And so we have used kfree_rcu() from within call_srcu() handlers.
- */
-struct device_opp {
-	struct list_head node;
-
-	struct srcu_notifier_head srcu_head;
-	struct rcu_head rcu_head;
-	struct list_head dev_list;
-	struct list_head opp_list;
-
-	struct device_node *np;
-	unsigned long clock_latency_ns_max;
-	bool shared_opp;
-	struct dev_pm_opp *suspend_opp;
-};
+#include "opp.h"
 
 /*
  * The root of the list of all devices. All device_opp structures branch off
@@ -200,7 +83,7 @@ static struct device_opp *_managed_opp(const struct device_node *np)
  * is a RCU protected pointer. This means that device_opp is valid as long
  * as we are under RCU lock.
  */
-static struct device_opp *_find_device_opp(struct device *dev)
+struct device_opp *_find_device_opp(struct device *dev)
 {
 	struct device_opp *dev_opp;
 
@@ -551,8 +434,8 @@ static void _remove_list_dev(struct device_list_opp *list_dev,
 		  _kfree_list_dev_rcu);
 }
 
-static struct device_list_opp *_add_list_dev(const struct device *dev,
-					     struct device_opp *dev_opp)
+struct device_list_opp *_add_list_dev(const struct device *dev,
+				      struct device_opp *dev_opp)
 {
 	struct device_list_opp *list_dev;
 
@@ -1234,28 +1117,8 @@ void dev_pm_opp_of_remove_table(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 
-void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask)
-{
-	struct device *cpu_dev;
-	int cpu;
-
-	WARN_ON(cpumask_empty(cpumask));
-
-	for_each_cpu(cpu, cpumask) {
-		cpu_dev = get_cpu_device(cpu);
-		if (!cpu_dev) {
-			pr_err("%s: failed to get cpu%d device\n", __func__,
-			       cpu);
-			continue;
-		}
-
-		dev_pm_opp_of_remove_table(cpu_dev);
-	}
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_remove_table);
-
 /* Returns opp descriptor node for a device, caller must do of_node_put() */
-static struct device_node *_of_get_opp_desc_node(struct device *dev)
+struct device_node *_of_get_opp_desc_node(struct device *dev)
 {
 	/*
 	 * TODO: Support for multiple OPP tables.
@@ -1399,133 +1262,4 @@ int dev_pm_opp_of_add_table(struct device *dev)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table);
-
-int dev_pm_opp_of_cpumask_add_table(cpumask_var_t cpumask)
-{
-	struct device *cpu_dev;
-	int cpu, ret = 0;
-
-	WARN_ON(cpumask_empty(cpumask));
-
-	for_each_cpu(cpu, cpumask) {
-		cpu_dev = get_cpu_device(cpu);
-		if (!cpu_dev) {
-			pr_err("%s: failed to get cpu%d device\n", __func__,
-			       cpu);
-			continue;
-		}
-
-		ret = dev_pm_opp_of_add_table(cpu_dev);
-		if (ret) {
-			pr_err("%s: couldn't find opp table for cpu:%d, %d\n",
-			       __func__, cpu, ret);
-
-			/* Free all other OPPs */
-			dev_pm_opp_of_cpumask_remove_table(cpumask);
-			break;
-		}
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_add_table);
-
-/* Required only for V1 bindings, as v2 can manage it from DT itself */
-int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
-{
-	struct device_list_opp *list_dev;
-	struct device_opp *dev_opp;
-	struct device *dev;
-	int cpu, ret = 0;
-
-	rcu_read_lock();
-
-	dev_opp = _find_device_opp(cpu_dev);
-	if (IS_ERR(dev_opp)) {
-		ret = -EINVAL;
-		goto out_rcu_read_unlock;
-	}
-
-	for_each_cpu(cpu, cpumask) {
-		if (cpu == cpu_dev->id)
-			continue;
-
-		dev = get_cpu_device(cpu);
-		if (!dev) {
-			dev_err(cpu_dev, "%s: failed to get cpu%d device\n",
-				__func__, cpu);
-			continue;
-		}
-
-		list_dev = _add_list_dev(dev, dev_opp);
-		if (!list_dev) {
-			dev_err(dev, "%s: failed to add list-dev for cpu%d device\n",
-				__func__, cpu);
-			continue;
-		}
-	}
-out_rcu_read_unlock:
-	rcu_read_unlock();
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_set_sharing_cpus);
-
-/*
- * Works only for OPP v2 bindings.
- *
- * cpumask should be already set to mask of cpu_dev->id.
- * Returns -ENOENT if operating-points-v2 bindings aren't supported.
- */
-int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
-{
-	struct device_node *np, *tmp_np;
-	struct device *tcpu_dev;
-	int cpu, ret = 0;
-
-	/* Get OPP descriptor node */
-	np = _of_get_opp_desc_node(cpu_dev);
-	if (!np) {
-		dev_dbg(cpu_dev, "%s: Couldn't find opp node: %ld\n", __func__,
-			PTR_ERR(np));
-		return -ENOENT;
-	}
-
-	/* OPPs are shared ? */
-	if (!of_property_read_bool(np, "opp-shared"))
-		goto put_cpu_node;
-
-	for_each_possible_cpu(cpu) {
-		if (cpu == cpu_dev->id)
-			continue;
-
-		tcpu_dev = get_cpu_device(cpu);
-		if (!tcpu_dev) {
-			dev_err(cpu_dev, "%s: failed to get cpu%d device\n",
-				__func__, cpu);
-			ret = -ENODEV;
-			goto put_cpu_node;
-		}
-
-		/* Get OPP descriptor node */
-		tmp_np = _of_get_opp_desc_node(tcpu_dev);
-		if (!tmp_np) {
-			dev_err(tcpu_dev, "%s: Couldn't find opp node: %ld\n",
-				__func__, PTR_ERR(tmp_np));
-			ret = PTR_ERR(tmp_np);
-			goto put_cpu_node;
-		}
-
-		/* CPUs are sharing opp node */
-		if (np == tmp_np)
-			cpumask_set_cpu(cpu, cpumask);
-
-		of_node_put(tmp_np);
-	}
-
-put_cpu_node:
-	of_node_put(np);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_sharing_cpus);
 #endif
diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index 0dd033016e9d..3d946b508a13 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -10,17 +10,18 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/cpu.h>
 #include <linux/cpufreq.h>
-#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/export.h>
-#include <linux/kernel.h>
-#include <linux/pm_opp.h>
-#include <linux/rcupdate.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 
+#include "opp.h"
+
 #ifdef CONFIG_CPU_FREQ
+
 /**
  * dev_pm_opp_init_cpufreq_table() - create a cpufreq table for a device
  * @dev:	device for which we do this operation
@@ -114,3 +115,154 @@ void dev_pm_opp_free_cpufreq_table(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_free_cpufreq_table);
 #endif	/* CONFIG_CPU_FREQ */
+
+/* Required only for V1 bindings, as v2 can manage it from DT itself */
+int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
+{
+	struct device_list_opp *list_dev;
+	struct device_opp *dev_opp;
+	struct device *dev;
+	int cpu, ret = 0;
+
+	rcu_read_lock();
+
+	dev_opp = _find_device_opp(cpu_dev);
+	if (IS_ERR(dev_opp)) {
+		ret = -EINVAL;
+		goto out_rcu_read_unlock;
+	}
+
+	for_each_cpu(cpu, cpumask) {
+		if (cpu == cpu_dev->id)
+			continue;
+
+		dev = get_cpu_device(cpu);
+		if (!dev) {
+			dev_err(cpu_dev, "%s: failed to get cpu%d device\n",
+				__func__, cpu);
+			continue;
+		}
+
+		list_dev = _add_list_dev(dev, dev_opp);
+		if (!list_dev) {
+			dev_err(dev, "%s: failed to add list-dev for cpu%d device\n",
+				__func__, cpu);
+			continue;
+		}
+	}
+out_rcu_read_unlock:
+	rcu_read_unlock();
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_sharing_cpus);
+
+#ifdef CONFIG_OF
+void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask)
+{
+	struct device *cpu_dev;
+	int cpu;
+
+	WARN_ON(cpumask_empty(cpumask));
+
+	for_each_cpu(cpu, cpumask) {
+		cpu_dev = get_cpu_device(cpu);
+		if (!cpu_dev) {
+			pr_err("%s: failed to get cpu%d device\n", __func__,
+			       cpu);
+			continue;
+		}
+
+		dev_pm_opp_of_remove_table(cpu_dev);
+	}
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_remove_table);
+
+int dev_pm_opp_of_cpumask_add_table(cpumask_var_t cpumask)
+{
+	struct device *cpu_dev;
+	int cpu, ret = 0;
+
+	WARN_ON(cpumask_empty(cpumask));
+
+	for_each_cpu(cpu, cpumask) {
+		cpu_dev = get_cpu_device(cpu);
+		if (!cpu_dev) {
+			pr_err("%s: failed to get cpu%d device\n", __func__,
+			       cpu);
+			continue;
+		}
+
+		ret = dev_pm_opp_of_add_table(cpu_dev);
+		if (ret) {
+			pr_err("%s: couldn't find opp table for cpu:%d, %d\n",
+			       __func__, cpu, ret);
+
+			/* Free all other OPPs */
+			dev_pm_opp_of_cpumask_remove_table(cpumask);
+			break;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_add_table);
+
+/*
+ * Works only for OPP v2 bindings.
+ *
+ * cpumask should be already set to mask of cpu_dev->id.
+ * Returns -ENOENT if operating-points-v2 bindings aren't supported.
+ */
+int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
+{
+	struct device_node *np, *tmp_np;
+	struct device *tcpu_dev;
+	int cpu, ret = 0;
+
+	/* Get OPP descriptor node */
+	np = _of_get_opp_desc_node(cpu_dev);
+	if (!np) {
+		dev_dbg(cpu_dev, "%s: Couldn't find opp node: %ld\n", __func__,
+			PTR_ERR(np));
+		return -ENOENT;
+	}
+
+	/* OPPs are shared ? */
+	if (!of_property_read_bool(np, "opp-shared"))
+		goto put_cpu_node;
+
+	for_each_possible_cpu(cpu) {
+		if (cpu == cpu_dev->id)
+			continue;
+
+		tcpu_dev = get_cpu_device(cpu);
+		if (!tcpu_dev) {
+			dev_err(cpu_dev, "%s: failed to get cpu%d device\n",
+				__func__, cpu);
+			ret = -ENODEV;
+			goto put_cpu_node;
+		}
+
+		/* Get OPP descriptor node */
+		tmp_np = _of_get_opp_desc_node(tcpu_dev);
+		if (!tmp_np) {
+			dev_err(tcpu_dev, "%s: Couldn't find opp node: %ld\n",
+				__func__, PTR_ERR(tmp_np));
+			ret = PTR_ERR(tmp_np);
+			goto put_cpu_node;
+		}
+
+		/* CPUs are sharing opp node */
+		if (np == tmp_np)
+			cpumask_set_cpu(cpu, cpumask);
+
+		of_node_put(tmp_np);
+	}
+
+put_cpu_node:
+	of_node_put(np);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_sharing_cpus);
+#endif
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
new file mode 100644
index 000000000000..dcb38f78dae4
--- /dev/null
+++ b/drivers/base/power/opp/opp.h
@@ -0,0 +1,143 @@
+/*
+ * Generic OPP Interface
+ *
+ * Copyright (C) 2009-2010 Texas Instruments Incorporated.
+ *	Nishanth Menon
+ *	Romit Dasgupta
+ *	Kevin Hilman
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __DRIVER_OPP_H__
+#define __DRIVER_OPP_H__
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/pm_opp.h>
+#include <linux/rculist.h>
+#include <linux/rcupdate.h>
+
+/*
+ * Internal data structure organization with the OPP layer library is as
+ * follows:
+ * dev_opp_list (root)
+ *	|- device 1 (represents voltage domain 1)
+ *	|	|- opp 1 (availability, freq, voltage)
+ *	|	|- opp 2 ..
+ *	...	...
+ *	|	`- opp n ..
+ *	|- device 2 (represents the next voltage domain)
+ *	...
+ *	`- device m (represents mth voltage domain)
+ * device 1, 2.. are represented by dev_opp structure while each opp
+ * is represented by the opp structure.
+ */
+
+/**
+ * struct dev_pm_opp - Generic OPP description structure
+ * @node:	opp list node. The nodes are maintained throughout the lifetime
+ *		of boot. It is expected only an optimal set of OPPs are
+ *		added to the library by the SoC framework.
+ *		RCU usage: opp list is traversed with RCU locks. node
+ *		modification is possible realtime, hence the modifications
+ *		are protected by the dev_opp_list_lock for integrity.
+ *		IMPORTANT: the opp nodes should be maintained in increasing
+ *		order.
+ * @dynamic:	not-created from static DT entries.
+ * @available:	true/false - marks if this OPP as available or not
+ * @turbo:	true if turbo (boost) OPP
+ * @rate:	Frequency in hertz
+ * @u_volt:	Target voltage in microvolts corresponding to this OPP
+ * @u_volt_min:	Minimum voltage in microvolts corresponding to this OPP
+ * @u_volt_max:	Maximum voltage in microvolts corresponding to this OPP
+ * @u_amp:	Maximum current drawn by the device in microamperes
+ * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
+ *		frequency from any other OPP's frequency.
+ * @dev_opp:	points back to the device_opp struct this opp belongs to
+ * @rcu_head:	RCU callback head used for deferred freeing
+ * @np:		OPP's device node.
+ *
+ * This structure stores the OPP information for a given device.
+ */
+struct dev_pm_opp {
+	struct list_head node;
+
+	bool available;
+	bool dynamic;
+	bool turbo;
+	unsigned long rate;
+
+	unsigned long u_volt;
+	unsigned long u_volt_min;
+	unsigned long u_volt_max;
+	unsigned long u_amp;
+	unsigned long clock_latency_ns;
+
+	struct device_opp *dev_opp;
+	struct rcu_head rcu_head;
+
+	struct device_node *np;
+};
+
+/**
+ * struct device_list_opp - devices managed by 'struct device_opp'
+ * @node:	list node
+ * @dev:	device to which the struct object belongs
+ * @rcu_head:	RCU callback head used for deferred freeing
+ *
+ * This is an internal data structure maintaining the list of devices that are
+ * managed by 'struct device_opp'.
+ */
+struct device_list_opp {
+	struct list_head node;
+	const struct device *dev;
+	struct rcu_head rcu_head;
+};
+
+/**
+ * struct device_opp - Device opp structure
+ * @node:	list node - contains the devices with OPPs that
+ *		have been registered. Nodes once added are not modified in this
+ *		list.
+ *		RCU usage: nodes are not modified in the list of device_opp,
+ *		however addition is possible and is secured by dev_opp_list_lock
+ * @srcu_head:	notifier head to notify the OPP availability changes.
+ * @rcu_head:	RCU callback head used for deferred freeing
+ * @dev_list:	list of devices that share these OPPs
+ * @opp_list:	list of opps
+ * @np:		struct device_node pointer for opp's DT node.
+ * @shared_opp: OPP is shared between multiple devices.
+ *
+ * This is an internal data structure maintaining the link to opps attached to
+ * a device. This structure is not meant to be shared to users as it is
+ * meant for book keeping and private to OPP library.
+ *
+ * Because the opp structures can be used from both rcu and srcu readers, we
+ * need to wait for the grace period of both of them before freeing any
+ * resources. And so we have used kfree_rcu() from within call_srcu() handlers.
+ */
+struct device_opp {
+	struct list_head node;
+
+	struct srcu_notifier_head srcu_head;
+	struct rcu_head rcu_head;
+	struct list_head dev_list;
+	struct list_head opp_list;
+
+	struct device_node *np;
+	unsigned long clock_latency_ns_max;
+	bool shared_opp;
+	struct dev_pm_opp *suspend_opp;
+};
+
+/* Routines internal to opp core */
+struct device_opp *_find_device_opp(struct device *dev);
+struct device_list_opp *_add_list_dev(const struct device *dev,
+				      struct device_opp *dev_opp);
+struct device_node *_of_get_opp_desc_node(struct device *dev);
+
+#endif		/* __DRIVER_OPP_H__ */
-- 
2.4.0
