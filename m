From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 4/7] PM / OPP: use OPP node clock to set CPU frequency
Date: Thu, 24 Aug 2017 00:10:07 +0800
Message-ID: <1503504610-12880-5-git-send-email-aisheng.dong@nxp.com>
References: <1503504610-12880-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-sn1nam02on0077.outbound.protection.outlook.com ([104.47.36.77]:24576
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932204AbdHWQKc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 23 Aug 2017 12:10:32 -0400
In-Reply-To: <1503504610-12880-1-git-send-email-aisheng.dong@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sboyd@codeaurora.org, vireshk@kernel.org, nm@ti.com, rjw@rjwysocki.net, shawnguo@kernel.org, Anson.Huang@nxp.com, ping.bai@nxp.com, Dong Aisheng <aisheng.dong@nxp.com>

If OPP node has a valid clock, we use this corresponding OPP clock to
set the device clock frequency instead of the default opp_table->clk which
is shared by all OPPs.

Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/base/power/opp/core.c | 10 +++++++++-
 drivers/base/power/opp/of.c   |  8 ++++++++
 drivers/base/power/opp/opp.h  |  3 +++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 2579401..d4656cc 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -600,7 +600,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	struct opp_table *opp_table;
 	unsigned long freq, old_freq;
 	struct dev_pm_opp *old_opp, *opp;
-	struct clk *clk;
+	struct clk *clk, *old_clk = NULL;
 	int ret, size;
 
 	if (unlikely(!target_freq)) {
@@ -651,6 +651,11 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		goto put_old_opp;
 	}
 
+	if (!IS_ERR_OR_NULL(opp->clk)) {
+		old_clk = opp_table->cur_clk;
+		opp_table->cur_clk = opp->clk;
+	}
+
 	dev_dbg(dev, "%s: switching OPP: %lu Hz --> %lu Hz\n", __func__,
 		old_freq, freq);
 
@@ -683,6 +688,9 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		ret = opp_table->set_opp(data);
 	}
 
+	if (ret && !IS_ERR_OR_NULL(opp->clk))
+		opp_table->cur_clk = old_clk;
+
 	dev_pm_opp_put(opp);
 put_old_opp:
 	if (!IS_ERR(old_opp))
diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 57eec1c..64909e7 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -13,6 +13,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/clk.h>
 #include <linux/cpu.h>
 #include <linux/errno.h>
 #include <linux/device.h>
@@ -314,6 +315,13 @@ static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
 	new_opp->dynamic = false;
 	new_opp->available = true;
 
+	new_opp->clk = of_clk_get(np, 0);
+	if (IS_ERR(new_opp->clk)) {
+		ret = PTR_ERR(new_opp->clk);
+		if (ret == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+	}
+
 	if (!of_property_read_u32(np, "clock-latency-ns", &val))
 		new_opp->clock_latency_ns = val;
 
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 30a637c..dbe8ec6 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -60,6 +60,7 @@ extern struct list_head opp_tables;
  * @suspend:	true if suspend OPP
  * @rate:	Frequency in hertz
  * @supplies:	Power supplies voltage/current values
+ * @clk:	Clock used for this OPP
  * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
  *		frequency from any other OPP's frequency.
  * @opp_table:	points back to the opp_table struct this opp belongs to
@@ -80,6 +81,8 @@ struct dev_pm_opp {
 
 	struct dev_pm_opp_supply *supplies;
 
+	struct clk *clk;
+
 	unsigned long clock_latency_ns;
 
 	struct opp_table *opp_table;
-- 
2.7.4
