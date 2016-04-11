From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v9 03/20] PM / devfreq: Add devfreq_get_devfreq_by_phandle()
Date: Mon, 11 Apr 2016 12:57:41 +0900
Message-ID: <1460347078-15175-4-git-send-email-cw00.choi@samsung.com>
References: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com
Cc: mark.rutland@arm.com, inki.dae@samsung.com, linux-samsung-soc@vger.kernel.org, linux@arm.linux.org.uk, cw00.choi@samsung.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux.amoon@gmail.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, devicetree@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patch adds the new devfreq_get_devfreq_by_phandle() OF helper function
which can find the instance of devfreq device by using phandle ("devfreq").

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
[m.reichl and linux.amoon: Tested it on exynos4412-odroidu3 board]
Tested-by: Markus Reichl <m.reichl@fivetechno.de>
Tested-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/devfreq/devfreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/devfreq.h   |  9 +++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 984c5e9e7bdd..20a9422c2552 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -25,6 +25,7 @@
 #include <linux/list.h>
 #include <linux/printk.h>
 #include <linux/hrtimer.h>
+#include <linux/of.h>
 #include "governor.h"
 
 static struct class *devfreq_class;
@@ -639,6 +640,49 @@ struct devfreq *devm_devfreq_add_device(struct device *dev,
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
index 6fa02a20eb63..aa0b8424ebc3 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -208,6 +208,9 @@ extern int devm_devfreq_register_opp_notifier(struct device *dev,
 extern void devm_devfreq_unregister_opp_notifier(struct device *dev,
 						struct devfreq *devfreq);
 
+extern struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
+						int index);
+
 /**
  * devfreq_update_stats() - update the last_status pointer in struct devfreq
  * @df:		the devfreq instance whose status needs updating
@@ -307,6 +310,12 @@ static inline void devm_devfreq_unregister_opp_notifier(struct device *dev,
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
