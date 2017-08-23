From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 1/7] PM / OPP: Add platform specific set_clk function
Date: Thu, 24 Aug 2017 00:10:04 +0800
Message-ID: <1503504610-12880-2-git-send-email-aisheng.dong@nxp.com>
References: <1503504610-12880-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1503504610-12880-1-git-send-email-aisheng.dong@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-pm@vger.kernel.org
Cc: nm@ti.com, rjw@rjwysocki.net, ping.bai@nxp.com, Anson.Huang@nxp.com, vireshk@kernel.org, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, shawnguo@kernel.org, Dong Aisheng <aisheng.dong@nxp.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This is useful to support platforms which only the clk setting is
different from the generic OPP set rate but others like voltage
setting are still the same.

Users can use this function to register a custom OPP set clk helper
working in place of the default simple clk setting in the generic
dev_pm_opp_set_rate(). Then user can still use dev_pm_opp_set_rate()
with .set_clk() to save a lot duplicated work.

Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/base/power/opp/core.c | 90 ++++++++++++++++++++++++++++++++++++++++---
 drivers/base/power/opp/opp.h  |  4 ++
 include/linux/pm_opp.h        | 13 +++++++
 3 files changed, 102 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index a8cc14f..37cf970 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -521,12 +521,15 @@ static int _set_opp_voltage(struct device *dev, struct regulator *reg,
 }
 
 static inline int
-_generic_set_opp_clk_only(struct device *dev, struct clk *clk,
+_generic_set_opp_clk_only(const struct opp_table *opp_table, struct device *dev,
 			  unsigned long old_freq, unsigned long freq)
 {
 	int ret;
 
-	ret = clk_set_rate(clk, freq);
+	if (opp_table->set_clk)
+		return opp_table->set_clk(dev, opp_table->clk, old_freq, freq);
+
+	ret = clk_set_rate(opp_table->clk, freq);
 	if (ret) {
 		dev_err(dev, "%s: failed to set clock rate: %d\n", __func__,
 			ret);
@@ -559,7 +562,7 @@ static int _generic_set_opp_regulator(const struct opp_table *opp_table,
 	}
 
 	/* Change frequency */
-	ret = _generic_set_opp_clk_only(dev, opp_table->clk, old_freq, freq);
+	ret = _generic_set_opp_clk_only(opp_table, dev, old_freq, freq);
 	if (ret)
 		goto restore_voltage;
 
@@ -573,7 +576,7 @@ static int _generic_set_opp_regulator(const struct opp_table *opp_table,
 	return 0;
 
 restore_freq:
-	if (_generic_set_opp_clk_only(dev, opp_table->clk, freq, old_freq))
+	if (_generic_set_opp_clk_only(opp_table, dev, freq, old_freq))
 		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
 			__func__, old_freq);
 restore_voltage:
@@ -653,7 +656,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
 	/* Only frequency scaling */
 	if (!opp_table->regulators) {
-		ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
+		ret = _generic_set_opp_clk_only(opp_table, dev, old_freq, freq);
 	} else if (!opp_table->set_opp) {
 		ret = _generic_set_opp_regulator(opp_table, dev, old_freq, freq,
 						 IS_ERR(old_opp) ? NULL : old_opp->supplies,
@@ -1500,6 +1503,83 @@ void dev_pm_opp_register_put_opp_helper(struct opp_table *opp_table)
 EXPORT_SYMBOL_GPL(dev_pm_opp_register_put_opp_helper);
 
 /**
+ * dev_pm_opp_register_set_clk_helper() - Register custom OPP set clk helper
+ * @dev: Device for which the helper is getting registered.
+ * @set_clk: Custom OPP set clk helper.
+ *
+ * This is useful to support complex platforms which only the clk setting
+ * is different from the generic OPP set rate but others like voltage
+ * setting are still the same.
+ *
+ * Users can use this function to register a custom OPP set clk helper
+ * working in place of the default simple clk setting in the generic
+ * dev_pm_opp_set_rate().
+ *
+ * This must be called before any OPPs are initialized for the device.
+ */
+struct opp_table *dev_pm_opp_register_set_clk_helper(struct device *dev,
+		int (*set_clk)(struct device *dev, struct clk *clk,
+			       unsigned long old_freq, unsigned long freq))
+{
+	struct opp_table *opp_table;
+	int ret;
+
+	if (!set_clk)
+		return ERR_PTR(-EINVAL);
+
+	opp_table = dev_pm_opp_get_opp_table(dev);
+	if (!opp_table)
+		return ERR_PTR(-ENOMEM);
+
+	/* This should be called before OPPs are initialized */
+	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
+		ret = -EBUSY;
+		goto err;
+	}
+
+	/* Already have custom set_clk helper */
+	if (WARN_ON(opp_table->set_clk)) {
+		ret = -EBUSY;
+		goto err;
+	}
+
+	opp_table->set_clk = set_clk;
+
+	return opp_table;
+
+err:
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_register_set_clk_helper);
+
+/**
+ * dev_pm_opp_register_put_clk_helper() - Releases resources blocked for
+ *					   set_clk helper
+ * @opp_table: OPP table returned from dev_pm_opp_register_set_clk_helper().
+ *
+ * Release resources blocked for platform specific set_clk helper.
+ */
+void dev_pm_opp_register_put_clk_helper(struct opp_table *opp_table)
+{
+	if (!opp_table->set_clk) {
+		pr_err("%s: Doesn't have custom set_clk helper set\n",
+		       __func__);
+		return;
+	}
+
+	/* Make sure there are no concurrent readers while updating opp_table */
+	WARN_ON(!list_empty(&opp_table->opp_list));
+
+	opp_table->set_clk = NULL;
+
+	dev_pm_opp_put_opp_table(opp_table);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_register_put_clk_helper);
+
+
+/**
  * dev_pm_opp_add()  - Add an OPP table from a table definitions
  * @dev:	device for which we do this operation
  * @freq:	Frequency in Hz for this OPP
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 166eef9..c85405e 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -137,6 +137,8 @@ enum opp_table_access {
  * @regulator_count: Number of power supply regulators
  * @set_opp: Platform specific set_opp callback
  * @set_opp_data: Data to be passed to set_opp callback
+ * @set_clk:	Platform specific set_clk callback. Different from @set_opp,
+		@set_clk only handles the clk part setting.
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
  * @dentry_name: Name of the real dentry.
  *
@@ -174,6 +176,8 @@ struct opp_table {
 	int (*set_opp)(struct dev_pm_set_opp_data *data);
 	struct dev_pm_set_opp_data *set_opp_data;
 
+	int (*set_clk)(struct device *dev, struct clk *clk, unsigned long old_freq, unsigned long freq);
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
 	char dentry_name[NAME_MAX];
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 51ec727..a8b1e4d 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -125,6 +125,9 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 void dev_pm_opp_register_put_opp_helper(struct opp_table *opp_table);
+struct opp_table *dev_pm_opp_register_set_clk_helper(struct device *dev, int (*set_clk)(struct device *dev, struct clk *clk,
+											unsigned long old_freq, unsigned long freq));
+void dev_pm_opp_register_put_clk_helper(struct opp_table *opp_table);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
@@ -245,6 +248,16 @@ static inline struct opp_table *dev_pm_opp_register_set_opp_helper(struct device
 
 static inline void dev_pm_opp_register_put_opp_helper(struct opp_table *opp_table) {}
 
+
+static inline struct opp_table *dev_pm_opp_register_set_clk_helper(struct device *dev,
+			int (*set_clk)(struct device *dev, struct clk *clk,
+				       unsigned long old_freq, unsigned long freq))
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static inline void dev_pm_opp_register_put_clk_helper(struct opp_table *opp_table) {}
+
 static inline struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 {
 	return ERR_PTR(-ENOTSUPP);
-- 
2.7.4
