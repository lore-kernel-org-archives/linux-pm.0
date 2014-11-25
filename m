From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/8] opp: mark OPPs as 'static' or 'dynamic'
Date: Tue, 25 Nov 2014 16:04:18 +0530
Message-ID: <4b873db57c0c57933cea1be97ba6fe128f3925c5.1416910766.git.viresh.kumar@linaro.org>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33350 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbaKYKfX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 05:35:23 -0500
Received: by mail-pa0-f41.google.com with SMTP id rd3so332010pab.14
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 02:35:22 -0800 (PST)
In-Reply-To: <cover.1416910766.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1416910766.git.viresh.kumar@linaro.org>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, stefan.wahren@i2se.com, nm@ti.com, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

Static OPPs are the ones created from Device Tree entries and dynamic are the
ones created at runtime by calling dev_pm_opp_add().

There is a need to distinguish them as we need to free static OPPs from cpufreq
drivers when they are removed.

So, add another field 'dynamic' in 'struct dev_pm_opp' to keep this information.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 59 ++++++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 25 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index a333e2ef..b249b01 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -49,6 +49,7 @@
  *		are protected by the dev_opp_list_lock for integrity.
  *		IMPORTANT: the opp nodes should be maintained in increasing
  *		order.
+ * @dynamic:	not-created from static DT entries.
  * @available:	true/false - marks if this OPP as available or not
  * @rate:	Frequency in hertz
  * @u_volt:	Nominal voltage in microvolts corresponding to this OPP
@@ -61,6 +62,7 @@ struct dev_pm_opp {
 	struct list_head node;
 
 	bool available;
+	bool dynamic;
 	unsigned long rate;
 	unsigned long u_volt;
 
@@ -378,30 +380,8 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
-/**
- * dev_pm_opp_add()  - Add an OPP table from a table definitions
- * @dev:	device for which we do this operation
- * @freq:	Frequency in Hz for this OPP
- * @u_volt:	Voltage in uVolts for this OPP
- *
- * This function adds an opp definition to the opp list and returns status.
- * The opp is made available by default and it can be controlled using
- * dev_pm_opp_enable/disable functions.
- *
- * Locking: The internal device_opp and opp structures are RCU protected.
- * Hence this function internally uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
- *
- * Return:
- * 0:		On success OR
- *		Duplicate OPPs (both freq and volt are same) and opp->available
- * -EEXIST:	Freq are same and volt are different OR
- *		Duplicate OPPs (both freq and volt are same) and !opp->available
- * -ENOMEM:	Memory allocation failure
- */
-int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
+static int dev_pm_opp_add_dynamic(struct device *dev, unsigned long freq,
+				  unsigned long u_volt, bool dynamic)
 {
 	struct device_opp *dev_opp = NULL;
 	struct dev_pm_opp *opp, *new_opp;
@@ -422,6 +402,7 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 	new_opp->rate = freq;
 	new_opp->u_volt = u_volt;
 	new_opp->available = true;
+	new_opp->dynamic = dynamic;
 
 	/* Check for existing list for 'dev' */
 	dev_opp = find_device_opp(dev);
@@ -487,6 +468,34 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 	srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_ADD, new_opp);
 	return 0;
 }
+
+/**
+ * dev_pm_opp_add()  - Add an OPP table from a table definitions
+ * @dev:	device for which we do this operation
+ * @freq:	Frequency in Hz for this OPP
+ * @u_volt:	Voltage in uVolts for this OPP
+ *
+ * This function adds an opp definition to the opp list and returns status.
+ * The opp is made available by default and it can be controlled using
+ * dev_pm_opp_enable/disable functions.
+ *
+ * Locking: The internal device_opp and opp structures are RCU protected.
+ * Hence this function internally uses RCU updater strategy with mutex locks
+ * to keep the integrity of the internal data structures. Callers should ensure
+ * that this function is *NOT* called under RCU protection or in contexts where
+ * mutex cannot be locked.
+ *
+ * Return:
+ * 0:		On success OR
+ *		Duplicate OPPs (both freq and volt are same) and opp->available
+ * -EEXIST:	Freq are same and volt are different OR
+ *		Duplicate OPPs (both freq and volt are same) and !opp->available
+ * -ENOMEM:	Memory allocation failure
+ */
+int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
+{
+	return dev_pm_opp_add_dynamic(dev, freq, u_volt, true);
+}
 EXPORT_SYMBOL_GPL(dev_pm_opp_add);
 
 /**
@@ -669,7 +678,7 @@ int of_init_opp_table(struct device *dev)
 		unsigned long freq = be32_to_cpup(val++) * 1000;
 		unsigned long volt = be32_to_cpup(val++);
 
-		if (dev_pm_opp_add(dev, freq, volt))
+		if (dev_pm_opp_add_dynamic(dev, freq, volt, false))
 			dev_warn(dev, "%s: Failed to add OPP %ld\n",
 				 __func__, freq);
 		nr -= 2;
-- 
2.0.3.693.g996b0fd

