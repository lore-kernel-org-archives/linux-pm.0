From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V3] PM / clk: Add support for obtaining clocks from device-tree
Date: Thu, 10 Mar 2016 13:40:34 +0100
Message-ID: <CAMuHMdXNRade9m5Qm+EDiSw+VOqgosD-2vR1YZTeasqhHD4xCg@mail.gmail.com>
References: <1457600456-4283-1-git-send-email-jonathanh@nvidia.com>
	<CAMuHMdUToumZwuisg7HeOVuB7Amke7W=qpZ5f0dzavSqnjXygg@mail.gmail.com>
	<56E1683C.4020206@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f196.google.com ([209.85.213.196]:35459 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbcCJMkg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Mar 2016 07:40:36 -0500
In-Reply-To: <56E1683C.4020206@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org

Hi Jon,

On Thu, Mar 10, 2016 at 1:27 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
> On 10/03/16 09:41, Geert Uytterhoeven wrote:
>> On Thu, Mar 10, 2016 at 10:00 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
>>> The PM clocks framework requires clients to pass either a con-id or a
>>> valid clk pointer in order to add a clock to a device. Add a new
>>> function of_pm_clk_add_clks() to allows device clocks to be retrieved
>>> from device-tree and populated for a given device. Note that
>>> of_clk_get_from_provider() is not defined if CONFIG_OF and
>>> CONFIG_COMMON_CLK are not selected. Therefore, make of_pm_clk_add_clks()
>>> dependent on these options.
>>>
>>> An optional function pointer may be passed to of_pm_clk_add_clks() that
>>> can be used to filter the clocks that are added for a device when
>>> calling of_pm_clk_add_clks().
>>>
>>> In order to handle errors encountered when adding clocks from
>>> device-tree, add a function pm_clk_remove_clk() to remove any clocks
>>> (using a pointer to the clk structure) that have been added
>>> successfully before the error occurred.
>>>
>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>
>> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> But more comments below...
>>
>>> --- a/drivers/base/power/clock_ops.c
>>> +++ b/drivers/base/power/clock_ops.c
>>> @@ -137,6 +137,81 @@ int pm_clk_add_clk(struct device *dev, struct clk *clk)
>>>         return __pm_clk_add(dev, NULL, clk);
>>>  }
>>>
>>> +
>>> +#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
>>> +/**
>>> + * of_pm_clk_add_clks - Start using device clock(s) for power management.
>>> + * @dev: Device whose clock(s) is going to be used for power management.
>>> + * @of_pm_clk_filter: Optional function for filtering clocks
>>> + *
>>> + * Add a series of clocks described in the 'clocks' device-tree node for
>>> + * a device to the list of clocks used for the power management of @dev.
>>> + * If 'of_pm_clk_filter' is specified, then this filter function will be
>>> + * called for each clock found and the clock will be added to the list
>>> + * of clocks if this function returns true. Return success if clocks are
>>> + * added successfully and return a negative error code if adding a clock
>>> + * fails or there are no clocks that match with the filter function.
>>> + */
>>> +int of_pm_clk_add_clks(struct device *dev, of_pm_clk_filter fn, void *data)
>>> +{
>>
>> [...]
>>
>>> +       count = of_count_phandle_with_args(dev->of_node, "clocks",
>>> +                                          "#clock-cells");
>>> +       if (count == 0)
>>> +               return -ENODEV;
>>
>> [...]
>>
>> +       return added ? 0 : -ENODEV;
>>
>> Is it an error condition if no clocks were present in DT, or if no clocks have
>> been accepted by the filter function? If not, the caller has to check for
>> -ENODEV. Now the caller has to call pm_clk_create() first, before it knows if
>> any clocks will be added, it may want to call pm_clk_destroy() later if no
>> clocks have been added.
>
> It seems odd to me that someone would call this function and either
> there are no clocks in the DT or they are all filtered out. For example,
> most drivers are calling of_clk_get() because there are clocks they need
> to add.

of_pm_clk_add_clks() would typically be called from the .attach_dev()
callback of the PM Domain, for all devices in the PM Domain. However, there may
exist devices without clocks properties, or without gateable clocks.

>> Alternatively, you could return 0 vs. the actual number of clocks added.
>
> However, a nice comprise here could be to return the number of clocks
> added and let the user decide what to do. I like that idea. Not sure I
> understand what you mean by "0 vs. the actual number of clocks added".
> Do you just mean the return the number added?

Yes, that what I meant:
  (current) -ENODEV => (new) 0
  (current) 0 => (new) number of clocks added

Sorry for the confusion.

>> I hooked up your code in renesas-cpg-mssr.c, and it worked.
>> However, I noticed it added 27 clocks for one device node (rcar_sound), and
>> only then I realized that I only want to add the first clock accepted by the
>> filter, not all of them, as the others are under driver control.
>> I'm not sure this can be handled in the filter function.
>> So I can't use your code (for now)...
>
> I see, that is unfortunate. Are you using the void *data variable in
> your filter? If not may be you could use this to indicate a clock has
> been 'found' and don't match any further clocks.

Perhaps. I'll think about it...

> If you cannot use it, then I am tempted to drop the filter function for
> now as this simplifies the code. It can always be added later if someone
> has a need for it.

That's fine for me.

Note that if the need arises for the filter function, you'll have to add a new
function and make the old one a wrapper, to avoid having to update all
existing users that don't use the filter function.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
