From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] [RFC] PM / Domains: add multiple states
Date: Fri, 10 Apr 2015 12:24:39 +0200
Message-ID: <CAPDyKFoSvY=G7PQ5EnacTDfmuxYw398A0h_TV--6E9exXJv-cg@mail.gmail.com>
References: <1428507725-12205-1-git-send-email-ahaslam@baylibre.com>
	<1428507725-12205-2-git-send-email-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35788 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613AbbDJKYk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2015 06:24:40 -0400
Received: by qkhg7 with SMTP id g7so24009405qkh.2
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2015 03:24:39 -0700 (PDT)
In-Reply-To: <1428507725-12205-2-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ahaslam@baylibre.com
Cc: Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>

On 8 April 2015 at 17:42,  <ahaslam@baylibre.com> wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
>
> Some architectures may have intermediate
> power levels between on and off. each state in
> between may have its own set of registers to
> save and restore, and procedures to put the power
> domain into that state.
>
> This patch adds the ability to declare multiple
> states for a given generic power domain, the
> idea is that the deepest state will be entered which
> does not violate any of the device or sub-domain
> latency constraints.
>
> for this purpose, the device save and restore callbacks
> take in a new parameter "state" which is the state
> the domain is trying to go to. The implementation
> of these callbacks can use this to save and restore
> the appropriate registers. Also the power on and off
> callbacks and latencies are now tied to a particular
> state.
>
> States should be declared in ascending order from shallowest
> to deepest, deepest meaning the state which takes longer
> to enter and exit. The declaration would look something like:
>
> struct generic_pm_domain pd1 = {
>         .name = "pd1",
>         .states = {
>                 [0] = {
>                         .name= "D0",
>                         .power_off = D0_power_off_cb,
>                         .power_on = D0_power_on_cb,
>                         .power_off_latency_ns = 1000000,
>                         .power_on_latency_ns = 1000000,
>                 },
>                 [1] = {
>                         .name= "D1",
>                         .power_off = D1_power_off_cb,
>                         .power_on = D1_power_on_cb,
>                         .power_off_latency_ns = 2000000,
>                         .power_on_latency_ns = 2000000,
>                 },
>                 [2] = {
>                         .name= "D2",
>                         .power_off = D2_power_off_cb,
>                         .power_on = D2_power_on_cb,
>                         .power_off_latency_ns = 3000000,
>                         .power_on_latency_ns = 3000000,
>                 },
>         },
>
>         .state_count = 3,
>         .dev_ops.start = dev_callback_start,
>         .dev_ops.stop = dev_callback_stop,

I would like to get the complete picture.

Could you elaborate on what theese two callbacks will be doing in your case?

>         .dev_ops.save_state = dev_callback_save,
>         .dev_ops.restore_state = dev_callback_restore,

...and some more information about these as well, please.

>
> };
>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> ---
>  drivers/base/power/domain.c          | 80 ++++++++++++++++++++++++++++--------
>  drivers/base/power/domain_governor.c | 14 ++++---
>  include/linux/pm_domain.h            | 27 ++++++++----
>  3 files changed, 90 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index ef54f98..33baecb 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -46,6 +46,36 @@
>         }                                                                       \
>         __retval;                                                               \
>  })
> +#define GENPD_DEV_CALLBACK_STATE(genpd, type, callback, dev, state)    \
> +({                                                                     \
> +       type (*__routine)(struct device *__d, int __s);                 \
> +       type __ret = (type)0;                                           \
> +                                                                       \
> +       __routine = genpd->dev_ops.callback;                            \
> +       if (__routine) {                                                \
> +               __ret = __routine(dev, state);                          \
> +       }                                                               \
> +       __ret;                                                          \
> +})
> +
> +#define GENPD_DEV_TIMED_CALLBACK_STATE(genpd, type, callback, dev,     \
> +                                       field, name, state)             \
> +({                                                                     \
> +       ktime_t __start = ktime_get();                                  \
> +       type __retval = GENPD_DEV_CALLBACK_STATE(genpd, type, callback, \
> +                                                dev, state);           \
> +       s64 __elapsed = ktime_to_ns(ktime_sub(ktime_get(), __start));   \
> +       struct gpd_timing_data *__td = &dev_gpd_data(dev)->td;          \
> +       if (!__retval && __elapsed > __td->field[state]) {              \
> +               __td->field[state] = __elapsed;                         \
> +               dev_dbg(dev, name                                       \
> +               "State %d latency exceeded, new value %lld ns\n",       \
> +                       state, __elapsed);                              \
> +               genpd->max_off_time_changed = true;                     \
> +               __td->constraint_changed = true;                        \
> +       }                                                               \
> +       __retval;                                                       \
> +})

In general I would like to move away from using such macros, since I
think it becomes less readable code.
I know we have them already, but that is to me not a good reason for
adding yet another pair.

Should we try to find a better way?

>
>  static LIST_HEAD(gpd_list);
>  static DEFINE_MUTEX(gpd_list_lock);
> @@ -141,12 +171,13 @@ static void genpd_set_active(struct generic_pm_domain *genpd)
>
>  static void genpd_recalc_cpu_exit_latency(struct generic_pm_domain *genpd)
>  {
> +       int target_state = genpd->target_state;
>         s64 usecs64;
>
>         if (!genpd->cpuidle_data)
>                 return;
>
> -       usecs64 = genpd->power_on_latency_ns;
> +       usecs64 = genpd->states[target_state].power_on_latency_ns;
>         do_div(usecs64, NSEC_PER_USEC);
>         usecs64 += genpd->cpuidle_data->saved_exit_latency;
>         genpd->cpuidle_data->idle_state->exit_latency = usecs64;
> @@ -154,23 +185,24 @@ static void genpd_recalc_cpu_exit_latency(struct generic_pm_domain *genpd)
>
>  static int genpd_power_on(struct generic_pm_domain *genpd)
>  {
> +       int target_state = genpd->target_state;
>         ktime_t time_start;
>         s64 elapsed_ns;
>         int ret;
>
> -       if (!genpd->power_on)
> +       if (!genpd->states[target_state].power_on)
>                 return 0;
>
>         time_start = ktime_get();
> -       ret = genpd->power_on(genpd);
> +       ret = genpd->states[target_state].power_on(genpd);
>         if (ret)
>                 return ret;
>
>         elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
> -       if (elapsed_ns <= genpd->power_on_latency_ns)
> +       if (elapsed_ns <= genpd->states[target_state].power_on_latency_ns)
>                 return ret;
>
> -       genpd->power_on_latency_ns = elapsed_ns;
> +       genpd->states[target_state].power_on_latency_ns = elapsed_ns;
>         genpd->max_off_time_changed = true;
>         genpd_recalc_cpu_exit_latency(genpd);
>         pr_warn("%s: Power-%s latency exceeded, new value %lld ns\n",
> @@ -181,23 +213,24 @@ static int genpd_power_on(struct generic_pm_domain *genpd)
>
>  static int genpd_power_off(struct generic_pm_domain *genpd)
>  {
> +       int target_state = genpd->target_state;
>         ktime_t time_start;
>         s64 elapsed_ns;
>         int ret;
>
> -       if (!genpd->power_off)
> +       if (!genpd->states[target_state].power_off)
>                 return 0;
>
>         time_start = ktime_get();
> -       ret = genpd->power_off(genpd);
> +       ret = genpd->states[target_state].power_off(genpd);
>         if (ret == -EBUSY)
>                 return ret;
>
>         elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
> -       if (elapsed_ns <= genpd->power_off_latency_ns)
> +       if (elapsed_ns <= genpd->states[target_state].power_off_latency_ns)
>                 return ret;
>
> -       genpd->power_off_latency_ns = elapsed_ns;
> +       genpd->states[target_state].power_off_latency_ns = elapsed_ns;
>         genpd->max_off_time_changed = true;
>         pr_warn("%s: Power-%s latency exceeded, new value %lld ns\n",
>                 genpd->name, "off", elapsed_ns);
> @@ -326,15 +359,17 @@ static int genpd_start_dev_no_timing(struct generic_pm_domain *genpd,
>
>  static int genpd_save_dev(struct generic_pm_domain *genpd, struct device *dev)
>  {
> -       return GENPD_DEV_TIMED_CALLBACK(genpd, int, save_state, dev,
> -                                       save_state_latency_ns, "state save");
> +       return GENPD_DEV_TIMED_CALLBACK_STATE(genpd, int, save_state, dev,
> +                                       save_state_latency_ns, "state save",
> +                                       genpd->target_state);
>  }
>
>  static int genpd_restore_dev(struct generic_pm_domain *genpd, struct device *dev)
>  {
> -       return GENPD_DEV_TIMED_CALLBACK(genpd, int, restore_state, dev,
> +       return GENPD_DEV_TIMED_CALLBACK_STATE(genpd, int, restore_state, dev,
>                                         restore_state_latency_ns,
> -                                       "state restore");
> +                                       "state restore",
> +                                       genpd->target_state);
>  }
>
>  static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
> @@ -486,6 +521,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
>         struct pm_domain_data *pdd;
>         struct gpd_link *link;
>         unsigned int not_suspended;
> +       int target_state;
>         int ret = 0;
>
>   start:
> @@ -538,6 +574,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
>
>         genpd->status = GPD_STATE_BUSY;
>         genpd->poweroff_task = current;
> +       target_state = genpd->target_state;
>
>         list_for_each_entry_reverse(pdd, &genpd->dev_list, list_node) {
>                 ret = atomic_read(&genpd->sd_count) == 0 ?
> @@ -572,7 +609,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
>                 goto out;
>         }
>
> -       if (genpd->power_off) {
> +       if (genpd->states[target_state].power_off) {
>                 if (atomic_read(&genpd->sd_count) > 0) {
>                         ret = -EBUSY;
>                         goto out;
> @@ -1809,7 +1846,7 @@ int pm_genpd_name_detach_cpuidle(const char *name)
>   * pm_genpd_default_save_state - Default "save device state" for PM domains.
>   * @dev: Device to handle.
>   */
> -static int pm_genpd_default_save_state(struct device *dev)
> +static int pm_genpd_default_save_state(struct device *dev, int state)

Why change this?

>  {
>         int (*cb)(struct device *__dev);
>
> @@ -1832,7 +1869,7 @@ static int pm_genpd_default_save_state(struct device *dev)
>   * pm_genpd_default_restore_state - Default PM domains "restore device state".
>   * @dev: Device to handle.
>   */
> -static int pm_genpd_default_restore_state(struct device *dev)
> +static int pm_genpd_default_restore_state(struct device *dev, int state)

Why change this?

>  {
>         int (*cb)(struct device *__dev);
>
> @@ -1877,6 +1914,8 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>         genpd->resume_count = 0;
>         genpd->device_count = 0;
>         genpd->max_off_time_ns = -1;
> +       /* on init assume we are coming from the deepest state */
> +       genpd->target_state = genpd->state_count - 1;

Couldn't we have the SoC specific genpd driver configure this instead?
That would make it more flexible.

>         genpd->max_off_time_changed = true;
>         genpd->domain.ops.runtime_suspend = pm_genpd_runtime_suspend;
>         genpd->domain.ops.runtime_resume = pm_genpd_runtime_resume;
> @@ -2249,12 +2288,13 @@ static int pm_genpd_summary_one(struct seq_file *s,
>                 [GPD_STATE_WAIT_MASTER] = "wait-master",
>                 [GPD_STATE_BUSY] = "busy",
>                 [GPD_STATE_REPEAT] = "off-in-progress",
> -               [GPD_STATE_POWER_OFF] = "off"
> +               [GPD_STATE_POWER_OFF] = "off:"
>         };
>         struct pm_domain_data *pm_data;
>         const char *kobj_path;
>         struct gpd_link *link;
>         int ret;
> +       int target_state = genpd->target_state;
>
>         ret = mutex_lock_interruptible(&genpd->lock);
>         if (ret)
> @@ -2262,7 +2302,11 @@ static int pm_genpd_summary_one(struct seq_file *s,
>
>         if (WARN_ON(genpd->status >= ARRAY_SIZE(status_lookup)))
>                 goto exit;
> -       seq_printf(s, "%-30s  %-15s  ", genpd->name, status_lookup[genpd->status]);
> +
> +       seq_printf(s, "%-30s  %s%-15s  ", genpd->name,
> +               status_lookup[genpd->status],
> +               (genpd->status == GPD_STATE_POWER_OFF) ?
> +                       genpd->states[target_state].name : "");
>
>         /*
>          * Modifications on the list require holding locks on both
> diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> index 2a4154a..deaaa76 100644
> --- a/drivers/base/power/domain_governor.c
> +++ b/drivers/base/power/domain_governor.c
> @@ -100,10 +100,12 @@ static bool default_stop_ok(struct device *dev)
>  static bool default_power_down_ok(struct dev_pm_domain *pd)
>  {
>         struct generic_pm_domain *genpd = pd_to_genpd(pd);
> +       struct generic_pm_domain_data *gpd_data;
>         struct gpd_link *link;
>         struct pm_domain_data *pdd;
>         s64 min_off_time_ns;
>         s64 off_on_time_ns;
> +       int state = 0;
>
>         if (genpd->max_off_time_changed) {
>                 struct gpd_link *link;
> @@ -124,8 +126,8 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
>                 return genpd->cached_power_down_ok;
>         }
>
> -       off_on_time_ns = genpd->power_off_latency_ns +
> -                               genpd->power_on_latency_ns;
> +       off_on_time_ns = genpd->states[state].power_off_latency_ns +
> +                       genpd->states[state].power_on_latency_ns;
>         /*
>          * It doesn't make sense to remove power from the domain if saving
>          * the state of all devices in it and the power off/power on operations
> @@ -134,9 +136,10 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
>          * All devices in this domain have been stopped already at this point.
>          */
>         list_for_each_entry(pdd, &genpd->dev_list, list_node) {
> +               gpd_data = to_gpd_data(pdd);
>                 if (pdd->dev->driver)
>                         off_on_time_ns +=
> -                               to_gpd_data(pdd)->td.save_state_latency_ns;
> +                               gpd_data->td.save_state_latency_ns[state];
>         }
>
>         min_off_time_ns = -1;
> @@ -193,7 +196,7 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
>                  * constraint_ns cannot be negative here, because the device has
>                  * been suspended.
>                  */
> -               constraint_ns -= td->restore_state_latency_ns;
> +               constraint_ns -= td->restore_state_latency_ns[state];
>                 if (constraint_ns <= off_on_time_ns)
>                         return false;
>
> @@ -216,7 +219,8 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
>          * time and the time needed to turn the domain on is the maximum
>          * theoretical time this domain can spend in the "off" state.
>          */
> -       genpd->max_off_time_ns = min_off_time_ns - genpd->power_on_latency_ns;
> +       genpd->max_off_time_ns = min_off_time_ns -
> +                       genpd->states[state].power_on_latency_ns;
>         return true;
>  }
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 3082247..d57ea37 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -17,6 +17,8 @@
>  #include <linux/notifier.h>
>  #include <linux/cpuidle.h>
>
> +#define GENPD_MAX_NSTATES 10
> +
>  /* Defines used for the flags field in the struct generic_pm_domain */
>  #define GENPD_FLAG_PM_CLK      (1U << 0) /* PM domain uses PM clk */
>
> @@ -36,8 +38,8 @@ struct dev_power_governor {
>  struct gpd_dev_ops {
>         int (*start)(struct device *dev);
>         int (*stop)(struct device *dev);
> -       int (*save_state)(struct device *dev);
> -       int (*restore_state)(struct device *dev);
> +       int (*save_state)(struct device *dev, int state);
> +       int (*restore_state)(struct device *dev, int state);

I don't see why these changes are needed, but that's maybe because I
don't get the big picture, yet, :-)

>         bool (*active_wakeup)(struct device *dev);
>  };
>
> @@ -46,6 +48,16 @@ struct gpd_cpuidle_data {
>         struct cpuidle_state *idle_state;
>  };
>
> +struct generic_pm_domain;
> +
> +struct genpd_power_state {
> +       char *name;
> +       s64 power_off_latency_ns;
> +       s64 power_on_latency_ns;
> +       int (*power_off)(struct generic_pm_domain *domain);
> +       int (*power_on)(struct generic_pm_domain *domain);
> +};
> +
>  struct generic_pm_domain {
>         struct dev_pm_domain domain;    /* PM domain operations */
>         struct list_head gpd_list_node; /* Node in the global PM domains list */
> @@ -66,10 +78,6 @@ struct generic_pm_domain {
>         unsigned int suspended_count;   /* System suspend device counter */
>         unsigned int prepared_count;    /* Suspend counter of prepared devices */
>         bool suspend_power_off; /* Power status before system suspend */
> -       int (*power_off)(struct generic_pm_domain *domain);
> -       s64 power_off_latency_ns;
> -       int (*power_on)(struct generic_pm_domain *domain);
> -       s64 power_on_latency_ns;

This will break compilation for some SoC using genpd.

>         struct gpd_dev_ops dev_ops;
>         s64 max_off_time_ns;    /* Maximum allowed "suspended" time. */
>         bool max_off_time_changed;
> @@ -80,6 +88,9 @@ struct generic_pm_domain {
>         void (*detach_dev)(struct generic_pm_domain *domain,
>                            struct device *dev);
>         unsigned int flags;             /* Bit field of configs for genpd */
> +       int target_state; /* state that genpd will go to when off */
> +       struct genpd_power_state states[GENPD_MAX_NSTATES];
> +       int state_count; /* number of states*/
>  };
>
>  static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
> @@ -97,8 +108,8 @@ struct gpd_link {
>  struct gpd_timing_data {
>         s64 stop_latency_ns;
>         s64 start_latency_ns;
> -       s64 save_state_latency_ns;
> -       s64 restore_state_latency_ns;
> +       s64 save_state_latency_ns[GENPD_MAX_NSTATES];
> +       s64 restore_state_latency_ns[GENPD_MAX_NSTATES];

This will break compilation for some SoC using genpd.

>         s64 effective_constraint_ns;
>         bool constraint_changed;
>         bool cached_stop_ok;
> --

Kind regards
Uffe
