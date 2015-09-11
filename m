From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 12/16] PM / OPP: Parse clock and voltage tolerance for v1 bindings
Date: Fri, 11 Sep 2015 17:32:08 +0530
Message-ID: <ddc3cdc76ff2bfa0e8caabb25a5c20535b52484b.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, lee.jones@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

V2 bindings have better support for that and doesn't need special care.
To use callbacks, like dev_pm_opp_get_max_{transition|volt}_latency(),
irrespective of the bindings, the core needs to know clock/voltage
tolerance for the earlier bindings.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 29 ++++++++++++++++++++++++++---
 drivers/base/power/opp/opp.h  |  5 +++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index d0678e804a75..9633f2fc3481 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -568,16 +568,19 @@ struct device_list_opp *_add_list_dev(const struct device *dev,
  * _add_device_opp() - Find device OPP table or allocate a new one
  * @dev:	device for which we do this operation
  * @supply_count: Number of supplies available for each OPP.
+ * @opp_v2:	true if parsing v2 bindings, else false.
  *
  * It tries to find an existing table first, if it couldn't find one, it
  * allocates a new OPP table and returns that.
  *
  * Return: valid device_opp pointer if success, else NULL.
  */
-static struct device_opp *_add_device_opp(struct device *dev, int supply_count)
+static struct device_opp *_add_device_opp(struct device *dev, int supply_count,
+					  bool opp_v2)
 {
 	struct device_opp *dev_opp;
 	struct device_list_opp *list_dev;
+	struct device_node *np;
 	size_t size;
 
 	/* Check for existing list for 'dev' first */
@@ -598,6 +601,22 @@ static struct device_opp *_add_device_opp(struct device *dev, int supply_count)
 	if (!dev_opp)
 		return NULL;
 
+	if (!opp_v2) {
+		/*
+		 * Only required for backward compatibility with v1 bindings.
+		 */
+		np = of_node_get(dev->of_node);
+		if (np) {
+			u32 val;
+
+			if (!of_property_read_u32(np, "clock-latency", &val))
+				dev_opp->clock_latency_ns_max = val;
+			of_property_read_u32(np, "voltage-tolerance",
+					     &dev_opp->voltage_tolerance_v1);
+			of_node_put(np);
+		}
+	}
+
 	dev_opp->supply_count = supply_count;
 	dev_opp->regulators = (struct regulator **)(dev_opp + 1);
 	dev_opp->supply_names = (const char **)(dev_opp->regulators + supply_count);
@@ -767,7 +786,7 @@ _allocate_opp(struct device *dev, struct device_opp **dev_opp, int supply_count)
 
 	INIT_LIST_HEAD(&opp->node);
 
-	*dev_opp = _add_device_opp(dev, supply_count);
+	*dev_opp = _add_device_opp(dev, supply_count, false);
 	if (!*dev_opp) {
 		kfree(opp);
 		return NULL;
@@ -873,6 +892,7 @@ static int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
 {
 	struct device_opp *dev_opp;
 	struct dev_pm_opp *new_opp;
+	unsigned long tol;
 	int ret;
 
 	/* Hold our list modification lock here */
@@ -886,7 +906,10 @@ static int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
 
 	/* populate the opp table */
 	new_opp->rate = freq;
+	tol = u_volt * dev_opp->voltage_tolerance_v1 / 100;
 	new_opp->supplies[0].u_volt = u_volt;
+	new_opp->supplies[0].u_volt_min = u_volt - tol;
+	new_opp->supplies[0].u_volt_max = u_volt + tol;
 	new_opp->available = true;
 	new_opp->dynamic = dynamic;
 
@@ -1436,7 +1459,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 	 * We need to add dev_opp before adding any OPPs, so that supply_names
 	 * are valid while the OPPs are getting added.
 	 */
-	dev_opp = _add_device_opp(dev, supply_count);
+	dev_opp = _add_device_opp(dev, supply_count, true);
 	if (!dev_opp)
 		return -ENOMEM;
 
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 830c4b654a51..55205cbe59dc 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -142,6 +142,8 @@ struct device_list_opp {
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
  * @dentry_name: Name of the real dentry.
  *
+ * @voltage_tolerance_v1: In percentage, for v1 bindings only.
+ *
  * This is an internal data structure maintaining the link to opps attached to
  * a device. This structure is not meant to be shared to users as it is
  * meant for book keeping and private to OPP library.
@@ -173,6 +175,9 @@ struct device_opp {
 	struct dentry *dentry;
 	char dentry_name[NAME_MAX];
 #endif
+
+	/* For backward compatibility with v1 bindings */
+	unsigned int voltage_tolerance_v1;
 };
 
 /* Routines internal to opp core */
-- 
2.4.0
