From: Thomas Abraham <ta.omasab@gmail.com>
Subject: [PATCH 1/2] PM / OPP: Add support for 'boost' mode OPP
Date: Tue,  4 Feb 2014 15:11:29 +0530
Message-ID: <1391506890-7335-2-git-send-email-thomas.ab@samsung.com>
References: <1391506890-7335-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1391506890-7335-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: rjw@rjwysocki.net, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, thomas.ab@samsung.com, Nishanth Menon <nm@ti.com>
List-Id: linux-pm@vger.kernel.org

From: Thomas Abraham <thomas.ab@samsung.com>

Commit 6f19efc0 ("cpufreq: Add boost frequency support in core") adds
support for CPU boost mode. This patch adds support for finding available
boost OPPs from device tree and marking them as usable in boost mode.

Cc: Nishanth Menon <nm@ti.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 drivers/base/power/opp.c |   69 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 13 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 2553867..de4d52d 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -62,6 +62,7 @@ struct dev_pm_opp {
 	struct list_head node;
 
 	bool available;
+	bool boost;
 	unsigned long rate;
 	unsigned long u_volt;
 
@@ -380,10 +381,12 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
 /**
- * dev_pm_opp_add()  - Add an OPP table from a table definitions
+ * dev_pm_opp_add_flags()  - Add an OPP to device OPP list with flags
  * @dev:	device for which we do this operation
  * @freq:	Frequency in Hz for this OPP
  * @u_volt:	Voltage in uVolts for this OPP
+ * @available:	initial availability of the OPP with adding it to the list.
+ * @boost:	availability of this opp in controller's boost operating mode.
  *
  * This function adds an opp definition to the opp list and returns status.
  * The opp is made available by default and it can be controlled using
@@ -395,7 +398,8 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
  * that this function is *NOT* called under RCU protection or in contexts where
  * mutex cannot be locked.
  */
-int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
+static int dev_pm_opp_add_flags(struct device *dev, unsigned long freq,
+			unsigned long u_volt, bool available, bool boost)
 {
 	struct device_opp *dev_opp = NULL;
 	struct dev_pm_opp *opp, *new_opp;
@@ -441,7 +445,8 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 	new_opp->dev_opp = dev_opp;
 	new_opp->rate = freq;
 	new_opp->u_volt = u_volt;
-	new_opp->available = true;
+	new_opp->available = available;
+	new_opp->boost = boost;
 
 	/* Insert new OPP in order of increasing frequency */
 	head = &dev_opp->opp_list;
@@ -462,6 +467,27 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 	srcu_notifier_call_chain(&dev_opp->head, OPP_EVENT_ADD, new_opp);
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
+ */
+int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
+{
+	return dev_pm_opp_add_flags(dev, freq, u_volt, true, false);
+}
 EXPORT_SYMBOL_GPL(dev_pm_opp_add);
 
 /**
@@ -651,7 +677,8 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
 
 	list_for_each_entry(opp, &dev_opp->opp_list, node) {
 		if (opp->available) {
-			freq_table[i].driver_data = i;
+			freq_table[i].driver_data =
+				opp->boost ? CPUFREQ_BOOST_FREQ : i;
 			freq_table[i].frequency = opp->rate / 1000;
 			i++;
 		}
@@ -701,19 +728,14 @@ struct srcu_notifier_head *dev_pm_opp_get_notifier(struct device *dev)
 }
 
 #ifdef CONFIG_OF
-/**
- * of_init_opp_table() - Initialize opp table from device tree
- * @dev:	device pointer used to lookup device OPPs.
- *
- * Register the initial OPP table with the OPP library for given device.
- */
-int of_init_opp_table(struct device *dev)
+static int of_parse_opp_table(struct device *dev, const char *prop_name,
+					bool boost)
 {
 	const struct property *prop;
 	const __be32 *val;
 	int nr;
 
-	prop = of_find_property(dev->of_node, "operating-points", NULL);
+	prop = of_find_property(dev->of_node, prop_name, NULL);
 	if (!prop)
 		return -ENODEV;
 	if (!prop->value)
@@ -734,7 +756,7 @@ int of_init_opp_table(struct device *dev)
 		unsigned long freq = be32_to_cpup(val++) * 1000;
 		unsigned long volt = be32_to_cpup(val++);
 
-		if (dev_pm_opp_add(dev, freq, volt)) {
+		if (dev_pm_opp_add_flags(dev, freq, volt, true, boost)) {
 			dev_warn(dev, "%s: Failed to add OPP %ld\n",
 				 __func__, freq);
 			continue;
@@ -744,5 +766,26 @@ int of_init_opp_table(struct device *dev)
 
 	return 0;
 }
+
+/**
+ * of_init_opp_table() - Initialize opp table from device tree
+ * @dev:	device pointer used to lookup device OPPs.
+ *
+ * Register the initial OPP table with the OPP library for given device.
+ * Additional "boost" operating points of the controller, if any, are
+ * specified with "boost-opp" property.
+ */
+int of_init_opp_table(struct device *dev)
+{
+	int ret;
+
+	ret = of_parse_opp_table(dev, "operating-points", false);
+	if (!ret) {
+		ret = of_parse_opp_table(dev, "boost-opp", true);
+		if (ret == -ENODEV)
+			ret = 0;
+	}
+	return ret;
+}
 EXPORT_SYMBOL_GPL(of_init_opp_table);
 #endif
-- 
1.7.10.4
