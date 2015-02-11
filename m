From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 5/7] opp: convert device_opp->dev to a list of devices
Date: Wed, 11 Feb 2015 16:16:28 +0800
Message-ID: <ac7a6543beed80bfe4d8bbe3900fc17673168f18.1423642246.git.viresh.kumar@linaro.org>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1423642246.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1423642246.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1423642246.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, rob.herring-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, Sudeep.Holla-5wv7dgnIgG8@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, santosh.shilimkar-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, mike.turquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kesavan.abhilash-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, ta.omasab-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, viswanath.puttagunta-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

An opp can be shared by multiple devices, for example its very common for CPUs
to share the OPPs, i.e. when they share clock lines.

Until now, the OPPs are bound to a single device and there is no way to mark
them shared.

This patch adds support to manage a list of devices sharing OPPs. It also senses
if the device (we are trying to initialize OPPs for) shares OPPs with an device
added earlier and in that case we just update the list of devices managed by
OPPs instead of initializing them again.

Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/base/power/opp.c | 189 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 157 insertions(+), 32 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index b7b9c33fbb65..24a014b7a68a 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -89,16 +89,33 @@ struct dev_pm_opp {
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
+	struct device *dev;
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
@@ -111,10 +128,12 @@ struct dev_pm_opp {
 struct device_opp {
 	struct list_head node;
 
-	struct device *dev;
 	struct srcu_notifier_head srcu_head;
 	struct rcu_head rcu_head;
+	struct list_head dev_list;
 	struct list_head opp_list;
+	struct device_node *np;
+	bool shared_opp;
 };
 
 /*
@@ -134,6 +153,45 @@ do {									\
 			   "dev_opp_list_lock protection");		\
 } while (0)
 
+static struct device_list_opp *_find_list_dev(struct device *dev,
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
+static int _list_dev_count(struct device_opp *dev_opp)
+{
+	struct device_list_opp *list_dev;
+	int count = 0;
+
+	list_for_each_entry(list_dev, &dev_opp->dev_list, node)
+		count++;
+
+	return count;
+}
+
+static struct device_opp *_managed_opp(struct device_node *np)
+{
+	struct device_opp *dev_opp;
+
+	list_for_each_entry_rcu(dev_opp, &dev_opp_list, node)
+		if (dev_opp->np == np) {
+			/* Managed only if the OPPs are shared */
+			if (dev_opp->shared_opp)
+				return dev_opp;
+			else
+				return NULL;
+		}
+
+	return NULL;
+}
+
 /**
  * _find_device_opp() - find device_opp struct using device pointer
  * @dev:	device pointer used to lookup device OPPs
@@ -150,21 +208,18 @@ do {									\
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
@@ -425,6 +480,38 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
+static struct device_list_opp *_add_list_dev(struct device *dev,
+					     struct device_opp *dev_opp)
+{
+	struct device_list_opp *list_dev;
+
+	list_dev = kzalloc(sizeof(*list_dev), GFP_KERNEL);
+	if (!list_dev)
+		return NULL;
+
+	/* Initialize list-dev */
+	list_add_rcu(&list_dev->node, &dev_opp->dev_list);
+	list_dev->dev = dev;
+
+	return list_dev;
+}
+
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
 /**
  * _kfree_opp_rcu() - Free OPP RCU handler
  * @head:	RCU head
@@ -478,6 +565,17 @@ static void _opp_remove(struct device_opp *dev_opp,
 
 	/* Free device if all OPPs are freed */
 	if (list_empty(&dev_opp->opp_list)) {
+		struct device_list_opp *list_dev;
+
+		list_dev = list_first_entry(&dev_opp->dev_list,
+					    struct device_list_opp, node);
+
+		_remove_list_dev(list_dev, dev_opp);
+
+		/* dev_list must be empty now */
+		WARN_ON(!list_empty(&dev_opp->dev_list));
+
+		/* Free dev-opp */
 		list_del_rcu(&dev_opp->node);
 		call_srcu(&dev_opp->srcu_head.srcu, &dev_opp->rcu_head,
 			  _kfree_device_rcu);
@@ -541,6 +639,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
 static struct device_opp *_add_device_opp(struct device *dev)
 {
 	struct device_opp *dev_opp;
+	struct device_list_opp *list_dev;
 
 	/*
 	 * Allocate a new device OPP table. In the infrequent case where a new
@@ -550,7 +649,13 @@ static struct device_opp *_add_device_opp(struct device *dev)
 	if (!dev_opp)
 		return NULL;
 
-	dev_opp->dev = dev;
+	INIT_LIST_HEAD(&dev_opp->dev_list);
+	list_dev = _add_list_dev(dev, dev_opp);
+	if (!list_dev) {
+		kfree(dev_opp);
+		return NULL;
+	}
+
 	srcu_init_notifier_head(&dev_opp->srcu_head);
 	INIT_LIST_HEAD(&dev_opp->opp_list);
 
@@ -584,7 +689,8 @@ static struct dev_pm_opp *_allocate_opp(struct device *dev,
 	return opp;
 }
 
-static int _opp_add(struct dev_pm_opp *new_opp, struct device_opp *dev_opp)
+static int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
+		    struct device_opp *dev_opp)
 {
 	struct dev_pm_opp *opp = NULL;
 	struct list_head *head = &dev_opp->opp_list;
@@ -602,7 +708,7 @@ static int _opp_add(struct dev_pm_opp *new_opp, struct device_opp *dev_opp)
 
 	/* Duplicate OPPs ? */
 	if (opp && new_opp->rate == opp->rate) {
-		dev_warn(dev_opp->dev,
+		dev_warn(dev,
 			 "%s: duplicate OPPs detected. Existing: freq: %lu, volt: %lu, enabled: %d. New: freq: %lu, volt: %lu, enabled: %d\n",
 			 __func__, opp->rate, opp->u_volt, opp->available,
 			 new_opp->rate, new_opp->u_volt, new_opp->available);
@@ -665,7 +771,7 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
 	new_opp->available = true;
 	new_opp->dynamic = dynamic;
 
-	ret = _opp_add(new_opp, dev_opp);
+	ret = _opp_add(dev, new_opp, dev_opp);
 	if (ret)
 		goto free_opp;
 
@@ -789,7 +895,7 @@ static int _opp_add_dynamic_v2(struct device *dev, struct device_node *np,
 		}
 	}
 
-	ret = _opp_add(new_opp, dev_opp);
+	ret = _opp_add(dev, new_opp, dev_opp);
 	if (ret)
 		goto free_opp;
 
@@ -826,16 +932,11 @@ static struct dev_pm_opp *_get_opp_from_np(struct device_opp *dev_opp,
 	return NULL;
 }
 
-static void _opp_fill_opp_next(struct device *dev)
+static void _opp_fill_opp_next(struct device_opp *dev_opp, struct device *dev)
 {
-	struct device_opp *dev_opp;
 	struct dev_pm_opp *opp;
 	int i;
 
-	dev_opp = _find_device_opp(dev);
-	if (WARN_ON(!dev_opp))
-		return;
-
 	list_for_each_entry_rcu(opp, &dev_opp->opp_list, node) {
 		if (!opp->next)
 			continue;
@@ -1086,6 +1187,7 @@ static int _of_init_opp_table_v2(struct device *dev,
 				 const struct property *prop)
 {
 	struct device_node *opp_np, *np;
+	struct device_opp *dev_opp;
 	int ret = 0, count = 0;
 
 	/* Get opp node */
@@ -1093,6 +1195,14 @@ static int _of_init_opp_table_v2(struct device *dev,
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
@@ -1109,10 +1219,19 @@ static int _of_init_opp_table_v2(struct device *dev,
 	if (WARN_ON(!count))
 		goto put_opp_np;
 
-	if (ret)
+	if (ret) {
 		of_free_opp_table(dev);
-	else
-		_opp_fill_opp_next(dev);
+	} else {
+		/* Update np and shared_opp */
+		dev_opp = _find_device_opp(dev);
+		if (WARN_ON(!dev_opp))
+			goto put_opp_np;
+
+		dev_opp->np = opp_np;
+		if (of_get_property(opp_np, "shared-opp", NULL))
+			dev_opp->shared_opp = true;
+		_opp_fill_opp_next(dev_opp, dev);
+	}
 
 put_opp_np:
 	of_node_put(opp_np);
@@ -1219,6 +1338,9 @@ void of_free_opp_table(struct device *dev)
 	struct device_opp *dev_opp;
 	struct dev_pm_opp *opp, *tmp;
 
+	/* Hold our list modification lock here */
+	mutex_lock(&dev_opp_list_lock);
+
 	/* Check for existing list for 'dev' */
 	dev_opp = _find_device_opp(dev);
 	if (IS_ERR(dev_opp)) {
@@ -1228,18 +1350,21 @@ void of_free_opp_table(struct device *dev)
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
+	if (_list_dev_count(dev_opp) == 1) {
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
-- 
2.3.0.rc0.44.ga94655d

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
