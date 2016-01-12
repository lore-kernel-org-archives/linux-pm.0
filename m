From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 07/17] PM / OPP: Manage device clk
Date: Tue, 12 Jan 2016 11:13:13 +0530
Message-ID: <20160112054313.GM1084@ubuntu>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <1cdc1e6a83974a3f1bb44c0af3cd32ef94542d81.1450777582.git.viresh.kumar@linaro.org>
 <20160112013205.GL22188@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:32789 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759336AbcALFnR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 00:43:17 -0500
Received: by mail-pa0-f42.google.com with SMTP id cy9so333818541pac.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2016 21:43:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160112013205.GL22188@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 11-01-16, 17:32, Stephen Boyd wrote:
> > + * @clk:	struct clk pointer
> 
> Why tab? And perhaps it should say "clock handle" or "supply
> clock" or something instead of rewording the type "struct clk *".

-------------------------8<-------------------------

Subject: [PATCH] PM / OPP: Manage device clk

OPP core has got almost everything now to manage device's OPP
transitions, the only thing left is device's clk. Get that as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 15 +++++++++++++++
 drivers/base/power/opp/opp.h  |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 72d9fdf9ff0c..e7c9ae0c4c09 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -13,6 +13,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/clk.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/slab.h>
@@ -570,6 +571,7 @@ static struct device_opp *_add_device_opp_reg(struct device *dev,
 	struct device_opp *dev_opp;
 	struct device_list_opp *list_dev;
 	struct device_node *np;
+	int ret;
 
 	/*
 	 * Allocate a new device OPP table. In the infrequent case where a new
@@ -602,6 +604,15 @@ static struct device_opp *_add_device_opp_reg(struct device *dev,
 		of_node_put(np);
 	}
 
+	/* Find clk for the device */
+	dev_opp->clk = clk_get(dev, NULL);
+	if (IS_ERR(dev_opp->clk)) {
+		ret = PTR_ERR(dev_opp->clk);
+		if (ret != -EPROBE_DEFER)
+			dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__,
+				ret);
+	}
+
 	dev_opp->regulator = regulator_get_optional(dev, name);
 	if (IS_ERR(dev_opp->regulator))
 		dev_info(dev, "%s: no regulator (%s) found: %ld\n", __func__,
@@ -669,6 +680,10 @@ static void _remove_device_opp(struct device_opp *dev_opp)
 	if (dev_opp->regulator_set)
 		return;
 
+	/* Release clk */
+	if (!IS_ERR(dev_opp->clk))
+		clk_put(dev_opp->clk);
+
 	regulator_put(dev_opp->regulator);
 
 	list_dev = list_first_entry(&dev_opp->dev_list, struct device_list_opp,
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index d45570458f89..777ec70488bc 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -22,6 +22,7 @@
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 
+struct clk;
 struct regulator;
 
 /* Lock to allow exclusive modification to the device and opp lists */
@@ -134,6 +135,7 @@ struct device_list_opp {
  * @supported_hw: Array of version number to support.
  * @supported_hw_count: Number of elements in supported_hw array.
  * @prop_name: A name to postfix to many DT properties, while parsing them.
+ * @clk: Device's clock handle
  * @regulator: Supply regulator
  * @regulator_set: Regulator's name is explicitly set by platform.
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
@@ -169,6 +171,7 @@ struct device_opp {
 	unsigned int *supported_hw;
 	unsigned int supported_hw_count;
 	const char *prop_name;
+	struct clk *clk;
 	struct regulator *regulator;
 	bool regulator_set;
 
-- 
viresh
