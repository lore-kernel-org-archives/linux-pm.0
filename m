From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 09/10] PM / OPP: Don't expose srcu_head to register notifiers
Date: Mon,  2 Jan 2017 14:41:03 +0530
Message-ID: <9fd836f5bc197a04c9879054a8dd469028679d8b.1483348138.git.viresh.kumar@linaro.org>
References: <cover.1483348138.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35669 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932499AbdABJLo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jan 2017 04:11:44 -0500
Received: by mail-pg0-f46.google.com with SMTP id i5so137280184pgh.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Jan 2017 01:11:44 -0800 (PST)
In-Reply-To: <cover.1483348138.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1483348138.git.viresh.kumar@linaro.org>
References: <cover.1483348138.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

Let the OPP core provide helpers to register notifiers for any device,
instead of exposing srcu_head outside of the core.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/power/opp/core.c | 66 ++++++++++++++++++++++++++++++++-----------
 drivers/devfreq/devfreq.c     | 26 ++---------------
 include/linux/pm_opp.h        | 14 ++++++---
 3 files changed, 62 insertions(+), 44 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 614d779ab6a2..f35effad60d1 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -1860,29 +1860,63 @@ int dev_pm_opp_disable(struct device *dev, unsigned long freq)
 EXPORT_SYMBOL_GPL(dev_pm_opp_disable);
 
 /**
- * dev_pm_opp_get_notifier() - find notifier_head of the device with opp
- * @dev:	device pointer used to lookup OPP table.
+ * dev_pm_opp_register_notifier() - Register OPP notifier for the device
+ * @dev:	Device for which notifier needs to be registered
+ * @nb:		Notifier block to be registered
  *
- * Return: pointer to  notifier head if found, otherwise -ENODEV or
- * -EINVAL based on type of error casted as pointer. value must be checked
- *  with IS_ERR to determine valid pointer or error result.
+ * Return: 0 on success or a negative error value.
+ */
+int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb)
+{
+	struct opp_table *opp_table;
+	int ret;
+
+	rcu_read_lock();
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
+		goto unlock;
+	}
+
+	ret = srcu_notifier_chain_register(&opp_table->srcu_head, nb);
+
+unlock:
+	rcu_read_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL(dev_pm_opp_register_notifier);
+
+/**
+ * dev_pm_opp_unregister_notifier() - Unregister OPP notifier for the device
+ * @dev:	Device for which notifier needs to be unregistered
+ * @nb:		Notifier block to be unregistered
  *
- * Locking: This function must be called under rcu_read_lock(). opp_table is a
- * RCU protected pointer. The reason for the same is that the opp pointer which
- * is returned will remain valid for use with opp_get_{voltage, freq} only while
- * under the locked area. The pointer returned must be used prior to unlocking
- * with rcu_read_unlock() to maintain the integrity of the pointer.
+ * Return: 0 on success or a negative error value.
  */
-struct srcu_notifier_head *dev_pm_opp_get_notifier(struct device *dev)
+int dev_pm_opp_unregister_notifier(struct device *dev,
+				   struct notifier_block *nb)
 {
-	struct opp_table *opp_table = _find_opp_table(dev);
+	struct opp_table *opp_table;
+	int ret;
 
-	if (IS_ERR(opp_table))
-		return ERR_CAST(opp_table); /* matching type */
+	rcu_read_lock();
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
+		goto unlock;
+	}
+
+	ret = srcu_notifier_chain_unregister(&opp_table->srcu_head, nb);
 
-	return &opp_table->srcu_head;
+unlock:
+	rcu_read_unlock();
+
+	return ret;
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_get_notifier);
+EXPORT_SYMBOL(dev_pm_opp_unregister_notifier);
 
 /*
  * Free OPPs either created using static entries present in DT or even the
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index a324801d6a66..b0de42972b74 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1260,18 +1260,7 @@ EXPORT_SYMBOL(devfreq_recommended_opp);
  */
 int devfreq_register_opp_notifier(struct device *dev, struct devfreq *devfreq)
 {
-	struct srcu_notifier_head *nh;
-	int ret = 0;
-
-	rcu_read_lock();
-	nh = dev_pm_opp_get_notifier(dev);
-	if (IS_ERR(nh))
-		ret = PTR_ERR(nh);
-	rcu_read_unlock();
-	if (!ret)
-		ret = srcu_notifier_chain_register(nh, &devfreq->nb);
-
-	return ret;
+	return dev_pm_opp_register_notifier(dev, &devfreq->nb);
 }
 EXPORT_SYMBOL(devfreq_register_opp_notifier);
 
@@ -1287,18 +1276,7 @@ EXPORT_SYMBOL(devfreq_register_opp_notifier);
  */
 int devfreq_unregister_opp_notifier(struct device *dev, struct devfreq *devfreq)
 {
-	struct srcu_notifier_head *nh;
-	int ret = 0;
-
-	rcu_read_lock();
-	nh = dev_pm_opp_get_notifier(dev);
-	if (IS_ERR(nh))
-		ret = PTR_ERR(nh);
-	rcu_read_unlock();
-	if (!ret)
-		ret = srcu_notifier_chain_unregister(nh, &devfreq->nb);
-
-	return ret;
+	return dev_pm_opp_unregister_notifier(dev, &devfreq->nb);
 }
 EXPORT_SYMBOL(devfreq_unregister_opp_notifier);
 
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 7483ff291a8e..66a02deeb03f 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -108,7 +108,9 @@ int dev_pm_opp_enable(struct device *dev, unsigned long freq);
 
 int dev_pm_opp_disable(struct device *dev, unsigned long freq);
 
-struct srcu_notifier_head *dev_pm_opp_get_notifier(struct device *dev);
+int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb);
+int dev_pm_opp_unregister_notifier(struct device *dev, struct notifier_block *nb);
+
 int dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions,
 				unsigned int count);
 void dev_pm_opp_put_supported_hw(struct device *dev);
@@ -202,10 +204,14 @@ static inline int dev_pm_opp_disable(struct device *dev, unsigned long freq)
 	return 0;
 }
 
-static inline struct srcu_notifier_head *dev_pm_opp_get_notifier(
-							struct device *dev)
+static inline int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb)
 {
-	return ERR_PTR(-ENOTSUPP);
+	return -ENOTSUPP;
+}
+
+static inline int dev_pm_opp_unregister_notifier(struct device *dev, struct notifier_block *nb)
+{
+	return -ENOTSUPP;
 }
 
 static inline int dev_pm_opp_set_supported_hw(struct device *dev,
-- 
2.7.1.410.g6faf27b

