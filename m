From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V11 1/7] PM / Domains: Add support to select
 performance-state of domains
Date: Wed, 11 Oct 2017 13:27:34 +0200
Message-ID: <CAPDyKFrb29Oc_UMN62Hjtk4TvwADuOxBjRhcaaUWcmpw_npeOg@mail.gmail.com>
References: <cover.1507703370.git.viresh.kumar@linaro.org> <431a7a5803b4a552dfe2a71700e19b904c6d16dc.1507703370.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <431a7a5803b4a552dfe2a71700e19b904c6d16dc.1507703370.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 11 October 2017 at 09:24, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Some platforms have the capability to configure the performance state of
> PM domains. This patch enhances the genpd core to support such
> platforms.
>
> The performance levels (within the genpd core) are identified by
> positive integer values, a lower value represents lower performance
> state.
>
> This patch adds a new genpd API, which is called by user drivers (like
> OPP framework):
>
> - int dev_pm_genpd_set_performance_state(struct device *dev,
>                                          unsigned int state);
>
>   This updates the performance state constraint of the device on its PM
>   domain. On success, the genpd will have its performance state set to a
>   value which is >= "state" passed to this routine. The genpd core calls
>   the genpd->genpd_set_performance_state() callback, if implemented,
>   else -ENODEV is returned to the caller.
>
> The PM domain drivers need to implement the following callback if they
> want to support performance states.
>
> - int (*genpd_set_performance_state)(struct generic_pm_domain *genpd,
>                                      unsigned int state);
>
>   This is called internally by the genpd core on several occasions. The
>   genpd core passes the genpd pointer and the aggregate of the
>   performance states of the devices supported by that genpd to this
>   callback. This callback must update the performance state of the genpd
>   in a platform dependent way.
>
> The power domains can avoid supplying above callback, if they don't
> support setting performance-states.
>
> A TODO comment is also added to _genpd_reeval_performance_state(). This
> feature will be required once we have hardware that needs to propagate
> the performance state changes to master domains.

Perhaps re-phrase this to being about "a limitation that can be fixed
later if needed" rather than an TODO. That applies also to the comment
in the code.

>
> Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/domain.c | 179 +++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/pm_domain.h   |  13 ++++
>  2 files changed, 190 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index a6e4c8d7d837..b8360bc6a8eb 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -237,6 +237,169 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
>  static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
>  #endif
>
> +/* Returns negative errors or 0 on success */
> +static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
> +                                       int state)

Please rename the function to: genpd_set_performance_state().

> +{
> +       int ret;
> +
> +       ret = genpd->genpd_set_performance_state(genpd, state);
> +       if (!ret)
> +               genpd->performance_state = state;
> +
> +       return ret;
> +}
> +
> +/*
> + * Re-evaluate performance state of a genpd. Finds the highest requested
> + * performance state by the devices within the genpd and then change genpd's
> + * performance state (if required).
> + *
> + * @genpd: PM domain whose state needs to be reevaluated.
> + * @state: Newly requested performance state of the device for which this
> + *        routine is called.
> + *
> + * Returns negative errors or 0 on success.
> + */

This isn't an exported function, so you may slim down this information
quite a bit.

> +static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
> +                                          int state)

By looking how this function is used, I suggest you to rename it to
genpd_update_performance_state() and also fold in the code from the
__genpd_dev_update_performance_state(). I think that would simplify
the code a bit.

> +{
> +       struct generic_pm_domain_data *pd_data;
> +       struct pm_domain_data *pdd;
> +
> +       /* New requested state is same as Max requested state */
> +       if (state == genpd->performance_state)
> +               return 0;
> +
> +       /* New requested state is higher than Max requested state */
> +       if (state > genpd->performance_state)
> +               goto update_state;
> +
> +       /* Traverse all devices within the domain */
> +       list_for_each_entry(pdd, &genpd->dev_list, list_node) {
> +               pd_data = to_gpd_data(pdd);
> +
> +               if (pd_data->performance_state > state)
> +                       state = pd_data->performance_state;
> +       }
> +
> +       /*
> +        * TODO: Traverse all subdomains of the genpd. This will be
> +        * required once we have hardware that needs to propagate the
> +        * performance state changes.
> +        */

As mentioned, please re-phrase this to be about a limitation rather than a TODO.

> +
> +update_state:
> +       return _genpd_set_performance_state(genpd, state);
> +}
> +
> +static void __genpd_dev_update_performance_state(struct device *dev, int state)
> +{
> +       struct generic_pm_domain_data *gpd_data;
> +
> +       spin_lock_irq(&dev->power.lock);

I remember we already discussed this lock, but I did second thought
around this. Apologize for coming back to this again.

As you state in the function header of
dev_pm_genpd_set_performance_state(), users of this function must
guarantee that the device don't get detached from its genpd while
calling it. For that reason, the ->domain_data pointer will always be
valid when __genpd_dev_update_performance_state() is executed. In
other words, there's no reason to use the lock to protect access to
it.

> +
> +       if (!dev->power.subsys_data || !dev->power.subsys_data->domain_data) {
> +               WARN_ON(1);
> +               goto unlock;
> +       }
> +
> +       gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
> +       gpd_data->performance_state = state;
> +
> +unlock:
> +       spin_unlock_irq(&dev->power.lock);
> +}
> +
> +/**
> + * dev_pm_genpd_set_performance_state- Set performance state of device's power
> + * domain.
> + *
> + * @dev: Device for which the performance-state needs to be adjusted.
> + * @state: Target performance state of the device. This can be set as 0 when the
> + *        device doesn't have any performance state constraints left (And so
> + *        the device wouldn't participate anymore to find the target
> + *        performance state of the genpd).
> + *
> + * It is assumed that the user driver guarantees that the genpd wouldn't be
> + * detached while this routine is getting called.
> + *
> + * Returns 0 on success and negative error values on failures.
> + */
> +int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
> +{
> +       struct generic_pm_domain *genpd;
> +       int ret;
> +
> +       genpd = dev_to_genpd(dev);
> +       if (IS_ERR(genpd))
> +               return -ENODEV;
> +
> +       genpd_lock(genpd);
> +
> +       if (!genpd->genpd_set_performance_state) {

Because we expect the ->genpd_set_performance_state() to be assigned
once and at initialization (before pm_genpd_init() is called), you can
move this check outside the genpd lock.

If the reason for the lock, is to avoid the genpd from being removed!?
Then, that is also managed by stating that users of
dev_pm_genpd_set_performance_state() must guarantee the device won't
get detached from its genpd when calling this function.

> +               ret = -ENODEV;
> +               goto unlock;
> +       }
> +
> +       if (!genpd_status_on(genpd)) {
> +               ret = -EBUSY;

To me, it seems feasible to allow users to request a new performance
state, no matter of whether the PM domain is powered on or off.

In case the genpd is off, we should only compute a new aggregated
performance state value, but not call ->genpd_set_performance_state().
More comments about that below.

> +               goto unlock;
> +       }
> +
> +       ret = _genpd_reeval_performance_state(genpd, state);
> +       if (!ret) {
> +               /*
> +                * Since we are passing "state" as well to
> +                * _genpd_reeval_performance_state(), we don't need to call
> +                * __genpd_dev_update_performance_state() before updating
> +                * genpd's state with the above call. Update it only after the
> +                * state of master domain is updated.
> +                */

This looks like an old comment from earlier version. I guess you
should remove it!?

> +               __genpd_dev_update_performance_state(dev, state);
> +       }
> +
> +unlock:
> +       genpd_unlock(genpd);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_genpd_set_performance_state);
> +
> +static int _genpd_on_update_performance_state(struct generic_pm_domain *genpd)
> +{
> +       int ret, prev = genpd->prev_performance_state;
> +
> +       if (likely(!prev))
> +               return 0;
> +
> +       ret = _genpd_set_performance_state(genpd, prev);
> +       if (ret) {
> +               pr_err("%s: Failed to restore performance state to %d (%d)\n",
> +                      genpd->name, prev, ret);
> +       } else {
> +               genpd->prev_performance_state = 0;
> +       }
> +
> +       return ret;
> +}
> +
> +static void _genpd_off_update_performance_state(struct generic_pm_domain *genpd)
> +{
> +       int ret, state = genpd->performance_state;
> +
> +       if (likely(!state))
> +               return;
> +
> +       ret = _genpd_set_performance_state(genpd, 0);
> +       if (ret) {
> +               pr_err("%s: Failed to set performance state to 0 (%d)\n",
> +                      genpd->name, ret);
> +       } else {
> +               genpd->prev_performance_state = state;
> +       }
> +}
> +
>  static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>  {
>         unsigned int state_idx = genpd->state_idx;
> @@ -388,6 +551,8 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>                         return ret;
>         }
>
> +       _genpd_off_update_performance_state(genpd);
> +

This hole thing of keeping track of the previous performance state,
while powering off seems a bit unnecessary complex in my opinion.

Instead I suggest to pick a more simple approach, like this:
*) Allow users to update the performance state even when the genpd is
powered off. As stated above.
**) In _genpd_power_on(), invoke the _genpd_set_performance_state(),
after the ->power_on() callback has been invoked an succeeded. Whether
 _genpd_set_performance_state() fails in this case, there is not much
we can do, but just print a warning.
***) During power off, just don't care about the current performance
state, but instead leave that to the genpd client to be managed via
the ->power_off() callback.

In this way, the ->genpd_set_performance_state() is only called when
the genpd is powered on. That should be easier for the genpd clients
to cope with.

Moreover, most of this related code can then be dropped and so can the
"unsigned int prev_performance_state" in the genpd struct.

>         genpd->status = GPD_STATE_POWER_OFF;
>         genpd_update_accounting(genpd);
>
> @@ -437,15 +602,21 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
>                 }
>         }
>
> -       ret = _genpd_power_on(genpd, true);
> +       ret = _genpd_on_update_performance_state(genpd);
>         if (ret)
>                 goto err;
>
> +       ret = _genpd_power_on(genpd, true);
> +       if (ret)
> +               goto err_power_on;
> +
>         genpd->status = GPD_STATE_ACTIVE;
>         genpd_update_accounting(genpd);
>
>         return 0;
>
> + err_power_on:
> +       _genpd_off_update_performance_state(genpd);
>   err:
>         list_for_each_entry_continue_reverse(link,
>                                         &genpd->slave_links,
> @@ -803,6 +974,8 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
>         if (_genpd_power_off(genpd, false))
>                 return;
>
> +       _genpd_off_update_performance_state(genpd);
> +
>         genpd->status = GPD_STATE_POWER_OFF;
>
>         list_for_each_entry(link, &genpd->slave_links, slave_node) {
> @@ -848,7 +1021,9 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
>                         genpd_unlock(link->master);
>         }
>
> -       _genpd_power_on(genpd, false);
> +       if (!_genpd_on_update_performance_state(genpd))
> +               if (_genpd_power_on(genpd, false))
> +                       _genpd_off_update_performance_state(genpd);
>
>         genpd->status = GPD_STATE_ACTIVE;
>  }
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 84f423d5633e..81d923f058fd 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -64,8 +64,12 @@ struct generic_pm_domain {
>         unsigned int device_count;      /* Number of devices */
>         unsigned int suspended_count;   /* System suspend device counter */
>         unsigned int prepared_count;    /* Suspend counter of prepared devices */
> +       unsigned int performance_state; /* Max requested performance state */
> +       unsigned int prev_performance_state;    /* Performance state before power off */
>         int (*power_off)(struct generic_pm_domain *domain);
>         int (*power_on)(struct generic_pm_domain *domain);
> +       int (*genpd_set_performance_state)(struct generic_pm_domain *genpd,
> +                                          unsigned int state);

Please rename this callback to "set_performance_state".

>         struct gpd_dev_ops dev_ops;
>         s64 max_off_time_ns;    /* Maximum allowed "suspended" time. */
>         bool max_off_time_changed;
> @@ -121,6 +125,7 @@ struct generic_pm_domain_data {
>         struct pm_domain_data base;
>         struct gpd_timing_data td;
>         struct notifier_block nb;
> +       unsigned int performance_state;
>         void *data;
>  };
>
> @@ -148,6 +153,8 @@ extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>  extern int pm_genpd_init(struct generic_pm_domain *genpd,
>                          struct dev_power_governor *gov, bool is_off);
>  extern int pm_genpd_remove(struct generic_pm_domain *genpd);
> +extern int dev_pm_genpd_set_performance_state(struct device *dev,
> +                                             unsigned int state);
>
>  extern struct dev_power_governor simple_qos_governor;
>  extern struct dev_power_governor pm_domain_always_on_gov;
> @@ -188,6 +195,12 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
>         return -ENOTSUPP;
>  }
>
> +static inline int dev_pm_genpd_set_performance_state(struct device *dev,
> +                                                    unsigned int state)
> +{
> +       return -ENOTSUPP;
> +}
> +
>  #define simple_qos_governor            (*(struct dev_power_governor *)(NULL))
>  #define pm_domain_always_on_gov                (*(struct dev_power_governor *)(NULL))
>  #endif
> --
> 2.7.4
>

Kind regards
Uffe
