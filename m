From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH] PM / OPP: optimize dev_pm_opp_set_rate() a bit
Date: Fri, 22 Jul 2016 20:42:50 +0800
Message-ID: <1469191370-1285-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-pm@vger.kernel.org

In dev_pm_opp_set_rate(), _find_opp_table() is called three times: once
by _get_opp_clk(), twice by dev_pm_opp_find_freq_ceil(). If there are
several opp_tables in the system, three times of opp table finding is a
big waste. This patch reduced the call of _find_opp_table() to only
once.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/base/power/opp/core.c | 85 ++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 49 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 7c04c87..96043ee 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -402,6 +402,22 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);
 
+static struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
+					  unsigned long *freq)
+{
+	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
+
+	list_for_each_entry_rcu(temp_opp, &opp_table->opp_list, node) {
+		if (temp_opp->available && temp_opp->rate >= *freq) {
+			opp = temp_opp;
+			*freq = opp->rate;
+			break;
+		}
+	}
+
+	return opp;
+}
+
 /**
  * dev_pm_opp_find_freq_ceil() - Search for an rounded ceil freq
  * @dev:	device for which we do this operation
@@ -427,7 +443,6 @@ struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					     unsigned long *freq)
 {
 	struct opp_table *opp_table;
-	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
 
 	opp_rcu_lockdep_assert();
 
@@ -440,15 +455,7 @@ struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 	if (IS_ERR(opp_table))
 		return ERR_CAST(opp_table);
 
-	list_for_each_entry_rcu(temp_opp, &opp_table->opp_list, node) {
-		if (temp_opp->available && temp_opp->rate >= *freq) {
-			opp = temp_opp;
-			*freq = opp->rate;
-			break;
-		}
-	}
-
-	return opp;
+	return _find_freq_ceil(opp_table, freq);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil);
 
@@ -506,34 +513,6 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
-/*
- * The caller needs to ensure that opp_table (and hence the clk) isn't freed,
- * while clk returned here is used.
- */
-static struct clk *_get_opp_clk(struct device *dev)
-{
-	struct opp_table *opp_table;
-	struct clk *clk;
-
-	rcu_read_lock();
-
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table)) {
-		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
-		clk = ERR_CAST(opp_table);
-		goto unlock;
-	}
-
-	clk = opp_table->clk;
-	if (IS_ERR(clk))
-		dev_err(dev, "%s: No clock available for the device\n",
-			__func__);
-
-unlock:
-	rcu_read_unlock();
-	return clk;
-}
-
 static int _set_opp_voltage(struct device *dev, struct regulator *reg,
 			    unsigned long u_volt, unsigned long u_volt_min,
 			    unsigned long u_volt_max)
@@ -586,9 +565,24 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		return -EINVAL;
 	}
 
-	clk = _get_opp_clk(dev);
-	if (IS_ERR(clk))
+	rcu_read_lock();
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
+		rcu_read_unlock();
+		return PTR_ERR(opp_table);
+	}
+
+	clk = opp_table->clk;
+	if (IS_ERR(clk)) {
+		dev_err(dev, "%s: No clock available for the device\n",
+			__func__);
+		rcu_read_unlock();
 		return PTR_ERR(clk);
+	}
+
+	rcu_read_unlock();
 
 	freq = clk_round_rate(clk, target_freq);
 	if ((long)freq <= 0)
@@ -605,14 +599,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
 	rcu_read_lock();
 
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table)) {
-		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
-		rcu_read_unlock();
-		return PTR_ERR(opp_table);
-	}
-
-	old_opp = dev_pm_opp_find_freq_ceil(dev, &old_freq);
+	old_opp = _find_freq_ceil(opp_table, &old_freq);
 	if (!IS_ERR(old_opp)) {
 		ou_volt = old_opp->u_volt;
 		ou_volt_min = old_opp->u_volt_min;
@@ -622,7 +609,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 			__func__, old_freq, PTR_ERR(old_opp));
 	}
 
-	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
+	opp = _find_freq_ceil(opp_table, &freq);
 	if (IS_ERR(opp)) {
 		ret = PTR_ERR(opp);
 		dev_err(dev, "%s: failed to find OPP for freq %lu (%d)\n",
-- 
2.8.1
