From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v5 06/21] PM / devfreq: Add new passive governor
Date: Thu, 24 Mar 2016 13:25:15 +0900
Message-ID: <1458793530-31897-7-git-send-email-cw00.choi@samsung.com>
References: <1458793530-31897-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1458793530-31897-1-git-send-email-cw00.choi@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux@arm.linux.org.uk, cw00.choi@samsung.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux.amoon@gmail.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, tjakobi@math.uni-bielefeld.de, robh+dt@kernel.org, galak@codeaurora.org, linux-arm-kernel@lists.infradead.org
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

Suggested-by: Myungjoo Ham <myungjoo.ham@samsung.com>
[tjakobi: Reported RCU locking issue and cw00.choi fix it.]
Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/Kconfig            |   7 ++
 drivers/devfreq/Makefile           |   1 +
 drivers/devfreq/devfreq.c          |  17 ++++
 drivers/devfreq/governor.h         |  15 +++
 drivers/devfreq/governor_passive.c | 192 +++++++++++++++++++++++++++++++++++++
 include/linux/devfreq.h            |   3 +
 6 files changed, 235 insertions(+)
 create mode 100644 drivers/devfreq/governor_passive.c

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 55ec774f794c..ae689ad375fa 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -64,6 +64,13 @@ config DEVFREQ_GOV_USERSPACE
 	  Otherwise, the governor does not change the frequnecy
 	  given at the initialization.
 
+config DEVFREQ_GOV_PASSIVE
+	tristate "Passive"
+	help
+	  Sets the frequency based on the frequency of its parent devfreq
+	  device. This governor does not change the frequency by itself
+	  through sysfs entries.
+
 comment "DEVFREQ Drivers"
 
 config ARM_EXYNOS_BUS_DEVFREQ
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 8af8aaf922a8..2633087d5c63 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)	+= governor_simpleondemand.o
 obj-$(CONFIG_DEVFREQ_GOV_PERFORMANCE)	+= governor_performance.o
 obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+= governor_powersave.o
 obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
+obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
 
 # DEVFREQ Drivers
 obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 1d6c803804d5..9f84bbc2994c 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -478,7 +478,13 @@ static void _remove_devfreq(struct devfreq *devfreq)
 		dev_warn(&devfreq->dev, "releasing devfreq which doesn't exist\n");
 		return;
 	}
+
+	if (devfreq->governor->type == DEVFREQ_GOV_PASSIVE)
+		devfreq_passive_unregister_notifier(devfreq);
+
 	list_del(&devfreq->node);
+	list_del_init(&devfreq->passive_node);
+
 	mutex_unlock(&devfreq_list_lock);
 
 	if (devfreq->governor)
@@ -598,6 +604,17 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_init;
 	}
 
+	if (devfreq->governor->type == DEVFREQ_GOV_PASSIVE) {
+		struct devfreq *parent_devfreq = (struct devfreq *)data;
+		list_add(&devfreq->passive_node, &parent_devfreq->passive_node);
+
+		err = devfreq_passive_register_notifier(devfreq);
+		if (err <0)
+			goto err_init;
+	} else {
+		INIT_LIST_HEAD(&devfreq->passive_node);
+	}
+
 	return devfreq;
 
 err_init:
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index cf19b923c362..64d1dffcdb43 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -23,6 +23,7 @@
 #define DEVFREQ_GOV_PERFORMANCE			0x2
 #define DEVFREQ_GOV_POWERSAVE			0x3
 #define DEVFREQ_GOV_USERSPACE			0x4
+#define DEVFREQ_GOV_PASSIVE			0x5
 
 /* Devfreq events */
 #define DEVFREQ_GOV_START			0x1
@@ -44,4 +45,18 @@ extern void devfreq_interval_update(struct devfreq *devfreq,
 extern int devfreq_add_governor(struct devfreq_governor *governor);
 extern int devfreq_remove_governor(struct devfreq_governor *governor);
 
+#if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
+extern int devfreq_passive_register_notifier(struct devfreq *passive);
+extern void devfreq_passive_unregister_notifier(struct devfreq *passive);
+#else
+static inline int devfreq_passive_register_notifier(struct devfreq *passive)
+{
+	return 0;
+}
+
+static inline void devfreq_passive_unregister_notifier(struct devfreq *passive)
+{
+}
+#endif
+
 #endif /* _GOVERNOR_H */
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
new file mode 100644
index 000000000000..521e93b68c11
--- /dev/null
+++ b/drivers/devfreq/governor_passive.c
@@ -0,0 +1,192 @@
+/*
+ * linux/drivers/devfreq/governor_passive.c
+ *
+ * Copyright (C) 2016 Samsung Electronics
+ * Author: Chanwoo Choi <cw00.choi@samsung.com>
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
+	struct devfreq *parent_devfreq = (struct devfreq *)passive->data;
+	unsigned long child_freq = ULONG_MAX;
+	struct dev_pm_opp *opp;
+	int i, count;
+	u32 flags;
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
+	 * The passive governor have to get the correct frequency from OPP
+	 * list of parent device. Because in this case, *freq is temporary
+	 * value which is decided by ondemand governor.
+	 */
+	if (parent_devfreq->previous_freq < *freq)
+		flags = DEVFREQ_FLAG_LEAST_UPPER_BOUND;
+
+	rcu_read_lock();
+	opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, flags);
+	rcu_read_unlock();
+	if (IS_ERR_OR_NULL(opp))
+		return PTR_ERR(opp);
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
+
+	/* Get the suitable frequency by using index of parent device. */
+	if (i < passive->profile->max_state) {
+		child_freq = passive->profile->freq_table[i];
+	} else {
+		count = passive->profile->max_state;
+		child_freq = passive->profile->freq_table[count - 1];
+	}
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
+	.type = DEVFREQ_GOV_PASSIVE,
+	.get_target_freq = devfreq_passive_get_target_freq,
+	.event_handler = devfreq_passive_event_handler,
+};
+
+static int update_devfreq_passive(struct devfreq *parent, unsigned long freq)
+{
+	struct devfreq *passive;
+	unsigned long rate;
+	int ret;
+
+	list_for_each_entry(passive, &parent->passive_node, passive_node) {
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
+static int devfreq_passive_notifier_call(struct notifier_block *nb,
+				unsigned long event, void *ptr)
+{
+	struct devfreq *passive = container_of(nb, struct devfreq, passive_nb);
+	struct devfreq *parent = (struct devfreq *)passive->data;
+	struct devfreq_freqs *freqs = (struct devfreq_freqs *)ptr;
+	unsigned long freq = freqs->new;
+
+	switch (event) {
+	case DEVFREQ_PRECHANGE:
+		if (parent->previous_freq > freq);
+			update_devfreq_passive(parent, freq);
+		break;
+	case DEVFREQ_POSTCHANGE:
+		if (parent->previous_freq < freq);
+			update_devfreq_passive(parent, freq);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+/**
+ * devfreq_passive_register_notifier() - Register notifier block of passive
+ *					devfreq to parent devfreq device.
+ * @passive:	The parent devfreq object using passive governor.
+ *
+ * Register notifier block of passive devfreq device to receive the changed
+ * frequency of parent devfreq device through DEVFREQ_TRANSITION_NOTIFIER.
+ */
+int devfreq_passive_register_notifier(struct devfreq *passive)
+{
+	struct device *dev = passive->dev.parent;
+	struct devfreq *parent = (struct devfreq *)passive->data;
+	struct notifier_block *nb = &passive->passive_nb;
+
+	nb->notifier_call = devfreq_passive_notifier_call;
+	return devm_devfreq_register_notifier(dev, parent, nb,
+					DEVFREQ_TRANSITION_NOTIFIER);
+}
+
+/**
+ * devfreq_passive_register_notifier() - Unregister notifier block of passive
+ *					devfreq from parent devfreq device.
+ * @passive:	The parent devfreq object using passive governor.
+ */
+void devfreq_passive_unregister_notifier(struct devfreq *passive)
+{
+	struct devfreq *parent = (struct devfreq *)passive->data;
+	struct device *dev = passive->dev.parent;
+	struct notifier_block *nb = &passive->passive_nb;
+
+	devm_devfreq_unregister_notifier(dev, parent, nb,
+					DEVFREQ_TRANSITION_NOTIFIER);
+}
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
+MODULE_AUTHOR("Chanwoo Choi <cw00.choi@samsung.com>");
+MODULE_DESCRIPTION("DEVFREQ Passive governor");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 9baf45f661ad..bf073c74134f 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -188,6 +188,9 @@ struct devfreq {
 	unsigned long last_stat_updated;
 
 	struct srcu_notifier_head transition_notifier_list;
+
+	struct list_head passive_node;
+	struct notifier_block passive_nb;
 };
 
 struct devfreq_freqs {
-- 
1.9.1
