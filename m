From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 14/16] PM / OPP: Add dev_pm_opp_set_regulator() to specify regulator
Date: Fri, 11 Sep 2015 17:32:10 +0530
Message-ID: <1d8a3dabc6a0f46d1e94df0cbfec894c74e023a3.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, lee.jones@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

The new OPP V2 bindings have a way to find supplies for a particular
device. But the old V1 bindings doesn't have any API to do it today.

This is required in order to move the complexity of switching OPPs (i.e.
changing clock and voltages), into the OPP core, rather then keeping
that in individual drivers.

This patch adds another API, to be used only for V1 bindings, which
first finds the regulator for the dev_opp and then disables all OPPs
that aren't supported by the regulator.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 74 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pm_opp.h        |  6 ++++
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index a04dcacb8a07..4ee0911b97ea 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -970,6 +970,73 @@ static bool opp_supported_by_regulators(struct dev_pm_opp *opp,
 	return true;
 }
 
+/**
+ * dev_pm_opp_set_regulator() - Set regulator for the device OPP
+ * @dev: Device for which the regulator has to be set.
+ * @id: String used to find regulator.
+ *
+ * This is only required for the V1 bindings, as regulator is automatically
+ * found for the V2 bindings. OPP core finds a regulator with name <reg>-supply,
+ * and then get/put it automatically. The name of the debugfs files isn't
+ * changed however, to keep it simple. They are named as <dev_name>_*.
+ */
+int dev_pm_opp_set_regulator(struct device *dev, const char *id)
+{
+	struct device_opp *dev_opp;
+	struct dev_pm_opp *opp;
+	struct regulator *reg;
+	int ret = 0;
+
+	rcu_read_lock();
+
+	dev_opp = _find_device_opp(dev);
+	if (IS_ERR(dev_opp)) {
+		ret = PTR_ERR(dev_opp);
+		dev_err(dev, "%s: no device opp found: %d\n", __func__, ret);
+		goto unlock;
+	}
+
+	/* Do we already have a regulator attached to this dev_opp? */
+	if (!IS_ERR_OR_NULL(*dev_opp->regulators)) {
+		dev_err(dev, "%s: can't add (%s), regulator already present\n",
+			__func__, id);
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	reg = regulator_get_optional(dev, id);
+
+	/*
+	 * Few platforms may not have regulators for the device, and we need to
+	 * save error number in that case as well.
+	 */
+	*dev_opp->regulators = reg;
+
+	if (IS_ERR(reg)) {
+		ret = PTR_ERR(reg);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "%s: no regulator (%s) found: %d\n",
+				__func__, id, ret);
+		goto unlock;
+	}
+
+	list_for_each_entry_rcu(opp, &dev_opp->opp_list, node) {
+		/* Disable OPPs, that aren't supported by the regulator */
+		if (opp_supported_by_regulators(opp, dev_opp))
+			continue;
+
+		opp->available = false;
+		dev_warn(dev, "%s: disabled OPP (%lu), not supported by regulator (%s)\n",
+			 __func__, opp->rate, id);
+	}
+
+unlock:
+	rcu_read_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_regulator);
+
 /* returns the number of entries used from microvolt */
 static void opp_parse_single_supply(struct opp_supply *supply, bool triplet,
 				    u32 *microvolt, u32 *microamp)
@@ -1493,9 +1560,14 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 		if (IS_ERR(reg)) {
 			ret = PTR_ERR(reg);
 			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "%s: deferring, no regulator (%s) found: %d\n",
+					__func__, *name, ret);
+			/* Regulator may not be compulsory for the device */
+			if (!string_count)
 				dev_err(dev, "%s: no regulator (%s) found: %d\n",
 					__func__, *name, ret);
-			goto free_table;
+			else
+				goto free_table;
 		}
 		dev_opp->regulators[count] = reg;
 	}
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index e36f347ff32b..e8aee03b974a 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -57,6 +57,7 @@ int dev_pm_opp_enable(struct device *dev, unsigned long freq);
 int dev_pm_opp_disable(struct device *dev, unsigned long freq);
 
 struct srcu_notifier_head *dev_pm_opp_get_notifier(struct device *dev);
+int dev_pm_opp_set_regulator(struct device *dev, const char *id);
 #else
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
@@ -141,6 +142,11 @@ static inline struct srcu_notifier_head *dev_pm_opp_get_notifier(
 {
 	return ERR_PTR(-EINVAL);
 }
+
+static inline int dev_pm_opp_set_regulator(struct device *dev, const char *id)
+{
+	return -EINVAL;
+}
 #endif		/* CONFIG_PM_OPP */
 
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
-- 
2.4.0
