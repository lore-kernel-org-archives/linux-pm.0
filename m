From: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
Subject: [PATCH 6/8] PM / OPP: Support adjusting OPP voltages at runtime
Date: Thu, 16 May 2019 17:08:43 +0800
Message-ID: <1557997725-12178-7-git-send-email-andrew-sh.cheng@mediatek.com>
References: <1557997725-12178-1-git-send-email-andrew-sh.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1557997725-12178-1-git-send-email-andrew-sh.cheng@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Stephen
 Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com, linux-pm@vger.kernel.org, Roger Lu <roger.lu@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, fan.chen@mediatek.com, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

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

This patch is devired from [1] submitted by Stephen.
[1] https://lore.kernel.org/patchwork/patch/599279/

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Roger Lu <roger.lu@mediatek.com>
---
 drivers/opp/core.c     | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h | 11 +++++++
 2 files changed, 89 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 0420f7e8ad5b..879ca5f50d1a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1946,6 +1946,84 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 	return r;
 }
 
+/*
+ * dev_pm_opp_adjust_voltage() - helper to change the voltage of an OPP
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
+			      unsigned long u_volt)
+{
+	struct opp_table *opp_table;
+	struct dev_pm_opp *new_opp, *tmp_opp, *opp = ERR_PTR(-ENODEV);
+	int r = 0;
+
+	/* Find the opp_table */
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		r = PTR_ERR(opp_table);
+		dev_warn(dev, "%s: Device OPP not found (%d)\n", __func__, r);
+		return r;
+	}
+
+	/* keep the node allocated */
+	new_opp = kmalloc(sizeof(*new_opp), GFP_KERNEL);
+	if (!new_opp)
+		return -ENOMEM;
+
+	mutex_lock(&opp_table->lock);
+
+	/* Do we have the frequency? */
+	list_for_each_entry(tmp_opp, &opp_table->opp_list, node) {
+		if (tmp_opp->rate == freq) {
+			opp = tmp_opp;
+			break;
+		}
+	}
+
+	if (IS_ERR(opp)) {
+		r = PTR_ERR(opp);
+		goto unlock;
+	}
+
+	/* Is update really needed? */
+	if (opp->supplies->u_volt == u_volt)
+		goto unlock;
+
+	/* copy the old data over */
+	*new_opp = *opp;
+
+	/* plug in new node */
+	new_opp->supplies->u_volt = u_volt;
+
+	list_replace_rcu(&opp->node, &new_opp->node);
+	mutex_unlock(&opp_table->lock);
+
+	/* Notify the change of the OPP */
+	blocking_notifier_call_chain(&opp_table->head, OPP_EVENT_ADJUST_VOLTAGE,
+				     opp);
+
+	return 0;
+
+unlock:
+	mutex_unlock(&opp_table->lock);
+	kfree(new_opp);
+	return r;
+}
+
 /**
  * dev_pm_opp_enable() - Enable a specific OPP
  * @dev:	device for which we do this operation
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 24c757a32a7b..70219fe3ca20 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -25,6 +25,7 @@ struct opp_table;
 
 enum dev_pm_opp_event {
 	OPP_EVENT_ADD, OPP_EVENT_REMOVE, OPP_EVENT_ENABLE, OPP_EVENT_DISABLE,
+	OPP_EVENT_ADJUST_VOLTAGE,
 };
 
 /**
@@ -112,6 +113,9 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq,
 void dev_pm_opp_remove(struct device *dev, unsigned long freq);
 void dev_pm_opp_remove_all_dynamic(struct device *dev);
 
+int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
+			      unsigned long u_volt);
+
 int dev_pm_opp_enable(struct device *dev, unsigned long freq);
 
 int dev_pm_opp_disable(struct device *dev, unsigned long freq);
@@ -229,6 +233,13 @@ static inline void dev_pm_opp_remove_all_dynamic(struct device *dev)
 {
 }
 
+static inline int
+dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
+			  unsigned long u_volt)
+{
+	return 0;
+}
+
 static inline int dev_pm_opp_enable(struct device *dev, unsigned long freq)
 {
 	return 0;
-- 
2.12.5
