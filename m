From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v7 04/20] PM / devfreq: Add new DEVFREQ_TRANSITION_NOTIFIER
 notifier
Date: Thu, 31 Mar 2016 18:05:49 +0900
Message-ID: <1459415165-32613-5-git-send-email-cw00.choi@samsung.com>
References: <1459415165-32613-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1459415165-32613-1-git-send-email-cw00.choi@samsung.com>
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

This patch adds the new DEVFREQ_TRANSITION_NOTIFIER notifier to send
the notification when the frequency of device is changed.
This notifier has two state as following:
- DEVFREQ_PRECHANGE  : Notify it before chaning the frequency of device
- DEVFREQ_POSTCHANGE : Notify it after changed the frequency of device

And this patch adds the resourced-managed function to release the resource
automatically when error happen.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
[m.reichl and linux.amoon: Tested it on exynos4412-odroidu3 board]
Tested-by: Markus Reichl <m.reichl@fivetechno.de>
Tested-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/devfreq/devfreq.c | 163 +++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/devfreq.h   |  59 ++++++++++++++++-
 2 files changed, 220 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 20a9422c2552..1d6c803804d5 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -189,6 +189,29 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
 	return ERR_PTR(-ENODEV);
 }
 
+static int devfreq_notify_transition(struct devfreq *devfreq,
+		struct devfreq_freqs *freqs, unsigned int state)
+{
+	if (!devfreq)
+		return -EINVAL;
+
+	switch (state) {
+	case DEVFREQ_PRECHANGE:
+		srcu_notifier_call_chain(&devfreq->transition_notifier_list,
+				DEVFREQ_PRECHANGE, freqs);
+		break;
+
+	case DEVFREQ_POSTCHANGE:
+		srcu_notifier_call_chain(&devfreq->transition_notifier_list,
+				DEVFREQ_POSTCHANGE, freqs);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* Load monitoring helper functions for governors use */
 
 /**
@@ -200,7 +223,8 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
  */
 int update_devfreq(struct devfreq *devfreq)
 {
-	unsigned long freq;
+	struct devfreq_freqs freqs;
+	unsigned long freq, cur_freq;
 	int err = 0;
 	u32 flags = 0;
 
@@ -234,10 +258,22 @@ int update_devfreq(struct devfreq *devfreq)
 		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
 	}
 
+	if (devfreq->profile->get_cur_freq)
+		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
+	else
+		cur_freq = devfreq->previous_freq;
+
+	freqs.old = cur_freq;
+	freqs.new = freq;
+	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
+
 	err = devfreq->profile->target(devfreq->dev.parent, &freq, flags);
 	if (err)
 		return err;
 
+	freqs.new = freq;
+	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
+
 	if (devfreq->profile->freq_table)
 		if (devfreq_update_status(devfreq, freq))
 			dev_err(&devfreq->dev,
@@ -542,6 +578,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_out;
 	}
 
+	srcu_init_notifier_head(&devfreq->transition_notifier_list);
+
 	mutex_unlock(&devfreq->lock);
 
 	mutex_lock(&devfreq_list_lock);
@@ -1310,6 +1348,129 @@ void devm_devfreq_unregister_opp_notifier(struct device *dev,
 }
 EXPORT_SYMBOL(devm_devfreq_unregister_opp_notifier);
 
+/**
+ * devfreq_register_notifier() - Register a driver with devfreq
+ * @devfreq:	The devfreq object.
+ * @nb:		The notifier block to register.
+ * @list:	DEVFREQ_TRANSITION_NOTIFIER.
+ */
+int devfreq_register_notifier(struct devfreq *devfreq,
+				struct notifier_block *nb,
+				unsigned int list)
+{
+	int ret = 0;
+
+	if (!devfreq)
+		return -EINVAL;
+
+	switch (list) {
+	case DEVFREQ_TRANSITION_NOTIFIER:
+		ret = srcu_notifier_chain_register(
+				&devfreq->transition_notifier_list, nb);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(devfreq_register_notifier);
+
+/*
+ * devfreq_unregister_notifier() - Unregister a driver with devfreq
+ * @devfreq:	The devfreq object.
+ * @nb:		The notifier block to be unregistered.
+ * @list:	DEVFREQ_TRANSITION_NOTIFIER.
+ */
+int devfreq_unregister_notifier(struct devfreq *devfreq,
+				struct notifier_block *nb,
+				unsigned int list)
+{
+	int ret = 0;
+
+	if (!devfreq)
+		return -EINVAL;
+
+	switch (list) {
+	case DEVFREQ_TRANSITION_NOTIFIER:
+		ret = srcu_notifier_chain_unregister(
+				&devfreq->transition_notifier_list, nb);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(devfreq_unregister_notifier);
+
+struct devfreq_notifier_devres {
+	struct devfreq *devfreq;
+	struct notifier_block *nb;
+	unsigned int list;
+};
+
+static void devm_devfreq_notifier_release(struct device *dev, void *res)
+{
+	struct devfreq_notifier_devres *this = res;
+
+	devfreq_unregister_notifier(this->devfreq, this->nb, this->list);
+}
+
+/**
+ * devm_devfreq_register_notifier()
+	- Resource-managed devfreq_register_notifier()
+ * @dev:	The devfreq user device. (parent of devfreq)
+ * @devfreq:	The devfreq object.
+ * @nb:		The notifier block to be unregistered.
+ * @list:	DEVFREQ_TRANSITION_NOTIFIER.
+ */
+int devm_devfreq_register_notifier(struct device *dev,
+				struct devfreq *devfreq,
+				struct notifier_block *nb,
+				unsigned int list)
+{
+	struct devfreq_notifier_devres *ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_devfreq_notifier_release, sizeof(*ptr),
+				GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = devfreq_register_notifier(devfreq, nb, list);
+	if (ret) {
+		devres_free(ptr);
+		return ret;
+	}
+
+	ptr->devfreq = devfreq;
+	ptr->nb = nb;
+	ptr->list = list;
+	devres_add(dev, ptr);
+
+	return 0;
+}
+EXPORT_SYMBOL(devm_devfreq_register_notifier);
+
+/**
+ * devm_devfreq_unregister_notifier()
+	- Resource-managed devfreq_unregister_notifier()
+ * @dev:	The devfreq user device. (parent of devfreq)
+ * @devfreq:	The devfreq object.
+ * @nb:		The notifier block to be unregistered.
+ * @list:	DEVFREQ_TRANSITION_NOTIFIER.
+ */
+void devm_devfreq_unregister_notifier(struct device *dev,
+				struct devfreq *devfreq,
+				struct notifier_block *nb,
+				unsigned int list)
+{
+	WARN_ON(devres_release(dev, devm_devfreq_notifier_release,
+			       devm_devfreq_dev_match, devfreq));
+}
+EXPORT_SYMBOL(devm_devfreq_unregister_notifier);
+
 MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
 MODULE_DESCRIPTION("devfreq class support");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index aa0b8424ebc3..98c699304e12 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -19,6 +19,13 @@
 
 #define DEVFREQ_NAME_LEN 16
 
+/* DEVFREQ notifier interface */
+#define DEVFREQ_TRANSITION_NOTIFIER	(0)
+
+/* Transition notifiers of DEVFREQ_TRANSITION_NOTIFIER */
+#define	DEVFREQ_PRECHANGE		(0)
+#define DEVFREQ_POSTCHANGE		(1)
+
 struct devfreq;
 
 /**
@@ -143,6 +150,7 @@ struct devfreq_governor {
  * @trans_table:	Statistics of devfreq transitions
  * @time_in_state:	Statistics of devfreq states
  * @last_stat_updated:	The last time stat updated
+ * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
  *
  * This structure stores the devfreq information for a give device.
  *
@@ -177,6 +185,13 @@ struct devfreq {
 	unsigned int *trans_table;
 	unsigned long *time_in_state;
 	unsigned long last_stat_updated;
+
+	struct srcu_notifier_head transition_notifier_list;
+};
+
+struct devfreq_freqs {
+	unsigned long old;
+	unsigned long new;
 };
 
 #if defined(CONFIG_PM_DEVFREQ)
@@ -207,7 +222,20 @@ extern int devm_devfreq_register_opp_notifier(struct device *dev,
 					      struct devfreq *devfreq);
 extern void devm_devfreq_unregister_opp_notifier(struct device *dev,
 						struct devfreq *devfreq);
-
+extern int devfreq_register_notifier(struct devfreq *devfreq,
+					struct notifier_block *nb,
+					unsigned int list);
+extern int devfreq_unregister_notifier(struct devfreq *devfreq,
+					struct notifier_block *nb,
+					unsigned int list);
+extern int devm_devfreq_register_notifier(struct device *dev,
+				struct devfreq *devfreq,
+				struct notifier_block *nb,
+				unsigned int list);
+extern void devm_devfreq_unregister_notifier(struct device *dev,
+				struct devfreq *devfreq,
+				struct notifier_block *nb,
+				unsigned int list);
 extern struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
 						int index);
 
@@ -310,6 +338,35 @@ static inline void devm_devfreq_unregister_opp_notifier(struct device *dev,
 {
 }
 
+static inline int devfreq_register_notifier(struct devfreq *devfreq,
+					struct notifier_block *nb,
+					unsigned int list)
+{
+	return 0;
+}
+
+static inline int devfreq_unregister_notifier(struct devfreq *devfreq,
+					struct notifier_block *nb,
+					unsigned int list)
+{
+	return 0;
+}
+
+static inline int devm_devfreq_register_notifier(struct device *dev,
+				struct devfreq *devfreq,
+				struct notifier_block *nb,
+				unsigned int list)
+{
+	return 0;
+}
+
+static inline void devm_devfreq_unregister_notifier(struct device *dev,
+				struct devfreq *devfreq,
+				struct notifier_block *nb,
+				unsigned int list)
+{
+}
+
 static inline struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
 							int index)
 {
-- 
1.9.1
