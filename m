From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 7/9] OPP: Configure all required OPPs
Date: Fri, 12 Oct 2018 16:41:15 +0530
Message-ID: <e23cf6535abffbe9d2db63a555089cdc6d2d1d14.1539341929.git.viresh.kumar@linaro.org>
References: <cover.1539341929.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1539341929.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, niklas.cassel@linaro.org, rnayak@codeaurora.org, linux-kernel@vger.kernel.org
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
 drivers/opp/core.c | 113 ++++++++++++++++++++++++++-------------------
 drivers/opp/of.c   |   5 +-
 2 files changed, 68 insertions(+), 50 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 8d7bf9d83752..1eeb89ab9a68 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -548,44 +548,6 @@ _generic_set_opp_clk_only(struct device *dev, struct clk *clk,
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
@@ -663,6 +625,56 @@ static int _set_opp_custom(const struct opp_table *opp_table,
 	return opp_table->set_opp(data);
 }
 
+/* This is only called for PM domain for now */
+static int _set_required_opps(struct device *dev,
+			      struct opp_table *opp_table,
+			      struct dev_pm_opp *opp)
+{
+	struct opp_table **required_opp_tables = opp_table->required_opp_tables;
+	struct device **genpd_devices = opp_table->genpd_devices;
+	unsigned int pstate;
+	int i, ret = 0;
+
+	if (!required_opp_tables)
+		return 0;
+
+	/* Single genpd case */
+	if (!genpd_devices) {
+		pstate = opp->required_opps[0]->pstate;
+		ret = dev_pm_genpd_set_performance_state(dev, pstate);
+		if (ret) {
+			dev_err(dev, "Failed to set performance state of %s: %d (%d)\n",
+				dev_name(dev), pstate, ret);
+		}
+		return ret;
+	}
+
+	/* Multiple genpd case */
+
+	/*
+	 * Acquire genpd_dev_lock to make sure we don't use a genpd_dev after it
+	 * is freed from another thread.
+	 */
+	mutex_lock(&opp_table->genpd_dev_lock);
+
+	for (i = 0; i < opp_table->required_opp_count; i++) {
+		pstate = opp->required_opps[i]->pstate;
+
+		if (!genpd_devices[i])
+			continue;
+
+		ret = dev_pm_genpd_set_performance_state(genpd_devices[i], pstate);
+		if (ret) {
+			dev_err(dev, "Failed to set performance rate of %s: %d (%d)\n",
+				dev_name(genpd_devices[i]), pstate, ret);
+			break;
+		}
+	}
+	mutex_unlock(&opp_table->genpd_dev_lock);
+
+	return ret;
+}
+
 /**
  * dev_pm_opp_set_rate() - Configure new OPP based on frequency
  * @dev:	 device for which we do this operation
@@ -730,6 +742,13 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
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
@@ -740,19 +759,17 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
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
index fd67c9b55d7d..f4e8895542ca 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -595,12 +595,13 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
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
