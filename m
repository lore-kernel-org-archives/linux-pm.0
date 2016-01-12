From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 01/17] PM / OPP: get/put regulators from OPP core
Date: Tue, 12 Jan 2016 10:53:46 +0530
Message-ID: <20160112052346.GL1084@ubuntu>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <8731ff871e0eedfb08b9428af8da21b25d1ad283.1450777582.git.viresh.kumar@linaro.org>
 <20160111232118.GG22188@codeaurora.org>
 <20160112030543.GG1084@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35555 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbcALFXu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 00:23:50 -0500
Received: by mail-pf0-f172.google.com with SMTP id 65so56693490pff.2
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2016 21:23:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160112030543.GG1084@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 12-01-16, 08:35, Viresh Kumar wrote:
> On 11-01-16, 15:21, Stephen Boyd wrote:
> > Is there a reason we capitalize regulator?
> 

Something went wrong, I have updated the code correctly. Let me paste
it again..

-------------------------8<-------------------------

Subject: [PATCH] PM / OPP: get/put regulators from OPP core

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
 drivers/base/power/opp/core.c | 9 +++++++++
 drivers/base/power/opp/opp.h  | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index cf351d3dab1c..9e437416e155 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -19,6 +19,7 @@
 #include <linux/device.h>
 #include <linux/of.h>
 #include <linux/export.h>
+#include <linux/regulator/consumer.h>
 
 #include "opp.h"
 
@@ -505,6 +506,7 @@ static struct device_opp *_add_device_opp(struct device *dev)
 {
 	struct device_opp *dev_opp;
 	struct device_list_opp *list_dev;
+	const char *name = dev_name(dev);
 
 	/* Check for existing list for 'dev' first */
 	dev_opp = _find_device_opp(dev);
@@ -527,6 +529,11 @@ static struct device_opp *_add_device_opp(struct device *dev)
 		return NULL;
 	}
 
+	dev_opp->regulator = regulator_get_optional(dev, name);
+	if (IS_ERR(dev_opp->regulator))
+		dev_info(dev, "%s: no regulator (%s) found: %ld\n", __func__,
+			 name, PTR_ERR(dev_opp->regulator));
+
 	srcu_init_notifier_head(&dev_opp->srcu_head);
 	INIT_LIST_HEAD(&dev_opp->opp_list);
 
@@ -565,6 +572,8 @@ static void _remove_device_opp(struct device_opp *dev_opp)
 	if (dev_opp->prop_name)
 		return;
 
+	regulator_put(dev_opp->regulator);
+
 	list_dev = list_first_entry(&dev_opp->dev_list, struct device_list_opp,
 				    node);
 
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 690638ef36ee..416293b7da23 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -22,6 +22,8 @@
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 
+struct regulator;
+
 /* Lock to allow exclusive modification to the device and opp lists */
 extern struct mutex dev_opp_list_lock;
 
@@ -132,6 +134,7 @@ struct device_list_opp {
  * @supported_hw: Array of version number to support.
  * @supported_hw_count: Number of elements in supported_hw array.
  * @prop_name: A name to postfix to many DT properties, while parsing them.
+ * @regulator: Supply regulator
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
viresh
