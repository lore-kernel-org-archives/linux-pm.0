From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] genpd: cpuidle: Remove cpuidle attach
Date: Tue, 1 Sep 2015 19:32:09 +0200
Message-ID: <CAPDyKFrhV2Bi06=siqTfwc+i1sLPCWMcTa5TPrtLUe=361X_HQ@mail.gmail.com>
References: <1441118386-10003-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441118386-10003-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, zhaoyang.huang@linaro.org, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "open list:GENERIC PM DOMAINS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 1 September 2015 at 16:39, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> The power domains code allows to tie a cpuidle state with a power domain.
>
> Preventing the cpuidle framework to enter a specific idle state by disabling
> from the power domain framework is a good idea. Unfortunately, the current
> implementation has some gaps with a SMP system and a complex cpuidle
> implementation. Enabling a power domain wakes up all the cpus even if a cpu
> does not belong to the power domain.
>
> There is some work to do a logical representation with the power domains of
> the hardware dependencies (eg. a cpu belongs to a power domains, these power
> domains belong to a higher power domain for a cluster, etc ...). A new code
> relying on the genpd hierarchy to disable the idle states would make more
> sense.
>
> As the unique user of this code has been removed, let's wipe out this code
> to have a clean place to put a new implementation.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

This is certainly a good idea, not only to pave the road for a new
implementation but also to prevent us from adding more users of the
existing API.

I would suggest a minor update of the prefix of the commit message, to
align with earlier genpd patches. Please change from "genpd: cpuidle"
to "PM / Domains:".

With that change:
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 154 --------------------------------------------
>  include/linux/pm_domain.h   |  27 --------
>  2 files changed, 181 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 0ee43c1..f468627 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -171,19 +171,6 @@ static void genpd_set_active(struct generic_pm_domain *genpd)
>                 genpd->status = GPD_STATE_ACTIVE;
>  }
>
> -static void genpd_recalc_cpu_exit_latency(struct generic_pm_domain *genpd)
> -{
> -       s64 usecs64;
> -
> -       if (!genpd->cpuidle_data)
> -               return;
> -
> -       usecs64 = genpd->power_on_latency_ns;
> -       do_div(usecs64, NSEC_PER_USEC);
> -       usecs64 += genpd->cpuidle_data->saved_exit_latency;
> -       genpd->cpuidle_data->idle_state->exit_latency = usecs64;
> -}
> -
>  static int genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>  {
>         ktime_t time_start;
> @@ -207,7 +194,6 @@ static int genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>
>         genpd->power_on_latency_ns = elapsed_ns;
>         genpd->max_off_time_changed = true;
> -       genpd_recalc_cpu_exit_latency(genpd);
>         pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
>                  genpd->name, "on", elapsed_ns);
>
> @@ -280,13 +266,6 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
>                 return 0;
>         }
>
> -       if (genpd->cpuidle_data) {
> -               cpuidle_pause_and_lock();
> -               genpd->cpuidle_data->idle_state->disabled = true;
> -               cpuidle_resume_and_unlock();
> -               goto out;
> -       }
> -
>         /*
>          * The list is guaranteed not to change while the loop below is being
>          * executed, unless one of the masters' .power_on() callbacks fiddles
> @@ -595,21 +574,6 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
>                 }
>         }
>
> -       if (genpd->cpuidle_data) {
> -               /*
> -                * If cpuidle_data is set, cpuidle should turn the domain off
> -                * when the CPU in it is idle.  In that case we don't decrement
> -                * the subdomain counts of the master domains, so that power is
> -                * not removed from the current domain prematurely as a result
> -                * of cutting off the masters' power.
> -                */
> -               genpd->status = GPD_STATE_POWER_OFF;
> -               cpuidle_pause_and_lock();
> -               genpd->cpuidle_data->idle_state->disabled = false;
> -               cpuidle_resume_and_unlock();
> -               goto out;
> -       }
> -
>         if (genpd->power_off) {
>                 if (atomic_read(&genpd->sd_count) > 0) {
>                         ret = -EBUSY;
> @@ -1725,124 +1689,6 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>         return ret;
>  }
>
> -/**
> - * pm_genpd_attach_cpuidle - Connect the given PM domain with cpuidle.
> - * @genpd: PM domain to be connected with cpuidle.
> - * @state: cpuidle state this domain can disable/enable.
> - *
> - * Make a PM domain behave as though it contained a CPU core, that is, instead
> - * of calling its power down routine it will enable the given cpuidle state so
> - * that the cpuidle subsystem can power it down (if possible and desirable).
> - */
> -int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state)
> -{
> -       struct cpuidle_driver *cpuidle_drv;
> -       struct gpd_cpuidle_data *cpuidle_data;
> -       struct cpuidle_state *idle_state;
> -       int ret = 0;
> -
> -       if (IS_ERR_OR_NULL(genpd) || state < 0)
> -               return -EINVAL;
> -
> -       genpd_acquire_lock(genpd);
> -
> -       if (genpd->cpuidle_data) {
> -               ret = -EEXIST;
> -               goto out;
> -       }
> -       cpuidle_data = kzalloc(sizeof(*cpuidle_data), GFP_KERNEL);
> -       if (!cpuidle_data) {
> -               ret = -ENOMEM;
> -               goto out;
> -       }
> -       cpuidle_drv = cpuidle_driver_ref();
> -       if (!cpuidle_drv) {
> -               ret = -ENODEV;
> -               goto err_drv;
> -       }
> -       if (cpuidle_drv->state_count <= state) {
> -               ret = -EINVAL;
> -               goto err;
> -       }
> -       idle_state = &cpuidle_drv->states[state];
> -       if (!idle_state->disabled) {
> -               ret = -EAGAIN;
> -               goto err;
> -       }
> -       cpuidle_data->idle_state = idle_state;
> -       cpuidle_data->saved_exit_latency = idle_state->exit_latency;
> -       genpd->cpuidle_data = cpuidle_data;
> -       genpd_recalc_cpu_exit_latency(genpd);
> -
> - out:
> -       genpd_release_lock(genpd);
> -       return ret;
> -
> - err:
> -       cpuidle_driver_unref();
> -
> - err_drv:
> -       kfree(cpuidle_data);
> -       goto out;
> -}
> -
> -/**
> - * pm_genpd_name_attach_cpuidle - Find PM domain and connect cpuidle to it.
> - * @name: Name of the domain to connect to cpuidle.
> - * @state: cpuidle state this domain can manipulate.
> - */
> -int pm_genpd_name_attach_cpuidle(const char *name, int state)
> -{
> -       return pm_genpd_attach_cpuidle(pm_genpd_lookup_name(name), state);
> -}
> -
> -/**
> - * pm_genpd_detach_cpuidle - Remove the cpuidle connection from a PM domain.
> - * @genpd: PM domain to remove the cpuidle connection from.
> - *
> - * Remove the cpuidle connection set up by pm_genpd_attach_cpuidle() from the
> - * given PM domain.
> - */
> -int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd)
> -{
> -       struct gpd_cpuidle_data *cpuidle_data;
> -       struct cpuidle_state *idle_state;
> -       int ret = 0;
> -
> -       if (IS_ERR_OR_NULL(genpd))
> -               return -EINVAL;
> -
> -       genpd_acquire_lock(genpd);
> -
> -       cpuidle_data = genpd->cpuidle_data;
> -       if (!cpuidle_data) {
> -               ret = -ENODEV;
> -               goto out;
> -       }
> -       idle_state = cpuidle_data->idle_state;
> -       if (!idle_state->disabled) {
> -               ret = -EAGAIN;
> -               goto out;
> -       }
> -       idle_state->exit_latency = cpuidle_data->saved_exit_latency;
> -       cpuidle_driver_unref();
> -       genpd->cpuidle_data = NULL;
> -       kfree(cpuidle_data);
> -
> - out:
> -       genpd_release_lock(genpd);
> -       return ret;
> -}
> -
> -/**
> - * pm_genpd_name_detach_cpuidle - Find PM domain and disconnect cpuidle from it.
> - * @name: Name of the domain to disconnect cpuidle from.
> - */
> -int pm_genpd_name_detach_cpuidle(const char *name)
> -{
> -       return pm_genpd_detach_cpuidle(pm_genpd_lookup_name(name));
> -}
> -
>  /* Default device callbacks for generic PM domains. */
>
>  /**
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 681ccb0..85c5862 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -15,7 +15,6 @@
>  #include <linux/err.h>
>  #include <linux/of.h>
>  #include <linux/notifier.h>
> -#include <linux/cpuidle.h>
>
>  /* Defines used for the flags field in the struct generic_pm_domain */
>  #define GENPD_FLAG_PM_CLK      (1U << 0) /* PM domain uses PM clk */
> @@ -41,11 +40,6 @@ struct gpd_dev_ops {
>         bool (*active_wakeup)(struct device *dev);
>  };
>
> -struct gpd_cpuidle_data {
> -       unsigned int saved_exit_latency;
> -       struct cpuidle_state *idle_state;
> -};
> -
>  struct generic_pm_domain {
>         struct dev_pm_domain domain;    /* PM domain operations */
>         struct list_head gpd_list_node; /* Node in the global PM domains list */
> @@ -74,7 +68,6 @@ struct generic_pm_domain {
>         s64 max_off_time_ns;    /* Maximum allowed "suspended" time. */
>         bool max_off_time_changed;
>         bool cached_power_down_ok;
> -       struct gpd_cpuidle_data *cpuidle_data;
>         int (*attach_dev)(struct generic_pm_domain *domain,
>                           struct device *dev);
>         void (*detach_dev)(struct generic_pm_domain *domain,
> @@ -144,10 +137,6 @@ extern int pm_genpd_add_subdomain_names(const char *master_name,
>                                         const char *subdomain_name);
>  extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>                                      struct generic_pm_domain *target);
> -extern int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state);
> -extern int pm_genpd_name_attach_cpuidle(const char *name, int state);
> -extern int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd);
> -extern int pm_genpd_name_detach_cpuidle(const char *name);
>  extern void pm_genpd_init(struct generic_pm_domain *genpd,
>                           struct dev_power_governor *gov, bool is_off);
>
> @@ -199,22 +188,6 @@ static inline int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>  {
>         return -ENOSYS;
>  }
> -static inline int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int st)
> -{
> -       return -ENOSYS;
> -}
> -static inline int pm_genpd_name_attach_cpuidle(const char *name, int state)
> -{
> -       return -ENOSYS;
> -}
> -static inline int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd)
> -{
> -       return -ENOSYS;
> -}
> -static inline int pm_genpd_name_detach_cpuidle(const char *name)
> -{
> -       return -ENOSYS;
> -}
>  static inline void pm_genpd_init(struct generic_pm_domain *genpd,
>                                  struct dev_power_governor *gov, bool is_off)
>  {
> --
> 1.9.1
>
