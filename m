From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V11 2/7] OPP: Support updating performance state of device's power domain
Date: Wed, 11 Oct 2017 12:54:14 +0530
Message-ID: <7a774b46d24856d6899f507e7d41fa0f7cace336.1507703370.git.viresh.kumar@linaro.org>
References: <cover.1507703370.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1507703370.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1507703370.git.viresh.kumar@linaro.org>
References: <cover.1507703370.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
List-Id: linux-pm@vger.kernel.org

The genpd framework now provides an API to request device's power domain
to update its performance state.  Use that interface from the OPP core
for devices whose power domains support performance states.

Note that this commit doesn't add any mechanism by which performance
states are made available to the OPP core. That would be done by a
later commit.

Note that the current implementation is restricted to the case where the
device doesn't have separate regulators for itself. We shouldn't
over engineer the code before we have real use case for them. We can
always come back and add more code to support such cases later on.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c    | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/opp/debugfs.c |  3 +++
 drivers/opp/opp.h     |  4 ++++
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 80c21207e48c..0ce8069d6843 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
 
 #include "opp.h"
@@ -535,6 +536,44 @@ _generic_set_opp_clk_only(struct device *dev, struct clk *clk,
 	return ret;
 }
 
+static inline int
+_generic_set_opp_domain(struct device *dev, struct clk *clk,
+			unsigned long old_freq, unsigned long freq,
+			unsigned int old_pstate, unsigned int new_pstate)
+{
+	int ret;
+
+	/* Scaling up? Scale domain performance state before frequency */
+	if (freq > old_freq) {
+		ret = dev_pm_genpd_set_performance_state(dev, new_pstate);
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
+		ret = dev_pm_genpd_set_performance_state(dev, new_pstate);
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
+	if (freq > old_freq)
+		dev_pm_genpd_set_performance_state(dev, old_pstate);
+
+	return ret;
+}
+
 static int _generic_set_opp_regulator(const struct opp_table *opp_table,
 				      struct device *dev,
 				      unsigned long old_freq,
@@ -653,7 +692,16 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
 	/* Only frequency scaling */
 	if (!opp_table->regulators) {
-		ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
+		/*
+		 * We don't support devices with both regulator and
+		 * domain performance-state for now.
+		 */
+		if (opp_table->genpd_performance_state)
+			ret = _generic_set_opp_domain(dev, clk, old_freq, freq,
+						      IS_ERR(old_opp) ? 0 : old_opp->pstate,
+						      opp->pstate);
+		else
+			ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
 	} else if (!opp_table->set_opp) {
 		ret = _generic_set_opp_regulator(opp_table, dev, old_freq, freq,
 						 IS_ERR(old_opp) ? NULL : old_opp->supplies,
@@ -1706,6 +1754,13 @@ void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev,
 			if (remove_all || !opp->dynamic)
 				dev_pm_opp_put(opp);
 		}
+
+		/*
+		 * The OPP table is getting removed, drop the performance state
+		 * constraints.
+		 */
+		if (opp_table->genpd_performance_state)
+			dev_pm_genpd_set_performance_state(dev, 0);
 	} else {
 		_remove_opp_dev(_find_opp_dev(dev, opp_table), opp_table);
 	}
diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index 9318848f3c67..b03c03576a62 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -99,6 +99,9 @@ int opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
 	if (!debugfs_create_bool("suspend", S_IRUGO, d, &opp->suspend))
 		return -ENOMEM;
 
+	if (!debugfs_create_u32("performance_state", S_IRUGO, d, &opp->pstate))
+		return -ENOMEM;
+
 	if (!debugfs_create_ulong("rate_hz", S_IRUGO, d, &opp->rate))
 		return -ENOMEM;
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 166eef990599..e8f767ab5814 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -58,6 +58,7 @@ extern struct list_head opp_tables;
  * @dynamic:	not-created from static DT entries.
  * @turbo:	true if turbo (boost) OPP
  * @suspend:	true if suspend OPP
+ * @pstate: Device's power domain's performance state.
  * @rate:	Frequency in hertz
  * @supplies:	Power supplies voltage/current values
  * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
@@ -76,6 +77,7 @@ struct dev_pm_opp {
 	bool dynamic;
 	bool turbo;
 	bool suspend;
+	unsigned int pstate;
 	unsigned long rate;
 
 	struct dev_pm_opp_supply *supplies;
@@ -135,6 +137,7 @@ enum opp_table_access {
  * @clk: Device's clock handle
  * @regulators: Supply regulators
  * @regulator_count: Number of power supply regulators
+ * @genpd_performance_state: Device's power domain support performance state.
  * @set_opp: Platform specific set_opp callback
  * @set_opp_data: Data to be passed to set_opp callback
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
@@ -170,6 +173,7 @@ struct opp_table {
 	struct clk *clk;
 	struct regulator **regulators;
 	unsigned int regulator_count;
+	bool genpd_performance_state;
 
 	int (*set_opp)(struct dev_pm_set_opp_data *data);
 	struct dev_pm_set_opp_data *set_opp_data;
-- 
2.7.4
