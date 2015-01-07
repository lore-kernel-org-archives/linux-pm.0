From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv7 03/10] devfreq: event: Add resource-managed function for
 devfreq-event device
Date: Thu, 08 Jan 2015 08:51:10 +0900
Message-ID: <1420674677-3077-4-git-send-email-cw00.choi@samsung.com>
References: <1420674677-3077-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:14015 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755557AbbAGXvX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jan 2015 18:51:23 -0500
In-reply-to: <1420674677-3077-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, mark.rutland@arm.com, a.kesavan@samsung.com, tomasz.figa@gmail.com, k.kozlowski@samsung.com, b.zolnierkie@samsung.com, robh+dt@kernel.org, cw00.choi@samsung.com, inki.dae@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org

This patch add the resource-managed function for devfreq-event device as
following functions. The devm_devfreq_event_add_edev() manages automatically
the memory of devfreq-event device using resource management.
- devm_devfreq_event_add_edev()
- devm_devfreq_event_remove_edev()

Cc: Myungjoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq-event.c | 63 +++++++++++++++++++++++++++++++++++++++++
 include/linux/devfreq-event.h   | 16 +++++++++++
 2 files changed, 79 insertions(+)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 64c1764..5301e2b 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -451,6 +451,69 @@ int devfreq_event_remove_edev(struct devfreq_event_dev *edev)
 }
 EXPORT_SYMBOL_GPL(devfreq_event_remove_edev);
 
+static int devm_devfreq_event_match(struct device *dev, void *res, void *data)
+{
+	struct devfreq_event_dev **r = res;
+
+	if (WARN_ON(!r || !*r))
+		return 0;
+
+	return *r == data;
+}
+
+static void devm_devfreq_event_release(struct device *dev, void *res)
+{
+	devfreq_event_remove_edev(*(struct devfreq_event_dev **)res);
+}
+
+/**
+ * devm_devfreq_event_add_edev() - Resource-managed devfreq_event_add_edev()
+ * @dev		: the device owning the devfreq-event device being created
+ * @desc	: the devfreq-event device's decriptor which include essential
+ *		  data for devfreq-event device.
+ *
+ * Note that this function manages automatically the memory of devfreq-event
+ * device using device resource management and simplify the free operation
+ * for memory of devfreq-event device.
+ */
+struct devfreq_event_dev *devm_devfreq_event_add_edev(struct device *dev,
+						struct devfreq_event_desc *desc)
+{
+	struct devfreq_event_dev **ptr, *edev;
+
+	ptr = devres_alloc(devm_devfreq_event_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	edev = devfreq_event_add_edev(dev, desc);
+	if (IS_ERR(edev)) {
+		devres_free(ptr);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	*ptr = edev;
+	devres_add(dev, ptr);
+
+	return edev;
+}
+EXPORT_SYMBOL(devm_devfreq_event_add_edev);
+
+/**
+ * devm_devfreq_event_remove_edev()- Resource-managed devfreq_event_remove_edev()
+ * @dev		: the device owning the devfreq-event device being created
+ * @edev	: the devfreq-event device
+ *
+ * Note that this function manages automatically the memory of devfreq-event
+ * device using device resource management.
+ */
+void devm_devfreq_event_remove_edev(struct device *dev,
+				struct devfreq_event_dev *edev)
+{
+	WARN_ON(devres_release(dev, devm_devfreq_event_release,
+			       devm_devfreq_event_match, edev));
+}
+EXPORT_SYMBOL(devm_devfreq_event_remove_edev);
+
 /*
  * Device attributes for devfreq-event class.
  */
diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
index 13a5703..3c44ad1 100644
--- a/include/linux/devfreq-event.h
+++ b/include/linux/devfreq-event.h
@@ -123,6 +123,10 @@ extern int devfreq_event_get_edev_count(struct device *dev);
 extern struct devfreq_event_dev *devfreq_event_add_edev(struct device *dev,
 				struct devfreq_event_desc *desc);
 extern int devfreq_event_remove_edev(struct devfreq_event_dev *edev);
+extern struct devfreq_event_dev *devm_devfreq_event_add_edev(struct device *dev,
+				struct devfreq_event_desc *desc);
+extern void devm_devfreq_event_remove_edev(struct device *dev,
+				struct devfreq_event_dev *edev);
 
 #else
 static inline int devfreq_event_enable_edev(struct devfreq_event_dev *edev)
@@ -184,6 +188,18 @@ static inline int devfreq_event_remove_edev(struct devfreq_event_dev *edev)
 {
 	return -EINVAL;
 }
+
+static inline struct devfreq_event_dev *devm_devfreq_event_add_edev(
+					struct device *dev,
+					struct devfreq_event_desc *desc)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline void devm_devfreq_event_remove_edev(struct device *dev,
+					struct devfreq_event_dev *edev)
+{
+}
 #endif /* CONFIG_PM_DEVFREQ_EVENT */
 
 #endif /* __LINUX_DEVFREQ_EVENT_H__ */
-- 
1.8.5.5

