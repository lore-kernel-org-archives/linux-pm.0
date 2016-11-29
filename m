From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] PM / Domains: Add support for devices that require
 multiple domains
Date: Tue, 29 Nov 2016 12:33:02 +0100
Message-ID: <52af1977-8ca3-40d1-43bb-920c5b933f94@samsung.com>
References: <CAPDyKFoFPNNnoc-7G34A7a4Yo8f=WUyurNP1evabw3MOEubEoA@mail.gmail.com>
 <90faea7d-65b6-590a-83f1-24fcdffa0569@nvidia.com>
 <CAPDyKFr4S3tM7KL2hfwJ3R4e5z1-Zd99aMhMSgVq4XzkrUUdow@mail.gmail.com>
 <fd7c8f40-2a9f-b71c-bd11-43ee657441ae@nvidia.com>
 <63670abf-1d58-a7e3-6927-0c815d44d8a1@nvidia.com>
 <d961715d-820a-dd63-e3a9-c908ce465582@nvidia.com>
 <CAJZ5v0hqdjGJ8v+k-Nkp_bx-fj_yTD5WoMeVfkmqBuTwCjRoyA@mail.gmail.com>
 <d9a4c1cd-6682-663d-e30d-cc85f665cf64@nvidia.com>
 <m2lgwbxtea.fsf@baylibre.com>
 <f54b4912-bfdd-aa2c-6f04-e09ed4207af6@nvidia.com>
 <CGME20161124023037epcas4p2891cf07f4bc49115f210c1298b0f9b82@epcas4p2.samsung.com>
 <20161124023014.GK6095@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20161124023014.GK6095-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Stephen,

Thanks for pointing to my patches, but I would like to clarify a few things.

On 2016-11-24 03:30, Stephen Boyd wrote:
> On 11/22, Jon Hunter wrote:
>> On 22/11/16 18:26, Kevin Hilman wrote:
>>> Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> writes:
>>>> However, I would rather the client of
>>>> the power-domains specify which power-domains they require and
>>>> dynamically nested the power-domains at runtime. This is slightly
>>>> different to what I proposed in this RFC, but it is not really beyond
>>>> the bounds of what we support today IMO. What is missing is a means to
>>>> do this dynamically and not statically.
>>>>
>>>> By the way, I am not sure if you are suggesting that for devices that
>>>> may need multiple power-domains we should architect the driver
>>>> differently and split it up in some way such that we have a power-domain
>>>> per device. But for the case of the Tegra XHCI it is quite complex
>>>> because the driver loads firmware which runs on a micro-controller and
>>>> we need to manage the various power-domains that are used.
>>> IMO, constructing a network of new struct devices just to workaround
>>> limitations in the framework doesn't sound quite right either.
>> I agree.
>>
> Marek is attempting to do this for the samsung clock
> controller[1] (patch #5 is informative).

You probably meant patch #3 / #4, which is a patch for Exynos 4412
( https://marc.info/?l=linux-arm-kernel&m=147731142926053&w=2 ).

Patch #5 is for Exynos 5433, which already has separate nodes for
each clock sub-controller, so there is no problem to add generic
power domains there (see multiple CMU nodes):

https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/exynos/exynos5433.dtsi#n261

>  From what I can tell
> they have one DT node for their clock controller because it's one
> register address space to control clocks. But, certain clocks
> exposed by that driver only work when certain power domains are
> enabled. For example, they have a clock controller that exposes
> clock signals for multimedia hardware blocks like video
> accelerators, gpus, and cameras. The clocks seem to have been
> placed inside different power domains for the multimedia hardware
> they're associated with, so there may be 10 or so power domains
> that need to be enabled at different times for different clocks
> to work. If the GPU power domain isn't enabled when the GPU
> clocks are touched by the driver, things break, etc.
>
> In the proposed patchset, we have the top-level clock controller
> node with subnodes for each power domain that needs to be
> associated with clocks inside these different multimedia blocks.

This is valid only for the Exynos4412 case (and not-yet-posted
Exynos5422), which has a single clock controller node and patch #4
added a sub-node for ISP clocks part (the only one which in fact
is in the other power domain).

> So we end up with one parent device and attached driver for the
> clock driver, and then that driver populates child nodes as
> devices and matches up clocks with child nodes while registering
> clks with clk_register(). Because we pass a dev pointer to
> clk_register, we associate different devices with different
> clocks all from the same top-level clock controller device
> driver. Then clk framework calls runtime_pm APIs with devices
> used during clk registration.

Right, this is how I did it for Exynos4412 case.

> Some of those devices don't have
> any driver bound to them, which feels odd.

Well, I don't get this. In the proposed patches each sub-node has
a separate driver, none is left without a driver.

> This seems like a case where we really want a better way to
> explicitly control power domains without making up subnodes and
> registering struct devices just to work around the one device to
> one genpd construct we have today. Maybe power domains just don't
> map to genpd though and that's the disconnect.

Having an API for full control over multiple power domain assigned to
a single device node might indeed solve somehow this problem, but as
long as runtime pm is tied to struct device, this will again end in
creating virtual sub-devices per each power domain to fit runtime pm
principles. However we might be able to avoid creating sub-nodes in
the device tree.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
