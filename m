From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 07/10] PM / OPP: Don't allocate OPP table from
 _opp_allocate()
Date: Thu, 8 Dec 2016 09:15:58 +0530
Message-ID: <20161208034558.GB24152@vireshk-i7>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
 <ab1dbd94f4638ac04a9dd4b526ddaaf136154dd1.1481015522.git.viresh.kumar@linaro.org>
 <20161207010221.GE4388@codeaurora.org>
 <20161207041744.GF31255@vireshk-i7>
 <20161207220525.GB5423@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36655 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752980AbcLHDqD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Dec 2016 22:46:03 -0500
Received: by mail-pg0-f53.google.com with SMTP id f188so168623087pgc.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Dec 2016 19:46:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161207220525.GB5423@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 07-12-16, 14:05, Stephen Boyd wrote:
> Sorry I don't understand. After this patch it looks like dev is
> unused in the function because we delete the only user
> _add_opp_table().

Sorry, I misread your earlier comment :(

> I haven't looked at the next round of patches. If the lock is
> still held across the notifier for OPP_EVENT_ADD then it would
> seem that we should get some sort of lockdep splat if the
> notified functions want to call back into the OPP code and that
> takes the same lock we held across the notifier.

Right.

> Even if it would
> work for the other notifiers that aren't OPP_EVENT_ADD, lockdep
> wouldn't know that because of locking classes, hence the splat.

yes.

> That's my only concern. Obviously if the locking is going away
> then it's just a bisection hole problem that I'm willing to
> ignore.

Yes it is surely going away and we wouldn't get the splat for now as well.
I already confirmed that only devfreq uses OPP notifiers. I can also confirm
that only two devfreq drivers (rk3399 and exynos) register the notifiers and
they do that after adding the OPP table.

IOW, no one is listening to OPP_ADD event for now.

Here is the new version of the patch. I will send the complete series only after
all the patches are reviewed now..

-------------------------8<-------------------------

Subject: [PATCH] PM / OPP: Don't allocate OPP table from _opp_allocate()

There is no point in trying to find/allocate the table for every OPP
that is added for a device. It would be far more efficient to allocate
the table only once and pass its pointer to the routines that add the
OPP entry.

Locking is removed from _opp_add_static_v2() and _opp_add_v1() now as
the callers call them with that lock already held.

Call to _remove_opp_table() routine is also removed from _opp_free()
now, as opp_table isn't allocated from within _opp_allocate(). This is
handled by the routines which created the OPP table in the first place.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 67 +++++++++++++++++++-------------------
 drivers/base/power/opp/of.c   | 75 ++++++++++++++++++++++---------------------
 drivers/base/power/opp/opp.h  |  9 ++++--
 3 files changed, 78 insertions(+), 73 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index b3a624a4af81..dde7dd099aa0 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -829,7 +829,7 @@ struct opp_device *_add_opp_dev(const struct device *dev,
  *
  * Return: valid opp_table pointer if success, else NULL.
  */
-static struct opp_table *_add_opp_table(struct device *dev)
+struct opp_table *_add_opp_table(struct device *dev)
 {
 	struct opp_table *opp_table;
 	struct opp_device *opp_dev;
@@ -929,10 +929,9 @@ static void _remove_opp_table(struct opp_table *opp_table)
 		  _kfree_device_rcu);
 }
 
-void _opp_free(struct dev_pm_opp *opp, struct opp_table *opp_table)
+void _opp_free(struct dev_pm_opp *opp)
 {
 	kfree(opp);
-	_remove_opp_table(opp_table);
 }
 
 /**
@@ -1016,16 +1015,10 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
 
-struct dev_pm_opp *_opp_allocate(struct device *dev,
-				 struct opp_table **opp_table)
+struct dev_pm_opp *_opp_allocate(struct opp_table *table)
 {
 	struct dev_pm_opp *opp;
 	int count, supply_size;
-	struct opp_table *table;
-
-	table = _add_opp_table(dev);
-	if (!table)
-		return NULL;
 
 	/* Allocate space for at least one supply */
 	count = table->regulator_count ? table->regulator_count : 1;
@@ -1033,17 +1026,13 @@ struct dev_pm_opp *_opp_allocate(struct device *dev,
 
 	/* allocate new OPP node and supplies structures */
 	opp = kzalloc(sizeof(*opp) + supply_size, GFP_KERNEL);
-	if (!opp) {
-		kfree(table);
+	if (!opp)
 		return NULL;
-	}
 
 	/* Put the supplies at the end of the OPP structure as an empty array */
 	opp->supplies = (struct dev_pm_opp_supply *)(opp + 1);
 	INIT_LIST_HEAD(&opp->node);
 
-	*opp_table = table;
-
 	return opp;
 }
 
@@ -1133,6 +1122,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 
 /**
  * _opp_add_v1() - Allocate a OPP based on v1 bindings.
+ * @opp_table:	OPP table
  * @dev:	device for which we do this operation
  * @freq:	Frequency in Hz for this OPP
  * @u_volt:	Voltage in uVolts for this OPP
@@ -1158,22 +1148,18 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
  *		Duplicate OPPs (both freq and volt are same) and !opp->available
  * -ENOMEM	Memory allocation failure
  */
-int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
-		bool dynamic)
+int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
+		unsigned long freq, long u_volt, bool dynamic)
 {
-	struct opp_table *opp_table;
 	struct dev_pm_opp *new_opp;
 	unsigned long tol;
 	int ret;
 
-	/* Hold our table modification lock here */
-	mutex_lock(&opp_table_lock);
+	opp_rcu_lockdep_assert();
 
-	new_opp = _opp_allocate(dev, &opp_table);
-	if (!new_opp) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
+	new_opp = _opp_allocate(opp_table);
+	if (!new_opp)
+		return -ENOMEM;
 
 	/* populate the opp table */
 	new_opp->rate = freq;
@@ -1192,8 +1178,6 @@ int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
 		goto free_opp;
 	}
 
-	mutex_unlock(&opp_table_lock);
-
 	/*
 	 * Notify the changes in the availability of the operable
 	 * frequency/voltage list.
@@ -1202,9 +1186,8 @@ int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
 	return 0;
 
 free_opp:
-	_opp_free(new_opp, opp_table);
-unlock:
-	mutex_unlock(&opp_table_lock);
+	_opp_free(new_opp);
+
 	return ret;
 }
 
@@ -1722,7 +1705,25 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_register_put_opp_helper);
  */
 int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 {
-	return _opp_add_v1(dev, freq, u_volt, true);
+	struct opp_table *opp_table;
+	int ret;
+
+	/* Hold our table modification lock here */
+	mutex_lock(&opp_table_lock);
+
+	opp_table = _add_opp_table(dev);
+	if (!opp_table) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	ret = _opp_add_v1(opp_table, dev, freq, u_volt, true);
+	if (ret)
+		_remove_opp_table(opp_table);
+
+unlock:
+	mutex_unlock(&opp_table_lock);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_add);
 
@@ -1888,8 +1889,8 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_notifier);
  * Free OPPs either created using static entries present in DT or even the
  * dynamically added entries based on remove_all param.
  */
-static void _dev_pm_opp_remove_table(struct opp_table *opp_table,
-				     struct device *dev, bool remove_all)
+void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev,
+			      bool remove_all)
 {
 	struct dev_pm_opp *opp, *tmp;
 
diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 442fa46c4f5c..cdbf733ac9b1 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -255,6 +255,7 @@ static struct device_node *_of_get_opp_desc_node(struct device *dev)
 
 /**
  * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
+ * @opp_table:	OPP table
  * @dev:	device for which we do this operation
  * @np:		device node
  *
@@ -276,22 +277,17 @@ static struct device_node *_of_get_opp_desc_node(struct device *dev)
  * -ENOMEM	Memory allocation failure
  * -EINVAL	Failed parsing the OPP node
  */
-static int _opp_add_static_v2(struct device *dev, struct device_node *np)
+static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
+			      struct device_node *np)
 {
-	struct opp_table *opp_table;
 	struct dev_pm_opp *new_opp;
 	u64 rate;
 	u32 val;
 	int ret;
 
-	/* Hold our table modification lock here */
-	mutex_lock(&opp_table_lock);
-
-	new_opp = _opp_allocate(dev, &opp_table);
-	if (!new_opp) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
+	new_opp = _opp_allocate(opp_table);
+	if (!new_opp)
+		return -ENOMEM;
 
 	ret = of_property_read_u64(np, "opp-hz", &rate);
 	if (ret < 0) {
@@ -347,8 +343,6 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 	if (new_opp->clock_latency_ns > opp_table->clock_latency_ns_max)
 		opp_table->clock_latency_ns_max = new_opp->clock_latency_ns;
 
-	mutex_unlock(&opp_table_lock);
-
 	pr_debug("%s: turbo:%d rate:%lu uv:%lu uvmin:%lu uvmax:%lu latency:%lu\n",
 		 __func__, new_opp->turbo, new_opp->rate,
 		 new_opp->supplies[0].u_volt, new_opp->supplies[0].u_volt_min,
@@ -362,9 +356,8 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 	return 0;
 
 free_opp:
-	_opp_free(new_opp, opp_table);
-unlock:
-	mutex_unlock(&opp_table_lock);
+	_opp_free(new_opp);
+
 	return ret;
 }
 
@@ -382,16 +375,20 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 		/* OPPs are already managed */
 		if (!_add_opp_dev(dev, opp_table))
 			ret = -ENOMEM;
-		mutex_unlock(&opp_table_lock);
-		return ret;
+		goto unlock;
+	}
+
+	opp_table = _add_opp_table(dev);
+	if (!opp_table) {
+		ret = -ENOMEM;
+		goto unlock;
 	}
-	mutex_unlock(&opp_table_lock);
 
 	/* We have opp-table node now, iterate over it and add OPPs */
 	for_each_available_child_of_node(opp_np, np) {
 		count++;
 
-		ret = _opp_add_static_v2(dev, np);
+		ret = _opp_add_static_v2(opp_table, dev, np);
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
@@ -400,15 +397,8 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 	}
 
 	/* There should be one of more OPP defined */
-	if (WARN_ON(!count))
-		return -ENOENT;
-
-	mutex_lock(&opp_table_lock);
-
-	opp_table = _find_opp_table(dev);
-	if (WARN_ON(IS_ERR(opp_table))) {
-		ret = PTR_ERR(opp_table);
-		mutex_unlock(&opp_table_lock);
+	if (WARN_ON(!count)) {
+		ret = -ENOENT;
 		goto free_table;
 	}
 
@@ -418,12 +408,12 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 	else
 		opp_table->shared_opp = OPP_TABLE_ACCESS_EXCLUSIVE;
 
-	mutex_unlock(&opp_table_lock);
-
-	return 0;
+	goto unlock;
 
 free_table:
-	dev_pm_opp_of_remove_table(dev);
+	_dev_pm_opp_remove_table(opp_table, dev, false);
+unlock:
+	mutex_unlock(&opp_table_lock);
 
 	return ret;
 }
@@ -431,9 +421,10 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 /* Initializes OPP tables based on old-deprecated bindings */
 static int _of_add_opp_table_v1(struct device *dev)
 {
+	struct opp_table *opp_table;
 	const struct property *prop;
 	const __be32 *val;
-	int nr, ret;
+	int nr, ret = 0;
 
 	prop = of_find_property(dev->of_node, "operating-points", NULL);
 	if (!prop)
@@ -451,22 +442,32 @@ static int _of_add_opp_table_v1(struct device *dev)
 		return -EINVAL;
 	}
 
+	mutex_lock(&opp_table_lock);
+
+	opp_table = _add_opp_table(dev);
+	if (!opp_table) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
 	val = prop->value;
 	while (nr) {
 		unsigned long freq = be32_to_cpup(val++) * 1000;
 		unsigned long volt = be32_to_cpup(val++);
 
-		ret = _opp_add_v1(dev, freq, volt, false);
+		ret = _opp_add_v1(opp_table, dev, freq, volt, false);
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP %ld (%d)\n",
 				__func__, freq, ret);
-			dev_pm_opp_of_remove_table(dev);
-			return ret;
+			_dev_pm_opp_remove_table(opp_table, dev, false);
+			break;
 		}
 		nr -= 2;
 	}
 
-	return 0;
+unlock:
+	mutex_unlock(&opp_table_lock);
+	return ret;
 }
 
 /**
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index c4b539a8533a..0a5eb4d1e8f7 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -191,13 +191,16 @@ struct opp_table {
 
 /* Routines internal to opp core */
 struct opp_table *_find_opp_table(struct device *dev);
+struct opp_table *_add_opp_table(struct device *dev);
 struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_table);
+void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev, bool remove_all);
 void _dev_pm_opp_find_and_remove_table(struct device *dev, bool remove_all);
-struct dev_pm_opp *_opp_allocate(struct device *dev, struct opp_table **opp_table);
-void _opp_free(struct dev_pm_opp *opp, struct opp_table *opp_table);
+struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
+void _opp_free(struct dev_pm_opp *opp);
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table);
-int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt, bool dynamic);
+int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
 void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of);
+struct opp_table *_add_opp_table(struct device *dev);
 
 #ifdef CONFIG_OF
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev);
