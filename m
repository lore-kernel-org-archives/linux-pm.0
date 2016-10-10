From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2 1/5] clk: add support for runtime pm
Date: Mon, 10 Oct 2016 13:21:35 +0200
Message-ID: <86cd1c31-6265-7493-fe6d-9a64fc34cd65@samsung.com>
References: <CGME20160919105548eucas1p24b28143fab25eb47f5629d31f817b0bc@eucas1p2.samsung.com>
 <1474282525-30441-1-git-send-email-m.szyprowski@samsung.com>
 <1474282525-30441-2-git-send-email-m.szyprowski@samsung.com>
 <CAPDyKFqtGTJ38K5xm+-xVZcjAmLuo21613GHwUkQKKJXvYtsLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:47707 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751752AbcJJLVq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2016 07:21:46 -0400
In-reply-to: <CAPDyKFqtGTJ38K5xm+-xVZcjAmLuo21613GHwUkQKKJXvYtsLQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-clk <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, =?UTF-8?Q?Krzysztof_Koz=c5=82owski?= <k.kozlowski.k@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Ulf,

Thanks for your comments!

On 2016-10-07 12:07, Ulf Hansson wrote:
> On 19 September 2016 at 12:55, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> Registers for some clocks might be located in the SOC area, which are under the
>> power domain. To enable access to those registers respective domain has to be
>> turned on. Additionally, registers for such clocks will usually loose its
>> contents when power domain is turned off, so additional saving and restoring of
>> them might be needed in the clock controller driver.
>>
>> This patch adds basic infrastructure in the clocks core to allow implementing
>> driver for such clocks under power domains. Clock provider can supply a
>> struct device pointer, which is the used by clock core for tracking and managing
>> clock's controller runtime pm state. Each clk_prepare() operation
>> will first call pm_runtime_get_sync() on the supplied device, while
>> clk_unprepare() will do pm_runtime_put() at the end.
>>
>> Additional calls to pm_runtime_get/put functions are required to ensure that any
>> register access (like calculating/changing clock rates and unpreparing/disabling
>> unused clocks on boot) will be done with clock controller in runtime resumend
>> state.
>>
>> When one wants to register clock controller, which make use of this feature, he
>> has to:
>> 1. Provide a struct device to the core when registering the provider and set
>>     CLK_RUNTIME_PM flags for its clocks.
>> 2. It needs to enable runtime PM for that device.
>> 3. It needs to make sure the runtime PM status of the controller device reflects
>>     the HW state.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   drivers/clk/clk.c            | 107 +++++++++++++++++++++++++++++++++++++++----
>>   include/linux/clk-provider.h |   1 +
>>   2 files changed, 98 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index 820a939fb6bb..096a199b8e46 100644
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
>> @@ -87,6 +89,26 @@ struct clk {
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
>> +       ret = pm_runtime_get_sync(core->dev);
>> +       return ret < 0 ? ret : 0;
>> +}
>> +
>> +static void clk_pm_runtime_put(struct clk_core *core)
>> +{
>> +       if (!core->dev)
>> +               return;
>> +
>> +       pm_runtime_put(core->dev);
>> +}
>> +
>>   /***           locking             ***/
>>   static void clk_prepare_lock(void)
>>   {
>> @@ -150,6 +172,8 @@ static void clk_enable_unlock(unsigned long flags)
>>
>>   static bool clk_core_is_prepared(struct clk_core *core)
>>   {
>> +       bool status;
>> +
>>          /*
>>           * .is_prepared is optional for clocks that can prepare
>>           * fall back to software usage counter if it is missing
>> @@ -157,11 +181,17 @@ static bool clk_core_is_prepared(struct clk_core *core)
>>          if (!core->ops->is_prepared)
>>                  return core->prepare_count;
>>
>> -       return core->ops->is_prepared(core->hw);
>> +       clk_pm_runtime_get(core);
> I guess you should assign status to the return code, and check it.

Okay. I assume that in case of any failure from runtime pm, the function
should return false?

>
>> +       status = core->ops->is_prepared(core->hw);
>> +       clk_pm_runtime_put(core);
>> +
>> +       return status;
>>   }
>>
>>   static bool clk_core_is_enabled(struct clk_core *core)
>>   {
>> +       bool status;
>> +
>>          /*
>>           * .is_enabled is only mandatory for clocks that gate
>>           * fall back to software usage counter if .is_enabled is missing
>> @@ -169,7 +199,29 @@ static bool clk_core_is_enabled(struct clk_core *core)
>>          if (!core->ops->is_enabled)
>>                  return core->enable_count;
>>
>> -       return core->ops->is_enabled(core->hw);
>> +       /*
>> +        * Check if runtime pm is enabled before calling .is_enabled callback,
>> +        * if not assume that clock is disabled, because we might be called
>> +        * from atomic context, from which pm_runtime_get() is not allowed.
>> +        * This function is called mainly from clk_disable_unused_subtree,
>> +        * which ensures proper runtime pm activation of controller before
>> +        * taking enable spinlock, but the below check is needed if one tries
>> +        * to call it from other place.
>> +        */
>> +       if (core->dev) {
>> +               pm_runtime_get_noresume(core->dev);
>> +               if (pm_runtime_suspended(core->dev)) {
> I think it's wrong to use pm_runtime_suspended().
>
> What you should be checking, is whether the device is RPM_ACTIVE or if
> runtime PM isn't enabled for device.
>
> In other words, you should use pm_runtime_active() to find out whether
> it's okay to invoke the ->is_enabled() ops or not.
>
> Accordingly, I think the upper comment you added then needs to be a
> rephrased a bit to reflect this.

Okay, I will change it to use pm_runtime_active(). It looks that mentally
I still assume that runtime pm will be disabled in system sleep transitions
phase, so the only check that provided some useful information about
previous runtime pm state was pm_runtime_suspended().

>
>> +                       status = false;
>> +                       goto done;
>> +               }
>> +       }
>> +
>> +       status = core->ops->is_enabled(core->hw);
>> +done:
>> +       if (core->dev)
>> +               pm_runtime_put(core->dev);
>> +
>> +       return status;
>>   }
>>
>>   /***    helper functions   ***/
>> @@ -489,6 +541,8 @@ static void clk_core_unprepare(struct clk_core *core)
>>          if (core->ops->unprepare)
>>                  core->ops->unprepare(core->hw);
>>
>> +       clk_pm_runtime_put(core);
>> +
>>          trace_clk_unprepare_complete(core);
>>          clk_core_unprepare(core->parent);
>>   }
>> @@ -530,10 +584,14 @@ static int clk_core_prepare(struct clk_core *core)
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
>> @@ -541,15 +599,18 @@ static int clk_core_prepare(struct clk_core *core)
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
>> @@ -745,6 +806,9 @@ static void clk_unprepare_unused_subtree(struct clk_core *core)
>>          if (core->flags & CLK_IGNORE_UNUSED)
>>                  return;
>>
>> +       if (clk_pm_runtime_get(core) != 0)
> You may simplify this:
> if (clk_pm_runtime_get(core))
>
>> +               return;
>> +
>>          if (clk_core_is_prepared(core)) {
>>                  trace_clk_unprepare(core);
>>                  if (core->ops->unprepare_unused)
>> @@ -753,6 +817,8 @@ static void clk_unprepare_unused_subtree(struct clk_core *core)
>>                          core->ops->unprepare(core->hw);
>>                  trace_clk_unprepare_complete(core);
>>          }
>> +
>> +       clk_pm_runtime_put(core);
>>   }
>>
>>   static void clk_disable_unused_subtree(struct clk_core *core)
>> @@ -768,6 +834,9 @@ static void clk_disable_unused_subtree(struct clk_core *core)
>>          if (core->flags & CLK_OPS_PARENT_ENABLE)
>>                  clk_core_prepare_enable(core->parent);
>>
>> +       if (clk_pm_runtime_get(core) != 0)
> Is there any reason to why you haven't moved this further down in this
> function, like just before calling clk_core_is_enabled()?

Yes, clk_enable_lock() takes a spinlock, so I cannot call pm_runtime_get 
after it.

>
> You may also simplify this:
> if (clk_pm_runtime_get(core))
>
>> +               return;
>> +
> You need to restore the call made to clk_core_prepare_enable()
> earlier, so please update the error handling to cope with this.
>
>>          flags = clk_enable_lock();
>>
>>          if (core->enable_count)
>> @@ -794,6 +863,8 @@ unlock_out:
>>          clk_enable_unlock(flags);
>>          if (core->flags & CLK_OPS_PARENT_ENABLE)
>>                  clk_core_disable_unprepare(core->parent);
>> +
>> +       clk_pm_runtime_put(core);
>>   }
>>
>>   static bool clk_ignore_unused;
>> @@ -1563,6 +1634,7 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
>>   {
>>          struct clk_core *top, *fail_clk;
>>          unsigned long rate = req_rate;
>> +       int ret = 0;
>>
>>          if (!core)
>>                  return 0;
>> @@ -1579,21 +1651,28 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
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
>> @@ -1824,12 +1903,16 @@ static int clk_core_set_parent(struct clk_core *core, struct clk_core *parent)
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
>> @@ -1842,6 +1925,8 @@ static int clk_core_set_parent(struct clk_core *core, struct clk_core *parent)
>>                  __clk_recalc_accuracies(core);
>>          }
>>
>> +runtime_put:
>> +       clk_pm_runtime_put(core);
>>   out:
>>          clk_prepare_unlock();
>>
>> @@ -2546,6 +2631,8 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
>>                  goto fail_name;
>>          }
>>          core->ops = hw->init->ops;
>> +       if (dev && (hw->init->flags & CLK_RUNTIME_PM))
>> +               core->dev = dev;
> I guess you need this to play safe, although I am really wondering if
> we should try without.
>
> Not that many clocks are currently being registered with a valid
> struct device pointer. For the other cases why not try to use runtime
> PM as per default?

I've that tried initially, but it causes failure for all the clock
controllers, which don't enable runtime pm. One of such case is max77686
PMIC, which provides 3 clocks. Maybe a negative flag (CLK_NO_RUNTIME_PM)
will be a better solution, so by default the runtime pm calls will be
enabled for every driver providing struct device?

> Moreover we anyway rely on the clock provider to enable runtime PM for
> the clock device, and when that isn't the case the runtime PM
> deployment in the core should still be safe, right!?

I don't get the above comment. Do you want to check if runtime pm has
been enabled during clock registration?

>>         if (dev && dev->driver)
>>                  core->owner = dev->driver->owner;
>>          core->hw = hw;
>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>> index a39c0c530778..8a131eb71fdf 100644
>> --- a/include/linux/clk-provider.h
>> +++ b/include/linux/clk-provider.h
>> @@ -35,6 +35,7 @@
>>   #define CLK_IS_CRITICAL                BIT(11) /* do not gate, ever */
>>   /* parents need enable during gate/ungate, set rate and re-parent */
>>   #define CLK_OPS_PARENT_ENABLE  BIT(12)
>> +#define CLK_RUNTIME_PM         BIT(13)
>>
>>   struct clk;
>>   struct clk_hw;
>> --
>> 1.9.1
>>
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

