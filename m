From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/5] clk: add support for runtime pm
Date: Tue, 13 Sep 2016 15:13:30 +0200
Message-ID: <76bb5b71-dd4e-e1ad-df0b-b84833812502@samsung.com>
References: <1472737551-15272-1-git-send-email-m.szyprowski@samsung.com>
 <1472737551-15272-2-git-send-email-m.szyprowski@samsung.com>
 <CGME20160913084956eucas1p2433fb17456cea4620de2729efbbf78c7@eucas1p2.samsung.com>
 <CAPDyKFo7R1f1H1R5Q78L4e_nHfngRYfo8jP_Dfi3uf_OGWvZCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-reply-to: <CAPDyKFo7R1f1H1R5Q78L4e_nHfngRYfo8jP_Dfi3uf_OGWvZCg@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-clk <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Ulf,

Thanks for looking into this patch!

On 2016-09-13 10:49, Ulf Hansson wrote:
> On 1 September 2016 at 15:45, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> Registers for some clocks might be located in the SOC area, which are under the
>> power domain. To enable access to those registers respective domain has to be
>> turned on. Additionally, registers for such clocks will usually loose its
>> contents when power domain is turned off, so additional saving and restoring of
>> them might be needed in the clock controller driver.
> This is indeed correct, I can confirm that the UX500 SoC's PRCC clock
> controllers also needs to be managed like this.
>
>> This patch adds basic infrastructure in the clocks core to allow implementing
>> driver for such clocks under power domains. Clock provider can supply a
>> struct device pointer, which is the used by clock core for tracking and managing
>> clock's controller runtime pm state. Each clk_prepare() operation
>> will first call pm_runtime_get_sync() on the supplied device, while
>> clk_unprepare() will do pm_runtime_put() at the end.
> This make sense!
>
>> Additional calls to pm_runtime_get/put functions are required to ensure that any
>> register access (like calculating/chaning clock rates) will be done with clock
> /s/chaning/changing
>
>> controller in active runtime state.
> /s/active runtime/runtime resumed
>
>> Special handling of the case when runtime pm is disabled for clock controller's
>> device is needed to let this feature work properly also during system sleep
>> suspend/resume operations (runtime pm is first disabled before entering sleep
>> state's, but controller is usually still operational until its suspend pm
>> callback is called).
> This needs to be clarified. I agree we need to cover system PM as
> well, but let's try be a bit more precise about it.

Right, I wasn't precise here. I've developed this code on older (v4.1 
and v4.6)
kernels, which had a code which disables runtime pm during system sleep 
transition
time. Maybe I need to revisit it and consider your change merged to 
v4.8-rc1, which
keeps runtime pm enabled during system sleep transitions.

>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> I would also like to extend the change log to describe a little bit of
> how a clk provider should interact with this new and nice feature.
> Something like:
>
> *) It needs to provide a struct device to the core when registering
> the provider.
> **) It needs to enable runtime PM.
> ***) It needs to make sure the runtime PM status of the controller
> device reflects the HW state.

Right, this definitely has to be added. Thank you for reminding about 
such obvious
things.

>> ---
>>   drivers/clk/clk.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++------
>>   1 file changed, 76 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index 820a939fb6bb..a1934e9b4e95 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/of.h>
>>   #include <linux/device.h>
>>   #include <linux/init.h>
>> +#include <linux/pm_runtime.h>
>>   #include <linux/sched.h>
>>   #include <linux/clkdev.h>
>>
>> @@ -46,6 +47,7 @@ struct clk_core {
>>          const struct clk_ops    *ops;
>>          struct clk_hw           *hw;
>>          struct module           *owner;
>> +       struct device           *dev;
>>          struct clk_core         *parent;
>>          const char              **parent_names;
>>          struct clk_core         **parents;
>> @@ -87,6 +89,42 @@ struct clk {
>>          struct hlist_node clks_node;
>>   };
>>
>> +/***           runtime pm          ***/
>> +static int clk_pm_runtime_get(struct clk_core *core)
>> +{
>> +       int ret = 0;
>> +
>> +       if (!core->dev)
>> +               return 0;
>> +
>> +       if (pm_runtime_enabled(core->dev)) {
> Why do you need to check for this?

This was a workaround, which let it work during the system sleep transition
state.

>
>> +               ret = pm_runtime_get_sync(core->dev);
>> +       } else {
>> +               if (!pm_runtime_status_suspended(core->dev))
>> +                       pm_runtime_get_noresume(core->dev);
> This looks weird. I guess it's related to the system PM case somehow?
>
>> +       }
>> +       return ret < 0 ? ret : 0;
>> +}
>> +
>> +static void clk_pm_runtime_put(struct clk_core *core)
>> +{
> Similar comments as for clk_pm_runtime_get().
>
>> +       if (!core->dev)
>> +               return;
>> +
>> +       if (pm_runtime_enabled(core->dev))
>> +               pm_runtime_put(core->dev);
>> +       else
>> +               pm_runtime_put_noidle(core->dev);
>> +}
>> +
>> +static bool clk_pm_runtime_suspended(struct clk_core *core)
>> +{
>> +       if (!core->dev)
>> +               return 0;
>> +
>> +       return pm_runtime_suspended(core->dev);
>> +}
>> +
>>   /***           locking             ***/
>>   static void clk_prepare_lock(void)
>>   {
>> @@ -150,6 +188,9 @@ static void clk_enable_unlock(unsigned long flags)
>>
>>   static bool clk_core_is_prepared(struct clk_core *core)
>>   {
>> +       if (clk_pm_runtime_suspended(core))
>> +               return false;
>> +
> This isn't safe, as even if the clock controller is runtime resumed at
> this point, that's *not* a guarantee that is stays runtime resumed
> while invoking the ->ops->is_prepared().
>
> Instead you must call a pm_runtime_get_noresume() before you check the
> runtime PM status, as that should avoid the device from being runtime
> suspended. Then when the ->ops->is_prepared() has been invoked, we
> should call pm_runtime_put().
>
> Although, I am not sure the above change becomes entirely correct as I
> think we are mixing the runtime PM status with the clock prepare
> status here. In other words, the next time the clock controller
> becomes runtime resumed, it may very well restore some register
> context which may prepare the clock, unless someone explicitly has
> unprepared it.
>
> Of course, it all depends on how clk_core_is_prepared() is used by the
> clock framework.

clk_core_is_prepared() is mainly used by disable_unused_tree_*. You are
right that it mixes a bit clock prepared state with runtime pm active
state of clock controller's, but I assumed here that clock cannot be
prepared if runtime pm state of controller is suspended. Other approach
here would be to call pm_runtime_get(), check status and then
pm_runtime_put(). If you prefer such approach, I will change it.

>
>>          /*
>>           * .is_prepared is optional for clocks that can prepare
>>           * fall back to software usage counter if it is missing
>> @@ -162,6 +203,9 @@ static bool clk_core_is_prepared(struct clk_core *core)
>>
>>   static bool clk_core_is_enabled(struct clk_core *core)
>>   {
>> +       if (clk_pm_runtime_suspended(core))
>> +               return false;
>> +
> Similar comment as for clk_core_is_prepared().
>
>>          /*
>>           * .is_enabled is only mandatory for clocks that gate
>>           * fall back to software usage counter if .is_enabled is missing
>> @@ -489,6 +533,8 @@ static void clk_core_unprepare(struct clk_core *core)
>>          if (core->ops->unprepare)
>>                  core->ops->unprepare(core->hw);
>>
>> +       clk_pm_runtime_put(core);
>> +
>>          trace_clk_unprepare_complete(core);
>>          clk_core_unprepare(core->parent);
>>   }
>> @@ -530,10 +576,14 @@ static int clk_core_prepare(struct clk_core *core)
>>                  return 0;
>>
>>          if (core->prepare_count == 0) {
>> -               ret = clk_core_prepare(core->parent);
>> +               ret = clk_pm_runtime_get(core);
>>                  if (ret)
>>                          return ret;
>>
>> +               ret = clk_core_prepare(core->parent);
>> +               if (ret)
>> +                       goto runtime_put;
>> +
>>                  trace_clk_prepare(core);
>>
>>                  if (core->ops->prepare)
>> @@ -541,15 +591,18 @@ static int clk_core_prepare(struct clk_core *core)
>>
>>                  trace_clk_prepare_complete(core);
>>
>> -               if (ret) {
>> -                       clk_core_unprepare(core->parent);
>> -                       return ret;
>> -               }
>> +               if (ret)
>> +                       goto unprepare;
>>          }
>>
>>          core->prepare_count++;
>>
>>          return 0;
>> +unprepare:
>> +       clk_core_unprepare(core->parent);
>> +runtime_put:
>> +       clk_pm_runtime_put(core);
>> +       return ret;
>>   }
>>
>>   static int clk_core_prepare_lock(struct clk_core *core)
>> @@ -1563,6 +1616,7 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
>>   {
>>          struct clk_core *top, *fail_clk;
>>          unsigned long rate = req_rate;
>> +       int ret = 0;
>>
>>          if (!core)
>>                  return 0;
>> @@ -1579,21 +1633,28 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
>>          if (!top)
>>                  return -EINVAL;
>>
>> +       ret = clk_pm_runtime_get(core);
>> +       if (ret)
>> +               return ret;
>> +
>>          /* notify that we are about to change rates */
>>          fail_clk = clk_propagate_rate_change(top, PRE_RATE_CHANGE);
>>          if (fail_clk) {
>>                  pr_debug("%s: failed to set %s rate\n", __func__,
>>                                  fail_clk->name);
>>                  clk_propagate_rate_change(top, ABORT_RATE_CHANGE);
>> -               return -EBUSY;
>> +               ret = -EBUSY;
>> +               goto err;
>>          }
>>
>>          /* change the rates */
>>          clk_change_rate(top);
>>
>>          core->req_rate = req_rate;
>> +err:
>> +       clk_pm_runtime_put(core);
>>
>> -       return 0;
>> +       return ret;
>>   }
>>
>>   /**
>> @@ -1824,12 +1885,16 @@ static int clk_core_set_parent(struct clk_core *core, struct clk_core *parent)
>>                  p_rate = parent->rate;
>>          }
>>
>> +       ret = clk_pm_runtime_get(core);
>> +       if (ret)
>> +               goto out;
>> +
>>          /* propagate PRE_RATE_CHANGE notifications */
>>          ret = __clk_speculate_rates(core, p_rate);
>>
>>          /* abort if a driver objects */
>>          if (ret & NOTIFY_STOP_MASK)
>> -               goto out;
>> +               goto runtime_put;
>>
>>          /* do the re-parent */
>>          ret = __clk_set_parent(core, parent, p_index);
>> @@ -1842,6 +1907,8 @@ static int clk_core_set_parent(struct clk_core *core, struct clk_core *parent)
>>                  __clk_recalc_accuracies(core);
>>          }
>>
>> +runtime_put:
>> +       clk_pm_runtime_put(core);
>>   out:
>>          clk_prepare_unlock();
>>
>> @@ -2546,6 +2613,7 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
>>                  goto fail_name;
>>          }
>>          core->ops = hw->init->ops;
>> +       core->dev = dev;
>>          if (dev && dev->driver)
>>                  core->owner = dev->driver->owner;
>>          core->hw = hw;
>> --
>> 1.9.1
>>
> I believe we are also accessing the clock controller HW from the
> late_initcall_sync(clk_disable_unused) function.

This was indirectly handled by the runtime pm state check in is_prepared
and is_enabled().

> More precisely, in clk_disable_unused_subtree(), we probably need a
> pm_runtime_get_sync() before calling clk_core_is_enabled(). And then
> restore that with a pm_runtime_put() after the clock has been
> disabled.
> The similar is needed in clk_unprepare_unused_subtree().

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

