From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 06/10] OPP: Add clock-latency-ns support
Date: Mon, 15 Jun 2015 17:27:32 +0530
Message-ID: <1376f9ac3f955e67bd56327ea0ac9aecd06a6070.1434369079.git.viresh.kumar@linaro.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35582 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933AbbFOL6S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 07:58:18 -0400
Received: by pdbnf5 with SMTP id nf5so71737420pdb.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 04:58:18 -0700 (PDT)
In-Reply-To: <cover.1434369079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434369079.git.viresh.kumar@linaro.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, Viresh Kumar <viresh.kumar@linaro.org>

With "operating-points-v2" bindings, clock-latency is defined per OPP.
Users of this value expect a single value which defines the latency to
switch to any clock rate. Find maximum clock-latency-ns from the OPP
table to service requests from such users.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 41 +++++++++++++++++++++++++++++++++++++++--
 include/linux/pm_opp.h   |  6 ++++++
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 3198c3e77224..fe79e5146a29 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -57,6 +57,8 @@
  * @u_volt_min:	Minimum voltage in microvolts corresponding to this OPP
  * @u_volt_max:	Maximum voltage in microvolts corresponding to this OPP
  * @u_amp:	Maximum current drawn by the device in microamperes
+ * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
+ *		frequency from any other OPP's frequency.
  * @dev_opp:	points back to the device_opp struct this opp belongs to
  * @rcu_head:	RCU callback head used for deferred freeing
  * @np:		OPP's device node.
@@ -79,6 +81,7 @@ struct dev_pm_opp {
 	unsigned long u_volt_min;
 	unsigned long u_volt_max;
 	unsigned long u_amp;
+	unsigned long clock_latency_ns;
 
 	struct device_opp *dev_opp;
 	struct rcu_head rcu_head;
@@ -113,6 +116,8 @@ struct device_opp {
 	struct srcu_notifier_head srcu_head;
 	struct rcu_head rcu_head;
 	struct list_head opp_list;
+
+	unsigned long clock_latency_ns_max;
 };
 
 /*
@@ -230,6 +235,32 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
 
 /**
+ * dev_pm_opp_get_max_clock_latency() - Get max clock latency in nanoseconds
+ * @dev:	device for which we do this operation
+ *
+ * Return: This function returns the max clock latency in nanoseconds.
+ *
+ * Locking: This function takes rcu_read_lock().
+ */
+unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev)
+{
+	struct device_opp *dev_opp;
+	unsigned long clock_latency_ns;
+
+	rcu_read_lock();
+
+	dev_opp = _find_device_opp(dev);
+	if (IS_ERR(dev_opp))
+		clock_latency_ns = 0;
+	else
+		clock_latency_ns = dev_opp->clock_latency_ns_max;
+
+	rcu_read_unlock();
+	return clock_latency_ns;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_clock_latency);
+
+/**
  * dev_pm_opp_get_opp_count() - Get number of opps available in the opp list
  * @dev:	device for which we do this operation
  *
@@ -741,6 +772,8 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 	new_opp->np = np;
 	new_opp->dynamic = false;
 	new_opp->available = true;
+	of_property_read_u32(np, "clock-latency-ns",
+			     (u32 *)&new_opp->clock_latency_ns);
 
 	/*
 	 * TODO: Support multiple regulators
@@ -765,9 +798,13 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 	if (ret)
 		goto free_opp;
 
-	pr_debug("%s: turbo:%d rate:%lu uv:%lu uvmin:%lu uvmax:%lu\n",
+	if (new_opp->clock_latency_ns > dev_opp->clock_latency_ns_max)
+		dev_opp->clock_latency_ns_max = new_opp->clock_latency_ns;
+
+	pr_debug("%s: turbo:%d rate:%lu uv:%lu uvmin:%lu uvmax:%lu latency:%lu\n",
 		 __func__, new_opp->turbo, new_opp->rate, new_opp->u_volt,
-		 new_opp->u_volt_min, new_opp->u_volt_max);
+		 new_opp->u_volt_min, new_opp->u_volt_max,
+		 new_opp->clock_latency_ns);
 
 	mutex_unlock(&dev_opp_list_lock);
 
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index cec2d4540914..20324b579adc 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -31,6 +31,7 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
 
 int dev_pm_opp_get_opp_count(struct device *dev);
+unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev);
 
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					      unsigned long freq,
@@ -67,6 +68,11 @@ static inline int dev_pm_opp_get_opp_count(struct device *dev)
 	return 0;
 }
 
+static inline unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev)
+{
+	return 0;
+}
+
 static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					unsigned long freq, bool available)
 {
-- 
2.4.0

