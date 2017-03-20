From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 6/9] PM / OPP: Add dev_pm_opp_find_dps() helper
Date: Mon, 20 Mar 2017 15:02:18 +0530
Message-ID: <746e4e6f040cefb280569754cebd49db57d58d59.1490001099.git.viresh.kumar@linaro.org>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1490001099.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1490001099.git.viresh.kumar@linaro.org>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

This patch adds dev_pm_opp_find_dps() helper to get the OPP node for a
domain-performance-state. This helper is only supported for tables
representing power domains.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 66 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h        |  8 ++++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index c435acb21a47..212f11d65790 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -503,6 +503,72 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
+/**
+ * dev_pm_opp_find_dps() - search for an exact domain-performance-state
+ * @dev:		device for which we do this operation
+ * @dps:		domain-performance-state
+ * @available:		true/false - match for available opp
+ *
+ * Return: Searches for exact match in the opp table and returns pointer to the
+ * matching opp if found, else returns ERR_PTR in case of error and should
+ * be handled using IS_ERR. Error return values can be:
+ * EINVAL:	for bad pointer
+ * ERANGE:	no match found for search
+ * ENODEV:	if device not found in list of registered devices
+ *
+ * Note: available is a modifier for the search. if available=true, then the
+ * match is for exact matching domain-performance-state and is available in the
+ * stored OPP table. if false, the match is for exact domain-performance-state
+ * which is not available.
+ *
+ * This provides a mechanism to enable an opp which is not available currently
+ * or the opposite as well.
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ */
+struct dev_pm_opp *dev_pm_opp_find_dps(struct device *dev, unsigned int dps,
+				       bool available)
+{
+	struct opp_table *opp_table;
+	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-EINVAL);
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		int r = PTR_ERR(opp_table);
+
+		dev_err(dev, "%s: OPP table not found (%d)\n", __func__, r);
+		return ERR_PTR(r);
+	}
+
+	/* This API is only supported for tables representing power domains */
+	if (WARN_ON(!opp_table->is_domain))
+		goto put_table;
+
+	opp = ERR_PTR(-ERANGE);
+
+	mutex_lock(&opp_table->lock);
+
+	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
+		if (temp_opp->available == available &&
+		    temp_opp->domain_perf_state == dps) {
+			opp = temp_opp;
+
+			/* Increment the reference count of OPP */
+			dev_pm_opp_get(opp);
+			break;
+		}
+	}
+
+	mutex_unlock(&opp_table->lock);
+
+put_table:
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return opp;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_dps);
+
 static int _set_opp_voltage(struct device *dev, struct regulator *reg,
 			    struct dev_pm_opp_supply *supply)
 {
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index a6685b3dde26..11d3ff4de4b0 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -102,6 +102,8 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 
 struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					     unsigned long *freq);
+struct dev_pm_opp *dev_pm_opp_find_dps(struct device *dev, unsigned int freq,
+				       bool available);
 void dev_pm_opp_put(struct dev_pm_opp *opp);
 
 int dev_pm_opp_add(struct device *dev, unsigned long freq,
@@ -194,6 +196,12 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 	return ERR_PTR(-ENOTSUPP);
 }
 
+static inline struct dev_pm_opp *dev_pm_opp_find_dps(struct device *dev,
+					unsigned int freq, bool available)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 static inline void dev_pm_opp_put(struct dev_pm_opp *opp) {}
 
 static inline int dev_pm_opp_add(struct device *dev, unsigned long freq,
-- 
2.12.0.432.g71c3a4f4ba37
