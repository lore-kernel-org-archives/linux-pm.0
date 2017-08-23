From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 5/7] PM / OPP: Add dev_pm_opp_get_cur_clk()
Date: Thu, 24 Aug 2017 00:10:08 +0800
Message-ID: <1503504610-12880-6-git-send-email-aisheng.dong@nxp.com>
References: <1503504610-12880-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-cys01nam02on0078.outbound.protection.outlook.com ([104.47.37.78]:63852
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932182AbdHWQKt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 23 Aug 2017 12:10:49 -0400
In-Reply-To: <1503504610-12880-1-git-send-email-aisheng.dong@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sboyd@codeaurora.org, vireshk@kernel.org, nm@ti.com, rjw@rjwysocki.net, shawnguo@kernel.org, Anson.Huang@nxp.com, ping.bai@nxp.com, Dong Aisheng <aisheng.dong@nxp.com>

User may need to know the current OPP clock for updating policy clk
accordingly. e.g. cpufreq policy clock.
This function does the work.

Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/base/power/opp/core.c | 29 +++++++++++++++++++++++++++++
 include/linux/pm_opp.h        |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index d4656cc..a425f98 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -1441,6 +1441,35 @@ void dev_pm_opp_put_clkname(struct opp_table *opp_table)
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_clkname);
 
 /**
+ * dev_pm_opp_get_cur_clk() - Get the current OPP clock the device is running
+ * @dev: device for which we do this operation
+ *
+ * This must be called before any OPPs are initialized for the device.
+ */
+struct clk *dev_pm_opp_get_cur_clk(struct device *dev)
+{
+	struct opp_table *opp_table;
+	int ret;
+
+	opp_table = dev_pm_opp_get_opp_table(dev);
+	if (!opp_table)
+		return ERR_PTR(-ENOMEM);
+
+	if (IS_ERR(opp_table->cur_clk)) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	return opp_table->cur_clk;
+
+err:
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_cur_clk);
+
+/**
  * dev_pm_opp_register_set_opp_helper() - Register custom set OPP helper
  * @dev: Device for which the helper is getting registered.
  * @set_opp: Custom set OPP helper.
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index a8b1e4d..e20d090 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -123,6 +123,7 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * con
 void dev_pm_opp_put_regulators(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
+struct clk *dev_pm_opp_get_cur_clk(struct device *dev);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 void dev_pm_opp_register_put_opp_helper(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_register_set_clk_helper(struct device *dev, int (*set_clk)(struct device *dev, struct clk *clk,
@@ -279,6 +280,8 @@ static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const
 
 static inline void dev_pm_opp_put_clkname(struct opp_table *opp_table) {}
 
+static inline struct clk *dev_pm_opp_get_cur_clk(struct device *dev) {}
+
 static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 {
 	return -ENOTSUPP;
-- 
2.7.4
