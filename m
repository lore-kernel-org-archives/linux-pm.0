From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [RFC PATCHv2 2/7] devfreq: event: Add the list of supported
 devfreq-event type
Date: Tue, 09 Dec 2014 23:13:01 +0900
Message-ID: <1418134386-14681-3-git-send-email-cw00.choi@samsung.com>
References: <1418134386-14681-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1418134386-14681-1-git-send-email-cw00.choi@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, k.kozlowski@samsung.com, kgene.kim@samsung.com, b.zolnierkie@samsung.com, rafael.j.wysocki@intel.com, tomasz.figa@gmail.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, myungjoo.ham@samsung.com, linux-samsung-soc@vger.kernel.org, a.kesavan@samsung.com, linux-arm-kernel@lists.infradead.org
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
 drivers/devfreq/devfreq-event.c | 23 ++++++++++++++++++++---
 include/linux/devfreq.h         | 28 ++++++++++++++++++++++++----
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index b47329f..a71fcee 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -203,7 +203,8 @@ bool devfreq_is_enabled_event_dev(struct devfreq_event_dev *event_dev)
 }
 EXPORT_SYMBOL_GPL(devfreq_is_enabled_event_dev);
 
-int devfreq_set_event_event_dev(struct devfreq_event_dev *event_dev)
+int devfreq_set_event_event_dev(struct devfreq_event_dev *event_dev,
+				enum devfreq_event_type event_type)
 {
 	if (!event_dev || !event_dev->desc)
 		return -EINVAL;
@@ -211,14 +212,22 @@ int devfreq_set_event_event_dev(struct devfreq_event_dev *event_dev)
 	if (!devfreq_is_enabled_event_dev(event_dev))
 		return -EPERM;
 
+	if ((event_dev->desc->event_type & event_type) == 0) {
+		dev_err(&event_dev->dev, "unsupported of devfreq-event type\n");
+		return -EINVAL;
+	}
+
 	if (event_dev->desc->ops && event_dev->desc->ops->set_event)
-		return event_dev->desc->ops->set_event(event_dev);
+		return event_dev->desc->ops->set_event(event_dev, event_type);
+
+	dev_err(&event_dev->dev, "failed to set devfreq-event\n");
 
 	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(devfreq_set_event_event_dev);
 
 int devfreq_get_event_event_dev(struct devfreq_event_dev *event_dev,
+				enum devfreq_event_type event_type,
 				int *total_event)
 {
 	if (!event_dev || !event_dev->desc)
@@ -227,8 +236,16 @@ int devfreq_get_event_event_dev(struct devfreq_event_dev *event_dev,
 	if (!devfreq_is_enabled_event_dev(event_dev))
 		return -EPERM;
 
+	if ((event_dev->desc->event_type & event_type) == 0) {
+		dev_err(&event_dev->dev, "unsupported of devfreq-event type\n");
+		return -EINVAL;
+	}
+
 	if (event_dev->desc->ops && event_dev->desc->ops->get_event)
-		return event_dev->desc->ops->get_event(event_dev, total_event);
+		return event_dev->desc->ops->get_event(event_dev, event_type,
+							total_event);
+
+	dev_err(&event_dev->dev, "failed to get devfreq-event\n");
 
 	return -EINVAL;
 }
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 3c5f233..f6d44b7 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -197,6 +197,15 @@ struct devfreq_event_dev {
 	const struct devfreq_event_desc *desc;
 };
 
+/* The supported type by devfreq-event device */
+enum devfreq_event_type {
+	DEVFREQ_EVENT_TYPE_NONE		= BIT(0),
+	DEVFREQ_EVENT_TYPE_RAW_DATA	= BIT(1),
+	DEVFREQ_EVENT_TYPE_UTILIZATION	= BIT(2),
+	DEVFREQ_EVENT_TYPE_BANDWIDTH	= BIT(3),
+	DEVFREQ_EVENT_TYPE_LATENCY	= BIT(4),
+};
+
 /**
  * struct devfreq_event_ops - the operations of devfreq-event device
  *
@@ -215,8 +224,10 @@ struct devfreq_event_ops {
 	int (*enable)(struct devfreq_event_dev *event_dev);
 	int (*disable)(struct devfreq_event_dev *event_dev);
 	bool (*is_enabled)(struct devfreq_event_dev *event_dev);
-	int (*set_event)(struct devfreq_event_dev *event_dev);
-	int (*get_event)(struct devfreq_event_dev *event_dev, int *total_event);
+	int (*set_event)(struct devfreq_event_dev *event_dev,
+			enum devfreq_event_type);
+	int (*get_event)(struct devfreq_event_dev *event_dev,
+			enum devfreq_event_type, int *total_event);
 	int (*reset)(struct devfreq_event_dev *event_dev);
 };
 
@@ -225,6 +236,10 @@ struct devfreq_event_ops {
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
@@ -233,6 +248,7 @@ struct devfreq_event_ops {
 struct devfreq_event_desc {
 	const char *name;
 	void *driver_data;
+	enum devfreq_event_type event_type;
 
 	struct devfreq_event_ops *ops;
 };
@@ -277,8 +293,10 @@ extern int devfreq_put_event_dev(struct devfreq_event_dev *event_dev);
 extern int devfreq_enable_event_dev(struct devfreq_event_dev *event_dev);
 extern int devfreq_disable_event_dev(struct devfreq_event_dev *event_dev);
 extern bool devfreq_is_enabled_event_dev(struct devfreq_event_dev *event_dev);
-extern int devfreq_set_event_event_dev(struct devfreq_event_dev *event_dev);
+extern int devfreq_set_event_event_dev(struct devfreq_event_dev *event_dev,
+					enum devfreq_event_type event_type);
 extern int devfreq_get_event_event_dev(struct devfreq_event_dev *event_dev,
+					enum devfreq_event_type event_type,
 					int *total_event);
 extern int devfreq_reset_event_dev(struct devfreq_event_dev *event_dev);
 
@@ -414,13 +432,15 @@ static inline bool devfreq_is_enabled_event_dev(
 }
 
 static inline int devfreq_set_event_event_dev(
-				struct devfreq_event_dev *event_dev)
+				struct devfreq_event_dev *event_dev,
+				enum devfreq_event_type event_type);
 {
 	return -EINVAL;
 }
 
 static inline int devfreq_get_event_event_dev(
 				struct devfreq_event_dev *event_dev,
+				enum devfreq_event_type event_type,
 				int *total_event);
 {
 	return -EINVAL;
-- 
1.8.5.5
