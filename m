From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V8 1/6] PM / Domains: Add support to select
 performance-state of domains
Date: Wed, 19 Jul 2017 18:07:51 +0530
Message-ID: <20170719123751.GF352@vireshk-i7>
References: <cover.1498026827.git.viresh.kumar@linaro.org>
 <52daf22d2c9d92b0e61c8c5c5a88516d7a08a31a.1498026827.git.viresh.kumar@linaro.org>
 <CAPDyKFqaFvET9yM_6wr7b1Zw=hePQrE-Ak-7YPCR9izooh4LBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqaFvET9yM_6wr7b1Zw=hePQrE-Ak-7YPCR9izooh4LBA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 17-07-17, 14:38, Ulf Hansson wrote:
> On 21 June 2017 at 09:10, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Some platforms have the capability to configure the performance state of
> > their Power Domains. The performance levels are identified by positive
> > integer values, a lower value represents lower performance state.
> >
> > This patch adds a new genpd API: pm_genpd_update_performance_state().
> > The caller passes the affected device and the frequency representing its
> > next DVFS state.
> >
> > The power domains get two new callbacks:
> >
> > - get_performance_state(): This is called by the genpd core to retrieve
> >   the performance state (integer value) corresponding to a target
> >   frequency for the device. This state is used by the genpd core to find
> >   the highest requested state by all the devices powered by a domain.
> 
> Please clarify this a bit more.
> 
> I guess what you want to say is that genpd aggregates all requested
> performance state of all its devices and its subdomains, to be able to
> set a correct (highest requested) performance state.

Right.

> Moreover, could you perhaps explain a bit on *when* this callback
> becomes invoked.

Sure, its done when pm_genpd_update_performance_state() is called for
a device. On such an event, the genpd core first calls
get_performance_state() and gets the device's target state. It then
aggregates the states of all devices/subdomains of the parent domain
of this device and finally calls set_performance_state() for the genpd.

> >
> > - set_performance_state(): The highest state retrieved from above
> >   interface is then passed to this callback to finally program the
> >   performance state of the power domain.
> 
> When will this callback be invoked?

See above.

> What happens when a power domain gets powered off and then on. Is the
> performance state restored? Please elaborate a bit on this.

Can this happen while the genpd is still in use? If not then we
wouldn't have a problem here as the users of it would have revoked
their constraints by now.

> > The power domains can avoid supplying these callbacks, if they don't
> > support setting performance-states.
> >
> > A power domain may have only get_performance_state() callback, if it
> > doesn't have the capability of changing the performance state itself but
> > someone in its parent hierarchy has.
> >
> > A power domain may have only set_performance_state(), if it doesn't have
> > any direct devices below it but subdomains. And so the
> > get_performance_state() will never get called from the core.
> >
> 
> It seems like the ->get_perfomance_state() is a device specific
> callback, while the ->set_performance_state() is a genpd domain
> callback.

Yes.

> I am wondering whether we should try to improve the names of the
> callbacks to reflect this.

What about dev_get_performance_state() and
genpd_set_performance_state() ?

> > The more common case would be to have both the callbacks set.
> >
> > Another API, pm_genpd_has_performance_state(), is also added to let
> > other parts of the kernel check if the power domain of a device supports
> > performance-states or not. This could have been done from
> 
> I think a better name of this function is:
> dev_pm_genpd_has_performance_state(). What do you think?

Sure.

> We might even want to decide to explicitly stay using the terminology
> "DVFS" instead. In such case, perhaps converting the names of the
> callbacks/API to use "dvfs" instead. For the API added here, maybe
> dev_pm_genpd_can_dvfs().

I am not sure about that really. Because in most of the cases genpd
wouldn't do any freq switching, but only voltage.

> > pm_genpd_update_performance_state() as well, but that routine gets
> > called every time we do DVFS for the device and it wouldn't be optimal
> > in that case.
> 
> So pm_genpd_update_performance_state() is also a new API added in
> $subject patch. But there is no information about it in the changelog,
> besides the above. Please add that.

Yeah, I missed that and will include like what I said in the beginning
of the reply on how this leads to call of other callbacks.

> Moreover, perhaps we should rename the function to dev_pm_genpd_set_dvfs()

Not sure as earlier said.

> > Note that, the performance level as returned by
> > ->get_performance_state() for the parent domain of a device is used for
> > all domains in parent hierarchy.
> 
> Please clarify a bit on this. What exactly does this mean?

For a hierarchy like this:

PPdomain 0               PPdomain 1
   |                        |
   --------------------------
                |
             Pdomain
                |
              device

->dev_get_performance_state(dev) would be called for the device and it
will return a single value (X) representing the performance index of
its parent ("Pdomain"). But the direct parent domain may not support
setting of performance index and so we need to propagate the call to
parents of Pdomain. And that would be PPdomain 0 and 1.

Now the paragraph in the commit says that the same performance index
value X will be used for both these PPdomains, as we don't want to
make things more complex to begin with.

> > Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/base/power/domain.c | 223 ++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pm_domain.h   |  22 +++++
> >  2 files changed, 245 insertions(+)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 71c95ad808d5..d506be9ff1f7 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -466,6 +466,229 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
> >         return NOTIFY_DONE;
> >  }
> >
> > +/*
> > + * Returns true if anyone in genpd's parent hierarchy has
> > + * set_performance_state() set.
> > + */
> > +static bool genpd_has_set_performance_state(struct generic_pm_domain *genpd)
> > +{
> 
> So this function will be become in-directly called by generic drivers
> that supports DVFS of the genpd for their devices.
> 
> I think the data you validate here would be better to be pre-validated
> at pm_genpd_init() and at pm_genpd_add|remove_subdomain() and the
> result stored in a variable in the genpd struct. Especially when a
> subdomain is added, that is a point when you can verify the
> *_performance_state() callbacks, and thus make sure it's a correct
> setup from the topology point of view.

Something like this ?

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4a898e095a1d..182c1911ea9c 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -466,25 +466,6 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
        return NOTIFY_DONE;
 }
 
-/*
- * Returns true if anyone in genpd's parent hierarchy has
- * set_performance_state() set.
- */
-static bool genpd_has_set_performance_state(struct generic_pm_domain *genpd)
-{
-       struct gpd_link *link;
-
-       if (genpd->set_performance_state)
-               return true;
-
-       list_for_each_entry(link, &genpd->slave_links, slave_node) {
-               if (genpd_has_set_performance_state(link->master))
-                       return true;
-       }
-
-       return false;
-}
-
 /**
  * pm_genpd_has_performance_state - Checks if power domain does performance
  * state management.
@@ -507,7 +488,7 @@ bool pm_genpd_has_performance_state(struct device *dev)
 
        /* The parent domain must have set get_performance_state() */
        if (!IS_ERR(genpd) && genpd->get_performance_state) {
-               if (genpd_has_set_performance_state(genpd))
+               if (genpd->can_set_performance_state)
                        return true;
 
                /*
@@ -1594,6 +1575,8 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
        if (genpd_status_on(subdomain))
                genpd_sd_counter_inc(genpd);
 
+       subdomain->can_set_performance_state += genpd->can_set_performance_state;
+
  out:
        genpd_unlock(genpd);
        genpd_unlock(subdomain);
@@ -1654,6 +1637,8 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
                if (genpd_status_on(subdomain))
                        genpd_sd_counter_dec(genpd);
 
+               subdomain->can_set_performance_state -= genpd->can_set_performance_state;
+
                ret = 0;
                break;
        }
@@ -1721,6 +1706,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
        genpd->max_off_time_changed = true;
        genpd->provider = NULL;
        genpd->has_provider = false;
+       genpd->can_set_performance_state = !!genpd->set_performance_state;
        genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
        genpd->domain.ops.runtime_resume = genpd_runtime_resume;
        genpd->domain.ops.prepare = pm_genpd_prepare;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index bf90177208a2..995d0cb1bc14 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -64,6 +64,7 @@ struct generic_pm_domain {
        unsigned int suspended_count;   /* System suspend device counter */
        unsigned int prepared_count;    /* Suspend counter of prepared devices */
        unsigned int performance_state; /* Max requested performance state */
+       unsigned int can_set_performance_state; /* Number of parent domains supporting set state */
        int (*power_off)(struct generic_pm_domain *domain);
        int (*power_on)(struct generic_pm_domain *domain);
        int (*get_performance_state)(struct device *dev, unsigned long rate);


> > +       struct gpd_link *link;
> > +
> > +       if (genpd->set_performance_state)
> > +               return true;
> > +
> > +       list_for_each_entry(link, &genpd->slave_links, slave_node) {
> > +               if (genpd_has_set_performance_state(link->master))
> > +                       return true;
> > +       }
> > +
> > +       return false;
> > +}
> > +
> > +/**
> > + * pm_genpd_has_performance_state - Checks if power domain does performance
> > + * state management.
> > + *
> > + * @dev: Device whose power domain is getting inquired.
> > + *
> > + * This must be called by the user drivers, before they start calling
> > + * pm_genpd_update_performance_state(), to guarantee that all dependencies are
> > + * met and the device's genpd supports performance states.
> > + *
> > + * It is assumed that the user driver guarantees that the genpd wouldn't be
> > + * detached while this routine is getting called.
> > + *
> > + * Returns "true" if device's genpd supports performance states, "false"
> > + * otherwise.
> > + */
> > +bool pm_genpd_has_performance_state(struct device *dev)
> > +{
> > +       struct generic_pm_domain *genpd = genpd_lookup_dev(dev);
> > +
> > +       /* The parent domain must have set get_performance_state() */
> 
> This comment is wrong. This is not about *parent* domains.
> 
> Instead I think it should say: "The genpd must have the
> ->get_performance_state() assigned." ...

I was (wrongly) calling power domain of a device as its parent power
domain and so yeah I agree with your feedback.

> > +       if (!IS_ERR(genpd) && genpd->get_performance_state) {
> > +               if (genpd_has_set_performance_state(genpd))
> > +                       return true;
> 
> ... while this is about verifying that some of the domains (genpds) in
> domain topology has a ->set_performance_state() callback.
> 
> In other words, either the genpd or some of its masters must have a
> ->set_performance_state() callback.

Right.

> That makes me wonder: what will happen if there are more than one
> master having a ->set_perfomance_state() callback assigned? I guess
> that is non-allowed configuration?

This patch supports them at least. Device's domain can have multiple
masters which require this configuration, but the same performance
index will be used for all of them (for simplicity unless we have a
real example to serve).

> > +
> > +               /*
> > +                * A genpd with ->get_performance_state() callback must also
> > +                * allow setting performance state.
> > +                */
> > +               dev_err(dev, "genpd doesn't support setting performance state\n");
> > +       }
> > +
> > +       return false;
> > +}
> > +EXPORT_SYMBOL_GPL(pm_genpd_has_performance_state);
> > +
> > +/*
> > + * Re-evaluate performance state of a power domain. Finds the highest requested
> > + * performance state by the devices and subdomains within the power domain and
> > + * then tries to change its performance state. If the power domain doesn't have
> > + * a set_performance_state() callback, then we move the request to its parent
> > + * power domain.
> > + *
> > + * Locking: Access (or update) to device's "pd_data->performance_state" field
> > + * happens only with parent domain's lock held. Subdomains have their
> 
> What is a *parent* domain here?

Same crappy wording I have been using. Its about device's genpd.

> In genpd we try to use the terminology of master- and sub-domains.
> Could you re-phrase this to get some clarity on what you try to
> explain from the above?

Yeah, sure.

So do we call a device's power domain as its master domain? I thought
that master is only used in context of sub-domains, right ?

> > + * "genpd->performance_state" protected with their own lock (and they are the
> > + * only user of this field) and their per-parent-domain
> > + * "link->performance_state" field is protected with individual parent power
> > + * domain's lock and is only accessed/updated with that lock held.
> > + */
> 
> I recall we discussed this off-list, but I am not sure this was the
> conclusion on how to solve the locking. :-) More comments below.

There was no conclusion there :)

> > +static int genpd_update_performance_state(struct generic_pm_domain *genpd,
> > +                                         int depth)
> > +{
> > +       struct generic_pm_domain_data *pd_data;
> > +       struct generic_pm_domain *master;
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
> 
> I don't think walking the list of devices for each master domain is
> necessary, unless the aggregated performance state from the subdomain
> was increased.

Actually we can skip both ^^ and below loop in few cases. Here is the
diff:

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 599b731fcffc..55bbfdabab53 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -509,6 +509,9 @@ EXPORT_SYMBOL_GPL(pm_genpd_has_performance_state);
  * a set_performance_state() callback, then we move the request to its parent
  * power domain.
  *
+ * The state parameter is the newly requested performance state of the device or
+ * subdomain for which this routine is called.
+ *
  * Locking: Access (or update) to device's "pd_data->performance_state" field
  * happens only with parent domain's lock held. Subdomains have their
  * "genpd->performance_state" protected with their own lock (and they are the
@@ -517,15 +520,23 @@ EXPORT_SYMBOL_GPL(pm_genpd_has_performance_state);
  * domain's lock and is only accessed/updated with that lock held.
  */
 static int genpd_update_performance_state(struct generic_pm_domain *genpd,
-                                         int depth)
+                                         int state, int depth)
 {
        struct generic_pm_domain_data *pd_data;
        struct generic_pm_domain *master;
        struct pm_domain_data *pdd;
-       unsigned int state = 0, prev;
+       unsigned int prev;
        struct gpd_link *link;
        int ret;
 
+       /* New requested state is same as Max requested state */
+       if (state == genpd->performance_state)
+               return 0;
+
+       /* New requested state is higher than Max requested state */
+       if (state > genpd->performance_state)
+               goto update_state;
+
        /* Traverse all devices within the domain */
        list_for_each_entry(pdd, &genpd->dev_list, list_node) {
                pd_data = to_gpd_data(pdd);
@@ -540,9 +551,7 @@ static int genpd_update_performance_state(struct generic_pm_domain *genpd,
                        state = link->performance_state;
        }
 
-       if (genpd->performance_state == state)
-               return 0;
-
+update_state:
        if (genpd->set_performance_state) {
                ret = genpd->set_performance_state(genpd, state);
                if (!ret)
@@ -563,7 +572,7 @@ static int genpd_update_performance_state(struct generic_pm_domain *genpd,
                genpd_lock_nested(master, depth + 1);
 
                link->performance_state = state;
-               ret = genpd_update_performance_state(master, depth + 1);
+               ret = genpd_update_performance_state(master, state, depth + 1);
                if (ret)
                        link->performance_state = prev;
 
@@ -587,7 +596,7 @@ static int genpd_update_performance_state(struct generic_pm_domain *genpd,
 
                genpd_lock_nested(master, depth + 1);
                link->performance_state = prev;
-               if (genpd_update_performance_state(master, depth + 1))
+               if (genpd_update_performance_state(master, prev, depth + 1))
                        pr_err("%s: Failed to roll back to %d performance state\n",
                               genpd->name, prev);
                genpd_unlock(master);
@@ -659,7 +668,7 @@ int pm_genpd_update_performance_state(struct device *dev, unsigned long rate)
                goto unlock;
        }
 
-       ret = genpd_update_performance_state(genpd, 0);
+       ret = genpd_update_performance_state(genpd, state, 0);
        if (ret)
                __dev_update_performance_state(dev, state);
 

> > +
> > +       /* Traverse all subdomains within the domain */
> > +       list_for_each_entry(link, &genpd->master_links, master_node) {
> > +               if (link->performance_state > state)
> > +                       state = link->performance_state;
> > +       }
> > +
> 
> From a locking point of view we always traverse the topology from
> bottom an up. In other words, we walk the genpd's ->slave_links, and
> lock the masters in the order the are defined via the slave_links
> list. The order is important to avoid deadlocks. I don't think you
> should walk the master_links as being done above, especially not
> without using locks.

So we need to look at the performance states of the subdomains of a
master. The way it is done in this patch with help of
link->performance_state, we don't need that locking while traversing
the master_links list. Here is how:

- Master's (genpd) master_links list is only updated under master's
  lock, which we have already taken here. So master_links list can't
  get updated concurrently.

- The link->performance_state field of a subdomain (or slave) is only
  updated from within the master's lock. And we are reading it here
  from the same lock.

AFAIU, there shouldn't be any deadlocks or locking issues here. Can
you describe some case that may blow up ?

> > +       if (genpd->performance_state == state)
> > +               return 0;
> > +
> > +       if (genpd->set_performance_state) {
> > +               ret = genpd->set_performance_state(genpd, state);
> > +               if (!ret)
> > +                       genpd->performance_state = state;
> > +
> > +               return ret;
> 
> This looks wrong.
> 
> I think you should continue to walk upwards in the domain topology, as
> there may be some other master than needs to get its performance state
> updated.

I can do that.

> > +       }
> > +
> > +       /*
> > +        * Not all domains support updating performance state. Move on to their
> > +        * parent domains in that case.
> 
> /s/parent/master
> 
> > +        */
> > +       prev = genpd->performance_state;
> > +
> > +       list_for_each_entry(link, &genpd->slave_links, slave_node) {
> > +               master = link->master;
> > +
> > +               genpd_lock_nested(master, depth + 1);
> > +
> > +               link->performance_state = state;
> > +               ret = genpd_update_performance_state(master, depth + 1);
> > +               if (ret)
> > +                       link->performance_state = prev;
> > +
> > +               genpd_unlock(master);
> > +
> > +               if (ret)
> > +                       goto err;
> > +       }
> > +
> 
> A general comment is that I think you should look more closely in the
> code of genpd_power_off|on(). And also how it calls the
> ->power_on|off() callbacks.
> 
> Depending whether you want to update the performance state of the
> master domain before the subdomain or the opposite, you will find one
> of them being suited for this case as well.

Isn't it very much similar to that already ? The only major difference
is link->performance_state and I already explained why is it required
to be done that way to avoid deadlocks.

> > +       /*
> > +        * The parent domains are updated now, lets get genpd performance_state
> > +        * in sync with those.
> > +        */
> > +       genpd->performance_state = state;
> > +       return 0;
> > +
> > +err:
> > +       list_for_each_entry_continue_reverse(link, &genpd->slave_links,
> > +                                            slave_node) {
> > +               master = link->master;
> > +
> > +               genpd_lock_nested(master, depth + 1);
> > +               link->performance_state = prev;
> > +               if (genpd_update_performance_state(master, depth + 1))
> > +                       pr_err("%s: Failed to roll back to %d performance state\n",
> > +                              genpd->name, prev);
> > +               genpd_unlock(master);
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static int __dev_update_performance_state(struct device *dev, int state)
> 
> Please use the prefix genpd, _genpd_ or __genpd for static functions.
> 
> > +{
> > +       struct generic_pm_domain_data *gpd_data;
> > +       int ret;
> > +
> > +       spin_lock_irq(&dev->power.lock);
> 
> Actually there is no need to use this lock.
> 
> Because you hold the genpd lock here, then the device can't be removed
> from its genpd and thus there is always a valid gpd_data.

I am afraid we still need this lock.

genpd_free_dev_data() is called from genpd_remove_device() without
genpd lock and so it is possible that we reach here after that lock is
dropped from genpd_remove_device() but before genpd_free_dev_data() is
called.

Right ?

> > +
> > +       if (!dev->power.subsys_data || !dev->power.subsys_data->domain_data) {
> > +               ret = -ENODEV;
> > +               goto unlock;
> > +       }
> > +
> > +       gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
> > +
> > +       ret = gpd_data->performance_state;
> > +       gpd_data->performance_state = state;
> > +
> > +unlock:
> > +       spin_unlock_irq(&dev->power.lock);
> > +
> > +       return ret;
> > +}
> > +
> > +/**
> > + * pm_genpd_update_performance_state - Update performance state of device's
> > + * parent power domain for the target frequency for the device.
> > + *
> > + * @dev: Device for which the performance-state needs to be adjusted.
> > + * @rate: Device's next frequency. This can be set as 0 when the device doesn't
> > + * have any performance state constraints left (And so the device wouldn't
> > + * participate anymore to find the target performance state of the genpd).
> > + *
> > + * This must be called by the user drivers (as many times as they want) only
> > + * after pm_genpd_has_performance_state() is called (only once) and that
> > + * returned "true".
> > + *
> > + * It is assumed that the user driver guarantees that the genpd wouldn't be
> > + * detached while this routine is getting called.
> > + *
> > + * Returns 0 on success and negative error values on failures.
> > + */
> > +int pm_genpd_update_performance_state(struct device *dev, unsigned long rate)
> > +{
> > +       struct generic_pm_domain *genpd = dev_to_genpd(dev);
> > +       int ret, state;
> > +
> > +       if (IS_ERR(genpd))
> > +               return -ENODEV;
> > +
> > +       genpd_lock(genpd);
> > +
> > +       state = genpd->get_performance_state(dev, rate);
> > +       if (state < 0) {
> > +               ret = state;
> > +               goto unlock;
> > +       }
> > +
> > +       state = __dev_update_performance_state(dev, state);
> > +       if (state < 0) {
> > +               ret = state;
> > +               goto unlock;
> > +       }
> > +
> > +       ret = genpd_update_performance_state(genpd, 0);
> > +       if (ret)
> > +               __dev_update_performance_state(dev, state);
> > +
> > +unlock:
> > +       genpd_unlock(genpd);
> > +
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(pm_genpd_update_performance_state);
> > +
> >  /**
> >   * genpd_power_off_work_fn - Power off PM domain whose subdomain count is 0.
> >   * @work: Work structure used for scheduling the execution of this function.
> > diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> > index b7803a251044..bf90177208a2 100644
> > --- a/include/linux/pm_domain.h
> > +++ b/include/linux/pm_domain.h
> > @@ -63,8 +63,12 @@ struct generic_pm_domain {
> >         unsigned int device_count;      /* Number of devices */
> >         unsigned int suspended_count;   /* System suspend device counter */
> >         unsigned int prepared_count;    /* Suspend counter of prepared devices */
> > +       unsigned int performance_state; /* Max requested performance state */
> >         int (*power_off)(struct generic_pm_domain *domain);
> >         int (*power_on)(struct generic_pm_domain *domain);
> > +       int (*get_performance_state)(struct device *dev, unsigned long rate);
> > +       int (*set_performance_state)(struct generic_pm_domain *domain,
> > +                                    unsigned int state);
> >         struct gpd_dev_ops dev_ops;
> >         s64 max_off_time_ns;    /* Maximum allowed "suspended" time. */
> >         bool max_off_time_changed;
> > @@ -99,6 +103,9 @@ struct gpd_link {
> >         struct list_head master_node;
> >         struct generic_pm_domain *slave;
> >         struct list_head slave_node;
> > +
> > +       /* Sub-domain's per-parent domain performance state */
> > +       unsigned int performance_state;
> 
> How about aggregate_dvfs_state, and move it to the struct generic_pm_domain.
> 
> Because I think you only need to keep track one aggregated state per
> domain and per each subdomain, right?

This is required to solve the deadlock you showed in the previous
version of this patch. As I explained earlier.

> Huh, I hope my comments make some sense.

Sure, and thanks for such a detailed review :)

> It's a bit of tricky code,
> when walking the domain topology and I think there are couple
> optimization we can do while doing that. Hopefully you can understand
> most of my comments at least. :-)
> 
> Feel free to ping me on IRC, if further explanations is needed.

I would let you go through this reply and then we can talk tomorrow on
IRC as we don't agree on some of the cases here for sure :)

-- 
viresh
