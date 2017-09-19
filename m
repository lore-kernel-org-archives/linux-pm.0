From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V10 2/7] PM / OPP: Support updating performance state of device's power domains
Date: Tue, 19 Sep 2017 15:32:18 -0700
Message-ID: <8850bb5088dc6fec4463247b0ec5040ce6415f2d.1505859768.git.viresh.kumar@linaro.org>
References: <cover.1505859768.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1505859768.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1505859768.git.viresh.kumar@linaro.org>
References: <cover.1505859768.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
List-Id: linux-pm@vger.kernel.org

The genpd framework now provides an API to request device's power
domain to update its performance state based on a particular target
frequency for the device.

Use that interface from the OPP core for devices whose power domains
support performance states.

Note that the current implementation is restricted to the case where the
device doesn't have separate regulators for itself. We shouldn't
over engineer the code before we have real use case for them. We can
always come back and add more code to support such cases later on.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 48 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/base/power/opp/opp.h  |  2 ++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index a8cc14fd8ae4..4360b4efcd4c 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
 
 #include "opp.h"
@@ -535,6 +536,42 @@ _generic_set_opp_clk_only(struct device *dev, struct clk *clk,
 	return ret;
 }
 
+static inline int
+_generic_set_opp_domain(struct device *dev, struct clk *clk,
+			unsigned long old_freq, unsigned long freq)
+{
+	int ret;
+
+	/* Scaling up? Scale domain performance state before frequency */
+	if (freq > old_freq) {
+		ret = dev_pm_genpd_update_performance_state(dev, freq);
+		if (ret)
+			return ret;
+	}
+
+	ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
+	if (ret)
+		goto restore_domain_state;
+
+	/* Scaling down? Scale domain performance state after frequency */
+	if (freq < old_freq) {
+		ret = dev_pm_genpd_update_performance_state(dev, freq);
+		if (ret)
+			goto restore_freq;
+	}
+
+	return 0;
+
+restore_freq:
+	if (_generic_set_opp_clk_only(dev, clk, freq, old_freq))
+		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
+			__func__, old_freq);
+restore_domain_state:
+	dev_pm_genpd_update_performance_state(dev, old_freq);
+
+	return ret;
+}
+
 static int _generic_set_opp_regulator(const struct opp_table *opp_table,
 				      struct device *dev,
 				      unsigned long old_freq,
@@ -653,7 +690,14 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
 	/* Only frequency scaling */
 	if (!opp_table->regulators) {
-		ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
+		/*
+		 * We don't support devices with both regulator and
+		 * domain performance-state for now.
+		 */
+		if (opp_table->genpd_performance_state)
+			ret = _generic_set_opp_domain(dev, clk, old_freq, freq);
+		else
+			ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
 	} else if (!opp_table->set_opp) {
 		ret = _generic_set_opp_regulator(opp_table, dev, old_freq, freq,
 						 IS_ERR(old_opp) ? NULL : old_opp->supplies,
@@ -755,6 +799,8 @@ static struct opp_table *_allocate_opp_table(struct device *dev)
 				ret);
 	}
 
+	opp_table->genpd_performance_state = dev_pm_genpd_has_performance_state(dev);
+
 	BLOCKING_INIT_NOTIFIER_HEAD(&opp_table->head);
 	INIT_LIST_HEAD(&opp_table->opp_list);
 	mutex_init(&opp_table->lock);
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 166eef990599..1efa253e1934 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -135,6 +135,7 @@ enum opp_table_access {
  * @clk: Device's clock handle
  * @regulators: Supply regulators
  * @regulator_count: Number of power supply regulators
+ * @genpd_performance_state: Device's power domain support performance state.
  * @set_opp: Platform specific set_opp callback
  * @set_opp_data: Data to be passed to set_opp callback
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
@@ -170,6 +171,7 @@ struct opp_table {
 	struct clk *clk;
 	struct regulator **regulators;
 	unsigned int regulator_count;
+	bool genpd_performance_state;
 
 	int (*set_opp)(struct dev_pm_set_opp_data *data);
 	struct dev_pm_set_opp_data *set_opp_data;
-- 
2.7.4
