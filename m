From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V3] PM / clk: Add support for obtaining clocks from
 device-tree
Date: Thu, 10 Mar 2016 13:23:12 +0000
Message-ID: <56E17540.7060706@nvidia.com>
References: <1457600456-4283-1-git-send-email-jonathanh@nvidia.com>
 <CAMuHMdUToumZwuisg7HeOVuB7Amke7W=qpZ5f0dzavSqnjXygg@mail.gmail.com>
 <56E1683C.4020206@nvidia.com>
 <CAMuHMdXNRade9m5Qm+EDiSw+VOqgosD-2vR1YZTeasqhHD4xCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdXNRade9m5Qm+EDiSw+VOqgosD-2vR1YZTeasqhHD4xCg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


On 10/03/16 12:40, Geert Uytterhoeven wrote:
> Hi Jon,
> 
> On Thu, Mar 10, 2016 at 1:27 PM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>> On 10/03/16 09:41, Geert Uytterhoeven wrote:
>>> On Thu, Mar 10, 2016 at 10:00 AM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>>> The PM clocks framework requires clients to pass either a con-id or a
>>>> valid clk pointer in order to add a clock to a device. Add a new
>>>> function of_pm_clk_add_clks() to allows device clocks to be retrieved
>>>> from device-tree and populated for a given device. Note that
>>>> of_clk_get_from_provider() is not defined if CONFIG_OF and
>>>> CONFIG_COMMON_CLK are not selected. Therefore, make of_pm_clk_add_clks()
>>>> dependent on these options.
>>>>
>>>> An optional function pointer may be passed to of_pm_clk_add_clks() that
>>>> can be used to filter the clocks that are added for a device when
>>>> calling of_pm_clk_add_clks().
>>>>
>>>> In order to handle errors encountered when adding clocks from
>>>> device-tree, add a function pm_clk_remove_clk() to remove any clocks
>>>> (using a pointer to the clk structure) that have been added
>>>> successfully before the error occurred.
>>>>
>>>> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>>
>>> Tested-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
>>>
>>> But more comments below...
>>>
>>>> --- a/drivers/base/power/clock_ops.c
>>>> +++ b/drivers/base/power/clock_ops.c
>>>> @@ -137,6 +137,81 @@ int pm_clk_add_clk(struct device *dev, struct clk *clk)
>>>>         return __pm_clk_add(dev, NULL, clk);
>>>>  }
>>>>
>>>> +
>>>> +#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
>>>> +/**
>>>> + * of_pm_clk_add_clks - Start using device clock(s) for power management.
>>>> + * @dev: Device whose clock(s) is going to be used for power management.
>>>> + * @of_pm_clk_filter: Optional function for filtering clocks
>>>> + *
>>>> + * Add a series of clocks described in the 'clocks' device-tree node for
>>>> + * a device to the list of clocks used for the power management of @dev.
>>>> + * If 'of_pm_clk_filter' is specified, then this filter function will be
>>>> + * called for each clock found and the clock will be added to the list
>>>> + * of clocks if this function returns true. Return success if clocks are
>>>> + * added successfully and return a negative error code if adding a clock
>>>> + * fails or there are no clocks that match with the filter function.
>>>> + */
>>>> +int of_pm_clk_add_clks(struct device *dev, of_pm_clk_filter fn, void *data)
>>>> +{
>>>
>>> [...]
>>>
>>>> +       count = of_count_phandle_with_args(dev->of_node, "clocks",
>>>> +                                          "#clock-cells");
>>>> +       if (count == 0)
>>>> +               return -ENODEV;
>>>
>>> [...]
>>>
>>> +       return added ? 0 : -ENODEV;
>>>
>>> Is it an error condition if no clocks were present in DT, or if no clocks have
>>> been accepted by the filter function? If not, the caller has to check for
>>> -ENODEV. Now the caller has to call pm_clk_create() first, before it knows if
>>> any clocks will be added, it may want to call pm_clk_destroy() later if no
>>> clocks have been added.
>>
>> It seems odd to me that someone would call this function and either
>> there are no clocks in the DT or they are all filtered out. For example,
>> most drivers are calling of_clk_get() because there are clocks they need
>> to add.
> 
> of_pm_clk_add_clks() would typically be called from the .attach_dev()
> callback of the PM Domain, for all devices in the PM Domain. However, there may
> exist devices without clocks properties, or without gateable clocks.

I was planning to use it from within the probe of a driver wishing to
use PM_CLK framework in general. Adding them automatically could be
nice, but like you have pointed out, some drivers want specific control
over certain clocks. May be having a "pm-clocks" node in the DT would be
needed for something like this. Or some way of saying it can be
controlled by PM_CLK.

>>> Alternatively, you could return 0 vs. the actual number of clocks added.
>>
>> However, a nice comprise here could be to return the number of clocks
>> added and let the user decide what to do. I like that idea. Not sure I
>> understand what you mean by "0 vs. the actual number of clocks added".
>> Do you just mean the return the number added?
> 
> Yes, that what I meant:
>   (current) -ENODEV => (new) 0
>   (current) 0 => (new) number of clocks added
> 
> Sorry for the confusion.

That's what I thought you meant and sounds good to me.

>>> I hooked up your code in renesas-cpg-mssr.c, and it worked.
>>> However, I noticed it added 27 clocks for one device node (rcar_sound), and
>>> only then I realized that I only want to add the first clock accepted by the
>>> filter, not all of them, as the others are under driver control.
>>> I'm not sure this can be handled in the filter function.
>>> So I can't use your code (for now)...
>>
>> I see, that is unfortunate. Are you using the void *data variable in
>> your filter? If not may be you could use this to indicate a clock has
>> been 'found' and don't match any further clocks.
> 
> Perhaps. I'll think about it...

Another option is to add another variable called "max_clocks" which if
-1 means there is no user max and defer to the 'count' for the number of
clocks to be added. Where 'count' is the number of clocks in the DT blob
for the device. Obviously if you set max_clocks = 200 and there are only
2 clocks in the DT blob only 2 would be added.

It would also be possible to pass the 'added' number of clocks to the
filter and so the filter could decided if it wanted to keep matching or
not. However, you could equally keep track of that with the void *data
variable yourself and so may be that is redundant.

>> If you cannot use it, then I am tempted to drop the filter function for
>> now as this simplifies the code. It can always be added later if someone
>> has a need for it.
> 
> That's fine for me.
> 
> Note that if the need arises for the filter function, you'll have to add a new
> function and make the old one a wrapper, to avoid having to update all
> existing users that don't use the filter function.

If it is not something that we can sort out now, then I would rather not
added it. However, may be a wrapper would not be so bad after all. Even
with the above proposal of another variable called 'max_clocks' I would
be tempted to split the functions into two, for example,
of_pm_clk_add_clks() and of_pm_clk_add_clks_match(), where the later
uses the filter and the former does not.

Cheers
Jon
