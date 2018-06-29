From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 08/10] OPP: Configure all required OPPs
Date: Fri, 29 Jun 2018 11:49:38 +0530
Message-ID: <c1da547faaa9fb4e3fe9034a643853847b106d68.1530252803.git.viresh.kumar@linaro.org>
References: <cover.1530252803.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530252803.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Now that all the infrastructure is in place to support multiple required
OPPs, lets switch over to using it.

A new internal routine _set_required_opps() takes care of updating
performance state for all the required OPPs. With this the performance
state updates are supported even when the end device needs to configure
regulators as well, that wasn't the case earlier.

The pstates were earlier stored in the end device's OPP structures, that
also changes now as those values are stored in the genpd's OPP
structures. And so we switch over to using
genpd_opp_to_performance_state() instead of
of_genpd_opp_to_performance_state() to get performance state for the
genpd OPPs.

The routine _generic_set_opp_domain() is not required anymore and is
removed.

On errors we don't try to recover by reverting to old settings as things
are really complex now and the calls here should never really fail
unless there is a bug. There is no point increasing the complexity, for
code which will never be executed.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 99 ++++++++++++++++++++++++----------------------
 drivers/opp/of.c   |  5 ++-
 2 files changed, 54 insertions(+), 50 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 3a2f08c56c4e..6b3410ded1ca 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -543,44 +543,6 @@ _generic_set_opp_clk_only(struct device *dev, struct clk *clk,
 	return ret;
 }
 
-static inline int
-_generic_set_opp_domain(struct device *dev, struct clk *clk,
-			unsigned long old_freq, unsigned long freq,
-			unsigned int old_pstate, unsigned int new_pstate)
-{
-	int ret;
-
-	/* Scaling up? Scale domain performance state before frequency */
-	if (freq > old_freq) {
-		ret = dev_pm_genpd_set_performance_state(dev, new_pstate);
-		if (ret)
-			return ret;
-	}
-
-	ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
-	if (ret)
-		goto restore_domain_state;
-
-	/* Scaling down? Scale domain performance state after frequency */
-	if (freq < old_freq) {
-		ret = dev_pm_genpd_set_performance_state(dev, new_pstate);
-		if (ret)
-			goto restore_freq;
-	}
-
-	return 0;
-
-restore_freq:
-	if (_generic_set_opp_clk_only(dev, clk, freq, old_freq))
-		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
-			__func__, old_freq);
-restore_domain_state:
-	if (freq > old_freq)
-		dev_pm_genpd_set_performance_state(dev, old_pstate);
-
-	return ret;
-}
-
 static int _generic_set_opp_regulator(const struct opp_table *opp_table,
 				      struct device *dev,
 				      unsigned long old_freq,
@@ -658,6 +620,42 @@ static int _set_opp_custom(const struct opp_table *opp_table,
 	return opp_table->set_opp(data);
 }
 
+/* This is only called for PM domain for now */
+static int _set_required_opps(struct device *dev,
+			      const struct opp_table *opp_table,
+			      struct dev_pm_opp *opp)
+{
+	struct opp_table **required_opp_tables = opp_table->required_opp_tables;
+	struct device **required_devices = opp_table->required_devices;
+	struct device *required_dev = dev;
+	unsigned int pstate;
+	int i, ret;
+
+	if (!required_opp_tables)
+		return 0;
+
+	for (i = 0; i < opp_table->required_opp_count; i++) {
+		pstate = opp->required_opps[i]->pstate;
+
+		if (required_devices) {
+			required_dev = required_devices[i];
+			if (!required_dev) {
+				dev_err(dev, "Missing OPP required device\n");
+				return -ENODEV;
+			}
+		}
+
+		ret = dev_pm_genpd_set_performance_state(required_dev, pstate);
+		if (ret) {
+			dev_err(dev, "Failed to set performance rate of %s: %d (%d)\n",
+				dev_name(required_dev), pstate, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * dev_pm_opp_set_rate() - Configure new OPP based on frequency
  * @dev:	 device for which we do this operation
@@ -725,6 +723,13 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	dev_dbg(dev, "%s: switching OPP: %lu Hz --> %lu Hz\n", __func__,
 		old_freq, freq);
 
+	/* Scaling up? Configure required OPPs before frequency */
+	if (freq > old_freq) {
+		ret = _set_required_opps(dev, opp_table, opp);
+		if (ret)
+			goto put_opp;
+	}
+
 	if (opp_table->set_opp) {
 		ret = _set_opp_custom(opp_table, dev, old_freq, freq,
 				      IS_ERR(old_opp) ? NULL : old_opp->supplies,
@@ -735,19 +740,17 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 						 opp->supplies);
 	} else {
 		/* Only frequency scaling */
+		ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
+	}
 
-		/*
-		 * We don't support devices with both regulator and
-		 * domain performance-state for now.
-		 */
-		if (opp_table->genpd_performance_state)
-			ret = _generic_set_opp_domain(dev, clk, old_freq, freq,
-						      IS_ERR(old_opp) ? 0 : old_opp->pstate,
-						      opp->pstate);
-		else
-			ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
+	/* Scaling down? Configure required OPPs after frequency */
+	if (!ret && freq < old_freq) {
+		ret = _set_required_opps(dev, opp_table, opp);
+		if (ret)
+			dev_err(dev, "Failed to set required opps: %d\n", ret);
 	}
 
+put_opp:
 	dev_pm_opp_put(opp);
 put_old_opp:
 	if (!IS_ERR(old_opp))
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 20baba090c17..e1e4a58dd748 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -584,12 +584,13 @@ static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
 	if (!of_property_read_u32(np, "clock-latency-ns", &val))
 		new_opp->clock_latency_ns = val;
 
-	new_opp->pstate = of_genpd_opp_to_performance_state(dev, np);
-
 	ret = opp_parse_supplies(new_opp, dev, opp_table);
 	if (ret)
 		goto free_required_opps;
 
+	if (opp_table->is_genpd)
+		new_opp->pstate = genpd_opp_to_performance_state(dev, new_opp);
+
 	ret = _opp_add(dev, new_opp, opp_table, rate_not_available);
 	if (ret) {
 		/* Don't return error for duplicate OPPs */
-- 
2.18.0.rc1.242.g61856ae69a2c
