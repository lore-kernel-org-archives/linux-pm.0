From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv2 3/5] devfreq: Add
 devm_devfreq_{register,unregister}_opp_notfier function
Date: Fri, 09 May 2014 16:43:09 +0900
Message-ID: <1399621391-27228-4-git-send-email-cw00.choi@samsung.com>
References: <1399621391-27228-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1399621391-27228-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rafael.j.wysocki@intel.com, nm@ti.com, jkosina@suse.cz, labbe.montjoie@gmail.com, a.kesavan@samsung.com, sreekumar.c@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch add resource-managed function for devfreq opp as following
functions. The devm_devfreq_register_opp_notifier() manages automatically
the registration of devfreq opp using device resource management.
- devm_devfreq_register_opp_notifier
- devm_devfreq_unregister_opp_notifier()

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/devfreq.h   | 14 ++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 40fe650..6f5374cf 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1293,6 +1293,54 @@ int devfreq_unregister_opp_notifier(struct device *dev, struct devfreq *devfreq)
 	return ret;
 }
 
+static void devm_devfreq_opp_release(struct device *dev, void *res)
+{
+	devfreq_unregister_opp_notifier(dev, *(struct devfreq **)res);
+}
+
+/**
+ * devm_ devfreq_register_opp_notifier()
+ *		- Resource-managed devfreq_register_opp_notifier()
+ * @dev:	The devfreq user device. (parent of devfreq)
+ * @devfreq:	The devfreq object.
+ */
+int devm_devfreq_register_opp_notifier(struct device *dev,
+				       struct devfreq *devfreq)
+{
+	struct devfreq **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_devfreq_opp_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = devfreq_register_opp_notifier(dev, devfreq);
+	if (ret) {
+		devres_free(ptr);
+		return ret;
+	}
+
+	*ptr = devfreq;
+	devres_add(dev, ptr);
+
+	return 0;
+}
+EXPORT_SYMBOL(devm_devfreq_register_opp_notifier);
+
+/**
+ * devm_devfreq_unregister_opp_notifier()
+ *		- Resource-managed devfreq_unregister_opp_notifier()
+ * @dev:	The devfreq user device. (parent of devfreq)
+ * @devfreq:	The devfreq object.
+ */
+void devm_devfreq_unregister_opp_notifier(struct device *dev,
+					 struct devfreq *devfreq)
+{
+	WARN_ON(devres_release(dev, devm_devfreq_opp_release,
+			       devm_devfreq_dev_match, devfreq));
+}
+EXPORT_SYMBOL(devm_devfreq_unregister_opp_notifier);
+
 MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
 MODULE_DESCRIPTION("devfreq class support");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 3a5fbc3..cf808d0 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -241,6 +241,10 @@ extern int devfreq_register_opp_notifier(struct device *dev,
 					 struct devfreq *devfreq);
 extern int devfreq_unregister_opp_notifier(struct device *dev,
 					   struct devfreq *devfreq);
+extern int devm_devfreq_register_opp_notifier(struct device *dev,
+					      struct devfreq *devfreq);
+extern void devm_devfreq_unregister_opp_notifier(struct device *dev,
+						struct devfreq *devfreq);
 
 #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
 /**
@@ -317,6 +321,16 @@ static inline int devfreq_unregister_opp_notifier(struct device *dev,
 	return -EINVAL;
 }
 
+static inline int devm_devfreq_register_opp_notifier(struct device *dev,
+						     struct devfreq *devfreq)
+{
+	return -EINVAL;
+}
+
+static inline void devm_devfreq_unregister_opp_notifier(struct device *dev,
+							struct devfreq *devfreq)
+{
+}
 #endif /* CONFIG_PM_DEVFREQ */
 
 #endif /* __LINUX_DEVFREQ_H__ */
-- 
1.8.0
