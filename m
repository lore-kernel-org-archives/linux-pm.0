From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V7 1/2] PM / Domains: Add support to select
 performance-state of domains
Date: Thu, 8 Jun 2017 12:35:05 +0530
Message-ID: <20170608070505.GB4634@vireshk-i7>
References: <cover.1495003720.git.viresh.kumar@linaro.org>
 <4cc55fce0fd4199941f1d7b785e677255ff792d5.1495003720.git.viresh.kumar@linaro.org>
 <CAPDyKFoWXPJx9pahzv6CkXosncODHSThYA9MoMVdruRtzHRyZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34383 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751770AbdFHHFK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2017 03:05:10 -0400
Received: by mail-pf0-f178.google.com with SMTP id 9so14001699pfj.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Jun 2017 00:05:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPDyKFoWXPJx9pahzv6CkXosncODHSThYA9MoMVdruRtzHRyZg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>

On 07-06-17, 14:26, Ulf Hansson wrote:
> On 17 May 2017 at 09:02, Viresh Kumar <viresh.kumar@linaro.org> wrote:
 
> Apologize for the delay! I was kind of waiting for Kevin to jump in as
> he has already been in the loop.

Thanks for getting these reviewed eventually :)

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
> There is no protection from locking point view

I hope you are talking about not taking genpd_lock(genpd) here ? If yes, can you
please explain what kind of race will that protect here with an example ?

As I really fail to see how can this be racy at all as we are just checking if
a callback is set or not.

> and there is no
> validation the pm_domain pointer being a valid genpd.

Isn't dev_to_genpd() already doing that? And the check !IS_ERR(genpd) is all we
need. Sorry if I missed something really stupid.

> Please study the locks that is used in genpd more carefully and try to
> figure out what is needed here. I know it's a bit tricky, but the
> above just isn't sufficient.

Sure.

> > +static int genpd_update_performance_state(struct generic_pm_domain *genpd,
> > +                                         int depth)
> > +{
> > +       struct generic_pm_domain_data *pd_data;
> > +       struct generic_pm_domain *subdomain;
> > +       struct pm_domain_data *pdd;
> > +       unsigned int state = 0, prev;
> > +       struct gpd_link *link;
> > +       int ret;
> > +
> > +       /* Traverse all devices within the domain */
> > +       list_for_each_entry(pdd, &genpd->dev_list, list_node) {
> > +               pd_data = to_gpd_data(pdd);
> > +
> > +               if (pd_data->performance_state > state)
> > +                       state = pd_data->performance_state;
> > +       }
> > +
> > +       /* Traverse all subdomains within the domain */
> > +       list_for_each_entry(link, &genpd->master_links, master_node) {
> > +               subdomain = link->slave;
> > +
> > +               if (subdomain->performance_state > state)
> > +                       state = subdomain->performance_state;
> 
> You need to take the genpd lock of the subdomain before assigning this, right?

Maybe not, but sure there is one problem you highlighted very well.
subdomain->performance_state might have been updated from the same function
(from a different thread) and we may end up using that incorrectly. Thanks for
noticing the stupid mistake.

> Is there a way to do this the opposite direction? It's important that
> we walk upwards in the topology, as we need to preserve the order for
> how genpd locks are taken.

At least I couldn't get around a solution which would be able to do this. All
these requests generate from a device and its domain may have subdomains and
devices. Though, we can add a constraint (see below) which can get us around
this for now at least.

> The way we do it is always taking the lock of the subdomain first,
> then its master, then the master's master and so own. You can have
> look at for example genpd_power_on().

Right. Locking was surely messy here.

> > +       }
> > +
> > +       if (genpd->performance_state == state)
> > +               return 0;
> > +
> > +       /*
> > +        * Not all domains support updating performance state. Move on to their
> > +        * parent domains in that case.
> > +        */
> > +       if (genpd->set_performance_state) {
> > +               ret = genpd->set_performance_state(genpd, state);
> > +               if (!ret)
> > +                       genpd->performance_state = state;
> > +
> > +               return ret;
> > +       }
> > +
> > +       prev = genpd->performance_state;
> > +       genpd->performance_state = state;
> > +
> > +       list_for_each_entry(link, &genpd->slave_links, slave_node) {
> > +               struct generic_pm_domain *master = link->master;
> > +
> > +               genpd_lock_nested(master, depth + 1);
> > +               ret = genpd_update_performance_state(master, depth + 1);
> > +               genpd_unlock(master);
> > +
> > +               if (!ret)
> > +                       continue;
> > +
> > +               /*
> > +                * Preserve earlier state for all the power domains which have
> > +                * been updated.
> > +                */
> > +               genpd->performance_state = prev;
> > +
> > +               list_for_each_entry(link, &genpd->slave_links, slave_node) {
> > +                       struct generic_pm_domain *nmaster = link->master;
> > +
> > +                       if (nmaster == master)
> > +                               break;
> > +
> > +                       genpd_lock_nested(nmaster, depth + 1);
> > +                       genpd_update_performance_state(master, depth + 1);
> > +                       genpd_unlock(master);
> > +               }
> 
> I think some comment on how to walk the genpd topology to fetch the
> current selected state would be nice. I am not sure I get it by just
> looking at the code.
> 
> First you are walking master links then slave links. Then you start
> over again with the slave links in the error path.

Sure, a comment might be helpful.

> > +int pm_genpd_update_performance_state(struct device *dev, unsigned long rate)
> > +{
> > +       struct generic_pm_domain *genpd = ERR_PTR(-ENODATA);
> > +       struct generic_pm_domain_data *gpd_data;
> > +       int ret, prev;
> > +
> > +       spin_lock_irq(&dev->power.lock);
> > +       if (dev->power.subsys_data && dev->power.subsys_data->domain_data) {
> > +               gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
> > +               genpd = dev_to_genpd(dev);
> > +       }
> > +       spin_unlock_irq(&dev->power.lock);
> 
> So even if you fetch the genpd pointer here, you don't protect the
> device from detached from its genpd after this point (thus freeing the
> domain data).
> 
> To move this issue even further, there is no guarantee that the genpd
> don't get removed after this point, but you are still operating on the
> pointer...

That's another blunder. I agree. Thanks.

> As you probably figured out from my above comments, the solution here
> isn't really working.
> 
> Adding these new APIs, more or less requires us to manage reference
> counting on the genpd for the device.

Hmm, I am not able to understand why would we need that with this series :(

> I haven't thought about that in
> great detail, just that we of course need to be careful if we want to
> introduce something like that, to make sure all aspect of locking
> becomes correct.
> 
> Moreover adding reference counting touches the idea of adding APIs to
> genpd, to allow users/drivers to control their genpd explicitly. This
> is required to support > 1 pm_domain per device. I assume you have
> been following that discussion for genpd on linux-pm as well. My point
> is that, we should consider that while inventing *any* new APIs.

Not very deeply but yeah I have seen that thread.

So, I couldn't find way to get the locking thing fixed to avoid deadlocks but we
can live with a constraint (if you guys think it is fine) to have this solved.

Constraint: Update performance state API wouldn't support power domains that
don't provide a set_performance_state() callback and have multiple parent power
domains.

Why: In order to guarantee that we read and update the performance_state of
subdomains and devices properly, we need to do that under the parent domain's
lock. And if we have multiple parent power domains, then we would be required to
get them locked at once before updating subdomain's state and that would be a
nightmare.

And here is the new diff based on above (only compile tested):

---
 drivers/base/power/domain.c | 177 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  19 +++++
 2 files changed, 196 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 71c95ad808d5..cf090adc7967 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -466,6 +466,171 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
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
+ */
+bool pm_genpd_has_performance_state(struct device *dev)
+{
+	struct generic_pm_domain *genpd = dev_to_genpd(dev);
+
+	/* The parent domain must have set get_performance_state() */
+	if (!IS_ERR(genpd) && genpd->get_performance_state)
+		return true;
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
+ * power domain (with constraints explained below).
+ */
+static int genpd_update_performance_state(struct generic_pm_domain *genpd,
+					  int depth)
+{
+	struct generic_pm_domain_data *pd_data;
+	struct generic_pm_domain *master;
+	struct generic_pm_domain *subdomain;
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
+		subdomain = link->slave;
+
+		if (subdomain->performance_state > state)
+			state = subdomain->performance_state;
+	}
+
+	if (genpd->performance_state == state)
+		return 0;
+
+	/*
+	 * Not all domains support updating performance state. Move on to their
+	 * parent domains in that case.
+	 */
+	if (genpd->set_performance_state) {
+		ret = genpd->set_performance_state(genpd, state);
+		if (!ret)
+			genpd->performance_state = state;
+
+		return ret;
+	}
+
+	/*
+	 * Only support subdomains with single parent power domain to avoid
+	 * complicated locking problems. We only take locks in the upwards
+	 * direction (i.e. subdomain first, followed by parent domain). We also
+	 * need to guarantee that the performance_state field of devices and
+	 * subdomains of a domain is not updated (or read) without the domain's
+	 * lock and that wouldn't work with multiple parents of a subdomain.
+	 */
+	if (!list_is_singular(&genpd->slave_links)) {
+		pr_err("%s: Domain has multiple parents, can't update performance state\n",
+		       genpd->name);
+		return -EINVAL;
+	}
+
+	link = list_first_entry(&genpd->slave_links, struct gpd_link, slave_node);
+	master = link->master;
+
+	genpd_lock_nested(master, depth + 1);
+	prev = genpd->performance_state;
+	genpd->performance_state = state;
+
+	ret = genpd_update_performance_state(master, depth + 1);
+	if (ret)
+		genpd->performance_state = prev;
+	genpd_unlock(master);
+
+	return ret;
+}
+
+/**
+ * pm_genpd_update_performance_state - Update performance state of parent power
+ * domain for the target frequency for the device.
+ *
+ * @dev: Device for which the performance-state needs to be adjusted.
+ * @rate: Device's next frequency.
+ */
+int pm_genpd_update_performance_state(struct device *dev, unsigned long rate)
+{
+	struct generic_pm_domain *genpd = ERR_PTR(-ENODATA);
+	struct generic_pm_domain_data *gpd_data;
+	int ret, prev;
+
+	spin_lock_irq(&dev->power.lock);
+	if (dev->power.subsys_data && dev->power.subsys_data->domain_data) {
+		gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
+		genpd = dev_to_genpd(dev);
+	}
+
+	if (IS_ERR(genpd)) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
+	if (!genpd->get_performance_state) {
+		dev_err(dev, "Performance states aren't supported by power domain\n");
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	genpd_lock(genpd);
+	ret = genpd->get_performance_state(dev, rate);
+	if (ret < 0)
+		goto unlock_genpd;
+
+	prev = gpd_data->performance_state;
+	gpd_data->performance_state = ret;
+	ret = genpd_update_performance_state(genpd, 0);
+	if (ret)
+		gpd_data->performance_state = prev;
+
+unlock_genpd:
+	genpd_unlock(genpd);
+unlock:
+	spin_unlock_irq(&dev->power.lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pm_genpd_update_performance_state);
+
 /**
  * genpd_power_off_work_fn - Power off PM domain whose subdomain count is 0.
  * @work: Work structure used for scheduling the execution of this function.
@@ -1156,6 +1321,7 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
 	gpd_data->td.constraint_changed = true;
 	gpd_data->td.effective_constraint_ns = -1;
 	gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
+	gpd_data->performance_state = 0;
 
 	spin_lock_irq(&dev->power.lock);
 
@@ -1502,6 +1668,17 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 		genpd->dev_ops.start = pm_clk_resume;
 	}
 
+	/*
+	 * If this genpd supports getting performance state, then someone in its
+	 * hierarchy must support setting it too.
+	 */
+	if (genpd->get_performance_state &&
+	    !genpd_has_set_performance_state(genpd)) {
+		pr_err("%s: genpd doesn't support updating performance state\n",
+		       genpd->name);
+		return -ENODEV;
+	}
+
 	/* Always-on domains must be powered on at initialization. */
 	if (genpd_is_always_on(genpd) && !genpd_status_on(genpd))
 		return -EINVAL;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index b7803a251044..74502664ea33 100644
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
@@ -118,6 +122,7 @@ struct generic_pm_domain_data {
 	struct pm_domain_data base;
 	struct gpd_timing_data td;
 	struct notifier_block nb;
+	unsigned int performance_state;
 	void *data;
 };
 
@@ -148,6 +153,9 @@ extern int pm_genpd_remove(struct generic_pm_domain *genpd);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
+extern bool pm_genpd_has_performance_state(struct device *dev);
+extern int pm_genpd_update_performance_state(struct device *dev,
+					     unsigned long rate);
 #else
 
 static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
@@ -185,6 +193,17 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
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
