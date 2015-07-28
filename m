From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 08/11] opp: Add OPP sharing information to OPP library
Date: Tue, 28 Jul 2015 07:41:24 +0530
Message-ID: <20150728021124.GM18535@linux>
References: <cover.1437972635.git.viresh.kumar@linaro.org>
 <f92bd33dcaa2094dfc99aa9656487c6f08f160fe.1437972635.git.viresh.kumar@linaro.org>
 <1564699.gQjhqzf5VE@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33808 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446AbbG1CL3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 22:11:29 -0400
Received: by pacan13 with SMTP id an13so62318455pac.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2015 19:11:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1564699.gQjhqzf5VE@amdc1976>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 27-07-15, 16:48, Bartlomiej Zolnierkiewicz wrote:
> s/will not/will now/ ?

> Probably doesn't matter currently but how's about:
> 
> 	list_dev->dev = dev;
> 	list_add_rcu(&list_dev->node, &dev_opp->dev_list);

> Otherwise:
> 
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

---------------------8<---------------------
Message-Id: <feac18ce48674ec30a40db9ec65d0dc2e676cff2.1438049409.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 11 Feb 2015 16:16:28 +0800
Subject: [PATCH] opp: Add OPP sharing information to OPP library

An opp can be shared by multiple devices, for example its very common
for CPUs to share the OPPs, i.e. when they share clock/voltage rails.

This patch adds support of shared OPPs to the OPP library.

Instead of a single device, dev_opp will now contain a list of devices
that use it. It also senses if the device (we are trying to initialize
OPPs for) shares OPPs with a device added earlier and in that case we
update the list of devices managed by OPPs instead of duplicating OPPs
again.

The same infrastructure will be used for the old OPP bindings, with
later patches.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 174 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 150 insertions(+), 24 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 96d7d1b6730a..749c36e8141b 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -86,16 +86,33 @@ struct dev_pm_opp {
 };
 
 /**
+ * struct device_list_opp - devices managed by 'struct device_opp'
+ * @node:	list node
+ * @dev:	device to which the struct object belongs
+ * @rcu_head:	RCU callback head used for deferred freeing
+ *
+ * This is an internal data structure maintaining the list of devices that are
+ * managed by 'struct device_opp'.
+ */
+struct device_list_opp {
+	struct list_head node;
+	const struct device *dev;
+	struct rcu_head rcu_head;
+};
+
+/**
  * struct device_opp - Device opp structure
  * @node:	list node - contains the devices with OPPs that
  *		have been registered. Nodes once added are not modified in this
  *		list.
  *		RCU usage: nodes are not modified in the list of device_opp,
  *		however addition is possible and is secured by dev_opp_list_lock
- * @dev:	device pointer
  * @srcu_head:	notifier head to notify the OPP availability changes.
  * @rcu_head:	RCU callback head used for deferred freeing
+ * @dev_list:	list of devices that share these OPPs
  * @opp_list:	list of opps
+ * @np:		struct device_node pointer for opp's DT node.
+ * @shared_opp: OPP is shared between multiple devices.
  *
  * This is an internal data structure maintaining the link to opps attached to
  * a device. This structure is not meant to be shared to users as it is
@@ -108,12 +125,14 @@ struct dev_pm_opp {
 struct device_opp {
 	struct list_head node;
 
-	struct device *dev;
 	struct srcu_notifier_head srcu_head;
 	struct rcu_head rcu_head;
+	struct list_head dev_list;
 	struct list_head opp_list;
 
+	struct device_node *np;
 	unsigned long clock_latency_ns_max;
+	bool shared_opp;
 };
 
 /*
@@ -133,6 +152,38 @@ do {									\
 			   "dev_opp_list_lock protection");		\
 } while (0)
 
+static struct device_list_opp *_find_list_dev(const struct device *dev,
+					      struct device_opp *dev_opp)
+{
+	struct device_list_opp *list_dev;
+
+	list_for_each_entry(list_dev, &dev_opp->dev_list, node)
+		if (list_dev->dev == dev)
+			return list_dev;
+
+	return NULL;
+}
+
+static struct device_opp *_managed_opp(const struct device_node *np)
+{
+	struct device_opp *dev_opp;
+
+	list_for_each_entry_rcu(dev_opp, &dev_opp_list, node) {
+		if (dev_opp->np == np) {
+			/*
+			 * Multiple devices can point to the same OPP table and
+			 * so will have same node-pointer, np.
+			 *
+			 * But the OPPs will be considered as shared only if the
+			 * OPP table contains a "opp-shared" property.
+			 */
+			return dev_opp->shared_opp ? dev_opp : NULL;
+		}
+	}
+
+	return NULL;
+}
+
 /**
  * _find_device_opp() - find device_opp struct using device pointer
  * @dev:	device pointer used to lookup device OPPs
@@ -149,21 +200,18 @@ do {									\
  */
 static struct device_opp *_find_device_opp(struct device *dev)
 {
-	struct device_opp *tmp_dev_opp, *dev_opp = ERR_PTR(-ENODEV);
+	struct device_opp *dev_opp;
 
 	if (unlikely(IS_ERR_OR_NULL(dev))) {
 		pr_err("%s: Invalid parameters\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
 
-	list_for_each_entry_rcu(tmp_dev_opp, &dev_opp_list, node) {
-		if (tmp_dev_opp->dev == dev) {
-			dev_opp = tmp_dev_opp;
-			break;
-		}
-	}
+	list_for_each_entry_rcu(dev_opp, &dev_opp_list, node)
+		if (_find_list_dev(dev, dev_opp))
+			return dev_opp;
 
-	return dev_opp;
+	return ERR_PTR(-ENODEV);
 }
 
 /**
@@ -450,6 +498,39 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
+/* List-dev Helpers */
+static void _kfree_list_dev_rcu(struct rcu_head *head)
+{
+	struct device_list_opp *list_dev;
+
+	list_dev = container_of(head, struct device_list_opp, rcu_head);
+	kfree_rcu(list_dev, rcu_head);
+}
+
+static void _remove_list_dev(struct device_list_opp *list_dev,
+			     struct device_opp *dev_opp)
+{
+	list_del(&list_dev->node);
+	call_srcu(&dev_opp->srcu_head.srcu, &list_dev->rcu_head,
+		  _kfree_list_dev_rcu);
+}
+
+static struct device_list_opp *_add_list_dev(const struct device *dev,
+					     struct device_opp *dev_opp)
+{
+	struct device_list_opp *list_dev;
+
+	list_dev = kzalloc(sizeof(*list_dev), GFP_KERNEL);
+	if (!list_dev)
+		return NULL;
+
+	/* Initialize list-dev */
+	list_dev->dev = dev;
+	list_add_rcu(&list_dev->node, &dev_opp->dev_list);
+
+	return list_dev;
+}
+
 /**
  * _add_device_opp() - Find device OPP table or allocate a new one
  * @dev:	device for which we do this operation
@@ -462,6 +543,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 static struct device_opp *_add_device_opp(struct device *dev)
 {
 	struct device_opp *dev_opp;
+	struct device_list_opp *list_dev;
 
 	/* Check for existing list for 'dev' first */
 	dev_opp = _find_device_opp(dev);
@@ -476,7 +558,14 @@ static struct device_opp *_add_device_opp(struct device *dev)
 	if (!dev_opp)
 		return NULL;
 
-	dev_opp->dev = dev;
+	INIT_LIST_HEAD(&dev_opp->dev_list);
+
+	list_dev = _add_list_dev(dev, dev_opp);
+	if (!list_dev) {
+		kfree(dev_opp);
+		return NULL;
+	}
+
 	srcu_init_notifier_head(&dev_opp->srcu_head);
 	INIT_LIST_HEAD(&dev_opp->opp_list);
 
@@ -504,9 +593,19 @@ static void _kfree_device_rcu(struct rcu_head *head)
  */
 static void _remove_device_opp(struct device_opp *dev_opp)
 {
+	struct device_list_opp *list_dev;
+
 	if (!list_empty(&dev_opp->opp_list))
 		return;
 
+	list_dev = list_first_entry(&dev_opp->dev_list, struct device_list_opp,
+				    node);
+
+	_remove_list_dev(list_dev, dev_opp);
+
+	/* dev_list must be empty now */
+	WARN_ON(!list_empty(&dev_opp->dev_list));
+
 	list_del_rcu(&dev_opp->node);
 	call_srcu(&dev_opp->srcu_head.srcu, &dev_opp->rcu_head,
 		  _kfree_device_rcu);
@@ -616,7 +715,8 @@ static struct dev_pm_opp *_allocate_opp(struct device *dev,
 	return opp;
 }
 
-static int _opp_add(struct dev_pm_opp *new_opp, struct device_opp *dev_opp)
+static int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
+		    struct device_opp *dev_opp)
 {
 	struct dev_pm_opp *opp;
 	struct list_head *head = &dev_opp->opp_list;
@@ -632,7 +732,7 @@ static int _opp_add(struct dev_pm_opp *new_opp, struct device_opp *dev_opp)
 			break;
 
 		/* Duplicate OPPs */
-		dev_warn(dev_opp->dev, "%s: duplicate OPPs detected. Existing: freq: %lu, volt: %lu, enabled: %d. New: freq: %lu, volt: %lu, enabled: %d\n",
+		dev_warn(dev, "%s: duplicate OPPs detected. Existing: freq: %lu, volt: %lu, enabled: %d. New: freq: %lu, volt: %lu, enabled: %d\n",
 			 __func__, opp->rate, opp->u_volt, opp->available,
 			 new_opp->rate, new_opp->u_volt, new_opp->available);
 
@@ -695,7 +795,7 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
 	new_opp->available = true;
 	new_opp->dynamic = dynamic;
 
-	ret = _opp_add(new_opp, dev_opp);
+	ret = _opp_add(dev, new_opp, dev_opp);
 	if (ret)
 		goto free_opp;
 
@@ -805,7 +905,7 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 
 	of_property_read_u32(np, "opp-microamp", (u32 *)&new_opp->u_amp);
 
-	ret = _opp_add(new_opp, dev_opp);
+	ret = _opp_add(dev, new_opp, dev_opp);
 	if (ret)
 		goto free_opp;
 
@@ -1038,6 +1138,9 @@ void of_free_opp_table(struct device *dev)
 	struct device_opp *dev_opp;
 	struct dev_pm_opp *opp, *tmp;
 
+	/* Hold our list modification lock here */
+	mutex_lock(&dev_opp_list_lock);
+
 	/* Check for existing list for 'dev' */
 	dev_opp = _find_device_opp(dev);
 	if (IS_ERR(dev_opp)) {
@@ -1048,18 +1151,21 @@ void of_free_opp_table(struct device *dev)
 			     IS_ERR_OR_NULL(dev) ?
 					"Invalid device" : dev_name(dev),
 			     error);
-		return;
+		goto unlock;
 	}
 
-	/* Hold our list modification lock here */
-	mutex_lock(&dev_opp_list_lock);
-
-	/* Free static OPPs */
-	list_for_each_entry_safe(opp, tmp, &dev_opp->opp_list, node) {
-		if (!opp->dynamic)
-			_opp_remove(dev_opp, opp, true);
+	/* Find if dev_opp manages a single device */
+	if (list_is_singular(&dev_opp->dev_list)) {
+		/* Free static OPPs */
+		list_for_each_entry_safe(opp, tmp, &dev_opp->opp_list, node) {
+			if (!opp->dynamic)
+				_opp_remove(dev_opp, opp, true);
+		}
+	} else {
+		_remove_list_dev(_find_list_dev(dev, dev_opp), dev_opp);
 	}
 
+unlock:
 	mutex_unlock(&dev_opp_list_lock);
 }
 EXPORT_SYMBOL_GPL(of_free_opp_table);
@@ -1085,6 +1191,7 @@ static int _of_init_opp_table_v2(struct device *dev,
 				 const struct property *prop)
 {
 	struct device_node *opp_np, *np;
+	struct device_opp *dev_opp;
 	int ret = 0, count = 0;
 
 	if (!prop->value)
@@ -1095,6 +1202,14 @@ static int _of_init_opp_table_v2(struct device *dev,
 	if (IS_ERR(opp_np))
 		return PTR_ERR(opp_np);
 
+	dev_opp = _managed_opp(opp_np);
+	if (dev_opp) {
+		/* OPPs are already managed */
+		if (!_add_list_dev(dev, dev_opp))
+			ret = -ENOMEM;
+		goto put_opp_np;
+	}
+
 	/* We have opp-list node now, iterate over it and add OPPs */
 	for_each_available_child_of_node(opp_np, np) {
 		count++;
@@ -1111,8 +1226,19 @@ static int _of_init_opp_table_v2(struct device *dev,
 	if (WARN_ON(!count))
 		goto put_opp_np;
 
-	if (ret)
+	if (!ret) {
+		if (!dev_opp) {
+			dev_opp = _find_device_opp(dev);
+			if (WARN_ON(!dev_opp))
+				goto put_opp_np;
+		}
+
+		dev_opp->np = opp_np;
+		dev_opp->shared_opp = of_property_read_bool(opp_np,
+							    "opp-shared");
+	} else {
 		of_free_opp_table(dev);
+	}
 
 put_opp_np:
 	of_node_put(opp_np);
