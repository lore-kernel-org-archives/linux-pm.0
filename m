From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 2/2] PM / clk: Add support for obtaining clocks from device-tree
Date: Mon, 7 Mar 2016 12:06:23 +0100
Message-ID: <CAMuHMdWe5x1pobvxjGV2Tr7RQ0ZgvcJ4DXzSLoRO2z0Pd2+0cg@mail.gmail.com>
References: <1457105585-25157-1-git-send-email-jonathanh@nvidia.com>
	<1457105585-25157-2-git-send-email-jonathanh@nvidia.com>
	<CAMuHMdWU2-yaoaxPCQKqyLknFQH5f=dPXPr+y96N1ZPMib8kuA@mail.gmail.com>
	<56DD5BE6.1070905@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56DD5BE6.1070905-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Jon,

On Mon, Mar 7, 2016 at 11:45 AM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> On 07/03/16 08:48, Geert Uytterhoeven wrote:
>> On Fri, Mar 4, 2016 at 4:33 PM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>> The PM clocks framework requires clients to pass either a con-id or a
>>> valid clk pointer in order to add a clock to a device. Add a new
>>> function pm_clk_add_clks_of() to allows device clocks to be retrieved
>>> from device-tree and populated for a given device. Note that there
>>> should be no need to add a stub function for this new function when
>>> CONFIG_OF is not selected because the OF functions used already have
>>> stubs functions.
>>>
>>> In order to handle errors encountered when adding clocks from
>>> device-tree, add a function pm_clk_remove_clk() to remove any clocks
>>> (using a pointer to the clk structure) that have been added
>>> successfully before the error occurred.
>>>
>>> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>> ---
>>>  drivers/base/power/clock_ops.c | 85 ++++++++++++++++++++++++++++++++++++++++++
>>>  include/linux/pm_clock.h       |  9 +++++
>>>  2 files changed, 94 insertions(+)
>>>
>>> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
>>> index 272a52ebafc0..5aa7365699c1 100644
>>> --- a/drivers/base/power/clock_ops.c
>>> +++ b/drivers/base/power/clock_ops.c
>>> @@ -138,6 +138,58 @@ int pm_clk_add_clk(struct device *dev, struct clk *clk)
>>>  }
>>>
>>>  /**
>>> + * pm_clk_add_clks_of - Start using device clock(s) for power management.
>>> + * @dev: Device whose clock(s) is going to be used for power management.
>>> + *
>>> + * Add a series of clocks described in the 'clocks' device-tree node for
>>> + * a device to the list of clocks used for the power management of @dev.
>>
>> This adds all clocks referenced by the device node, while not all clocks may
>> be suitable for power management, and some of them may be under explicit
>> driver control.
>> Cfr. drivers/clk/shmobile/renesas-cpg-mssr.c:cpg_mssr_attach_dev(), which
>> looks for module clocks, or core clocks explicitly listed in core_pm_clks[].
>>
>> What about adding an optional filter function to filter for suitable clocks?
>
> Yes that sounds reasonable. Are you filtering on clock ID? Would it work
> to allow the caller to pass a filter function which takes a struct *clk
> as it's only argument?  Or do you prefer we call
> of_parse_phandle_with_args(np, "clocks", "#clock-cells", i, &clkspec)
> and return the clkspec info?

cpg_mssr_attach_dev() filters on clkspec.

As pm_clk_add_clks_of() has "_of" in the name (BTW, should it be called
of_pm_clk_add_clks()), I think passing the clkspec makes more sense than
passing a struct clk *.

>>> +int pm_clk_add_clks_of(struct device *dev)
>>> +{
>>> +       struct clk **clks;
>>> +       unsigned int i, count;
>>> +       int ret;
>>> +
>>> +       if (!dev || !dev->of_node)
>>> +               return -EINVAL;
>>> +
>>> +       count = of_count_phandle_with_args(dev->of_node, "clocks",
>>> +                                          "#clock-cells");
>>> +       if (count == 0)
>>> +               return -ENODEV;
>>> +
>>> +       clks = kcalloc(count, sizeof(*clks), GFP_KERNEL);
>>> +       if (!clks)
>>> +               return -ENOMEM;
>>> +
>>
>> Don't you have to call pm_clk_create() here, to allocate a pm_subsys_data
>> structure that pm_clk_add_clk() can populate?
>
> This function will return an error when pm_clk_add_clk() is called if
> the user has not called pm_clk_create() first. It seems more natural to
> me that the user should call pm_clk_create() before calling
> pm_clk_add_clks_of() which is the same convention used for adding clocks
> by the other APIs to add clocks.

OK. That way the caller can add more clocks if needed. I missed that case.

>>> +       for (i = 0; i < count; i++) {
>>> +               clks[i] = of_clk_get(dev->of_node, i);
>>> +               if (IS_ERR(clks[i])) {
>>> +                       ret = PTR_ERR(clks[i]);
>>> +                       goto error;
>>> +               }
>>> +
>>> +               ret = pm_clk_add_clk(dev, clks[i]);
>>> +               if (ret) {
>>> +                       clk_put(clks[i]);
>>> +                       goto error;
>>> +               }
>>> +       }
>>> +
>>> +       kfree(clks);
>>> +
>>> +       return 0;
>>> +
>>> +error:
>>> +       while (i--)
>>> +               pm_clk_remove_clk(dev, clks[i]);
>>
>> Just pm_clk_destroy(dev) to destroy all at once?
>
> Right, however, this will remove all clocks associated with the device
> and not just those we have added. It is probably very unlikely that
> someone would call pm_clk_add_clks_of() and had previously called
> pm_clk_add(), but it seems best to not make any assumptions and only
> remove the clocks that were actually added. I guess that it would be
> possible to check to see if there were any clocks already added when
> this function is called and return an error in that case.
>
> All of that said, I do agree that it may be simpler, if we do call
> pm_clk_create() from within pm_clk_add_clks_of() and this would allow us
> to pmc_clk_destroy() in the error path. So if this is preferred I could
> do that, but I think that I would not allow clocks to be added if
> clock_list is not empty when this function is called.

Given the above, your code is fine.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
