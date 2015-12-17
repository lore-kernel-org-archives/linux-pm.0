From: Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH RFC 01/27] PM / Domains: core changes for multiple states
Date: Thu, 17 Dec 2015 18:58:40 +0100
Message-ID: <CAKXjFTOMwMBq7Md6BFLuGnq4yQTZOyv4QVA6Cw7MWrkH0PvYDg@mail.gmail.com>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
	<1447799871-56374-2-git-send-email-lina.iyer@linaro.org>
	<CAPDyKFoBkKdBpuA6_EMtQNc-n0HxVAFpULrxgpnU5eXtcuS6og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:36707 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426AbbLQR6m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Dec 2015 12:58:42 -0500
Received: by mail-ob0-f175.google.com with SMTP id no2so62385750obc.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Dec 2015 09:58:41 -0800 (PST)
In-Reply-To: <CAPDyKFoBkKdBpuA6_EMtQNc-n0HxVAFpULrxgpnU5eXtcuS6og@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Lina Iyer <lina.iyer@linaro.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Marc Titinger <mtitinger@baylibre.com>, Axel Haslam <ahaslam+renesas@baylibre.com>

On Wed, Dec 9, 2015 at 2:58 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 17 November 2015 at 23:37, Lina Iyer <lina.iyer@linaro.org> wrote:
>> From: Axel Haslam <ahaslam+renesas@baylibre.com>
>>
>> From: Axel Haslam <ahaslam@baylibre.com>
>>
>> Add the core changes to be able to declare multiple states.
>> When trying to set a power domain to off, genpd will be able to choose
>> from an array of states declared by the platform. The power on and off
>> latencies are now tied to a state.
>
> I would like to get an answer to *why* we need this.
>
> For example, we should mention that some HWs supports these multiple
> states - at least.
>
>>
>> States should be declared in ascending order from shallowest to deepest,
>
> I guess *should* isn't good enough. Perhaps *shall* is better?
>
>> deepest meaning the state which takes longer to enter and exit.
>>
>> the power_off and power_on function can use the 'state_idx' field of the
>> generic_pm_domain structure, to distinguish between the different states
>> and act accordingly.
>
> This needs some more explanation.
>
> First, please use the wording of "callbacks", like ->power_on() to
> better describe what function you are talking about.
> Second, what is "state_idx"? What's does it really tell the SOC PM
> domain driver here?
>
>>
>> Example:
>>
>> static int pd1_power_on(struct generic_pm_domain *domain)
>> {
>>         /* domain->state_idx = state the domain is coming from */
>> }
>>
>> static int pd1_power_off(struct generic_pm_domain *domain)
>> {
>>         /* domain->state_idx = desired powered off state */
>> }
>>
>> const struct genpd_power_state pd_states[] = {
>>         {
>>                 .name = "RET",
>>                 .power_on_latency_ns = ON_LATENCY_FAST,
>>                 .power_off_latency_ns = OFF_LATENCY_FAST,
>>         },
>>         {
>>                 .name = "DEEP_RET",
>>                 .power_on_latency_ns = ON_LATENCY_MED,
>>                 .power_off_latency_ns = OFF_LATENCY_MED,
>>         },
>>         {
>>                 .name = "OFF",
>>                 .power_on_latency_ns = ON_LATENCY_SLOW,
>>                 .power_off_latency_ns = OFF_LATENCY_SLOW,
>>         }
>> };
>>
>> struct generic_pm_domain pd1 = {
>>         .name = "PD1",
>>         .power_on = pd1_power_on,
>>         .power_off = pd1_power_off,
>>         [...]
>> };
>>
>> int xxx_init_pm_domain(){
>>
>>         pd1->state = copy_of(pd_states);
>>         pd1->state_count = ARRAY_SIZE(pd_states);
>>         pm_genpd_init(pd1, true);
>>
>> }
>
> Well, even if the above describes this quite good, I think it better
> belongs in the Documentation rather than in the change log.
>
> Can we try to the improve the text in the change-log instead?
>
>>
>> Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> [Lina: Modified genpd state initialization and remove use of
>> save_state_latency_ns in genpd timing data]
>>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
>>  drivers/base/power/domain.c          | 136 +++++++++++++++++++++++++++++++++--
>>  drivers/base/power/domain_governor.c |  13 +++-
>>  include/linux/pm_domain.h            |  10 +++
>>  3 files changed, 151 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index e03b1ad..3242854 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -34,6 +34,12 @@
>>         __ret;                                                  \
>>  })
>>
>> +#define GENPD_MAX_NAME_SIZE 20
>> +
>> +static int pm_genpd_alloc_states_names(struct generic_pm_domain *genpd,
>
> Please avoid forward declarations.
>
> Also, we have just got rid of all *name* based genpd API/functions. I
> don't want us to start adding another.
>
> Or perhaps it's just the name of the function that I don't like!? :-)
>
>> +                                      const struct genpd_power_state *st,
>> +                                      unsigned int st_count);
>> +
>>  static LIST_HEAD(gpd_list);
>>  static DEFINE_MUTEX(gpd_list_lock);
>>
>> @@ -102,6 +108,7 @@ static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
>>
>>  static int genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>>  {
>> +       unsigned int state_idx = genpd->state_idx;
>>         ktime_t time_start;
>>         s64 elapsed_ns;
>>         int ret;
>> @@ -118,10 +125,10 @@ static int genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>>                 return ret;
>>
>>         elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
>> -       if (elapsed_ns <= genpd->power_on_latency_ns)
>> +       if (elapsed_ns <= genpd->states[state_idx].power_on_latency_ns)
>>                 return ret;
>>
>> -       genpd->power_on_latency_ns = elapsed_ns;
>> +       genpd->states[state_idx].power_on_latency_ns = elapsed_ns;
>>         genpd->max_off_time_changed = true;
>>         pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
>>                  genpd->name, "on", elapsed_ns);
>> @@ -131,6 +138,7 @@ static int genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>>
>>  static int genpd_power_off(struct generic_pm_domain *genpd, bool timed)
>>  {
>> +       unsigned int state_idx = genpd->state_idx;
>>         ktime_t time_start;
>>         s64 elapsed_ns;
>>         int ret;
>> @@ -147,10 +155,10 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool timed)
>>                 return ret;
>>
>>         elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
>> -       if (elapsed_ns <= genpd->power_off_latency_ns)
>> +       if (elapsed_ns <= genpd->states[state_idx].power_off_latency_ns)
>>                 return ret;
>>
>> -       genpd->power_off_latency_ns = elapsed_ns;
>> +       genpd->states[state_idx].power_off_latency_ns = elapsed_ns;
>>         genpd->max_off_time_changed = true;
>>         pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
>>                  genpd->name, "off", elapsed_ns);
>> @@ -582,6 +590,8 @@ static void pm_genpd_sync_poweroff(struct generic_pm_domain *genpd,
>>             || atomic_read(&genpd->sd_count) > 0)
>>                 return;
>>
>> +       /* Choose the deepest state when suspending */
>> +       genpd->state_idx = genpd->state_count - 1;
>>         genpd_power_off(genpd, timed);
>>
>>         genpd->status = GPD_STATE_POWER_OFF;
>> @@ -1205,6 +1215,61 @@ static void genpd_free_dev_data(struct device *dev,
>>         dev_pm_put_subsys_data(dev);
>>  }
>>
>> +static int genpd_alloc_states_data(struct generic_pm_domain *genpd,
>
> In this patch I would rather just add *one* new "alloc" function and
> name it like below.
>
> static int genpd_alloc_default_state(struct generic_pm_domain *genpd)
>
> I assume the name I suggest for it, indicates what it needs to do and
> *not* needs to do.

Hi Ulf,

Thanks for your thorough review!
i will implement your suggestions for the next spin,

However I have a doubt about this comment, do you mean that i should get rid of
genpd_alloc_states_data completly? i had a static number of states before
but that was droped because o wasted memory if no states were needed.

if you just meant that it should be added in a separate patch, since i
will be sqashing
this patch with "PM / Domains: make governor select deepest state"   can
i keep it here? maybe it should  go with the dt parsing patch from Marc?

Regards
Axel


>
>> +                                  const struct genpd_power_state *st,
>> +                                  unsigned int st_count)
>> +{
>> +       int ret = 0;
>> +       unsigned int i;
>> +
>> +       if (IS_ERR_OR_NULL(genpd)) {
>> +               ret = -EINVAL;
>> +               goto err;
>> +       }
>> +
>> +       if (!st || (st_count < 1)) {
>> +               ret = -EINVAL;
>> +               goto err;
>> +       }
>> +
>> +       /* Allocate the local memory to keep the states for this genpd */
>> +       genpd->states = kcalloc(st_count, sizeof(*st), GFP_KERNEL);
>> +       if (!genpd->states) {
>> +               ret = -ENOMEM;
>> +               goto err;
>> +       }
>> +
>> +       for (i = 0; i < st_count; i++) {
>> +               genpd->states[i].power_on_latency_ns =
>> +                       st[i].power_on_latency_ns;
>> +               genpd->states[i].power_off_latency_ns =
>> +                       st[i].power_off_latency_ns;
>> +       }
>> +
>> +       /*
>> +        * Copy the latency values To keep compatibility with
>> +        * platforms that are not converted to use the multiple states.
>> +        * This will be removed once all platforms are converted to use
>> +        * multiple states. note that non converted platforms will use the
>> +        * default single off state.
>> +        */
>> +       if (genpd->power_on_latency_ns != 0)
>> +               genpd->states[0].power_on_latency_ns =
>> +                               genpd->power_on_latency_ns;
>> +
>> +       if (genpd->power_off_latency_ns != 0)
>> +               genpd->states[0].power_off_latency_ns =
>> +                               genpd->power_off_latency_ns;
>> +
>> +       genpd->state_count = st_count;
>> +
>> +       /* to save memory, Name allocation will happen if debug is enabled */
>
> Urgh. :-)
>
> I instead suggest we skip the entire "name" attribute" and just use
> the state_idx to provide the same information.
>
> For sure at this point, this information won't be interpreted by
> "anybody". Reading an integer value instead of string, shouldn't be
> that difficult to understand.
>
> Future wise, if we see that it could be beneficial to add the "name"
> attribute, we can do that then.
>
> Removing the name attribute will also simplify this patch, quite much.
> Can you please do that.
>
>> +       pm_genpd_alloc_states_names(genpd, st, st_count);
>> +
>> +err:
>> +       return ret;
>> +}
>> +
>>  /**
>>   * __pm_genpd_add_device - Add a device to an I/O PM domain.
>>   * @genpd: PM domain to add the device to.
>> @@ -1459,6 +1524,15 @@ static int pm_genpd_default_restore_state(struct device *dev)
>>  void pm_genpd_init(struct generic_pm_domain *genpd,
>>                    struct dev_power_governor *gov, bool is_off)
>>  {
>> +       int ret;
>> +       static const struct genpd_power_state genpd_default_off[] = {
>> +               {
>> +                       .name = "OFF",
>> +                       .power_off_latency_ns = 0,
>> +                       .power_on_latency_ns = 0,
>> +               },
>> +       };
>
> I suggest you remove this and instead handle that within
> genpd_alloc_default_state().
>
>> +
>>         if (IS_ERR_OR_NULL(genpd))
>>                 return;
>>
>> @@ -1503,6 +1577,19 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>>                 genpd->dev_ops.start = pm_clk_resume;
>>         }
>>
>> +       /*
>> +        * Allocate the default state if genpd states
>> +        * are not already defined.
>> +        */
>> +       if (!genpd->state_count) {
>> +               ret = genpd_alloc_states_data(genpd, genpd_default_off, 1);
>
> Call the new "genpd_alloc_default_state()" instead.
>
>> +               if (ret)
>> +                       return;
>> +       }
>> +
>> +       /* Assume the deepest state on init*/
>> +       genpd->state_idx = genpd->state_count - 1;
>
> When the PM domain is powered on, in other words the genpd->status ==
> GPD_STATE_ACTIVE, I guess this value doesn't matter much.
>
> Although, what if the PM domain is powered off, don't you need to
> respect the value that might have been assigned by the SoC PM domain
> driver? Else you may at the next power on, indicate that you are
> coming from a state that's not the correct one.
>
> Perhaps, you should only set genpd->state_idx = 0, from
> genpd_alloc_default_state() and in the other case leave the value as
> is?
>
>> +
>>         mutex_lock(&gpd_list_lock);
>>         list_add(&genpd->gpd_list_node, &gpd_list);
>>         mutex_unlock(&gpd_list_lock);
>> @@ -1822,6 +1909,33 @@ EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
>>  #include <linux/kobject.h>
>>  static struct dentry *pm_genpd_debugfs_dir;
>>
>> +static int pm_genpd_alloc_states_names(struct generic_pm_domain *genpd,
>> +                                      const struct genpd_power_state *st,
>> +                                      unsigned int st_count)
>> +{
>> +       unsigned int i;
>> +
>> +       if (IS_ERR_OR_NULL(genpd))
>> +               return -EINVAL;
>> +
>> +       if (genpd->state_count != st_count) {
>> +               pr_err("Invalid allocated state count\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       for (i = 0; i < st_count; i++) {
>> +               genpd->states[i].name = kstrndup(st[i].name,
>> +                               GENPD_MAX_NAME_SIZE, GFP_KERNEL);
>> +               if (!genpd->states[i].name) {
>> +                       pr_err("%s Failed to allocate state %d name.\n",
>> +                               genpd->name, i);
>> +                       return -ENOMEM;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>  /*
>>   * TODO: This function is a slightly modified version of rtpm_status_show
>>   * from sysfs.c, so generalize it.
>> @@ -1855,6 +1969,7 @@ static int pm_genpd_summary_one(struct seq_file *s,
>>                 [GPD_STATE_ACTIVE] = "on",
>>                 [GPD_STATE_POWER_OFF] = "off"
>>         };
>> +       unsigned int state_idx = genpd->state_idx;
>>         struct pm_domain_data *pm_data;
>>         const char *kobj_path;
>>         struct gpd_link *link;
>> @@ -1866,7 +1981,11 @@ static int pm_genpd_summary_one(struct seq_file *s,
>>
>>         if (WARN_ON(genpd->status >= ARRAY_SIZE(status_lookup)))
>>                 goto exit;
>> -       seq_printf(s, "%-30s  %-15s ", genpd->name, status_lookup[genpd->status]);
>> +
>> +       seq_printf(s, "%-30s  %-15s  ", genpd->name,
>> +                  (genpd->status == GPD_STATE_POWER_OFF) ?
>> +                  genpd->states[state_idx].name :
>> +                  status_lookup[genpd->status]);
>>
>>         /*
>>          * Modifications on the list require holding locks on both
>> @@ -1954,4 +2073,11 @@ static void __exit pm_genpd_debug_exit(void)
>>         debugfs_remove_recursive(pm_genpd_debugfs_dir);
>>  }
>>  __exitcall(pm_genpd_debug_exit);
>> +#else
>> +static inline int pm_genpd_alloc_states_names(struct generic_pm_domain *genpd,
>> +                                       const struct genpd_power_state *st,
>> +                                       unsigned int st_count)
>> +{
>> +       return 0;
>> +}
>>  #endif /* CONFIG_PM_ADVANCED_DEBUG */
>> diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
>> index e60dd12..b4984f5 100644
>> --- a/drivers/base/power/domain_governor.c
>> +++ b/drivers/base/power/domain_governor.c
>> @@ -125,8 +125,12 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
>>                 return genpd->cached_power_down_ok;
>>         }
>>
>> -       off_on_time_ns = genpd->power_off_latency_ns +
>> -                               genpd->power_on_latency_ns;
>> +       /*
>> +        * Use the only available state, until multiple state support is added
>> +        * to the governor.
>> +        */
>
> So you want to delay this step into a later patch. I am fine with
> that, but you need to state that in the change-log.
>
> Perhaps it's better to say that we will always try with the
> shallowest/deepest off state, and just ignore the other states in this
> phase?
>
>> +       off_on_time_ns = genpd->states[0].power_off_latency_ns +
>> +                               genpd->states[0].power_on_latency_ns;
>
> If you think my above idea seems reasonable, that should change the above to:
>
> off_on_time_ns = genpd->states[genpd->state_count - 1].power_off_latency_ns +
>      genpd->states[genpd->state_count - 1].power_on_latency_ns;
>
>>
>>         min_off_time_ns = -1;
>>         /*
>> @@ -203,8 +207,11 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
>>          * The difference between the computed minimum subdomain or device off
>>          * time and the time needed to turn the domain on is the maximum
>>          * theoretical time this domain can spend in the "off" state.
>> +        * Use the only available state, until multiple state support is added
>> +        * to the governor.
>>          */
>> -       genpd->max_off_time_ns = min_off_time_ns - genpd->power_on_latency_ns;
>> +       genpd->max_off_time_ns = min_off_time_ns -
>> +               genpd->states[0].power_on_latency_ns;
>
> Ditto.
>
>>         return true;
>>  }
>>
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index ba4ced3..11763cf 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -37,6 +37,12 @@ struct gpd_dev_ops {
>>         bool (*active_wakeup)(struct device *dev);
>>  };
>>
>> +struct genpd_power_state {
>> +       char *name;
>
> As stated, suggest to remove "name".
>
>> +       s64 power_off_latency_ns;
>> +       s64 power_on_latency_ns;
>> +};
>> +
>>  struct generic_pm_domain {
>>         struct dev_pm_domain domain;    /* PM domain operations */
>>         struct list_head gpd_list_node; /* Node in the global PM domains list */
>> @@ -66,6 +72,10 @@ struct generic_pm_domain {
>>         void (*detach_dev)(struct generic_pm_domain *domain,
>>                            struct device *dev);
>>         unsigned int flags;             /* Bit field of configs for genpd */
>> +       struct genpd_power_state *states;
>> +       unsigned int state_count; /* number of states */
>> +       unsigned int state_idx; /* state that genpd will go to when off */
>> +
>>  };
>>
>>  static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
>> --
>> 2.1.4
>>
>
> Kind regards
> Uffe
