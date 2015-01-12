From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv8 2/9] devfreq: event: Add resource-managed function for
 devfreq-event device
Date: Mon, 12 Jan 2015 21:34:50 +0900
Message-ID: <1421066097-26237-3-git-send-email-cw00.choi@samsung.com>
References: <1421066097-26237-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1421066097-26237-1-git-send-email-cw00.choi@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: myungjoo.ham@samsung.com, kgene@kernel.org
Cc: mark.rutland@arm.com, k.kozlowski@samsung.com, linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, tomasz.figa@gmail.com, linux-kernel@vger.kernel.org, inki.dae@samsung.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, robh+dt@kernel.org, a.kesavan@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

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
index 9ba5ba4..57529af 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -389,6 +389,69 @@ int devfreq_event_remove_edev(struct devfreq_event_dev *edev)
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
+EXPORT_SYMBOL_GPL(devm_devfreq_event_add_edev);
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
+EXPORT_SYMBOL_GPL(devm_devfreq_event_remove_edev);
+
 /*
  * Device attributes for devfreq-event class.
  */
diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
index b7363f5..b6e3afa 100644
--- a/include/linux/devfreq-event.h
+++ b/include/linux/devfreq-event.h
@@ -106,6 +106,10 @@ extern int devfreq_event_get_edev_count(struct device *dev);
 extern struct devfreq_event_dev *devfreq_event_add_edev(struct device *dev,
 				struct devfreq_event_desc *desc);
 extern int devfreq_event_remove_edev(struct devfreq_event_dev *edev);
+extern struct devfreq_event_dev *devm_devfreq_event_add_edev(struct device *dev,
+				struct devfreq_event_desc *desc);
+extern void devm_devfreq_event_remove_edev(struct device *dev,
+				struct devfreq_event_dev *edev);
 
 #else
 static inline int devfreq_event_enable_edev(struct devfreq_event_dev *edev)
@@ -165,6 +169,18 @@ static inline int devfreq_event_remove_edev(struct devfreq_event_dev *edev)
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
