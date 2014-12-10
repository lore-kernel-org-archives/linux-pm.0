From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4/5] opp: handle allocation of device_opp in a separate routine
Date: Wed, 10 Dec 2014 09:45:34 +0530
Message-ID: <b759d2563caee1189b543d7a3acb222d316d81a1.1418184737.git.viresh.kumar@linaro.org>
References: <0a31e317c90f601f77cc21b80455633928c70c96.1418184737.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50270 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310AbaLJEQV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Dec 2014 23:16:21 -0500
Received: by mail-pa0-f46.google.com with SMTP id lf10so1352845pab.33
        for <linux-pm@vger.kernel.org>; Tue, 09 Dec 2014 20:16:20 -0800 (PST)
In-Reply-To: <0a31e317c90f601f77cc21b80455633928c70c96.1418184737.git.viresh.kumar@linaro.org>
In-Reply-To: <0a31e317c90f601f77cc21b80455633928c70c96.1418184737.git.viresh.kumar@linaro.org>
References: <0a31e317c90f601f77cc21b80455633928c70c96.1418184737.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Get the 'device_opp' allocation code into a separate routine to keep only the
necessary part in dev_pm_opp_add_dynamic().

Also do s/sizeof(struct device_opp)/sizeof(*dev_opp) and remove the print
message on kzalloc() failure as checkpatch warns for that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 525ffb202d77..1150b9d2e012 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -386,6 +386,27 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
+static struct device_opp *add_device_opp(struct device *dev)
+{
+	struct device_opp *dev_opp;
+
+	/*
+	 * Allocate a new device OPP table. In the infrequent case where a new
+	 * device is needed to be added, we pay this penalty.
+	 */
+	dev_opp = kzalloc(sizeof(*dev_opp), GFP_KERNEL);
+	if (!dev_opp)
+		return NULL;
+
+	dev_opp->dev = dev;
+	srcu_init_notifier_head(&dev_opp->srcu_head);
+	INIT_LIST_HEAD(&dev_opp->opp_list);
+
+	/* Secure the device list modification */
+	list_add_rcu(&dev_opp->node, &dev_opp_list);
+	return dev_opp;
+}
+
 static int dev_pm_opp_add_dynamic(struct device *dev, unsigned long freq,
 				  unsigned long u_volt, bool dynamic)
 {
@@ -412,27 +433,13 @@ static int dev_pm_opp_add_dynamic(struct device *dev, unsigned long freq,
 	/* Check for existing list for 'dev' */
 	dev_opp = find_device_opp(dev);
 	if (IS_ERR(dev_opp)) {
-		/*
-		 * Allocate a new device OPP table. In the infrequent case
-		 * where a new device is needed to be added, we pay this
-		 * penalty.
-		 */
-		dev_opp = kzalloc(sizeof(struct device_opp), GFP_KERNEL);
+		dev_opp = add_device_opp(dev);
 		if (!dev_opp) {
 			mutex_unlock(&dev_opp_list_lock);
 			kfree(new_opp);
-			dev_warn(dev,
-				"%s: Unable to create device OPP structure\n",
-				__func__);
 			return -ENOMEM;
 		}
 
-		dev_opp->dev = dev;
-		srcu_init_notifier_head(&dev_opp->srcu_head);
-		INIT_LIST_HEAD(&dev_opp->opp_list);
-
-		/* Secure the device list modification */
-		list_add_rcu(&dev_opp->node, &dev_opp_list);
 		head = &dev_opp->opp_list;
 		goto list_add;
 	}
-- 
2.2.0

