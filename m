From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 01/17] PM / OPP: get/put regulators from OPP core
Date: Tue, 22 Dec 2015 15:46:02 +0530
Message-ID: <8731ff871e0eedfb08b9428af8da21b25d1ad283.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34900 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932652AbbLVKQ2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2015 05:16:28 -0500
Received: by mail-pa0-f48.google.com with SMTP id jx14so87412048pad.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2015 02:16:28 -0800 (PST)
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>

The allows the OPP core to request/free the regulator resource, attached
to a device OPP. The regulator device is fetched using device node and
name of the device.

For example, a cpu0 device node needs to look like this:
		cpu0: cpu@900 {
			device_type = "cpu";
			compatible = "arm,cortex-a9";
			reg = <0x900>;
			cpu0-supply = <&varm>;
			...
		};

This will work for both OPP-v1 and v2 bindings.

This is a preliminary step in moving the OPP switching logic into the
OPP core.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 8 ++++++++
 drivers/base/power/opp/opp.h  | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index cd230c63aee6..2e49f5e9daa3 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -505,6 +505,7 @@ static struct device_opp *_add_device_opp(struct device *dev)
 {
 	struct device_opp *dev_opp;
 	struct device_list_opp *list_dev;
+	const char *name = dev_name(dev);
 
 	/* Check for existing list for 'dev' first */
 	dev_opp = _find_device_opp(dev);
@@ -527,6 +528,11 @@ static struct device_opp *_add_device_opp(struct device *dev)
 		return NULL;
 	}
 
+	dev_opp->regulator = regulator_get_optional(dev, name);
+	if (IS_ERR(dev_opp->regulator))
+		dev_info(dev, "%s: no regulator (%s) found: %ld\n", __func__,
+			 name, PTR_ERR(dev_opp->regulator));
+
 	srcu_init_notifier_head(&dev_opp->srcu_head);
 	INIT_LIST_HEAD(&dev_opp->opp_list);
 
@@ -565,6 +571,8 @@ static void _remove_device_opp(struct device_opp *dev_opp)
 	if (dev_opp->prop_name)
 		return;
 
+	regulator_put(dev_opp->regulator);
+
 	list_dev = list_first_entry(&dev_opp->dev_list, struct device_list_opp,
 				    node);
 
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 690638ef36ee..c4a03ad34100 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/limits.h>
+#include <linux/regulator/consumer.h>
 #include <linux/pm_opp.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -132,6 +133,8 @@ struct device_list_opp {
  * @supported_hw: Array of version number to support.
  * @supported_hw_count: Number of elements in supported_hw array.
  * @prop_name: A name to postfix to many DT properties, while parsing them.
+ * @regulator: Supply Regulator
+ *
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
  * @dentry_name: Name of the real dentry.
  *
@@ -159,6 +162,7 @@ struct device_opp {
 	unsigned int *supported_hw;
 	unsigned int supported_hw_count;
 	const char *prop_name;
+	struct regulator *regulator;
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
-- 
2.7.0.rc1.186.g94414c4

