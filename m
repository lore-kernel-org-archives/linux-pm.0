From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 3/6] PM / OPP: Support adjusting OPP voltages at runtime
Date: Mon,  1 Jun 2015 18:47:56 -0700
Message-ID: <1433209679-31389-4-git-send-email-sboyd@codeaurora.org>
References: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <agross@codeaurora.org>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, David Collins <collinsd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On some SoCs the Adaptive Voltage Scaling (AVS) technique is
employed to optimize the operating voltage of a device. At a
given frequency, the hardware monitors dynamic factors and either
makes a suggestion for how much to adjust a voltage for the
current frequency, or it automatically adjusts the voltage
without software intervention. Add an API to the OPP library for
the former case, so that AVS type devices can update the voltages
for an OPP when the hardware determines the voltage should
change. The assumption is that drivers like CPUfreq or devfreq
will register for the OPP notifiers and adjust the voltage
according to suggestions that AVS makes.

Cc: Nishanth Menon <nm@ti.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

This should probably be cleanded up to share code with the enable/disable
APIs.

 drivers/base/power/opp.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h   | 10 +++++++
 2 files changed, 87 insertions(+)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 677fb2843553..b997a7eabcd4 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -748,6 +748,83 @@ unlock:
 }
 
 /**
+ * dev_pm_opp_adjust_voltage() - helper to change the voltage of an opp
+ * @dev:		device for which we do this operation
+ * @freq:		OPP frequency to adjust voltage of
+ * @u_volt:		new OPP voltage
+ *
+ * Change the voltage of an OPP with an RCU operation.
+ *
+ * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
+ * copy operation, returns 0 if no modifcation was done OR modification was
+ * successful.
+ *
+ * Locking: The internal device_opp and opp structures are RCU protected.
+ * Hence this function internally uses RCU updater strategy with mutex locks to
+ * keep the integrity of the internal data structures. Callers should ensure
+ * that this function is *NOT* called under RCU protection or in contexts where
+ * mutex locking or synchronize_rcu() blocking calls cannot be used.
+ */
+int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
+				 unsigned long u_volt)
+{
+	struct device_opp *dev_opp;
+	struct dev_pm_opp *new_opp, *tmp_opp, *opp = ERR_PTR(-ENODEV);
+	int r = 0;
+
+	/* keep the node allocated */
+	new_opp = kmalloc(sizeof(*new_opp), GFP_KERNEL);
+	if (!new_opp)
+		return -ENOMEM;
+
+	mutex_lock(&dev_opp_list_lock);
+
+	/* Find the device_opp */
+	dev_opp = _find_device_opp(dev);
+	if (IS_ERR(dev_opp)) {
+		r = PTR_ERR(dev_opp);
+		dev_warn(dev, "%s: Device OPP not found (%d)\n", __func__, r);
+		goto unlock;
+	}
+
+	/* Do we have the frequency? */
+	list_for_each_entry(tmp_opp, &dev_opp->opp_list, node) {
+		if (tmp_opp->rate == freq) {
+			opp = tmp_opp;
+			break;
+		}
+	}
+	if (IS_ERR(opp)) {
+		r = PTR_ERR(opp);
+		goto unlock;
+	}
+
+	/* Is update really needed? */
+	if (opp->u_volt == u_volt)
+		goto unlock;
+	/* copy the old data over */
+	*new_opp = *opp;
+
+	/* plug in new node */
+	new_opp->u_volt = u_volt;
+
+	list_replace_rcu(&opp->node, &new_opp->node);
+	mutex_unlock(&dev_opp_list_lock);
+	call_srcu(&dev_opp->srcu_head.srcu, &opp->rcu_head, _kfree_opp_rcu);
+
+	/* Notify the change of the OPP */
+	srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_ADJUST_VOLTAGE,
+				 new_opp);
+
+	return 0;
+
+unlock:
+	mutex_unlock(&dev_opp_list_lock);
+	kfree(new_opp);
+	return r;
+}
+
+/**
  * dev_pm_opp_enable() - Enable a specific OPP
  * @dev:	device for which we do this operation
  * @freq:	OPP frequency to enable
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index cec2d4540914..80f2c41e7daa 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -22,6 +22,7 @@ struct device;
 
 enum dev_pm_opp_event {
 	OPP_EVENT_ADD, OPP_EVENT_REMOVE, OPP_EVENT_ENABLE, OPP_EVENT_DISABLE,
+	OPP_EVENT_ADJUST_VOLTAGE,
 };
 
 #if defined(CONFIG_PM_OPP)
@@ -46,6 +47,9 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq,
 		   unsigned long u_volt);
 void dev_pm_opp_remove(struct device *dev, unsigned long freq);
 
+int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
+		   unsigned long u_volt);
+
 int dev_pm_opp_enable(struct device *dev, unsigned long freq);
 
 int dev_pm_opp_disable(struct device *dev, unsigned long freq);
@@ -95,6 +99,12 @@ static inline void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 {
 }
 
+static inline int dev_pm_opp_adjust_voltage(struct device *dev,
+		unsigned long freq, unsigned long u_volt)
+{
+	return 0;
+}
+
 static inline int dev_pm_opp_enable(struct device *dev, unsigned long freq)
 {
 	return 0;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
