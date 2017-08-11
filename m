From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v8 1/5] clk: Add support for runtime PM
Date: Fri, 11 Aug 2017 08:18:42 +0200
Message-ID: <3668240d-c425-6da8-d62c-1d5fdde7c91e@samsung.com>
References: <1502274907-11931-1-git-send-email-m.szyprowski@samsung.com>
        <CGME20170809103512eucas1p2eb66401b357d82bed91182a5a1b1fea9@eucas1p2.samsung.com>
        <1502274907-11931-2-git-send-email-m.szyprowski@samsung.com>
        <150238969053.5192.13225746723120483789@resonance>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <150238969053.5192.13225746723120483789@resonance>
Content-language: en-US
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Stephen Boyd <sboyd@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Michael,

Thanks for the comments!

On 2017-08-10 20:28, Michael Turquette wrote:
> Hi Marek,
>
> Quoting Marek Szyprowski (2017-08-09 03:35:03)
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
>> clk_unprepare() will do pm_runtime_put_sync() at the end.
>>
>> Additional calls to pm_runtime_get/put functions are required to ensure that any
>> register access (like calculating/changing clock rates and unpreparing/disabling
>> unused clocks on boot) will be done with clock controller in runtime resumend
>> state.
>>
>> When one wants to register clock controller, which make use of this feature, he
>> has to:
>> 1. Provide a struct device to the core when registering the provider.
>> 2. Ensure to enable runtime PM for that device before registering clocks.
>> 3. Make sure that the runtime PM status of the controller device reflects
>>     the HW state.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Overall the idea and the patch look good to me.
>
> Calling pm_runtime_get for prepare and pm_runtime_put for unprepared
> makes perfect sense to me. It means that the power domain that powers
> that clock hardware must be on for that clock to function properly.
>
> It’s worth pointing out that this patch leaves that power domain enabled
> for for as long as prepare_count is greater than zero.
>
> However the rate-change operations only use the pm_runtime functions to
> program the hardware and modify the registers. At the end of each
> rate-change call there is a pm_runtime_put. This makes sense to me, but
> I’m trying to wrap my head around the fact that this patch introduces
> two behaviors:
>
> 1) protect access to the clk hardware by wrapping writes across the bus
> with pm_runtime calls
> 2) power the clock logic when the clock is in use (e.g. clk_prepare())
>
> Everything about this patch *seems* correct to me, but I’m trying to
> figure out what it means to for a clock consumer driver to do something
> like this:
>
> clk_prepare_enable()
> clk_disable_unprepare()
> clk_set_rate()
>
> Maybe patches #2-5 will help me understand, but I wanted to jot this
> down in my review before I forget.

Well, the question is what will the above sequence do without my patches?

IMO the only result of above calls is (optionally) changed rate of parent
clocks and appropriate values written to given clock's registers, so next
time one calls clk_(prepare)_enable(), the given clock will be enabled
with the configured rate.

With runtime pm patches the overall result will be the same. However, if
the given clock is the only/last enabled clock from the provider, there
might be a runtime pm resume/suspend transition (2 times: one from
prepare/unprepare calls, the second from set_rate calls). This means that
the rate of parent clocks (especially if they comes from the other
providers) might or might not change between those transitions. This
depends how the runtime pm is implemented and what operations has to be
done for putting provider into suspend mode. The final result will be
however the same as without runtime pm patches.

Clock provider's runtime pm suspend callback should save internal
configuration and resume callback must restore it completely, so the
provider's internal state is exactly the same as before suspend. If we
assume that clock provider might be in a power domain, the internal
clock provider's hardware context might be lost after suspend callback.

>> @@ -2583,6 +2673,12 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
>>                  goto fail_name;
>>          }
>>          core->ops = hw->init->ops;
>> +       if (dev && pm_runtime_enabled(dev)) {
>> +               core->dev = dev;
>> +               ret = clk_pm_runtime_get(core);
>> +               if (ret)
>> +                       goto fail_pm;
>> +       }
>>          if (dev && dev->driver)
>>                  core->owner = dev->driver->owner;
>>          core->hw = hw;
>> @@ -2629,12 +2725,13 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
>>          }
>>   
>>          ret = __clk_core_init(core);
>> -       if (!ret)
>> +       if (!ret) {
>> +               clk_pm_runtime_put(core);
>>                  return hw->clk;
>> +       }
> I wonder if the above can be moved inside of __clk_core_init?
> clk_register shouldn't manage any clk_ops directly, only __clk_core_init
> does this.

If you prefer that, I will move runtime pm related bits to 
__clk_core_init then.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
