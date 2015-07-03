From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 05/10] opp: Add support to parse "operating-points-v2"
 bindings
Date: Fri, 3 Jul 2015 11:38:43 +0530
Message-ID: <20150703060843.GA4564@linux>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <1b5a393f2162752cbb773956dff15739e7525a1d.1434369079.git.viresh.kumar@linaro.org>
 <55949037.80305@codeaurora.org>
 <20150702063820.GE31684@linux>
 <559561B2.8010902@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36660 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754586AbbGCGMz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2015 02:12:55 -0400
Received: by paceq1 with SMTP id eq1so52116099pac.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2015 23:12:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <559561B2.8010902@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 02-07-15, 09:07, Stephen Boyd wrote:
> Oh I thought kernel-doc didn't care what order things were documented
> in, so moving it around doesn't really help unless someone cares that
> they match the struct ordering.

That was just for better readability, nothing more. And I really
prefer that. Consider a case where we have 15 fields in a struct and
the doc comment is all mixed up. Would be very difficult to read
explanations of individual fields. Of course you can do a simple
search in vim to match fields with comments, but its really good if we
follow the same order in comments as well.

Anyway, will drop it from this patch at least :)

> >>> +
> >>> +	new_opp->np = np;
> >>> +	new_opp->dynamic = false;
> >>> +	new_opp->available = true;
> >>> +
> >>> +	/*
> >>> +	 * TODO: Support multiple regulators
> >>> +	 *
> >>> +	 * read opp-microvolt array
> >>> +	 */
> >>> +	ret = of_property_count_u32_elems(np, "opp-microvolt");
> >>> +	if (ret == 1 || ret == 3) {
> >>> +		/* There can be one or three elements here */
> >>> +		ret = of_property_read_u32_array(np, "opp-microvolt",
> >>> +						 (u32 *)&new_opp->u_volt, ret);
> >> It seems fragile to rely on the struct packing here. Maybe the same
> >> comment in the struct should be copied here, and possibly some better
> >> way of doing this so the code can't be subtly broken?
> > Any example of how things will break? Aren't these guaranteed to be
> > present at 3 consecutive 32 bit positions ?
> 
> I'm mostly worried about someone jumbling fields in the struct. Maybe
> I'm too paranoid... Maybe we can have some sort of BUILD_BUG_ON() check
> here?
> 
> BUILD_BUG_ON(offsetof(struct dev_pm_opp, u_volt_max) - offsetof(struct
> dev_pm_opp, u_volt) != sizeof(u32) * 3);

> Have you tried compiling that on 64-bit? sizeof(unsigned long) !=
> sizeof(u32).

I see how it will break for 64 bit systems now, fixed it now.

-------------------8<---------------

Message-Id: <dc35329bc328e0ecb8534a3e1709a0d12cadb311.1435903622.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 15 Jun 2015 16:27:21 +0530
Subject: [PATCH] opp: Add support to parse "operating-points-v2" bindings

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
 drivers/base/power/opp.c | 249 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 225 insertions(+), 24 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index df5e5f14c368..c5829c86aa2a 100644
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
@@ -674,6 +686,118 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
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
@@ -905,29 +1029,64 @@ void of_free_opp_table(struct device *dev)
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
@@ -962,5 +1121,47 @@ int of_init_opp_table(struct device *dev)
 
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
+	return _of_init_opp_table_v2(dev, prop);
+}
 EXPORT_SYMBOL_GPL(of_init_opp_table);
 #endif
