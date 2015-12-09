From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 06/19] PM / devfreq: Add devfreq_get_devfreq_by_phandle()
Date: Wed, 09 Dec 2015 13:07:58 +0900
Message-ID: <1449634091-1842-7-git-send-email-cw00.choi@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds the new devfreq_get_devfreq_by_phandle() OF helper function
which can find the instance of devfreq device by using phandle ("devfreq").

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/devfreq.h   |  9 +++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 15e58779e4c0..78ea4cdaa82c 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -25,6 +25,7 @@
 #include <linux/list.h>
 #include <linux/printk.h>
 #include <linux/hrtimer.h>
+#include <linux/of.h>
 #include "governor.h"
 
 static struct class *devfreq_class;
@@ -686,6 +687,49 @@ struct devfreq *devm_devfreq_add_device(struct device *dev,
 }
 EXPORT_SYMBOL(devm_devfreq_add_device);
 
+#ifdef CONFIG_OF
+/*
+ * devfreq_get_devfreq_by_phandle - Get the devfreq device from devicetree
+ * @dev - instance to the given device
+ * @index - index into list of devfreq
+ *
+ * return the instance of devfreq device
+ */
+struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index)
+{
+	struct device_node *node;
+	struct devfreq *devfreq;
+
+	if (!dev)
+		return ERR_PTR(-EINVAL);
+
+	if (!dev->of_node)
+		return ERR_PTR(-EINVAL);
+
+	node = of_parse_phandle(dev->of_node, "devfreq", index);
+	if (!node)
+		return ERR_PTR(-ENODEV);
+
+	mutex_lock(&devfreq_list_lock);
+	list_for_each_entry(devfreq, &devfreq_list, node) {
+		if (devfreq->dev.parent
+			&& devfreq->dev.parent->of_node == node) {
+			mutex_unlock(&devfreq_list_lock);
+			return devfreq;
+		}
+	}
+	mutex_unlock(&devfreq_list_lock);
+
+	return ERR_PTR(-EPROBE_DEFER);
+}
+#else
+struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif /* CONFIG_OF */
+EXPORT_SYMBOL_GPL(devfreq_get_devfreq_by_phandle);
+
 /**
  * devm_devfreq_remove_device() - Resource-managed devfreq_remove_device()
  * @dev:	the device to add devfreq feature.
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index f7a6e6bd716e..d648041145ba 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -211,6 +211,9 @@ extern int devm_devfreq_register_opp_notifier(struct device *dev,
 extern void devm_devfreq_unregister_opp_notifier(struct device *dev,
 						struct devfreq *devfreq);
 
+extern struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
+						int index);
+
 /**
  * devfreq_update_stats() - update the last_status pointer in struct devfreq
  * @df:		the devfreq instance whose status needs updating
@@ -324,6 +327,12 @@ static inline void devm_devfreq_unregister_opp_notifier(struct device *dev,
 {
 }
 
+static inline struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
+							int index)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline int devfreq_update_stats(struct devfreq *df)
 {
 	return -EINVAL;
-- 
1.9.1
