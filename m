From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v8 05/20] PM / devfreq: Add new passive governor
Date: Fri, 08 Apr 2016 13:24:54 +0900
Message-ID: <1460089509-16260-6-git-send-email-cw00.choi@samsung.com>
References: <1460089509-16260-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1460089509-16260-1-git-send-email-cw00.choi@samsung.com>
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
Cc: mark.rutland@arm.com, inki.dae@samsung.com, linux-samsung-soc@vger.kernel.org, linux@arm.linux.org.uk, cw00.choi@samsung.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux.amoon@gmail.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, devicetree@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org, linux-arm-kernel@lists.infradead.org
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
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
[tjakobi: Reported RCU locking issue and cw00.choi fix it.]
Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/devfreq/Kconfig            |   8 ++
 drivers/devfreq/Makefile           |   1 +
 drivers/devfreq/governor_passive.c | 207 +++++++++++++++++++++++++++++++++++++
 include/linux/devfreq.h            |  33 ++++++
 4 files changed, 249 insertions(+)
 create mode 100644 drivers/devfreq/governor_passive.c

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index cedda8f1e5eb..d260cd0219f6 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -64,6 +64,14 @@ config DEVFREQ_GOV_USERSPACE
 	  Otherwise, the governor does not change the frequency
 	  given at the initialization.
 
+config DEVFREQ_GOV_PASSIVE
+	tristate "Passive"
+	help
+	  Sets the frequency based on the frequency of its parent devfreq
+	  device. This governor does not change the frequency by itself
+	  through sysfs entries. The passive governor recommends that
+	  devfreq device uses the OPP table to get the frequency/voltage.
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
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
new file mode 100644
index 000000000000..28a9ae32d330
--- /dev/null
+++ b/drivers/devfreq/governor_passive.c
@@ -0,0 +1,207 @@
+/*
+ * linux/drivers/devfreq/governor_passive.c
+ *
+ * Copyright (C) 2016 Samsung Electronics
+ * Author: Chanwoo Choi <cw00.choi@samsung.com>
+ * Author: MyungJoo Ham <myungjoo.ham@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/devfreq.h>
+#include "governor.h"
+
+static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
+					unsigned long *freq)
+{
+	struct devfreq_passive_data *p_data
+			= (struct devfreq_passive_data *)devfreq->data;
+	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
+	unsigned long child_freq = ULONG_MAX;
+	struct dev_pm_opp *opp;
+	int i, count, ret = 0;
+
+	/*
+	 * If the devfreq device with passive governor has the specific method
+	 * to determine the next frequency, should use the get_target_freq()
+	 * of struct devfreq_passive_data.
+	 */
+	if (p_data->get_target_freq) {
+		ret = p_data->get_target_freq(devfreq, freq);
+		goto out;
+	}
+
+	/*
+	 * If the parent and passive devfreq device uses the OPP table,
+	 * get the next frequency by using the OPP table.
+	 */
+
+	/*
+	 * - parent devfreq device uses the governors except for passive.
+	 * - passive devfreq device uses the passive governor.
+	 *
+	 * Each devfreq has the OPP table. After deciding the new frequency
+	 * from the governor of parent devfreq device, the passive governor
+	 * need to get the index of new frequency on OPP table of parent
+	 * device. And then the index is used for getting the suitable
+	 * new frequency for passive devfreq device.
+	 */
+	if (!devfreq->profile || !devfreq->profile->freq_table
+		|| devfreq->profile->max_state <= 0)
+		return -EINVAL;
+
+	/*
+	 * The passive governor have to get the correct frequency from OPP
+	 * list of parent device. Because in this case, *freq is temporary
+	 * value which is decided by ondemand governor.
+	 */
+	rcu_read_lock();
+	opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
+	rcu_read_unlock();
+	if (IS_ERR(opp)) {
+		ret = PTR_ERR(opp);
+		goto out;
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
+	if (i == parent_devfreq->profile->max_state) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Get the suitable frequency by using index of parent device. */
+	if (i < devfreq->profile->max_state) {
+		child_freq = devfreq->profile->freq_table[i];
+	} else {
+		count = devfreq->profile->max_state;
+		child_freq = devfreq->profile->freq_table[count - 1];
+	}
+
+	/* Return the suitable frequency for passive device. */
+	*freq = child_freq;
+
+out:
+	return ret;
+}
+
+static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
+{
+	int ret;
+
+	if (!devfreq->governor)
+		return -EINVAL;
+
+	mutex_lock(&devfreq->lock);
+
+	ret = devfreq->governor->get_target_freq(devfreq, &freq);
+	if (ret < 0)
+		goto out;
+
+	ret = devfreq->profile->target(devfreq->dev.parent, &freq, 0);
+	if (ret < 0)
+		goto out;
+
+	devfreq->previous_freq = freq;
+
+out:
+	mutex_unlock(&devfreq->lock);
+
+	return 0;
+}
+
+static int devfreq_passive_notifier_call(struct notifier_block *nb,
+				unsigned long event, void *ptr)
+{
+	struct devfreq_passive_data *data
+			= container_of(nb, struct devfreq_passive_data, nb);
+	struct devfreq *devfreq = (struct devfreq *)data->this;
+	struct devfreq *parent = (struct devfreq *)data->parent;
+	struct devfreq_freqs *freqs = (struct devfreq_freqs *)ptr;
+	unsigned long freq = freqs->new;
+
+	switch (event) {
+	case DEVFREQ_PRECHANGE:
+		if (parent->previous_freq > freq)
+			update_devfreq_passive(devfreq, freq);
+		break;
+	case DEVFREQ_POSTCHANGE:
+		if (parent->previous_freq < freq)
+			update_devfreq_passive(devfreq, freq);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int devfreq_passive_event_handler(struct devfreq *devfreq,
+				unsigned int event, void *data)
+{
+	struct device *dev = devfreq->dev.parent;
+	struct devfreq_passive_data *p_data
+			= (struct devfreq_passive_data *)devfreq->data;
+	struct devfreq *parent = (struct devfreq *)p_data->parent;
+	struct notifier_block *nb = &p_data->nb;
+	int ret = 0;
+
+	if (!parent)
+		return -EPROBE_DEFER;
+
+	switch (event) {
+	case DEVFREQ_GOV_START:
+		if (!p_data->this)
+			p_data->this = devfreq;
+
+		nb->notifier_call = devfreq_passive_notifier_call;
+		ret = devm_devfreq_register_notifier(dev, parent, nb,
+					DEVFREQ_TRANSITION_NOTIFIER);
+		break;
+	case DEVFREQ_GOV_STOP:
+		devm_devfreq_unregister_notifier(dev, parent, nb,
+					DEVFREQ_TRANSITION_NOTIFIER);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
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
+MODULE_AUTHOR("Chanwoo Choi <cw00.choi@samsung.com>");
+MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
+MODULE_DESCRIPTION("DEVFREQ Passive governor");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 98c699304e12..2de4e2eea180 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -272,6 +272,39 @@ struct devfreq_simple_ondemand_data {
 };
 #endif
 
+#if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
+/**
+ * struct devfreq_passive_data - void *data fed to struct devfreq
+ *	and devfreq_add_device
+ * @parent:	the devfreq instance of parent device.
+ * @get_target_freq:	Optional callback, Returns desired operating frequency
+ *			for the device using passive governor. That is called
+ *			when passive governor should decide the next frequency
+ *			by using the new frequency of parent devfreq device
+ *			using governors except for passive governor.
+ *			If the devfreq device has the specific method to decide
+ *			the next frequency, should use this callback.
+ * @this:	the devfreq instance of own device.
+ * @nb:		the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
+ *
+ * The devfreq_passive_data have to set the devfreq instance of parent
+ * device with governors except for the passive governor. But, don't need to
+ * initialize the 'this' and 'nb' field because the devfreq core will handle
+ * them.
+ */
+struct devfreq_passive_data {
+	/* Should set the devfreq instance of parent device */
+	struct devfreq *parent;
+
+	/* Optional callback to decide the next frequency of passvice device */
+	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
+
+	/* For passive governor's internal use. Don't need to set them */
+	struct devfreq *this;
+	struct notifier_block nb;
+};
+#endif
+
 #else /* !CONFIG_PM_DEVFREQ */
 static inline struct devfreq *devfreq_add_device(struct device *dev,
 					  struct devfreq_dev_profile *profile,
-- 
1.9.1
