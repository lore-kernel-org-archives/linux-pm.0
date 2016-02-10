From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V5 11/14] soc: tegra: pmc: Add generic PM domain support
Date: Wed, 10 Feb 2016 19:25:08 +0100
Message-ID: <CAPDyKFrZ6tWBsQC0tyWWeChiZja3h_zcbaiX25ak-Zyp4MzqVw@mail.gmail.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
	<1453998832-27383-12-git-send-email-jonathanh@nvidia.com>
	<CAPDyKFpnUJA2pLSUOw8rkjyXLY6b__TM=38jsvYAZVhe+DS=zg@mail.gmail.com>
	<56BB7AF4.8040708@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56BB7AF4.8040708-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

[...]

>>
>>>  /**
>>>   * tegra_powergate_power_on() - power on partition
>>>   * @id: partition ID
>>> @@ -319,35 +512,20 @@ EXPORT_SYMBOL(tegra_powergate_remove_clamping);
>>>  int tegra_powergate_sequence_power_up(unsigned int id, struct clk *clk,
>>>                                       struct reset_control *rst)
>>
>> There seems to be two viable ways for a driver to control tegra powergates.
>>
>> 1)
>> $Subject patch enables the use of runtime PM.
>>
>> 2)
>> The current tegra_powergate_sequence_power_up() and
>> tegra_powergate_power_off() API.
>>
>> It seems fragile to allow both options, but perhaps your are
>> protecting this with some lock to prevent concurrent accesses?
>
> There is a lock protecting accesses to the PMC registers which
> ultimately control the power domain. However, may be it would be better
> to ensure that any power-domain registered with genpd cannot be
> controlled by the legacy APIs. I have added a bitmap to mark valid
> power-domains to ensure that only valid power domains can be controlled
> by these legacy APIs. I could mark the power-domain invalid after
> registering with genpd to ensure that it cannot be accessed by the
> legacy APIs.

That seems like a good way of making it more robust!

>
>> Also, I assume you need the two options in a transition phase, before
>> you have deployed runtime PM for these drivers?
>
> Right and some of the legacy APIs are entrenched in some drivers. So to
> keep the patch set manageable it seems best to get some support in place
> then start migrating the drivers.

Thanks for elaborating on this! I get and like the idea of moving forward!

[...]

>>> +
>>> +static void tegra_powergate_remove(struct tegra_pmc *pmc)
>>> +{
>>> +       struct tegra_powergate *pg, *n;
>>> +
>>> +       list_for_each_entry_safe(pg, n, &pmc->powergates_list, node) {
>>
>> The tegra powergate driver will hold a list of nvidia powergates
>> domains, and the generic PM domain will hold a list of all generic PM
>> domains.
>>
>> Perhaps there's a way to allow the generic PM domain to control this
>> by itself. If we for example used the struct device corresponding to
>> the powergate driver, genpd could use it to distinguish between
>> various instances of genpd structs..!? Maybe it would simplify the way
>> to deal with removing domains?
>
> Yes, that would be ideal. However, would have require changing
> genpd_init()? I am not sure how genpd would be able to access the device
> struct for the powergate driver because we don't provide this via any
> API I am aware of? And I am guessing that you don't wish to expose the
> gpd_list to the world either.
>
> If there is an easy way, I am open to it, but looking at it today, I am
> not sure I see a simple way in which we could add a new API to do this.
> However, may be I am missing something!

If we add a new __pm_genpd_init() API, that could require a struct
device to be provided. That API will thus invoke the existing
pm_genpd_init() but also deal with the extra things needed here.

I would also allow such an API to return an error code.

Correspondingly, pm_genpd_remove() could be required to be provided
with a struct device.

Existing users of pm_genpd_init() can then convert to
__pm_genpd_init() whenever suitable.

Of course, another option is just to add new member in the genpd
struct for the struct *device. The caller of pm_genpd_init() could
check it, but allow it to be NULL. Although, the pm_genpd_remove() API
would require that pointer to the struct device to be set...

What do you think?

Kind regards
Uffe
