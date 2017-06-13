From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V7 1/2] PM / Domains: Add support to select
 performance-state of domains
Date: Tue, 13 Jun 2017 16:26:17 +0530
Message-ID: <20170613105616.GH5297@vireshk-i7>
References: <cover.1495003720.git.viresh.kumar@linaro.org>
 <4cc55fce0fd4199941f1d7b785e677255ff792d5.1495003720.git.viresh.kumar@linaro.org>
 <CAPDyKFoWXPJx9pahzv6CkXosncODHSThYA9MoMVdruRtzHRyZg@mail.gmail.com>
 <20170608070505.GB4634@vireshk-i7>
 <CAPDyKFo1-BN2PqXZgKUCGee_QH1zevXFLFSO2+TaCpkWxd5r-g@mail.gmail.com>
 <20170608094251.GC4634@vireshk-i7>
 <CAPDyKFrBnAzz6wYvmk7xtdeFUH+sEVLCE2WhMFtwipby-Xj8_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36263 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbdFMK4V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2017 06:56:21 -0400
Received: by mail-pf0-f176.google.com with SMTP id x63so66067787pff.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2017 03:56:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPDyKFrBnAzz6wYvmk7xtdeFUH+sEVLCE2WhMFtwipby-Xj8_w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>

On 09-06-17, 13:00, Ulf Hansson wrote:
> On 8 June 2017 at 11:42, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 08-06-17, 09:48, Ulf Hansson wrote:
> >> It's not a nightmare, just a tricky thing to solve. :-)
> >
> > I may have just solved it actually :)
> 
> That was quick. :-)

:)

> > So the real locking problem was the case where a subdomain have multiple parent
> > domains and how do we access its performance_state field from all the paths that
> > originate from the parent's update and from the subdomains own path. And a
> > single performance_state field isn't going to help in that as multiple locks are
> > involved here. I have added another per parent-domain field and that will help
> > get the locking quite simple. Here is the new patch (compile tested):
> 
> Obviously you didn't think about this long enough.

That's a fair point of view of yours, but something similar to what I
have done in this patch was running around in my head for a couple of
days and so I went implementing it really quickly.

> Please spare me
> from having to review something of this complexity just being compile
> tested. I don't have unlimited bandwidth. :-)

I agree, my aim wasn't to waste your time. I just wanted to get some
sort of Ack on the idea of re-using the per-parent link structure for
storing performance state and so went ahead just with compile tests.

> I recommend at least some functional tests run together with lockdep tests.

I have done that now (with lockdep) for multiple cases:

- Device with a parent genpd which supports setting performance state.
- Device with parent genpd which doesn't allow setting performance
  state, but the parent domains of the genpd allow that. This focusses
  on the complex part of this patch where the update is propagated to
  parents of a sub-domain.

And they are all working fine now.

> > +/**
> > + * pm_genpd_has_performance_state - Checks if power domain does performance
> > + * state management.
> > + *
> > + * @dev: Device whose power domain is getting inquired.
> > + */
> > +bool pm_genpd_has_performance_state(struct device *dev)
> > +{
> > +       struct generic_pm_domain *genpd = dev_to_genpd(dev);
> > +
> > +       /* The parent domain must have set get_performance_state() */
> > +       if (!IS_ERR(genpd) && genpd->get_performance_state)
> > +               return true;
> > +
> > +       return false;
> > +}
> > +EXPORT_SYMBOL_GPL(pm_genpd_has_performance_state);
>
> I think you didn't read my earlier comments well enough.

Actually I did and asked you a couple of questions in my previous
email, but as you haven't replied to them I thought you are fine with
my arguments.

Anyway, we had some chat regarding this yesterday on IRC and I have
understood what the problems can be here and so I have used your
suggestions here now.

> Who is going to call this?

Some user driver. For devices that support frequency scaling, the OPP
core (if used by device) will call it.

For cases where there is no frequency scaling, the driver may call it
directly.

> What prevents the genpd object from being
> removed in the middle of when you are operating on the genpd pointer?

So there are three cases we have and they kind of follow the sort of
assumptions already made in genpd.

1). Devices which have drivers for them, like MMC, etc. In such cases
  the genpd is attached to the device from the bus layer
  (platform/amba/etc) and so until the time driver is around, we are
  guaranteed to have the genpd structure. And because the driver
  creates/removes OPP tables, we will be fine here.

2). Devices for which we don't have drivers (at least for ARM
  platforms), like CPU. Here the platform specific power domain driver
  would be attaching the genpd with the devices instead of bus cores
  and so the domain driver has to guarantee that the genpd doesn't go
  away until the time some user driver (like cpufreq-dt.c) is using
  the device. This can be controlled by creating the cpufreq virtual
  device (which we create from cpufreq-dt-platdev.c today) from the
  domain driver itself.

So we perhaps don't need any refcount stuff for now at lest.

> How can you even be sure the pm_domain pointer is a valid genpd
> object?

I understood this comment yesterday only and now I have used
genpd_lookup_dev() instead of dev_to_genpd() here. The new patch with
some minor updates from the last version is pasted below.

I have also asked Rajendra Nayak to provide some sample code for
actual platform along with platform specific power domain driver. He
should be providing that to me sometime this week. I may post the
entire series again then along with his code.

-- 
viresh

---
 drivers/base/power/domain.c | 229 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  22 +++++
 2 files changed, 251 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 71c95ad808d5..8c92a2f00c4e 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -466,6 +466,235 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+/*
+ * Returns true if anyone in genpd's parent hierarchy has
+ * set_performance_state() set.
+ */
+static bool genpd_has_set_performance_state(struct generic_pm_domain *genpd)
+{
+	struct gpd_link *link;
+
+	if (genpd->set_performance_state)
+		return true;
+
+	list_for_each_entry(link, &genpd->slave_links, slave_node) {
+		if (genpd_has_set_performance_state(link->master))
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * pm_genpd_has_performance_state - Checks if power domain does performance
+ * state management.
+ *
+ * @dev: Device whose power domain is getting inquired.
+ *
+ * This must be called by the user drivers, before they start calling
+ * pm_genpd_update_performance_state(), to guarantee that all dependencies are
+ * met and the device's genpd supports performance states.
+ *
+ * It is assumed that the user driver guarantees that the genpd wouldn't be
+ * detached while this routine is getting called.
+ *
+ * Returns "true" if device's genpd supports performance states, "false"
+ * otherwise.
+ */
+bool pm_genpd_has_performance_state(struct device *dev)
+{
+	struct generic_pm_domain *genpd = genpd_lookup_dev(dev);
+
+	/* The parent domain must have set get_performance_state() */
+	if (!IS_ERR(genpd) && genpd->get_performance_state) {
+		if (genpd_has_set_performance_state(genpd))
+			return true;
+
+		/*
+		 * A genpd with ->get_performance_state() callback must also
+		 * allow setting performance state.
+		 */
+		dev_err(dev, "genpd doesn't support setting performance state\n");
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(pm_genpd_has_performance_state);
+
+/*
+ * Re-evaluate performance state of a power domain. Finds the highest requested
+ * performance state by the devices and subdomains within the power domain and
+ * then tries to change its performance state. If the power domain doesn't have
+ * a set_performance_state() callback, then we move the request to its parent
+ * power domain.
+ *
+ * Locking: Access (or update) to device's "pd_data->performance_state" field
+ * happens only with parent domain's lock held. Subdomains have their
+ * "genpd->performance_state" protected with their own lock (and they are the
+ * only user of this field) and their per-parent-domain
+ * "link->performance_state" field is protected with individual parent power
+ * domain's lock and is only accessed/updated with that lock held.
+ */
+static int genpd_update_performance_state(struct generic_pm_domain *genpd,
+					  int depth)
+{
+	struct generic_pm_domain_data *pd_data;
+	struct generic_pm_domain *master;
+	struct pm_domain_data *pdd;
+	unsigned int state = 0, prev;
+	struct gpd_link *link;
+	int ret;
+
+	/* Traverse all devices within the domain */
+	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
+		pd_data = to_gpd_data(pdd);
+
+		if (pd_data->performance_state > state)
+			state = pd_data->performance_state;
+	}
+
+	/* Traverse all subdomains within the domain */
+	list_for_each_entry(link, &genpd->master_links, master_node) {
+		if (link->performance_state > state)
+			state = link->performance_state;
+	}
+
+	if (genpd->performance_state == state)
+		return 0;
+
+	if (genpd->set_performance_state) {
+		ret = genpd->set_performance_state(genpd, state);
+		if (!ret)
+			genpd->performance_state = state;
+
+		return ret;
+	}
+
+	/*
+	 * Not all domains support updating performance state. Move on to their
+	 * parent domains in that case.
+	 */
+	prev = genpd->performance_state;
+
+	list_for_each_entry(link, &genpd->slave_links, slave_node) {
+		master = link->master;
+
+		genpd_lock_nested(master, depth + 1);
+
+		link->performance_state = state;
+		ret = genpd_update_performance_state(master, depth + 1);
+		if (ret)
+			link->performance_state = prev;
+
+		genpd_unlock(master);
+
+		if (ret)
+			goto err;
+	}
+
+	/*
+	 * The parent domains are updated now, lets get genpd performance_state
+	 * in sync with those.
+	 */
+	genpd->performance_state = state;
+	return 0;
+
+err:
+	list_for_each_entry_continue_reverse(link, &genpd->slave_links,
+					     slave_node) {
+		master = link->master;
+
+		genpd_lock_nested(master, depth + 1);
+		link->performance_state = prev;
+		if (genpd_update_performance_state(master, depth + 1))
+			pr_err("%s: Failed to roll back to %d performance state\n",
+			       genpd->name, prev);
+		genpd_unlock(master);
+	}
+
+	return ret;
+}
+
+static int __dev_update_performance_state(struct device *dev, int state)
+{
+	struct generic_pm_domain_data *gpd_data;
+	int ret;
+
+	spin_lock_irq(&dev->power.lock);
+
+	if (!dev->power.subsys_data || !dev->power.subsys_data->domain_data) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
+	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
+
+	ret = gpd_data->performance_state;
+	gpd_data->performance_state = state;
+
+unlock:
+	spin_unlock_irq(&dev->power.lock);
+
+	return ret;
+}
+
+/**
+ * pm_genpd_update_performance_state - Update performance state of device's
+ * parent power domain for the target frequency for the device.
+ *
+ * @dev: Device for which the performance-state needs to be adjusted.
+ * @rate: Device's next frequency. This can be set as 0 when the device doesn't
+ * have any performance state constraints left (And so the device wouldn't
+ * participate anymore to find the target performance state of the genpd).
+ *
+ * This must be called by the user drivers (as many times as they want) only
+ * after pm_genpd_has_performance_state() is called (only once) and that
+ * returned "true".
+ *
+ * This is assumed that the user driver guarantees that the genpd wouldn't be
+ * detached while this routine is getting called.
+ *
+ * Returns 0 on success and negative error values on failures.
+ */
+int pm_genpd_update_performance_state(struct device *dev, unsigned long rate)
+{
+	struct generic_pm_domain *genpd = dev_to_genpd(dev);
+	int ret, state;
+
+	if (IS_ERR(genpd))
+		return -ENODEV;
+
+	genpd_lock(genpd);
+
+	if (unlikely(!genpd->get_performance_state)) {
+		dev_err(dev, "Performance states aren't supported by power domain\n");
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	state = genpd->get_performance_state(dev, rate);
+	if (state < 0) {
+		ret = state;
+		goto unlock;
+	}
+
+	state = __dev_update_performance_state(dev, state);
+	if (state < 0) {
+		ret = state;
+		goto unlock;
+	}
+
+	ret = genpd_update_performance_state(genpd, 0);
+	if (ret)
+		__dev_update_performance_state(dev, state);
+
+unlock:
+	genpd_unlock(genpd);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pm_genpd_update_performance_state);
+
 /**
  * genpd_power_off_work_fn - Power off PM domain whose subdomain count is 0.
  * @work: Work structure used for scheduling the execution of this function.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index b7803a251044..bf90177208a2 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -63,8 +63,12 @@ struct generic_pm_domain {
 	unsigned int device_count;	/* Number of devices */
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
+	unsigned int performance_state;	/* Max requested performance state */
 	int (*power_off)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
+	int (*get_performance_state)(struct device *dev, unsigned long rate);
+	int (*set_performance_state)(struct generic_pm_domain *domain,
+				     unsigned int state);
 	struct gpd_dev_ops dev_ops;
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	bool max_off_time_changed;
@@ -99,6 +103,9 @@ struct gpd_link {
 	struct list_head master_node;
 	struct generic_pm_domain *slave;
 	struct list_head slave_node;
+
+	/* Sub-domain's per-parent domain performance state */
+	unsigned int performance_state;
 };
 
 struct gpd_timing_data {
@@ -118,6 +125,7 @@ struct generic_pm_domain_data {
 	struct pm_domain_data base;
 	struct gpd_timing_data td;
 	struct notifier_block nb;
+	unsigned int performance_state;
 	void *data;
 };
 
@@ -148,6 +156,9 @@ extern int pm_genpd_remove(struct generic_pm_domain *genpd);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
+extern bool pm_genpd_has_performance_state(struct device *dev);
+extern int pm_genpd_update_performance_state(struct device *dev,
+					     unsigned long rate);
 #else
 
 static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
@@ -185,6 +196,17 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
 	return -ENOTSUPP;
 }
 
+static inline bool pm_genpd_has_performance_state(struct device *dev)
+{
+	return false;
+}
+
+static inline int pm_genpd_update_performance_state(struct device *dev,
+						    unsigned long rate)
+{
+	return -ENOTSUPP;
+}
+
 #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
 #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
 #endif
