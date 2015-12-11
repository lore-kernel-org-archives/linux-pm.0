From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v3 05/20] PM / devfreq: Add new passive governor
Date: Fri, 11 Dec 2015 14:07:44 +0900
Message-ID: <1449810479-14763-6-git-send-email-cw00.choi@samsung.com>
References: <1449810479-14763-1-git-send-email-cw00.choi@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1449810479-14763-1-git-send-email-cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org, linux.amoon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patch adds the new passive governor for DEVFREQ framework. The following
governors are already present and used for DVFS (Dynamic Voltage and Frequency
Scaling) drivers. The following governors are independently used for one device
driver which don't give the influence to other device drviers and also don't
receive the effect from other device drivers.
- ondemand / performance / powersave / userspace

The passive governor depends on operation of parent driver with specific
governos extremely and is not able to decide the new frequency by oneself.
According to the decided new frequency of parent driver with governor,
the passive governor uses it to decide the appropriate frequency for own
device driver. The passive governor must need the following information
from device tree:
- the source clock and OPP tables
- the instance of parent device

For exameple,
there are one more devfreq device drivers which need to change their source
clock according to their utilization on runtime. But, they share the same
power line (e.g., regulator). So, specific device driver is operated as parent
with ondemand governor and then the rest device driver with passive governor
is influenced by parent device.

Suggested-by: Myungjoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
[linux.amoon: Tested on Odroid U3]
Tested-by: Anand Moon <linux.amoon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/devfreq/Kconfig            |   9 ++++
 drivers/devfreq/Makefile           |   1 +
 drivers/devfreq/devfreq.c          |  47 ++++++++++++++++
 drivers/devfreq/governor_passive.c | 108 +++++++++++++++++++++++++++++++++++++
 include/linux/devfreq.h            |  15 ++++++
 5 files changed, 180 insertions(+)
 create mode 100644 drivers/devfreq/governor_passive.c

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 55ec774f794c..d03f635a93e1 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -64,6 +64,15 @@ config DEVFREQ_GOV_USERSPACE
 	  Otherwise, the governor does not change the frequnecy
 	  given at the initialization.
 
+config DEVFREQ_GOV_PASSIVE
+	tristate "Passive"
+	help
+	  Sets the frequency by other governors (simple_ondemand, performance,
+	  powersave, usersapce) of a parent devfreq device. This governor
+	  always has the dependency on the chosen frequency from paired
+	  governor. This governor does not change the frequency by oneself
+	  through sysfs entry.
+
 comment "DEVFREQ Drivers"
 
 config ARM_EXYNOS_BUS_DEVFREQ
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 375ebbb4fcfb..f81c313b4b79 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)	+= governor_simpleondemand.o
 obj-$(CONFIG_DEVFREQ_GOV_PERFORMANCE)	+= governor_performance.o
 obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+= governor_powersave.o
 obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
+obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
 
 # DEVFREQ Drivers
 obj-$(CONFIG_ARCH_EXYNOS)		+= exynos/
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 984c5e9e7bdd..15e58779e4c0 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -190,6 +190,31 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
 
 /* Load monitoring helper functions for governors use */
 
+static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
+{
+	struct devfreq *passive;
+	unsigned long rate;
+	int ret;
+
+	list_for_each_entry(passive, &devfreq->passive_dev_list, passive_node) {
+		if (!passive->governor)
+			continue;
+		rate = freq;
+
+		ret = passive->governor->get_target_freq(passive, &rate);
+		if (ret)
+			return ret;
+
+		ret = passive->profile->target(passive->dev.parent, &rate, 0);
+		if (ret)
+			return ret;
+
+		passive->previous_freq = rate;
+	}
+
+	return 0;
+}
+
 /**
  * update_devfreq() - Reevaluate the device and configure frequency.
  * @devfreq:	the devfreq instance.
@@ -233,10 +258,18 @@ int update_devfreq(struct devfreq *devfreq)
 		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
 	}
 
+	if (!list_empty(&devfreq->passive_dev_list)
+		&& devfreq->previous_freq > freq)
+		update_devfreq_passive(devfreq, freq);
+
 	err = devfreq->profile->target(devfreq->dev.parent, &freq, flags);
 	if (err)
 		return err;
 
+	if (!list_empty(&devfreq->passive_dev_list)
+		&& devfreq->previous_freq < freq)
+		update_devfreq_passive(devfreq, freq);
+
 	if (devfreq->profile->freq_table)
 		if (devfreq_update_status(devfreq, freq))
 			dev_err(&devfreq->dev,
@@ -442,6 +475,10 @@ static void _remove_devfreq(struct devfreq *devfreq)
 		return;
 	}
 	list_del(&devfreq->node);
+	list_del(&devfreq->passive_node);
+	if (!list_empty(&devfreq->passive_dev_list))
+		list_del_init(&devfreq->passive_dev_list);
+
 	mutex_unlock(&devfreq_list_lock);
 
 	if (devfreq->governor)
@@ -559,6 +596,16 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_init;
 	}
 
+	if (!strncmp(devfreq->governor_name, "passive", 7)) {
+		struct devfreq *parent_devfreq =
+			((struct devfreq_passive_data *)data)->parent;
+
+		list_add(&devfreq->passive_node,
+			&parent_devfreq->passive_dev_list);
+	} else {
+		INIT_LIST_HEAD(&devfreq->passive_dev_list);
+	}
+
 	return devfreq;
 
 err_init:
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
new file mode 100644
index 000000000000..7443ae4b92f9
--- /dev/null
+++ b/drivers/devfreq/governor_passive.c
@@ -0,0 +1,108 @@
+/*
+ * linux/drivers/devfreq/governor_passive.c
+ *
+ * Copyright (C) 2015 Samsung Electronics
+ * Author: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/devfreq.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/devfreq.h>
+#include "governor.h"
+
+static int devfreq_passive_get_target_freq(struct devfreq *passive,
+					unsigned long *freq)
+{
+	struct devfreq_passive_data *passive_data = passive->data;
+	struct devfreq *parent_devfreq = passive_data->parent;
+	unsigned long child_freq = ULONG_MAX;
+	int i, count;
+
+	/*
+	 * Each devfreq has the OPP table. After deciding the new frequency
+	 * from the governor of parent devfreq device, the passive governor
+	 * need to get the index of new frequency on OPP table of parent
+	 * device. And then the index is used for getting the suitable
+	 * new frequency for passive devfreq device.
+	 */
+
+	if (!passive->profile || !passive->profile->freq_table
+		|| passive->profile->max_state <= 0)
+		return -EINVAL;
+
+	/*
+	 * When new frequency is lower than previous frequency of parent
+	 * devfreq device, passive governor get the correct frequency from OPP
+	 * list of parent device. Because in this case, *freq is temporary
+	 * value which is decided by ondemand governor.
+	 */
+	if (parent_devfreq->previous_freq > *freq) {
+		struct dev_pm_opp *opp;
+		opp = devfreq_recommended_opp(parent_devfreq->dev.parent,
+						freq, 0);
+		if (IS_ERR_OR_NULL(opp))
+			return PTR_ERR(opp);
+	}
+
+	/*
+	 * Get the OPP table's index of decided freqeuncy by governor
+	 * of parent device.
+	 */
+	for (i = 0; i < parent_devfreq->profile->max_state; i++)
+		if (parent_devfreq->profile->freq_table[i] == *freq)
+			break;
+
+	if (i == parent_devfreq->profile->max_state)
+		return -EINVAL;
+	count = passive->profile->max_state;
+
+	/* Get the suitable frequency by using index of parent device. */
+	if (i < passive->profile->max_state)
+		child_freq = passive->profile->freq_table[i];
+	else
+		child_freq = passive->profile->freq_table[count - 1];
+
+	/* Return the suitable frequency for passive device. */
+	*freq = child_freq;
+
+	return 0;
+}
+
+static int devfreq_passive_event_handler(struct devfreq *devfreq,
+				unsigned int event, void *data)
+{
+	return 0;
+}
+
+static struct devfreq_governor devfreq_passive = {
+	.name = "passive",
+	.get_target_freq = devfreq_passive_get_target_freq,
+	.event_handler = devfreq_passive_event_handler,
+};
+
+static int __init devfreq_passive_init(void)
+{
+	return devfreq_add_governor(&devfreq_passive);
+}
+subsys_initcall(devfreq_passive_init);
+
+static void __exit devfreq_passive_exit(void)
+{
+	int ret;
+
+	ret = devfreq_remove_governor(&devfreq_passive);
+	if (ret)
+		pr_err("%s: failed remove governor %d\n", __func__, ret);
+
+	return;
+}
+module_exit(devfreq_passive_exit);
+
+MODULE_AUTHOR("Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>");
+MODULE_DESCRIPTION("DEVFREQ Passive governor");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 6fa02a20eb63..95c54578a1b4 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -177,6 +177,9 @@ struct devfreq {
 	unsigned int *trans_table;
 	unsigned long *time_in_state;
 	unsigned long last_stat_updated;
+
+	struct list_head passive_dev_list;
+	struct list_head passive_node;
 };
 
 #if defined(CONFIG_PM_DEVFREQ)
@@ -241,6 +244,18 @@ struct devfreq_simple_ondemand_data {
 };
 #endif
 
+/**
+ * struct devfreq_passive_data - void *data fed to struct devfreq
+ *	and devfreq_add_device
+ * @parent:		The parent devfreq device.
+ *
+ * If the fed devfreq_passive_data pointer is NULL to the governor,
+ * the governor return ERROR.
+ */
+struct devfreq_passive_data {
+	struct devfreq *parent;
+};
+
 #else /* !CONFIG_PM_DEVFREQ */
 static inline struct devfreq *devfreq_add_device(struct device *dev,
 					  struct devfreq_dev_profile *profile,
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
