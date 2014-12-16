From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv4 2/8] devfreq: event: Add the list of supported devfreq-event
 type
Date: Wed, 17 Dec 2014 08:26:51 +0900
Message-ID: <1418772417-5164-3-git-send-email-cw00.choi@samsung.com>
References: <1418772417-5164-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1418772417-5164-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: kgene.kim@samsung.com, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, mark.rutland@arm.com, a.kesavan@samsung.com, tomasz.figa@gmail.com, k.kozlowski@samsung.com, cw00.choi@samsung.com, inki.dae@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds the list of supported devfreq-event type as following.
Each devfreq-event device driver would support the various devfreq-event type
for devfreq governor at the same time.
- DEVFREQ_EVENT_TYPE_RAW_DATA
- DEVFREQ_EVENT_TYPE_UTILIZATION
- DEVFREQ_EVENT_TYPE_BANDWIDTH
- DEVFREQ_EVENT_TYPE_LATENCY

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq-event.c | 58 ++++++++++++++++++++++++++++++++++++-----
 include/linux/devfreq.h         | 25 +++++++++++++++---
 2 files changed, 73 insertions(+), 10 deletions(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 0e1948e..5b93f1f 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -29,6 +29,9 @@
 #include <linux/of.h>
 #include "governor.h"
 
+#define EVENT_TYPE_RAW_DATA_MAX		ULONG_MAX
+#define EVENT_TYPE_UTILIZATION_MAX	100
+
 static struct class *devfreq_event_class;
 
 /* The list of all devfreq event list */
@@ -144,7 +147,8 @@ EXPORT_SYMBOL_GPL(devfreq_event_is_enabled);
  * Note that this function set the event to the devfreq-event device to start
  * for getting the event data which could be various event type.
  */
-int devfreq_event_set_event(struct devfreq_event_dev *edev)
+int devfreq_event_set_event(struct devfreq_event_dev *edev,
+				enum devfreq_event_type type)
 {
 	int ret;
 
@@ -158,7 +162,15 @@ int devfreq_event_set_event(struct devfreq_event_dev *edev)
 		return -EPERM;
 
 	mutex_lock(&edev->lock);
-	ret = edev->desc->ops->set_event(edev);
+
+	if ((edev->desc->type & type) == 0) {
+		dev_err(&edev->dev, "unsupported devfreq-event type\n");
+		mutex_unlock(&edev->lock);
+		return -EINVAL;
+	}
+
+	ret = edev->desc->ops->set_event(edev, type);
+
 	mutex_unlock(&edev->lock);
 
 	return ret;
@@ -174,6 +186,7 @@ EXPORT_SYMBOL_GPL(devfreq_event_set_event);
  * after stoping the progress of whole sequence of devfreq-event dev.
  */
 int devfreq_event_get_event(struct devfreq_event_dev *edev,
+			    enum devfreq_event_type type,
 			    struct devfreq_event_data *edata)
 {
 	int ret;
@@ -187,18 +200,49 @@ int devfreq_event_get_event(struct devfreq_event_dev *edev,
 	if (!devfreq_event_is_enabled(edev))
 		return -EINVAL;
 
+	mutex_lock(&edev->lock);
+
+	if ((edev->desc->type & type) == 0) {
+		dev_err(&edev->dev, "unsupported devfreq-event type\n");
+		return -EINVAL;
+	}
+
 	edata->event = edata->total_event = 0;
+	ret = edev->desc->ops->get_event(edev, type, edata);
+	if (ret < 0
+		|| edata->total_event <= 0
+		|| edata->event > edata->total_event) {
+		edata->event = edata->total_event = 0;
+		mutex_unlock(&edev->lock);
+		return -EINVAL;
+	}
 
-	mutex_lock(&edev->lock);
-	ret = edev->desc->ops->get_event(edev, edata);
-	mutex_unlock(&edev->lock);
+	switch (type) {
+	case DEVFREQ_EVENT_TYPE_RAW_DATA:
+	case DEVFREQ_EVENT_TYPE_BANDWIDTH:
+	case DEVFREQ_EVENT_TYPE_LATENCY:
+		if ((edata->event > EVENT_TYPE_RAW_DATA_MAX) ||
+			(edata->total_event > EVENT_TYPE_RAW_DATA_MAX)) {
+			edata->event = edata->total_event = 0;
+			ret = -EINVAL;
+		}
+		break;
+	case DEVFREQ_EVENT_TYPE_UTILIZATION:
+		edata->total_event = EVENT_TYPE_UTILIZATION_MAX;
 
-	if ((edata->total_event <= 0)
-		|| (edata->event > edata->total_event)) {
+		if (edata->event > EVENT_TYPE_UTILIZATION_MAX) {
+			edata->event = edata->total_event = 0;
+			ret = -EINVAL;
+		}
+		break;
+	default:
 		edata->event = edata->total_event = 0;
 		ret = -EINVAL;
+		break;
 	}
 
+	mutex_unlock(&edev->lock);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(devfreq_event_get_event);
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index ed85a8c..b424b0d 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -197,6 +197,14 @@ struct devfreq_event_dev {
 	const struct devfreq_event_desc *desc;
 };
 
+/* The supported type by devfreq-event device */
+enum devfreq_event_type {
+	DEVFREQ_EVENT_TYPE_RAW_DATA	= BIT(0),
+	DEVFREQ_EVENT_TYPE_UTILIZATION	= BIT(1),
+	DEVFREQ_EVENT_TYPE_BANDWIDTH	= BIT(2),
+	DEVFREQ_EVENT_TYPE_LATENCY	= BIT(3),
+};
+
 /**
  * struct devfreq_event_data - the devfreq-event data
  *
@@ -232,8 +240,10 @@ struct devfreq_event_ops {
 	int (*reset)(struct devfreq_event_dev *edev);
 
 	/* Mandatory functions */
-	int (*set_event)(struct devfreq_event_dev *edev);
+	int (*set_event)(struct devfreq_event_dev *edev,
+			 enum devfreq_event_type type);
 	int (*get_event)(struct devfreq_event_dev *edev,
+			 enum devfreq_event_type type,
 			 struct devfreq_event_data *edata);
 };
 
@@ -242,6 +252,10 @@ struct devfreq_event_ops {
  *
  * @name	: the name of devfreq-event device.
  * @driver_data	: the private data for devfreq-event driver.
+ * @event_type	: the supported devfreq-event type among as following
+ *		  - DEVFREQ_EVENT_TYPE_UTILIZATION
+ *		  - DEVFREQ_EVENT_TYPE_BANDWIDTH
+ *		  - DEVFREQ_EVENT_TYPE_LATENCY
  * @ops		: the operation to control devfreq-event device.
  *
  * Each devfreq-event device is described with a this structure.
@@ -250,6 +264,7 @@ struct devfreq_event_ops {
 struct devfreq_event_desc {
 	const char *name;
 	void *driver_data;
+	enum devfreq_event_type type;
 
 	struct devfreq_event_ops *ops;
 };
@@ -287,8 +302,10 @@ extern void devm_devfreq_unregister_opp_notifier(struct device *dev,
 extern int devfreq_event_enable_edev(struct devfreq_event_dev *edev);
 extern int devfreq_event_disable_edev(struct devfreq_event_dev *edev);
 extern bool devfreq_event_is_enabled(struct devfreq_event_dev *edev);
-extern int devfreq_event_set_event(struct devfreq_event_dev *edev);
+extern int devfreq_event_set_event(struct devfreq_event_dev *edev,
+				enum devfreq_event_type type);
 extern int devfreq_event_get_event(struct devfreq_event_dev *edev,
+				enum devfreq_event_type type,
 				struct devfreq_event_data *edata);
 extern int devfreq_event_reset_event(struct devfreq_event_dev *edev);
 extern void *devfreq_event_get_drvdata(struct devfreq_event_dev *edev);
@@ -411,12 +428,14 @@ static inline bool devfreq_event_is_enabled(struct devfreq_event_dev *edev);
 	return false;
 }
 
-static inline int devfreq_event_set_event(struct devfreq_event_dev *edev);
+static inline int devfreq_event_set_event(struct devfreq_event_dev *edev,
+					enum devfreq_event_type type)
 {
 	return -EINVAL;
 }
 
 static inline int devfreq_event_get_event(struct devfreq_event_dev *edev,
+					enum devfreq_event_type type,
 					struct devfreq_event_data *edata)
 {
 	return -EINVAL;
-- 
1.8.5.5
