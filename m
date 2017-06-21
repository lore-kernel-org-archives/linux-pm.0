From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2] PM / OPP: Add dev_pm_opp_{set|put}_clkname()
Date: Wed, 21 Jun 2017 10:29:13 +0530
Message-ID: <60e18f9d62e5cd65ae468beb065a3e3ebc205aa4.1498021098.git.viresh.kumar@linaro.org>
References: <e1ae46672cc137bf375349a6b9f7a5a3c9823e74.1497953043.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35910 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbdFUE7t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jun 2017 00:59:49 -0400
Received: by mail-pg0-f51.google.com with SMTP id u62so53073444pgb.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Jun 2017 21:59:49 -0700 (PDT)
In-Reply-To: <e1ae46672cc137bf375349a6b9f7a5a3c9823e74.1497953043.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org

In order to support OPP switching, OPP layer needs to get pointer to the
clock for the device. Simple cases work fine without using the routines
added by this patch (i.e.  by passing connection-id as NULL), but for a
device with multiple clocks available, the OPP core needs to know the
exact name of the clk to use.

Add a new set of APIs to get that done.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2:
- No need to save clk_name, as we wouldn't use it again.

 drivers/base/power/opp/core.c | 67 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h        |  9 ++++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 5ee7aadf0abf..a8cc14fd8ae4 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -1363,6 +1363,73 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_regulators);
 
 /**
+ * dev_pm_opp_set_clkname() - Set clk name for the device
+ * @dev: Device for which clk name is being set.
+ * @name: Clk name.
+ *
+ * In order to support OPP switching, OPP layer needs to get pointer to the
+ * clock for the device. Simple cases work fine without using this routine (i.e.
+ * by passing connection-id as NULL), but for a device with multiple clocks
+ * available, the OPP core needs to know the exact name of the clk to use.
+ *
+ * This must be called before any OPPs are initialized for the device.
+ */
+struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
+{
+	struct opp_table *opp_table;
+	int ret;
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
+	/* Already have default clk set, free it */
+	if (!IS_ERR(opp_table->clk))
+		clk_put(opp_table->clk);
+
+	/* Find clk for the device */
+	opp_table->clk = clk_get(dev, name);
+	if (IS_ERR(opp_table->clk)) {
+		ret = PTR_ERR(opp_table->clk);
+		if (ret != -EPROBE_DEFER) {
+			dev_err(dev, "%s: Couldn't find clock: %d\n", __func__,
+				ret);
+		}
+		goto err;
+	}
+
+	return opp_table;
+
+err:
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_clkname);
+
+/**
+ * dev_pm_opp_put_clkname() - Releases resources blocked for clk.
+ * @opp_table: OPP table returned from dev_pm_opp_set_clkname().
+ */
+void dev_pm_opp_put_clkname(struct opp_table *opp_table)
+{
+	/* Make sure there are no concurrent readers while updating opp_table */
+	WARN_ON(!list_empty(&opp_table->opp_list));
+
+	clk_put(opp_table->clk);
+	opp_table->clk = ERR_PTR(-EINVAL);
+
+	dev_pm_opp_put_opp_table(opp_table);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_put_clkname);
+
+/**
  * dev_pm_opp_register_set_opp_helper() - Register custom set OPP helper
  * @dev: Device for which the helper is getting registered.
  * @set_opp: Custom set OPP helper.
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index a6685b3dde26..51ec727b4824 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -121,6 +121,8 @@ struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count);
 void dev_pm_opp_put_regulators(struct opp_table *opp_table);
+struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
+void dev_pm_opp_put_clkname(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 void dev_pm_opp_register_put_opp_helper(struct opp_table *opp_table);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
@@ -257,6 +259,13 @@ static inline struct opp_table *dev_pm_opp_set_regulators(struct device *dev, co
 
 static inline void dev_pm_opp_put_regulators(struct opp_table *opp_table) {}
 
+static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static inline void dev_pm_opp_put_clkname(struct opp_table *opp_table) {}
+
 static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 {
 	return -ENOTSUPP;
-- 
2.13.0.71.gd7076ec9c9cb
