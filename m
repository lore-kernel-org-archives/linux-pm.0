From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4/7] opp: Parse new (v2) bindings
Date: Wed, 11 Feb 2015 16:16:27 +0800
Message-ID: <c215d5e8ea893bccba48abf9c80a5e0be5b8b9da.1423642246.git.viresh.kumar@linaro.org>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:37158 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbbBKIRH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Feb 2015 03:17:07 -0500
Received: by mail-pa0-f50.google.com with SMTP id hz1so2464107pad.9
        for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2015 00:17:07 -0800 (PST)
In-Reply-To: <cover.1423642246.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1423642246.git.viresh.kumar@linaro.org>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, grant.likely@linaro.org, olof@lixom.net, nm@ti.com, Sudeep.Holla@arm.com, sboyd@codeaurora.org, devicetree@vger.kernel.org, santosh.shilimkar@oracle.com, mike.turquette@linaro.org, kesavan.abhilash@gmail.com, catalin.marinas@arm.com, ta.omasab@gmail.com, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com, l.stach@pengutronix.de, broonie@kernel.org, viswanath.puttagunta@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

This adds support in OPP library to parse and create list of OPPs from
operating-points-v2 bindings. It takes care of most of the properties of new
bindings (except shared-opp, which will be handled separately).

For backward compatibility, we keep supporting earlier bindings. We try to
search for the new bindings first, in case they aren't present we look for the
old deprecated ones.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 342 +++++++++++++++++++++++++++++++++++++++++++----
 include/linux/pm_opp.h   |   6 +
 2 files changed, 323 insertions(+), 25 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 904dcf386747..b7b9c33fbb65 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -49,12 +49,21 @@
  *		are protected by the dev_opp_list_lock for integrity.
  *		IMPORTANT: the opp nodes should be maintained in increasing
  *		order.
- * @dynamic:	not-created from static DT entries.
  * @available:	true/false - marks if this OPP as available or not
+ * @dynamic:	not-created from static DT entries.
+ * @turbo:	true if turbo (boost) OPP
  * @rate:	Frequency in hertz
- * @u_volt:	Nominal voltage in microvolts corresponding to this OPP
+ * @u_volt:	Target voltage in microvolts corresponding to this OPP
+ * @u_volt_min:	Minimum voltage in microvolts corresponding to this OPP
+ * @u_volt_max:	Maximum voltage in microvolts corresponding to this OPP
+ * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
+ *		frequency from any other OPP's frequency.
  * @dev_opp:	points back to the device_opp struct this opp belongs to
  * @rcu_head:	RCU callback head used for deferred freeing
+ * @np:		OPP's device node.
+ * @next:	Array of OPPs we can switch to from this OPP.
+ * @next_np:	Array of device nodes of OPP to which we can switch from this OPP.
+ * @count:	count of 'next' array.
  *
  * This structure stores the OPP information for a given device.
  */
@@ -63,11 +72,20 @@ struct dev_pm_opp {
 
 	bool available;
 	bool dynamic;
+	bool turbo;
 	unsigned long rate;
 	unsigned long u_volt;
+	unsigned long u_volt_min;
+	unsigned long u_volt_max;
+	unsigned long clock_latency_ns;
 
 	struct device_opp *dev_opp;
 	struct rcu_head rcu_head;
+
+	struct device_node *np;
+	struct dev_pm_opp **next;
+	struct device_node **next_np;
+	unsigned int next_count;
 };
 
 /**
@@ -444,15 +462,21 @@ static void _kfree_device_rcu(struct rcu_head *head)
 static void _opp_remove(struct device_opp *dev_opp,
 			struct dev_pm_opp *opp, bool notify)
 {
+	/* Free any next OPP nodes */
+	kfree(opp->next);
+
 	/*
 	 * Notify the changes in the availability of the operable
 	 * frequency/voltage list.
 	 */
 	if (notify)
 		srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_REMOVE, opp);
+
+	/* Free OPP */
 	list_del_rcu(&opp->node);
 	call_srcu(&dev_opp->srcu_head.srcu, &opp->rcu_head, _kfree_opp_rcu);
 
+	/* Free device if all OPPs are freed */
 	if (list_empty(&dev_opp->opp_list)) {
 		list_del_rcu(&dev_opp->node);
 		call_srcu(&dev_opp->srcu_head.srcu, &dev_opp->rcu_head,
@@ -662,6 +686,170 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
 }
 
 /**
+ * _opp_add_dynamic_v2() - Allocate a dynamic OPP according to 'v2' DT bindings.
+ * @dev:	device for which we do this operation
+ * @np:		device node
+ * @dynamic:	Dynamically added OPPs.
+ *
+ * This function adds an opp definition to the opp list and returns status. The
+ * opp can be controlled using dev_pm_opp_enable/disable functions and may be
+ * removed by dev_pm_opp_remove.
+ *
+ * NOTE: "dynamic" parameter impacts OPPs added by the of_init_opp_table and
+ * freed by of_free_opp_table.
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
+static int _opp_add_dynamic_v2(struct device *dev, struct device_node *np,
+			       bool dynamic)
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
+	ret = of_property_read_u32(np, "opp-khz", (u32 *)&new_opp->rate);
+	if (ret < 0) {
+		dev_err(dev, "%s: opp-khz not found\n", __func__);
+		goto free_opp;
+	}
+	new_opp->rate *= 1000;
+
+	if (of_get_property(np, "turbo-mode", NULL))
+		new_opp->turbo = true;
+
+	new_opp->np = np;
+	new_opp->dynamic = dynamic;
+	new_opp->available = of_device_is_available(np);
+	of_property_read_u32(np, "clock-latency-ns",
+			     (u32 *)&new_opp->clock_latency_ns);
+
+	/* read opp-microvolt array */
+	ret = of_property_count_u32_elems(np, "opp-microvolt");
+	if (ret == 1 || ret == 3) {
+		/* There can be one or three elements here */
+		ret = of_property_read_u32_array(np, "opp-microvolt",
+						 (u32 *)&new_opp->u_volt, ret);
+		if (ret) {
+			dev_err(dev, "%s: error parsing opp-microvolt: %d\n",
+				__func__, ret);
+			goto free_opp;
+		}
+	}
+
+	/* Parse OPP phandles */
+	ret = of_property_count_u32_elems(np, "opp-next");
+	if (ret > 0) {
+		int i, size = sizeof(*new_opp->next) + sizeof(*new_opp->next_np);
+		struct device_node **next_np;
+
+		/* Allocate memory for both 'next' and 'next_np' */
+		new_opp->next = kmalloc(size * ret, GFP_KERNEL);
+		if (!new_opp->next) {
+			ret = -ENOMEM;
+			goto free_opp;
+		}
+
+		new_opp->next_count = ret;
+		new_opp->next_np = (struct device_node **)(new_opp->next + ret);
+		next_np = new_opp->next_np;
+
+		/*
+		 * Parse OPP phandles for now, we will create the list of OPPs
+		 * once all are available.
+		 */
+		for (i = 0; i < ret; i++) {
+			next_np[i] = of_parse_phandle(np, "opp-next", i);
+			if (!next_np[i]) {
+				dev_err(dev, "%s: Failed to get opp phandle\n",
+					__func__);
+				ret = -EINVAL;
+				goto free_opp;
+			}
+		}
+	}
+
+	ret = _opp_add(new_opp, dev_opp);
+	if (ret)
+		goto free_opp;
+
+	pr_debug("%s: dynamic:%d turbo:%d rate:%lu uv:%lu uvmin:%lu uvmax:%lu latency:%lu next-count:%u\n",
+		 __func__, new_opp->dynamic, new_opp->turbo, new_opp->rate,
+		 new_opp->u_volt, new_opp->u_volt_min, new_opp->u_volt_max,
+		 new_opp->clock_latency_ns, new_opp->next_count);
+
+	mutex_unlock(&dev_opp_list_lock);
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
+static struct dev_pm_opp *_get_opp_from_np(struct device_opp *dev_opp,
+					   struct device_node *np)
+{
+	struct dev_pm_opp *opp;
+
+	list_for_each_entry_rcu(opp, &dev_opp->opp_list, node)
+		if (opp->np == np)
+			return opp;
+
+	return NULL;
+}
+
+static void _opp_fill_opp_next(struct device *dev)
+{
+	struct device_opp *dev_opp;
+	struct dev_pm_opp *opp;
+	int i;
+
+	dev_opp = _find_device_opp(dev);
+	if (WARN_ON(!dev_opp))
+		return;
+
+	list_for_each_entry_rcu(opp, &dev_opp->opp_list, node) {
+		if (!opp->next)
+			continue;
+
+		for (i = 0; i < opp->next_count; i++) {
+			opp->next[i] = _get_opp_from_np(dev_opp, opp->next_np[i]);
+			if (!opp->next[i])
+				dev_err(dev, "%s: Have np but no OPP: %d\n",
+					__func__, i);
+		}
+	}
+}
+
+/**
  * dev_pm_opp_add()  - Add an OPP table from a table definitions
  * @dev:	device for which we do this operation
  * @freq:	Frequency in Hz for this OPP
@@ -851,29 +1039,89 @@ struct srcu_notifier_head *dev_pm_opp_get_notifier(struct device *dev)
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_notifier);
 
 #ifdef CONFIG_OF
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
+void of_free_opp_table(struct device *dev);
+
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
+/* Returns opp descriptor node for a device. Caller must do of_node_put() */
+struct device_node *of_get_opp_desc_node(struct device *dev)
+{
+	const struct property *prop;
+
+	prop = of_find_property(dev->of_node, "operating-points-v2", NULL);
+	if (!prop)
+		return ERR_PTR(-ENODEV);
+	if (!prop->value)
+		return ERR_PTR(-ENODATA);
+
+	/*
+	 * There should be only ONE phandle present in "operating-points-v2"
+	 * property.
+	 */
+	if (prop->length != sizeof(__be32)) {
+		dev_err(dev, "%s: Invalid opp desc phandle\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return _of_get_opp_desc_node_from_prop(dev, prop);
+}
+EXPORT_SYMBOL_GPL(of_get_opp_desc_node);
+
+/* Initializes OPP tables based on new bindings */
+static int _of_init_opp_table_v2(struct device *dev,
+				 const struct property *prop)
+{
+	struct device_node *opp_np, *np;
+	int ret = 0, count = 0;
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
+		ret = _opp_add_dynamic_v2(dev, np, false);
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
+	else
+		_opp_fill_opp_next(dev);
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
@@ -908,6 +1156,50 @@ int of_init_opp_table(struct device *dev)
 
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
+	if (!prop->value)
+		return -ENODATA;
+	return _of_init_opp_table_v2(dev, prop);
+}
 EXPORT_SYMBOL_GPL(of_init_opp_table);
 
 /**
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index cec2d4540914..9949d07a93f9 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -115,6 +115,7 @@ static inline struct srcu_notifier_head *dev_pm_opp_get_notifier(
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
 int of_init_opp_table(struct device *dev);
 void of_free_opp_table(struct device *dev);
+struct device_node *of_get_opp_desc_node(struct device *dev);
 #else
 static inline int of_init_opp_table(struct device *dev)
 {
@@ -124,6 +125,11 @@ static inline int of_init_opp_table(struct device *dev)
 static inline void of_free_opp_table(struct device *dev)
 {
 }
+
+static inline struct device_node *of_get_opp_desc_node(struct device *dev)
+{
+	return ERR_PTR(-EINVAL);
+}
 #endif
 
 #endif		/* __LINUX_OPP_H__ */
-- 
2.3.0.rc0.44.ga94655d

