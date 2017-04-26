From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 0/4] PM / Domains: Add support for explicit control of
 PM domains
Date: Wed, 26 Apr 2017 11:55:50 +0200
Message-ID: <CAPDyKFrg+L_U6ztzpUdQMuemXyPWvtWVt06GumXa1MoTjJesWg@mail.gmail.com>
References: <1490710443-27425-1-git-send-email-jonathanh@nvidia.com>
 <d2e3ceaa-57e2-033d-ecd1-a3b2bd8ffa26@nvidia.com> <CAPDyKFoJ58pwGz2U90ob8a8cY=hEbE-wLBHZ0BBzqPoLW_wgGA@mail.gmail.com>
 <CAMuHMdWvS6_Zf1nn1=zVLb1qNChyk+B6BDZsK9P9oKRBEpPKMg@mail.gmail.com>
 <CAPDyKFqqZPXpxCTDy079QeiAorLVrXZssQ5SvXLWa3oab21b5g@mail.gmail.com> <CAMuHMdWNnWdYop_U4BGznxDND3WK-V7hnCBbnPoUDzUHBBpgHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdWNnWdYop_U4BGznxDND3WK-V7hnCBbnPoUDzUHBBpgHA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 26 April 2017 at 11:17, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> Hi Ulf,
>
> On Wed, Apr 26, 2017 at 11:04 AM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> On 26 April 2017 at 10:06, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
>>> On Tue, Apr 25, 2017 at 9:34 PM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>>>> However, we currently know about at least two different SoCs that need
>>>> this. Perhaps we can extend the below list to justify adding a new
>>>> framework/APIs. Something along the lines what you propose in $subject
>>>> patchset.
>>>>
>>>> 1) Nvidia; to solve the USB super-speed host/device problem.
>>>> 2) QCOM, which has pointed to several cases where the PM topology is
>>>> laid out like devices having two PM domains..
>>>> 3?) I don't fully remember - but I think Geert also pointed to some
>>>> examples where a device could reside in a clock domain but also in
>>>> power domain for a Renesas SoC!?
>>>> 4) ?
>>>
>>> Most Renesas SoCs have module clocks, which we model as a clock domain.
>>> Some Renesas SoCs have power domains for CPUs, others have them for
>>> devices as well.
>>> As we always provide a virtual "always-on" power domain in the power domain
>>> controller, all devices can refer to it using "power-domains" properties,
>>> and the driver for the power domain controller can just forward the clock
>>> domain operations to the clock driver.
>>
>> Okay, thanks for clarifying this.
>>
>> Thinking about this as bit more, when I realized that *if* we would
>> add a new PM domain framework for explicit control of PM domains, that
>> would mean you need to deploy support for that in the drivers.
>
> Correct.  And we have to update DT bindings and DTS.
>
>> On the other hand, as you anyway would need to change the drivers, you
>> could instead deploy clock support in the drivers, which would avoid
>> using the clock domain. In that way, you could still stay with one PM
>> domain pointer per device, used to control the power domains instead.
>> Right? Or would that have other implications?
>
> That's exactly what we're doing already.

No really, but perhaps I was not clear enough.

Currently you deploy only runtime PM support in the driver and don't
do any clk_get() etc. Then you have a PM domain (genpd) attached to
the device and makes use of genpd's device specific callbacks, in
struct gpd_dev_ops ->start|stop(), which allows you to control clocks
for each device. Of course this is perfectly okay.

So then my question is/was; does there exist cases when these devices
(already attached to a PM domain) would needed to be attach to yet
another separate PM domain? From the nicely detailed description
below, I find the answer to be *no*!?

> Which means that if you allow multiple entries in power-domains, we
> have to change drivers, DT bindings, and DTS again (which we may
> decide not to do ;-)
>
> On SH/R-Mobile, we always did it that way, as the user manual had an
> explicit "always-on" power domain.
>
> On R-Car Gen2, the power domains contain CPU and L2 and GPU only,
> so devices had their power-domains pointing to the clock controller.
>
> On R-Car Gen3, some devices were moved into power domains, so we
> generalized this by creating a virtual "always-on" power domain, and
> letting all devices point their power-domains properties to the power
> domain controller, which forwards clock handling to the clock controller.
> For consistency, this was applied to R-Car Gen2 as well.
>
> Cfr. some late relics fixed in e.g. commit 24b2d930a50662c1
> ('ARM: dts: r8a7794: Use SYSC "always-on" PM Domain for sound'),
> but technically the fix was not needed, as it worked fine without.

Thanks for the detailed summary!

Kind regards
Uffe
