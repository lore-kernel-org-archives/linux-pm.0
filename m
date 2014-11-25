From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/8] opp: rename 'head' as 'rcu_head' or 'srcu_head' based on its type
Date: Tue, 25 Nov 2014 16:04:16 +0530
Message-ID: <1407c1d67e546a09f5dd122de943de45bcd3c846.1416910766.git.viresh.kumar@linaro.org>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:50912 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283AbaKYKfO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 05:35:14 -0500
Received: by mail-pa0-f54.google.com with SMTP id fb1so324459pad.27
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 02:35:13 -0800 (PST)
In-Reply-To: <cover.1416910766.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1416910766.git.viresh.kumar@linaro.org>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, stefan.wahren@i2se.com, nm@ti.com, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

Both 'struct dev_pm_opp' and 'struct device_opp' have member with name 'head'
but with different types. This leads to confusion while reading the code.

Name them 'rcu_head' and 'srcu_head'.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 89ced95..76ae6fd 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -53,7 +53,7 @@
  * @rate:	Frequency in hertz
  * @u_volt:	Nominal voltage in microvolts corresponding to this OPP
  * @dev_opp:	points back to the device_opp struct this opp belongs to
- * @head:	RCU callback head used for deferred freeing
+ * @rcu_head:	RCU callback head used for deferred freeing
  *
  * This structure stores the OPP information for a given device.
  */
@@ -65,7 +65,7 @@ struct dev_pm_opp {
 	unsigned long u_volt;
 
 	struct device_opp *dev_opp;
-	struct rcu_head head;
+	struct rcu_head rcu_head;
 };
 
 /**
@@ -76,7 +76,7 @@ struct dev_pm_opp {
  *		RCU usage: nodes are not modified in the list of device_opp,
  *		however addition is possible and is secured by dev_opp_list_lock
  * @dev:	device pointer
- * @head:	notifier head to notify the OPP availability changes.
+ * @srcu_head:	notifier head to notify the OPP availability changes.
  * @opp_list:	list of opps
  *
  * This is an internal data structure maintaining the link to opps attached to
@@ -87,7 +87,7 @@ struct device_opp {
 	struct list_head node;
 
 	struct device *dev;
-	struct srcu_notifier_head head;
+	struct srcu_notifier_head srcu_head;
 	struct list_head opp_list;
 };
 
@@ -436,7 +436,7 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 		}
 
 		dev_opp->dev = dev;
-		srcu_init_notifier_head(&dev_opp->head);
+		srcu_init_notifier_head(&dev_opp->srcu_head);
 		INIT_LIST_HEAD(&dev_opp->opp_list);
 
 		/* Secure the device list modification */
@@ -481,7 +481,7 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 	 * Notify the changes in the availability of the operable
 	 * frequency/voltage list.
 	 */
-	srcu_notifier_call_chain(&dev_opp->head, OPP_EVENT_ADD, new_opp);
+	srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_ADD, new_opp);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_add);
@@ -557,14 +557,14 @@ static int opp_set_availability(struct device *dev, unsigned long freq,
 
 	list_replace_rcu(&opp->node, &new_opp->node);
 	mutex_unlock(&dev_opp_list_lock);
-	kfree_rcu(opp, head);
+	kfree_rcu(opp, rcu_head);
 
 	/* Notify the change of the OPP availability */
 	if (availability_req)
-		srcu_notifier_call_chain(&dev_opp->head, OPP_EVENT_ENABLE,
+		srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_ENABLE,
 					 new_opp);
 	else
-		srcu_notifier_call_chain(&dev_opp->head, OPP_EVENT_DISABLE,
+		srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_DISABLE,
 					 new_opp);
 
 	return 0;
@@ -629,7 +629,7 @@ struct srcu_notifier_head *dev_pm_opp_get_notifier(struct device *dev)
 	if (IS_ERR(dev_opp))
 		return ERR_CAST(dev_opp); /* matching type */
 
-	return &dev_opp->head;
+	return &dev_opp->srcu_head;
 }
 
 #ifdef CONFIG_OF
-- 
2.0.3.693.g996b0fd

