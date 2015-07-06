From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v4 3/8] clk: add support for clocks provided by SCP(System
 Control Processor)
Date: Mon, 06 Jul 2015 12:52:52 -0700
Message-ID: <559ADC94.4080505@codeaurora.org>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com> <1433760002-24120-4-git-send-email-sudeep.holla@arm.com> <20150702172310.GF4301@codeaurora.org> <5596A1B6.8020307@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46545 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604AbbGFTw4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2015 15:52:56 -0400
In-Reply-To: <5596A1B6.8020307@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>, Mike Turquette <mturquette@linaro.org>

On 07/03/2015 07:52 AM, Sudeep Holla wrote:
> Hi Stephen,
>
>
> Thanks for the review.
>
> On 02/07/15 18:23, Stephen Boyd wrote:
>> On 06/08, Sudeep Holla wrote:
>>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>>> index 9897f353bf1a..0fe8daefc105 100644
>>> --- a/drivers/clk/Kconfig
>>> +++ b/drivers/clk/Kconfig
>>> @@ -59,6 +59,16 @@ config COMMON_CLK_RK808
>>>         clocked at 32KHz each. Clkout1 is always on, Clkout2 can off
>>>         by control register.
>>>
>>> +config COMMON_CLK_SCPI
>>> +        tristate "Clock driver controlled via SCPI interface"
>>> +        depends on ARM_SCPI_PROTOCOL || COMPILE_TEST
>>> +        ---help---
>>> +          This driver provides support for clocks that are controlled
>>> +          by firmware that implements the SCPI interface.
>>> +
>>> +      This driver uses SCPI Message Protocol to interact with the
>>> +      firmware providing all the clock controls.
>>
>> The tabbing is weird here. Both paragraphs should have the same
>> alignment.
>>
>
> Indeed, sorry for that, fixed now.
>
>>> diff --git a/drivers/clk/clk-scpi.c b/drivers/clk/clk-scpi.c
>>> new file mode 100644
>>> index 000000000000..707b3430c55f
>>> --- /dev/null
>>> +++ b/drivers/clk/clk-scpi.c
>>> +
>>> +#include <linux/clk-provider.h>
>>> +#include <linux/device.h>
>>> +#include <linux/err.h>
>>> +#include <linux/of.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of_platform.h>
>>> +#include <linux/scpi_protocol.h>
>>
>> Please include <linux/platform_device.h> as well.
>>
>
> Added now, didn't bother as of_platform.h includes it.
>
>>> +
>>> +struct scpi_clk {
>>> +    u32 id;
>>> +    const char *name;
>>
>> Do you need this? Or can you just use __clk_get_name() in places
>> where the name is used?
>>
>
> Not used, so removed it.
>
>
> [...]
>
>>> +static long scpi_clk_round_rate(struct clk_hw *hw, unsigned long rate,
>>> +                unsigned long *parent_rate)
>>> +{
>>
>> Maybe a comment here like:
>>
>> /*
>>   * We can't figure out what rate it will be, so just return the rate
>>   * back to the caller. scpi_clk_recalc_rate() will be called
>>   * after the rate is set and we'll know what rate the clock is
>>   * running at then.
>>   */
>>
>
> Done
>
>>> +    return rate;
>>> +}
>>> +
>>> +static int scpi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
>>> +                 unsigned long parent_rate)
>>> +{
>>> +    struct scpi_clk *clk = to_scpi_clk(hw);
>>> +
>>> +    return clk->scpi_ops->clk_set_val(clk->id, rate);
>>> +}
>>> +
>>> +static void scpi_clk_disable(struct clk_hw *hw)
>>> +{
>>> +    scpi_clk_set_rate(hw, 0, 0);
>>
>> Does this mean you have to set a rate to enable the clock? Are
>> you relying on drivers to call clk_set_rate() to implicitly
>> enable the clock? If so, it would be better to cache the rate of
>> the clock in set_rate if the clock isn't enabled in software and
>> then send the cached rate during enable.
>>
>
> Agreed, I have asked the firmware/SCPI specification guys about
> more details on what to expect from firmware. Once they get back,
> will update the code considering your feedback.
>
> [...]
>
>>> +static int __scpi_find_dvfs_index(struct scpi_clk *clk, unsigned
>>> long rate)
>>> +{
>>> +    int idx, max_opp = clk->info->count;
>>> +    struct scpi_opp *opp = clk->info->opps;
>>
>> const?
>>
>
> All the 3 above fixed now.
>
> [...]
>
>>> +
>>> +    clk = devm_clk_register(dev, &sclk->hw);
>>> +    if (!IS_ERR(clk) && max)
>>> +        clk_set_rate_range(clk, min, max);
>>
>> Hm.. we're planning to make clk_register() return a struct
>> clk_hw, so this will block that. We need some sort of clk_hw API
>> that allows us to setup min/max limits on the clock from the
>> provider side. Care to add that?
>>
>
> Can you provide pointer to the patches or the tree containing those
> changes ? Are they targeted for v4.3 ?
>

If I have time I may try to start doing the clk_register() conversion,
but it will take a while so I doubt it will be in v4.3. I'm asking if
you can add a clk_hw based API that does something like
clk_set_rate_range() without requiring a struct clk pointer. i.e.
clk_hw_set_rate_range(struct clk_hw *hw, min, max) that constraints the
min/max rate of the clock. This way, the driver is only using clk
provider APIs and not clk consumer APIs.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

