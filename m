From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [RFC PATCHv2 3/7] devfreq: event: Add the exclusive flag for
 devfreq-event device
Date: Tue, 09 Dec 2014 23:13:02 +0900
Message-ID: <1418134386-14681-4-git-send-email-cw00.choi@samsung.com>
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

This patch adds the exclusive flag for devfreq-event device. If the specific
devfreq-event device should be used in only one devfreq device driver,
devfreq driver have to use 'devfreq_enable_event_dev_exclusive()' function
to consist integrity of event data.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq-event.c | 44 +++++++++++++++++++++++++++++++++++++++++
 include/linux/devfreq.h         | 17 ++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index a71fcee..e7ce5ba 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -142,6 +142,9 @@ int devfreq_enable_event_dev(struct devfreq_event_dev *event_dev)
 	if (!event_dev || !event_dev->desc)
 		return -EINVAL;
 
+	if (event_dev->event_flag & DEVFREQ_EVENT_FLAG_EXCLUSIVE)
+		return -EBUSY;
+
 	mutex_lock(&event_dev->lock);
 	if (event_dev->desc->ops && event_dev->desc->ops->enable) {
 		ret = event_dev->desc->ops->enable(event_dev);
@@ -156,6 +159,29 @@ err:
 }
 EXPORT_SYMBOL_GPL(devfreq_enable_event_dev);
 
+int devfreq_enable_event_dev_exclusive(struct devfreq_event_dev *event_dev)
+{
+	int ret;
+
+	if (!event_dev || !event_dev->desc)
+		return -EINVAL;
+
+	if (event_dev->event_flag & DEVFREQ_EVENT_FLAG_EXCLUSIVE)
+		return -EBUSY;
+
+	ret = devfreq_enable_event_dev(event_dev);
+	if (ret < 0)
+		return ret;
+
+	/* Set exclusive flag to devfreq-event device */
+	mutex_lock(&event_dev->lock);
+	event_dev->event_flag |= DEVFREQ_EVENT_FLAG_EXCLUSIVE;
+	mutex_unlock(&event_dev->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devfreq_enable_event_dev_exclusive);
+
 int devfreq_disable_event_dev(struct devfreq_event_dev *event_dev)
 {
 	int ret = 0;
@@ -163,6 +189,9 @@ int devfreq_disable_event_dev(struct devfreq_event_dev *event_dev)
 	if (!event_dev || !event_dev->desc)
 		return -EINVAL;
 
+	if (event_dev->event_flag & DEVFREQ_EVENT_FLAG_EXCLUSIVE)
+		return -EBUSY;
+
 	mutex_lock(&event_dev->lock);
 	if (event_dev->enable_count > 0) {
 		event_dev->enable_count--;
@@ -196,6 +225,9 @@ bool devfreq_is_enabled_event_dev(struct devfreq_event_dev *event_dev)
 	if (!(event_dev->enable_count > 0))
 		return enabled;
 
+	if (event_dev->event_flag & DEVFREQ_EVENT_FLAG_EXCLUSIVE)
+		return -EBUSY;
+
 	if (event_dev->desc->ops && event_dev->desc->ops->is_enabled)
 		enabled = event_dev->desc->ops->is_enabled(event_dev);
 
@@ -212,6 +244,9 @@ int devfreq_set_event_event_dev(struct devfreq_event_dev *event_dev,
 	if (!devfreq_is_enabled_event_dev(event_dev))
 		return -EPERM;
 
+	if (event_dev->event_flag & DEVFREQ_EVENT_FLAG_EXCLUSIVE)
+		return -EBUSY;
+
 	if ((event_dev->desc->event_type & event_type) == 0) {
 		dev_err(&event_dev->dev, "unsupported of devfreq-event type\n");
 		return -EINVAL;
@@ -236,6 +271,9 @@ int devfreq_get_event_event_dev(struct devfreq_event_dev *event_dev,
 	if (!devfreq_is_enabled_event_dev(event_dev))
 		return -EPERM;
 
+	if (event_dev->event_flag & DEVFREQ_EVENT_FLAG_EXCLUSIVE)
+		return -EBUSY;
+
 	if ((event_dev->desc->event_type & event_type) == 0) {
 		dev_err(&event_dev->dev, "unsupported of devfreq-event type\n");
 		return -EINVAL;
@@ -259,6 +297,9 @@ int devfreq_reset_event_dev(struct devfreq_event_dev *event_dev)
 	if (!devfreq_is_enabled_event_dev(event_dev))
 		return -EPERM;
 
+	if (event_dev->event_flag & DEVFREQ_EVENT_FLAG_EXCLUSIVE)
+		return -EBUSY;
+
 	if (event_dev->desc->ops && event_dev->desc->ops->reset)
 		return event_dev->desc->ops->reset(event_dev);
 
@@ -268,6 +309,9 @@ EXPORT_SYMBOL_GPL(devfreq_reset_event_dev);
 
 void *event_dev_get_drvdata(struct devfreq_event_dev *event_dev)
 {
+	if (event_dev->event_flag & DEVFREQ_EVENT_FLAG_EXCLUSIVE)
+		return ERR_PTR(-EBUSY);
+
 	return event_dev->desc->driver_data;
 }
 EXPORT_SYMBOL_GPL(event_dev_get_drvdata);
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index f6d44b7..e7fedea 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -175,6 +175,12 @@ struct devfreq {
 	unsigned long last_stat_updated;
 };
 
+/* The supported flags by devfreq-event device */
+enum devfreq_event_flag {
+	DEVFREQ_EVENT_FLAG_NONE		= BIT(0),
+	DEVFREQ_EVENT_FLAG_EXCLUSIVE	= BIT(1),
+};
+
 /**
  * struct devfreq_event_dev - the devfreq-event device 
  *
@@ -194,6 +200,9 @@ struct devfreq_event_dev {
 	struct mutex lock;
 	u32 enable_count;
 
+	enum devfreq_event_flag event_flag;
+	unsigned int enabled_count;
+
 	const struct devfreq_event_desc *desc;
 };
 
@@ -291,6 +300,8 @@ extern struct devfreq_event_dev *devfreq_get_event_dev_by_phandle(
 				struct device *dev, int index);
 extern int devfreq_put_event_dev(struct devfreq_event_dev *event_dev);
 extern int devfreq_enable_event_dev(struct devfreq_event_dev *event_dev);
+extern int devfreq_enable_event_dev_exclusive(
+					struct devfreq_event_dev *event_dev);
 extern int devfreq_disable_event_dev(struct devfreq_event_dev *event_dev);
 extern bool devfreq_is_enabled_event_dev(struct devfreq_event_dev *event_dev);
 extern int devfreq_set_event_event_dev(struct devfreq_event_dev *event_dev,
@@ -419,6 +430,12 @@ static inline int devfreq_enable_event_dev(struct devfreq_event_dev *event_dev)
 	return -EINVAL;
 }
 
+static inline int devfreq_enable_event_dev_exclusive(
+					struct devfreq_event_dev *event_dev)
+{
+	return -EINVAL;
+}
+
 static inline int devfreq_disable_event_dev(
 				struct devfreq_event_dev *event_dev)
 {
-- 
1.8.5.5
