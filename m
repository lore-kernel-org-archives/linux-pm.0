From: Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH 1/2] [RFC] PM / Domains: add multiple states
Date: Mon, 13 Apr 2015 12:34:21 +0200
Message-ID: <552B9BAD.9050809@baylibre.com>
References: <1428507725-12205-1-git-send-email-ahaslam@baylibre.com>	<1428507725-12205-2-git-send-email-ahaslam@baylibre.com> <CAPDyKFoSvY=G7PQ5EnacTDfmuxYw398A0h_TV--6E9exXJv-cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35812 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbbDMKeZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2015 06:34:25 -0400
Received: by widdi4 with SMTP id di4so66522201wid.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2015 03:34:24 -0700 (PDT)
In-Reply-To: <CAPDyKFoSvY=G7PQ5EnacTDfmuxYw398A0h_TV--6E9exXJv-cg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>

Hi Uffe,


On 10/04/2015 12:24, Ulf Hansson wrote:
> On 8 April 2015 at 17:42,  <ahaslam@baylibre.com> wrote:
>> From: Axel Haslam <ahaslam@baylibre.com>

>>
>>          .state_count = 3,
>>          .dev_ops.start = dev_callback_start,
>>          .dev_ops.stop = dev_callback_stop,
>
> I would like to get the complete picture.
>
> Could you elaborate on what theese two callbacks will be doing in your case?

The idea is to add support to platforms where a power domain can be put 
into intermediate low power modes (retention), and not just on or off. 
context may be lost for only a subset of registers depending on how deep 
the retantion state is. Also the wakeup/sleep latency
would differ. a  device constraint may not allow for a domain to go to 
off, but it may allow a Retention state.

I tested the patch using a dummy driver that would register several 
devices, and genpds, some of them would be subdomains, so that i could 
test if the most restrictive constraint on a genpd was respected.
in my case these callbacks are not doing anything.


>
>>          .dev_ops.save_state = dev_callback_save,
>>          .dev_ops.restore_state = dev_callback_restore,
>
> ...and some more information about these as well, please.

im not sure i understood these functions correctly.

my thought is that the arch would implement these functions to
save/restore the registers it needs for a given power domain.
i added an extra argument to save and restore so the implementation
would use this information to decide what is needed to save and restore.

again these were on my dummy driver, so they are not
doing anything, in my case.


>>   })
>> +#define GENPD_DEV_CALLBACK_STATE(genpd, type, callback, dev, state)    \
>> +({                                                                     \
>> +       type (*__routine)(struct device *__d, int __s);                 \
>> +       type __ret = (type)0;                                           \
>> +                                                                       \
>> +       __routine = genpd->dev_ops.callback;                            \
>> +       if (__routine) {                                                \
>> +               __ret = __routine(dev, state);                          \
>> +       }                                                               \
>> +       __ret;                                                          \
>> +})
>> +
>> +#define GENPD_DEV_TIMED_CALLBACK_STATE(genpd, type, callback, dev,     \
>> +                                       field, name, state)             \
>> +({                                                                     \
>> +       ktime_t __start = ktime_get();                                  \
>> +       type __retval = GENPD_DEV_CALLBACK_STATE(genpd, type, callback, \
>> +                                                dev, state);           \
>> +       s64 __elapsed = ktime_to_ns(ktime_sub(ktime_get(), __start));   \
>> +       struct gpd_timing_data *__td = &dev_gpd_data(dev)->td;          \
>> +       if (!__retval && __elapsed > __td->field[state]) {              \
>> +               __td->field[state] = __elapsed;                         \
>> +               dev_dbg(dev, name                                       \
>> +               "State %d latency exceeded, new value %lld ns\n",       \
>> +                       state, __elapsed);                              \
>> +               genpd->max_off_time_changed = true;                     \
>> +               __td->constraint_changed = true;                        \
>> +       }                                                               \
>> +       __retval;                                                       \
>> +})
>
> In general I would like to move away from using such macros, since I
> think it becomes less readable code.
> I know we have them already, but that is to me not a good reason for
> adding yet another pair.
>
> Should we try to find a better way?

how about replacing them with something like:

+static int genpd_dev_timed_callback(struct generic_pm_domain *genpd,
+               struct device *dev,
+               int fn(struct device *),
+               s64 *time,
+               char* name)
+{
+       struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
+       ktime_t start = ktime_get();
+       s64 elapsed;
+       int retval;
+
+       retval = fn(dev);
+
+       elapsed = ktime_to_ns(ktime_sub(ktime_get(), start));
+       if (!retval && elapsed > *time) {
+               *time = elapsed;
+               td->constraint_changed = true;
+               genpd->max_off_time_changed = true;
+               dev_dbg(dev,
+                       "%s Latency exceeded, new value %lld ns\n",
+                       name, elapsed);
+
+       }
+
+       return retval;
+}

  static int genpd_stop_dev(struct generic_pm_domain *genpd, struct 
device *dev)
  {
-       return GENPD_DEV_TIMED_CALLBACK(genpd, int, stop, dev,
-                                       stop_latency_ns, "stop");
-}

+       struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
+       return genpd_dev_timed_callback(genpd, dev, genpd->dev_ops.stop,
+                       &td->stop_latency_ns, "stop");
+}



or we could also just expand them in the 4 places they
are used (save/restore, start/stop). for example:

  static int genpd_stop_dev(struct generic_pm_domain *genpd, struct 
device *dev)
  {
-       return GENPD_DEV_TIMED_CALLBACK(genpd, int, stop, dev,
-                                       stop_latency_ns, "stop");
+       struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
+       ktime_t start = ktime_get();
+       s64 elapsed;
+       int retval;
+
+       retval = genpd->dev_ops.stop(dev);
+       elapsed = ktime_to_ns(ktime_sub(ktime_get(), start));
+       if (!retval && elapsed > td->stop_latency_ns) {
+               td->stop_latency_ns = elapsed;
+               td->constraint_changed = true;
+               genpd->max_off_time_changed = true;
+               dev_dbg(dev,
+                       "Stop latency exceeded, new value %lld ns\n",
+                       elapsed);
+       }
+       return retval;
  }





fault "save device state" for PM domains.
>>    * @dev: Device to handle.
>>    */
>> -static int pm_genpd_default_save_state(struct device *dev)
>> +static int pm_genpd_default_save_state(struct device *dev, int state)
>
> Why change this?
>
>>   {
>>          int (*cb)(struct device *__dev);
>>
>> @@ -1832,7 +1869,7 @@ static int pm_genpd_default_save_state(struct device *dev)
>>    * pm_genpd_default_restore_state - Default PM domains "restore device state".
>>    * @dev: Device to handle.
>>    */
>> -static int pm_genpd_default_restore_state(struct device *dev)
>> +static int pm_genpd_default_restore_state(struct device *dev, int state)
>
> Why change this?


so that the driver can save or not context depending on what state is 
beeing entered. also, there may be a subset of registers to save. but 
again, im not sure this was the intended purpose of these functions.
i could not find examples of someone that uses them.

>
>>   {
>>          int (*cb)(struct device *__dev);
>>
>> @@ -1877,6 +1914,8 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>>          genpd->resume_count = 0;
>>          genpd->device_count = 0;
>>          genpd->max_off_time_ns = -1;
>> +       /* on init assume we are coming from the deepest state */
>> +       genpd->target_state = genpd->state_count - 1;
>
> Couldn't we have the SoC specific genpd driver configure this instead?
> That would make it more flexible.
>

it could be an extra argument to the init function
or i can add and "initial_state" field to the generic_pm_domain
struct.


>>   struct generic_pm_domain {
>>          struct dev_pm_domain domain;    /* PM domain operations */
>>          struct list_head gpd_list_node; /* Node in the global PM domains list */
>> @@ -66,10 +78,6 @@ struct generic_pm_domain {
>>          unsigned int suspended_count;   /* System suspend device counter */
>>          unsigned int prepared_count;    /* Suspend counter of prepared devices */
>>          bool suspend_power_off; /* Power status before system suspend */
>> -       int (*power_off)(struct generic_pm_domain *domain);
>> -       s64 power_off_latency_ns;
>> -       int (*power_on)(struct generic_pm_domain *domain);
>> -       s64 power_on_latency_ns;
>
> This will break compilation for some SoC using genpd.

yes, i posted the patch as rfc to validate the concepts behind it,
the full series would have to include the changes to the drivers that
are using these structures, i can do such changes on the next version.

>
>>          struct gpd_dev_ops dev_ops;
>>          s64 max_off_time_ns;    /* Maximum allowed "suspended" time. */
>>          bool max_off_time_changed;
>> @@ -80,6 +88,9 @@ struct generic_pm_domain {
>>          void (*detach_dev)(struct generic_pm_domain *domain,
>>                             struct device *dev);
>>          unsigned int flags;             /* Bit field of configs for genpd */
>> +       int target_state; /* state that genpd will go to when off */
>> +       struct genpd_power_state states[GENPD_MAX_NSTATES];
>> +       int state_count; /* number of states*/
>>   };
>>
>>   static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
>> @@ -97,8 +108,8 @@ struct gpd_link {
>>   struct gpd_timing_data {
>>          s64 stop_latency_ns;
>>          s64 start_latency_ns;
>> -       s64 save_state_latency_ns;
>> -       s64 restore_state_latency_ns;
>> +       s64 save_state_latency_ns[GENPD_MAX_NSTATES];
>> +       s64 restore_state_latency_ns[GENPD_MAX_NSTATES];
>
> This will break compilation for some SoC using genpd.
>
>>          s64 effective_constraint_ns;
>>          bool constraint_changed;
>>          bool cached_stop_ok;
>> --
>
> Kind regards
> Uffe
>
