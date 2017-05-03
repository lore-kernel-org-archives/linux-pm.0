From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 0/4] PM / Domains: Add support for explicit control of
 PM domains
Date: Wed, 3 May 2017 15:57:07 +0100
Message-ID: <107242f1-de90-b8bb-bc2c-feaf014485aa@nvidia.com>
References: <1490710443-27425-1-git-send-email-jonathanh@nvidia.com>
 <CAJZ5v0gMzN_zfC_2nnRtYFyFon3-_mnioQhNbDP0wsr91RnagA@mail.gmail.com>
 <ffe13074-9113-0a20-0fa6-76d0209dadfc@nvidia.com>
 <1832647.f77WMLkdQb@aspire.rjw.lan>
 <CAPDyKFokVKZfRAsEAB6ihx1FxW4JjarionyOwCATr3s+QW4aMg@mail.gmail.com>
 <b4e8fd34-e2f0-165d-aa22-32ba43a8dbed@nvidia.com>
 <CAPDyKFo-hfwbrY+AEMt0=fMshiT-BWvYDvGkKGqquTdowUvWHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFo-hfwbrY+AEMt0=fMshiT-BWvYDvGkKGqquTdowUvWHw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


On 03/05/17 14:43, Ulf Hansson wrote:
> On 3 May 2017 at 10:32, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>> On 03/05/17 09:12, Ulf Hansson wrote:
>>> On 2 May 2017 at 23:51, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
>>>> On Tuesday, May 02, 2017 11:10:29 AM Jon Hunter wrote:

...

>>>>> So unless I am misunderstanding you here, it seems that what we need to do
>>>>> is split the current genpd framework into a couple layers:
>>>>>
>>>>> 1. Low-level power resource control which has:
>>>>> - Power resource registration (ie. pm_genpd_init/remove())
>>>>> - Power resource provider registration (ie. of_genpd_add_xxx())
>>>>> - Power resource control (on/off etc)
>>>>
>>>> And reference counting.
>>>>
>>>>> - Power resource lookup (what this series is adding)
>>>>>
>>>>> 2. Generic power-domain infrastructure which is a client of the
>>>>> low-level power resource control that can automatically bind a device to
>>>>> a singular power resource entity (ie. power-domain).
>>>>
>>>> Something like that, but I would not require an additional complex framework
>>>> to be present below genpd.  I would make it *possible* for genpd to use that
>>>> framework if available, but if something simpler is sufficient, it should be
>>>> fine to use that instead.
>>>>
>>>> That is, I would allow genpd to use either a list of power resources or the on/off
>>>> callbacks provided by itself to cover different use cases.  That should be
>>>> flexible enough.
>>>>
>>>>> Is this along the right lines?
>>>>
>>>> It is, at least for the very narrow definition of "right" as being done along
>>>> the lines I would do that. :-)
>>>
>>> Let me first give some more background to how it looks like today.
>>>
>>> We have the following device callbacks being used by genpd:
>>>
>>> struct gpd_dev_ops {
>>>         int (*start)(struct device *dev);
>>>         int (*stop)(struct device *dev);
>>>         bool (*active_wakeup)(struct device *dev);
>>> };
>>>
>>> The ->stop|start() callback is invoked from genpd's
>>> ->runtime_suspend|resume() callbacks and may be assigned by a genpd
>>> client before it registers a genpd though pm_genpd_init(). Typically
>>> these callbacks can control any "power resources" that the genpd
>>> client finds suitable.
>>>
>>> To allow clients to instantiate "power resources" per device, we have
>>> the following callbacks, part of the struct generic_pm_domain.
>>>
>>> int (*attach_dev)(struct generic_pm_domain *domain, struct device *dev);
>>> void (*detach_dev)(struct generic_pm_domain *domain, struct device *dev);
>>>
>>> These callbacks are invoked when the device gets attached/detached
>>> from its PM domain (genpd).
>>>
>>> Moreover, the struct dev_pm_get_subsys_data is being used from within
>>> genpd (via struct pm_domain_data *domain_data), as it allows genpd and
>>> its client, to allocate and associate device specific data, which may
>>> be needed to store information about the "power resources".
>>>
>>> Currently Renesas SoCs are a good example of how to deploy this, as it
>>> implements its clock PM domain on top of this. In this regards I
>>> assume that we could consider the pm_clk_*() APIs as in control of the
>>> "power resources".
>>>
>>> So my conclusion is; unless I am totally misunderstanding the ideas
>>> here; I think we already have the infrastructure in place and we also
>>> have some good references of how to use it.
>>
>> So how do you represent more than one power-domain in device-tree for a
>> device which requires more than one? That is the fundamental problem IMO.
> 
> Describing this in DT is a separate, but related question. However can
> we first focus on how to manage this in software. :-)
> 
>>
>> From what Geert has described (and what I understand), it appears that
>> for the Renesas SoCs, the current infrastructure works because a device
>> has either a clock-domain or a power-domain and clock-domain. For
>> devices with both a power-domain and clock-domain, the clock-domain can
>> be handled via the clock callbacks (pm_clk_suspend/resume I assume).
>> However, this does not scale or work for devices that truly need more
>> than one power-domain which XUSB on Tegra does.
> 
> Exactly.
> 
>>
>>> What is missing, is how a call to pm_runtime_get_sync() by a driver,
>>> can inform the ->start() callback about what exact power resource(s)
>>> it shall turn on, because it may not always be all of them. Similar
>>> problem exists for pm_runtime_put().
>>
>> Yes that is missing too, but I still don't see how you bind a device to
>> more than one power-domain :-(
> 
> I think this is what Rafael wanted us avoid (because of the complexity
> involved). Instead the suggestion is to deal with this on top of the
> existing PM domain structure, as "power resources" instead. Unless I
> missed his point. :-)
> 
> Then *my* point is: To be able to implement that, still only allowing
> one PM domain per device, we would anyway need a new layer in-between
> the PM domain (genpd) and the driver controlling the device. Simply
> because these two entities, needs to be able to exchange information
> about which "power resources" that shall be turned off/on, when the
> driver do pm_runtime_get|put().

Right, but isn't this similar to what I was suggesting above in my
previous email?

I was proposing to have such a lower-layer by splitting the existing
genpd framework so the drivers would have the option of calling the
lower-level power control functions to look-up pm-domains and control
them directly from their rpm callbacks (if they need to). Same as we do
for clocks. This way you would not need to mess with the genpd ->start()
callback and leave it to the driver to handle itself as it knows what
needs to be done. This assumes that the device is never bound to the
pm-domain by the genpd core.

Cheers
Jon

-- 
nvpublic
