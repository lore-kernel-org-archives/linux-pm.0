From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv2 2/5] devfreq: Add resource-managed function for devfreq device
Date: Fri, 09 May 2014 16:43:08 +0900
Message-ID: <1399621391-27228-3-git-send-email-cw00.choi@samsung.com>
References: <1399621391-27228-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1399621391-27228-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rafael.j.wysocki@intel.com, nm@ti.com, jkosina@suse.cz, labbe.montjoie@gmail.com, a.kesavan@samsung.com, sreekumar.c@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch add resource-managed function for devfreq device as following
functions. The devm_devfreq_add_device() manages automatically the memory
of devfreq device using device resource management.
- devm_devfreq_add_device()
- devm_devfreq_remove_device()

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/devfreq.h   | 21 +++++++++++++++-
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index e960eb0..40fe650 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -659,6 +659,69 @@ int devfreq_remove_device(struct devfreq *devfreq)
 }
 EXPORT_SYMBOL(devfreq_remove_device);
 
+static int devm_devfreq_dev_match(struct device *dev, void *res, void *data)
+{
+	struct devfreq **r = res;
+
+	if (WARN_ON(!r || !*r))
+		return 0;
+
+	return *r == data;
+}
+
+static void devm_devfreq_dev_release(struct device *dev, void *res)
+{
+	devfreq_remove_device(*(struct devfreq **)res);
+}
+
+/**
+ * devm_devfreq_add_device() - Resource-managed devfreq_add_device()
+ * @dev:	the device to add devfreq feature.
+ * @profile:	device-specific profile to run devfreq.
+ * @governor_name:	name of the policy to choose frequency.
+ * @data:	private data for the governor. The devfreq framework does not
+ *		touch this value.
+ *
+ * This function manages automatically the memory of devfreq device using device
+ * resource management and simplify the free operation for memory of devfreq
+ * device.
+ */
+struct devfreq *devm_devfreq_add_device(struct device *dev,
+					struct devfreq_dev_profile *profile,
+					const char *governor_name,
+					void *data)
+{
+	struct devfreq **ptr, *devfreq;
+
+	ptr = devres_alloc(devm_devfreq_dev_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	devfreq = devfreq_add_device(dev, profile, governor_name, data);
+	if (IS_ERR(devfreq)) {
+		devres_free(ptr);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	*ptr = devfreq;
+	devres_add(dev, ptr);
+
+	return devfreq;
+}
+EXPORT_SYMBOL(devm_devfreq_add_device);
+
+/**
+ * devm_devfreq_remove_device() - Resource-managed devfreq_remove_device()
+ * @dev:	the device to add devfreq feature.
+ * @devfreq:	the devfreq instance to be removed
+ */
+void devm_devfreq_remove_device(struct device *dev, struct devfreq *devfreq)
+{
+	WARN_ON(devres_release(dev, devm_devfreq_dev_release,
+			       devm_devfreq_dev_match, devfreq));
+}
+EXPORT_SYMBOL(devm_devfreq_remove_device);
+
 /**
  * devfreq_suspend_device() - Suspend devfreq of a device.
  * @devfreq: the devfreq instance to be suspended
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 4dd8cca..3a5fbc3 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -223,6 +223,12 @@ extern struct devfreq *devfreq_add_device(struct device *dev,
 				  const char *governor_name,
 				  void *data);
 extern int devfreq_remove_device(struct devfreq *devfreq);
+extern struct devfreq *devm_devfreq_add_device(struct device *dev,
+				  struct devfreq_dev_profile *profile,
+				  const char *governor_name,
+				  void *data);
+extern void devm_devfreq_remove_device(struct device *dev,
+				  struct devfreq *devfreq);
 
 /* Supposed to be called by PM_SLEEP/PM_RUNTIME callbacks */
 extern int devfreq_suspend_device(struct devfreq *devfreq);
@@ -262,7 +268,7 @@ static inline struct devfreq *devfreq_add_device(struct device *dev,
 					  const char *governor_name,
 					  void *data)
 {
-	return NULL;
+	return ERR_PTR(-ENOSYS);
 }
 
 static inline int devfreq_remove_device(struct devfreq *devfreq)
@@ -270,6 +276,19 @@ static inline int devfreq_remove_device(struct devfreq *devfreq)
 	return 0;
 }
 
+static inline struct devfreq *devm_devfreq_add_device(struct device *dev,
+					struct devfreq_dev_profile *profile,
+					const char *governor_name,
+					void *data)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline void devm_devfreq_remove_device(struct device *dev,
+					struct devfreq *devfreq)
+{
+}
+
 static inline int devfreq_suspend_device(struct devfreq *devfreq)
 {
 	return 0;
-- 
1.8.0
