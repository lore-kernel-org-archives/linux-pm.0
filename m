From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 02/17] PM / OPP: Add APIs to set regulator-name
Date: Tue, 12 Jan 2016 10:13:13 +0530
Message-ID: <20160112044313.GH1084@ubuntu>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <30510e48c64f5aef8015e7dae838780e2c2fe86d.1450777582.git.viresh.kumar@linaro.org>
 <20160112011825.GH22188@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33114 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761736AbcALEnS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2016 23:43:18 -0500
Received: by mail-pa0-f53.google.com with SMTP id cy9so332983130pac.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2016 20:43:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160112011825.GH22188@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 11-01-16, 17:18, Stephen Boyd wrote:
> On 12/22, Viresh Kumar wrote:
> > This is required mostly for backward compatibility of DT users. The OPP
> > layer automatically gets the regulator device currently, but the name of
> > the device needs to be same as that of the device. But existing DT
> 
> The name of the device needs to be the same as that of the
> device? What does that mean? Perhaps this should say the name of
> the regulator/supply needs to be the same as that of the device?
>
> The same words are in the kernel doc too.

Absolutely.

> > +/**
> > + * dev_pm_opp_set_regulator() - Set regulator name for the device
> > + * @dev: Device for which regulator name is being set.
> > + * @name: Name of the regulator.
> > + *
> > + * This is required mostly for backward compatibility of DT users. The OPP layer
> > + * automatically gets the regulator device currently, but the name of the device
> > + * needs to be same as that of the device. But existing DT entries may not be
> > + * following that and might have used generic names instead. For example, they
> > + * might have used 'cpu-supply' instead of 'cpu0-supply'.
> 
> The new v2 OPP bindings are using cpu-supply instead of
> cpu0-supply.

I will say the examples are written that way, instead of the bindings.
And I will update the bindings doc to update that. Though we will keep
supporting cpu-supply (for backward compatibility), but
<devname>-supply is the way forward I believe. We can't really get the
device's generic name to use here for all kind of devices. Remember it
is not just about CPUs and so I went for it.

I will add another patch to update the bindings first and then rest of
the stuff, if that looks fine to you.

> This makes it sound like cpu-supply is the old style
> and we've added this API to handle it, when in reality, this is
> the preferred way to do this and so we've added this API because
> we almost always need it.

> > +int dev_pm_opp_set_regulator(struct device *dev, const char *name)
> > +{
> > +	struct device_opp *dev_opp;
> > +	struct regulator *reg;
> > +	int ret = 0;
> > +
> > +	/* Hold our list modification lock here */
> > +	mutex_lock(&dev_opp_list_lock);
> > +
> > +	dev_opp = _find_device_opp(dev);
> > +	/* We already have a dev-opp */
> > +	if (!IS_ERR(dev_opp)) {
> > +		/* This should be called before OPPs are initialized */
> > +		if (WARN_ON(!list_empty(&dev_opp->opp_list))) {
> > +			ret = -EBUSY;
> > +			goto unlock;
> > +		}
> > +
> > +		/* Already have a regulator set? Free it and re-allocate */
> > +		if (!IS_ERR(dev_opp->regulator))
> > +			regulator_put(dev_opp->regulator);
> 
> Is this used in practice? It seems odd that users would be using
> one regulator, and then change that to another regulator later.

Its required in the following possible scenario:
- The CPU0 DT node has two supplies, cpu-supply and cpu0-supply
- The dev_opp is added prior to this routine is called, which will
  actually allocate the 'cpu0-supply'.
- But the platform wanted to use cpu-supply instead ..

Yeah, this is kind of a corner case, but I think it is required.

> > +void dev_pm_opp_put_regulator(struct device *dev)
> > +{
> > +	struct device_opp *dev_opp;
> > +
> > +	/* Hold our list modification lock here */
> > +	mutex_lock(&dev_opp_list_lock);
> > +
> > +	/* Check for existing list for 'dev' first */
> > +	dev_opp = _find_device_opp(dev);
> > +	if (IS_ERR(dev_opp)) {
> > +		dev_err(dev, "Failed to find dev_opp: %ld\n", PTR_ERR(dev_opp));
> > +		goto unlock;
> > +	}
> > +
> > +	/* Make sure there are no concurrent readers while updating dev_opp */
> > +	WARN_ON(!list_empty(&dev_opp->opp_list));
> > +
> > +	if (!dev_opp->regulator_set) {
> > +		dev_err(dev, "%s: Doesn't have regulator set\n", __func__);
> > +		goto unlock;
> > +	}
> > +
> > +	dev_opp->regulator_set = false;
> > +
> > +	/* Try freeing device_opp if this was the last blocking resource */
> > +	_remove_device_opp(dev_opp);
> 
> It looks like this whole function exists to set the boolean to
> false so that _remove_device_opp() can continue. What's the point
> of that? From what I can tell all we're getting is symmetry in
> the API by having this function, so why have this function at
> all?

No. Consider this case:
- Platform code sets regulator for cpuX
- insmod cpufreq-dt.ko
- rmmod cpufreq-dt.ko
- insmod cpufreq-dt.ko

If we don't have that boolean and the put_regulator routine, the
second insmod wouldn't work.
-------------------------8<-------------------------

Subject: [PATCH] PM / OPP: Add APIs to set regulator-name

This is required mostly for backward compatibility of DT users. The OPP
layer automatically gets the regulator device currently, but the name of
the regulator needs to be same as that of the device. But existing DT
entries may not be following that and might have used generic names
instead. For example, they might have used 'cpu-supply' instead of
'cpu0-supply'.

The APIs allow such platforms to pass a supply 'name' to OPP core, so
that the correct regulator supply can be allocated by the OPP core.

This must be called before any OPPs are initialized for the device.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 161 +++++++++++++++++++++++++++++++++++++-----
 drivers/base/power/opp/opp.h  |   2 +
 include/linux/pm_opp.h        |   9 +++
 3 files changed, 156 insertions(+), 16 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 9e437416e155..2b9663d573b0 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -493,25 +493,11 @@ struct device_list_opp *_add_list_dev(const struct device *dev,
 	return list_dev;
 }
 
-/**
- * _add_device_opp() - Find device OPP table or allocate a new one
- * @dev:	device for which we do this operation
- *
- * It tries to find an existing table first, if it couldn't find one, it
- * allocates a new OPP table and returns that.
- *
- * Return: valid device_opp pointer if success, else NULL.
- */
-static struct device_opp *_add_device_opp(struct device *dev)
+static struct device_opp *_add_device_opp_reg(struct device *dev,
+					      const char *name)
 {
 	struct device_opp *dev_opp;
 	struct device_list_opp *list_dev;
-	const char *name = dev_name(dev);
-
-	/* Check for existing list for 'dev' first */
-	dev_opp = _find_device_opp(dev);
-	if (!IS_ERR(dev_opp))
-		return dev_opp;
 
 	/*
 	 * Allocate a new device OPP table. In the infrequent case where a new
@@ -543,6 +529,27 @@ static struct device_opp *_add_device_opp(struct device *dev)
 }
 
 /**
+ * _add_device_opp() - Find device OPP table or allocate a new one
+ * @dev: device for which we do this operation
+ *
+ * It tries to find an existing table first, if it couldn't find one, it
+ * allocates a new OPP table and returns that.
+ *
+ * Return: valid device_opp pointer if success, else NULL.
+ */
+static struct device_opp *_add_device_opp(struct device *dev)
+{
+	struct device_opp *dev_opp;
+
+	/* Check for existing list for 'dev' first */
+	dev_opp = _find_device_opp(dev);
+	if (!IS_ERR(dev_opp))
+		return dev_opp;
+
+	return _add_device_opp_reg(dev, dev_name(dev));
+}
+
+/**
  * _kfree_device_rcu() - Free device_opp RCU handler
  * @head:	RCU head
  */
@@ -572,6 +579,9 @@ static void _remove_device_opp(struct device_opp *dev_opp)
 	if (dev_opp->prop_name)
 		return;
 
+	if (dev_opp->regulator_set)
+		return;
+
 	regulator_put(dev_opp->regulator);
 
 	list_dev = list_first_entry(&dev_opp->dev_list, struct device_list_opp,
@@ -1094,6 +1104,125 @@ void dev_pm_opp_put_prop_name(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
 
+/**
+ * dev_pm_opp_set_regulator() - Set regulator name for the device
+ * @dev: Device for which regulator name is being set.
+ * @name: Name of the regulator.
+ *
+ * This is required mostly for backward compatibility of DT users. The OPP layer
+ * automatically gets the regulator device currently, but the name of the
+ * regulator needs to be same as that of the device. But existing DT entries may
+ * not be following that and might have used generic names instead. For example,
+ * they might have used 'cpu-supply' instead of 'cpu0-supply'.
+ *
+ * This must be called before any OPPs are initialized for the device.
+ *
+ * Locking: The internal device_opp and opp structures are RCU protected.
+ * Hence this function internally uses RCU updater strategy with mutex locks
+ * to keep the integrity of the internal data structures. Callers should ensure
+ * that this function is *NOT* called under RCU protection or in contexts where
+ * mutex cannot be locked.
+ */
+int dev_pm_opp_set_regulator(struct device *dev, const char *name)
+{
+	struct device_opp *dev_opp;
+	struct regulator *reg;
+	int ret = 0;
+
+	mutex_lock(&dev_opp_list_lock);
+
+	dev_opp = _find_device_opp(dev);
+	/* We already have a dev-opp */
+	if (!IS_ERR(dev_opp)) {
+		/* This should be called before OPPs are initialized */
+		if (WARN_ON(!list_empty(&dev_opp->opp_list))) {
+			ret = -EBUSY;
+			goto unlock;
+		}
+
+		/* Already have a regulator set? Free it and re-allocate */
+		if (!IS_ERR(dev_opp->regulator))
+			regulator_put(dev_opp->regulator);
+
+		/* Allocate the regulator */
+		reg = regulator_get_optional(dev, name);
+		if (IS_ERR(reg)) {
+			ret = PTR_ERR(reg);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "%s: no regulator (%s) found: %d\n",
+					__func__, name, ret);
+		}
+
+		dev_opp->regulator = reg;
+		goto unlock;
+	}
+
+	dev_opp = _add_device_opp_reg(dev, name);
+	if (!dev_opp) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	reg = dev_opp->regulator;
+	if (IS_ERR(reg)) {
+		ret = PTR_ERR(reg);
+		_remove_device_opp(dev_opp);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "%s: no regulator (%s) found: %d\n",
+				__func__, name, ret);
+	}
+
+unlock:
+	if (!ret)
+		dev_opp->regulator_set = true;
+
+	mutex_unlock(&dev_opp_list_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_regulator);
+
+/**
+ * dev_pm_opp_put_regulator() - Releases resources blocked for regulator
+ * @dev: Device for which regulator was set.
+ *
+ * Locking: The internal device_opp and opp structures are RCU protected.
+ * Hence this function internally uses RCU updater strategy with mutex locks
+ * to keep the integrity of the internal data structures. Callers should ensure
+ * that this function is *NOT* called under RCU protection or in contexts where
+ * mutex cannot be locked.
+ */
+void dev_pm_opp_put_regulator(struct device *dev)
+{
+	struct device_opp *dev_opp;
+
+	mutex_lock(&dev_opp_list_lock);
+
+	/* Check for existing list for 'dev' first */
+	dev_opp = _find_device_opp(dev);
+	if (IS_ERR(dev_opp)) {
+		dev_err(dev, "Failed to find dev_opp: %ld\n", PTR_ERR(dev_opp));
+		goto unlock;
+	}
+
+	/* Make sure there are no concurrent readers while updating dev_opp */
+	WARN_ON(!list_empty(&dev_opp->opp_list));
+
+	if (!dev_opp->regulator_set) {
+		dev_err(dev, "%s: Doesn't have regulator set\n", __func__);
+		goto unlock;
+	}
+
+	dev_opp->regulator_set = false;
+
+	/* Try freeing device_opp if this was the last blocking resource */
+	_remove_device_opp(dev_opp);
+
+unlock:
+	mutex_unlock(&dev_opp_list_lock);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_put_regulator);
+
 static bool _opp_is_supported(struct device *dev, struct device_opp *dev_opp,
 			      struct device_node *np)
 {
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index b9555f28f216..aca423caebf3 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -133,6 +133,7 @@ struct device_list_opp {
  * @supported_hw_count: Number of elements in supported_hw array.
  * @prop_name: A name to postfix to many DT properties, while parsing them.
  * @regulator: Supply Regulator
+ * @regulator_set: Regulator's name is explicitly set by platform.
  *
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
  * @dentry_name: Name of the real dentry.
@@ -162,6 +163,7 @@ struct device_opp {
 	unsigned int supported_hw_count;
 	const char *prop_name;
 	struct regulator *regulator;
+	bool regulator_set;
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 95403d2ccaf5..c70a18ac9c8a 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -60,6 +60,8 @@ int dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions,
 void dev_pm_opp_put_supported_hw(struct device *dev);
 int dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct device *dev);
+int dev_pm_opp_set_regulator(struct device *dev, const char *name);
+void dev_pm_opp_put_regulator(struct device *dev);
 #else
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
@@ -151,6 +153,13 @@ static inline int dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 
 static inline void dev_pm_opp_put_prop_name(struct device *dev) {}
 
+static inline int dev_pm_opp_set_regulator(struct device *dev, const char *name)
+{
+	return -EINVAL;
+}
+
+static inline void dev_pm_opp_put_regulator(struct device *dev) {}
+
 #endif		/* CONFIG_PM_OPP */
 
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)


-- 
viresh
