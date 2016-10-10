From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/5] clk: add support for runtime pm
Date: Mon, 10 Oct 2016 15:44:36 +0200
Message-ID: <CAPDyKFqExx5yfByx3ic3pBPAGqH1fsDR+m+nkrOXYzov60x4sg@mail.gmail.com>
References: <CGME20160919105548eucas1p24b28143fab25eb47f5629d31f817b0bc@eucas1p2.samsung.com>
 <1474282525-30441-1-git-send-email-m.szyprowski@samsung.com>
 <1474282525-30441-2-git-send-email-m.szyprowski@samsung.com>
 <CAPDyKFqtGTJ38K5xm+-xVZcjAmLuo21613GHwUkQKKJXvYtsLQ@mail.gmail.com>
 <86cd1c31-6265-7493-fe6d-9a64fc34cd65@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <86cd1c31-6265-7493-fe6d-9a64fc34cd65@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Inki Dae <inki.dae@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-clk <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

[...]

>>> @@ -157,11 +181,17 @@ static bool clk_core_is_prepared(struct clk_core
>>> *core)
>>>          if (!core->ops->is_prepared)
>>>                  return core->prepare_count;
>>>
>>> -       return core->ops->is_prepared(core->hw);
>>> +       clk_pm_runtime_get(core);
>>
>> I guess you should assign status to the return code, and check it.
>
>
> Okay. I assume that in case of any failure from runtime pm, the function
> should return false?

I think so, yes.

>
>

[...]

>>>   static void clk_disable_unused_subtree(struct clk_core *core)
>>> @@ -768,6 +834,9 @@ static void clk_disable_unused_subtree(struct
>>> clk_core *core)
>>>          if (core->flags & CLK_OPS_PARENT_ENABLE)
>>>                  clk_core_prepare_enable(core->parent);
>>>
>>> +       if (clk_pm_runtime_get(core) != 0)
>>
>> Is there any reason to why you haven't moved this further down in this
>> function, like just before calling clk_core_is_enabled()?
>
>
> Yes, clk_enable_lock() takes a spinlock, so I cannot call pm_runtime_get
> after it.

Of course, you are right!

>
>
>>
>> You may also simplify this:
>> if (clk_pm_runtime_get(core))
>>
>>> +               return;
>>> +
>>
>> You need to restore the call made to clk_core_prepare_enable()
>> earlier, so please update the error handling to cope with this.
>>

[...]

>>> @@ -2546,6 +2631,8 @@ struct clk *clk_register(struct device *dev, struct
>>> clk_hw *hw)
>>>                  goto fail_name;
>>>          }
>>>          core->ops = hw->init->ops;
>>> +       if (dev && (hw->init->flags & CLK_RUNTIME_PM))
>>> +               core->dev = dev;
>>
>> I guess you need this to play safe, although I am really wondering if
>> we should try without.
>>
>> Not that many clocks are currently being registered with a valid
>> struct device pointer. For the other cases why not try to use runtime
>> PM as per default?
>
>
> I've that tried initially, but it causes failure for all the clock
> controllers, which don't enable runtime pm. One of such case is max77686
> PMIC, which provides 3 clocks. Maybe a negative flag (CLK_NO_RUNTIME_PM)
> will be a better solution, so by default the runtime pm calls will be
> enabled for every driver providing struct device?

I assume that's because the runtime PM errors in clk_pm_runtime_get()
and friends, are being propagated to the callers? Especially because
the runtime PM core returns error codes, in cases when runtime PM
hasn't been enabled for the device.

>
>> Moreover we anyway rely on the clock provider to enable runtime PM for
>> the clock device, and when that isn't the case the runtime PM
>> deployment in the core should still be safe, right!?
>
>
> I don't get the above comment. Do you want to check if runtime pm has
> been enabled during clock registration?

Yes, something like that. Apologize, I was clearly being too vague.

My point is, we don't need to invent a specific clock provider flag
for this. Instead the clock core could just at clock registration
check if runtime PM is enabled for the device (pm_runtime_enabled()),.
and from that assign an internal clock core flag to keep track of
whether runtime PM should be managed or not.

>
>>>         if (dev && dev->driver)
>>>                  core->owner = dev->driver->owner;
>>>          core->hw = hw;
>>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>>> index a39c0c530778..8a131eb71fdf 100644
>>> --- a/include/linux/clk-provider.h
>>> +++ b/include/linux/clk-provider.h
>>> @@ -35,6 +35,7 @@
>>>   #define CLK_IS_CRITICAL                BIT(11) /* do not gate, ever */
>>>   /* parents need enable during gate/ungate, set rate and re-parent */
>>>   #define CLK_OPS_PARENT_ENABLE  BIT(12)
>>> +#define CLK_RUNTIME_PM         BIT(13)
>>>
>>>   struct clk;
>>>   struct clk_hw;
>>> --
>>> 1.9.1
>>>
>>
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>

Kind regards
Uffe
