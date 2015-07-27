From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 06/11] opp: Add support to parse "operating-points-v2" bindings
Date: Mon, 27 Jul 2015 10:32:36 +0530
Message-ID: <f2267207114646280c5fd0e066d2b99f59a3c2e8.1437972635.git.viresh.kumar@linaro.org>
References: <cover.1437972635.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437972635.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437972635.git.viresh.kumar@linaro.org>
References: <cover.1437972635.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

This adds support in OPP library to parse and create list of OPPs from
operating-points-v2 bindings. It takes care of most of the properties of
new bindings (except shared-opp, which will be handled separately).

For backward compatibility, we keep supporting earlier bindings. We try
to search for the new bindings first, in case they aren't present we
look for the old deprecated ones.

There are few things marked as TODO:
- Support for multiple OPP tables
- Support for multiple regulators

They should be fixed separately.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 250 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 226 insertions(+), 24 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 962d62316b80..d9ebbd739b23 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -51,10 +51,15 @@
  *		order.
  * @dynamic:	not-created from static DT entries.
  * @available:	true/false - marks if this OPP as available or not
+ * @turbo:	true if turbo (boost) OPP
  * @rate:	Frequency in hertz
- * @u_volt:	Nominal voltage in microvolts corresponding to this OPP
+ * @u_volt:	Target voltage in microvolts corresponding to this OPP
+ * @u_volt_min:	Minimum voltage in microvolts corresponding to this OPP
+ * @u_volt_max:	Maximum voltage in microvolts corresponding to this OPP
+ * @u_amp:	Maximum current drawn by the device in microamperes
  * @dev_opp:	points back to the device_opp struct this opp belongs to
  * @rcu_head:	RCU callback head used for deferred freeing
+ * @np:		OPP's device node.
  *
  * This structure stores the OPP information for a given device.
  */
@@ -63,11 +68,18 @@ struct dev_pm_opp {
 
 	bool available;
 	bool dynamic;
+	bool turbo;
 	unsigned long rate;
+
 	unsigned long u_volt;
+	unsigned long u_volt_min;
+	unsigned long u_volt_max;
+	unsigned long u_amp;
 
 	struct device_opp *dev_opp;
 	struct rcu_head rcu_head;
+
+	struct device_node *np;
 };
 
 /**
@@ -672,6 +684,118 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
 	return ret;
 }
 
+/* TODO: Support multiple regulators */
+static int opp_get_microvolt(struct dev_pm_opp *opp, struct device *dev)
+{
+	u32 microvolt[3] = {0};
+	int count, ret;
+
+	count = of_property_count_u32_elems(opp->np, "opp-microvolt");
+	if (!count)
+		return 0;
+
+	/* There can be one or three elements here */
+	if (count != 1 && count != 3) {
+		dev_err(dev, "%s: Invalid number of elements in opp-microvolt property (%d)\n",
+			__func__, count);
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32_array(opp->np, "opp-microvolt", microvolt,
+					 count);
+	if (ret) {
+		dev_err(dev, "%s: error parsing opp-microvolt: %d\n", __func__,
+			ret);
+		return -EINVAL;
+	}
+
+	opp->u_volt = microvolt[0];
+	opp->u_volt_min = microvolt[1];
+	opp->u_volt_max = microvolt[2];
+
+	return 0;
+}
+
+/**
+ * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
+ * @dev:	device for which we do this operation
+ * @np:		device node
+ *
+ * This function adds an opp definition to the opp list and returns status. The
+ * opp can be controlled using dev_pm_opp_enable/disable functions and may be
+ * removed by dev_pm_opp_remove.
+ *
+ * Locking: The internal device_opp and opp structures are RCU protected.
+ * Hence this function internally uses RCU updater strategy with mutex locks
+ * to keep the integrity of the internal data structures. Callers should ensure
+ * that this function is *NOT* called under RCU protection or in contexts where
+ * mutex cannot be locked.
+ *
+ * Return:
+ * 0		On success OR
+ *		Duplicate OPPs (both freq and volt are same) and opp->available
+ * -EEXIST	Freq are same and volt are different OR
+ *		Duplicate OPPs (both freq and volt are same) and !opp->available
+ * -ENOMEM	Memory allocation failure
+ * -EINVAL	Failed parsing the OPP node
+ */
+static int _opp_add_static_v2(struct device *dev, struct device_node *np)
+{
+	struct device_opp *dev_opp;
+	struct dev_pm_opp *new_opp;
+	int ret;
+
+	/* Hold our list modification lock here */
+	mutex_lock(&dev_opp_list_lock);
+
+	new_opp = _allocate_opp(dev, &dev_opp);
+	if (!new_opp) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	ret = of_property_read_u32(np, "opp-hz", (u32 *)&new_opp->rate);
+	if (ret < 0) {
+		dev_err(dev, "%s: opp-hz not found\n", __func__);
+		goto free_opp;
+	}
+
+	new_opp->turbo = of_property_read_bool(np, "turbo-mode");
+
+	new_opp->np = np;
+	new_opp->dynamic = false;
+	new_opp->available = true;
+
+	ret = opp_get_microvolt(new_opp, dev);
+	if (ret)
+		goto free_opp;
+
+	of_property_read_u32(np, "opp-microamp", (u32 *)&new_opp->u_amp);
+
+	ret = _opp_add(new_opp, dev_opp);
+	if (ret)
+		goto free_opp;
+
+	mutex_unlock(&dev_opp_list_lock);
+
+	pr_debug("%s: turbo:%d rate:%lu uv:%lu uvmin:%lu uvmax:%lu\n",
+		 __func__, new_opp->turbo, new_opp->rate, new_opp->u_volt,
+		 new_opp->u_volt_min, new_opp->u_volt_max);
+
+	/*
+	 * Notify the changes in the availability of the operable
+	 * frequency/voltage list.
+	 */
+	srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_ADD, new_opp);
+	return 0;
+
+free_opp:
+	_opp_remove(dev_opp, new_opp, false);
+unlock:
+	mutex_unlock(&dev_opp_list_lock);
+	return ret;
+}
+
 /**
  * dev_pm_opp_add()  - Add an OPP table from a table definitions
  * @dev:	device for which we do this operation
@@ -903,29 +1027,64 @@ void of_free_opp_table(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(of_free_opp_table);
 
-/**
- * of_init_opp_table() - Initialize opp table from device tree
- * @dev:	device pointer used to lookup device OPPs.
- *
- * Register the initial OPP table with the OPP library for given device.
- *
- * Locking: The internal device_opp and opp structures are RCU protected.
- * Hence this function indirectly uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
- *
- * Return:
- * 0		On success OR
- *		Duplicate OPPs (both freq and volt are same) and opp->available
- * -EEXIST	Freq are same and volt are different OR
- *		Duplicate OPPs (both freq and volt are same) and !opp->available
- * -ENOMEM	Memory allocation failure
- * -ENODEV	when 'operating-points' property is not found or is invalid data
- *		in device node.
- * -ENODATA	when empty 'operating-points' property is found
- */
-int of_init_opp_table(struct device *dev)
+/* Returns opp descriptor node from its phandle. Caller must do of_node_put() */
+static struct device_node *
+_of_get_opp_desc_node_from_prop(struct device *dev, const struct property *prop)
+{
+	struct device_node *opp_np;
+
+	opp_np = of_find_node_by_phandle(be32_to_cpup(prop->value));
+	if (!opp_np) {
+		dev_err(dev, "%s: Prop: %s contains invalid opp desc phandle\n",
+			__func__, prop->name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return opp_np;
+}
+
+/* Initializes OPP tables based on new bindings */
+static int _of_init_opp_table_v2(struct device *dev,
+				 const struct property *prop)
+{
+	struct device_node *opp_np, *np;
+	int ret = 0, count = 0;
+
+	if (!prop->value)
+		return -ENODATA;
+
+	/* Get opp node */
+	opp_np = _of_get_opp_desc_node_from_prop(dev, prop);
+	if (IS_ERR(opp_np))
+		return PTR_ERR(opp_np);
+
+	/* We have opp-list node now, iterate over it and add OPPs */
+	for_each_available_child_of_node(opp_np, np) {
+		count++;
+
+		ret = _opp_add_static_v2(dev, np);
+		if (ret) {
+			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
+				ret);
+			break;
+		}
+	}
+
+	/* There should be one of more OPP defined */
+	if (WARN_ON(!count))
+		goto put_opp_np;
+
+	if (ret)
+		of_free_opp_table(dev);
+
+put_opp_np:
+	of_node_put(opp_np);
+
+	return ret;
+}
+
+/* Initializes OPP tables based on old-deprecated bindings */
+static int _of_init_opp_table_v1(struct device *dev)
 {
 	const struct property *prop;
 	const __be32 *val;
@@ -960,5 +1119,48 @@ int of_init_opp_table(struct device *dev)
 
 	return 0;
 }
+
+/**
+ * of_init_opp_table() - Initialize opp table from device tree
+ * @dev:	device pointer used to lookup device OPPs.
+ *
+ * Register the initial OPP table with the OPP library for given device.
+ *
+ * Locking: The internal device_opp and opp structures are RCU protected.
+ * Hence this function indirectly uses RCU updater strategy with mutex locks
+ * to keep the integrity of the internal data structures. Callers should ensure
+ * that this function is *NOT* called under RCU protection or in contexts where
+ * mutex cannot be locked.
+ *
+ * Return:
+ * 0		On success OR
+ *		Duplicate OPPs (both freq and volt are same) and opp->available
+ * -EEXIST	Freq are same and volt are different OR
+ *		Duplicate OPPs (both freq and volt are same) and !opp->available
+ * -ENOMEM	Memory allocation failure
+ * -ENODEV	when 'operating-points' property is not found or is invalid data
+ *		in device node.
+ * -ENODATA	when empty 'operating-points' property is found
+ * -EINVAL	when invalid entries are found in opp-v2 table
+ */
+int of_init_opp_table(struct device *dev)
+{
+	const struct property *prop;
+
+	/*
+	 * OPPs have two version of bindings now. The older one is deprecated,
+	 * try for the new binding first.
+	 */
+	prop = of_find_property(dev->of_node, "operating-points-v2", NULL);
+	if (!prop) {
+		/*
+		 * Try old-deprecated bindings for backward compatibility with
+		 * older dtbs.
+		 */
+		return _of_init_opp_table_v1(dev);
+	}
+
+	return _of_init_opp_table_v2(dev, prop);
+}
 EXPORT_SYMBOL_GPL(of_init_opp_table);
 #endif
-- 
2.4.0
