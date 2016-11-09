From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 7/7] iommu/exynos: Use device dependency links to
 control runtime pm
Date: Thu, 10 Nov 2016 00:56:14 +0100
Message-ID: <CAJZ5v0i3_8AE_o7vx=5kyuc8+P0jFOvjTC3YB9gcJVyQ+pTSkA@mail.gmail.com>
References: <1476948173-21093-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161020072336eucas1p24a2b020f69b6ae1f55e1760e6e0e94f9@eucas1p2.samsung.com>
 <1476948173-21093-8-git-send-email-m.szyprowski@samsung.com>
 <20161107214747.GJ1764@wotan.suse.de> <4bc652ce-6cf9-f4df-4793-e126cf81079d@samsung.com>
 <20161108153044.GA6983@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161108153044.GA6983@wunner.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Kevin Hilman <khilman@kernel.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Tomasz Figa <tomasz.figa@gma>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 8, 2016 at 4:30 PM, Lukas Wunner <lukas@wunner.de> wrote:
> On Tue, Nov 08, 2016 at 08:27:12AM +0100, Marek Szyprowski wrote:
>> On 2016-11-07 22:47, Luis R. Rodriguez wrote:
>> > Has there been any review of the existing similar solutions out there
>> > such as the DRM / audio component framework? Would that help ?
>>
>> Nope, none of that solution deals with runtime pm.
>
> Well, they do.  Hybrid graphics laptops often have an HDA controller
> on the discrete GPU and I assume that's what Luis meant. There's code
> in drivers/gpu/vga/vga_switcheroo.c to make this (only sort of) work:
>
> * When the GPU is powered up/down, the HDA controller's driver is
>   instructed to pm_runtime_get/put the HDA device (see call to
>   set_audio_state() in vga_switcheroo_set_dynamic_switch()).
>
> * When a runtime PM ref is acquired on the HDA device, the
>   GPU is powered up (see vga_switcheroo_runtime_resume_hdmi_audio()).
>
>
> Unfortunately this is all fairly broken, e.g.:
>
> * If a runtime PM ref on the HDA device is held for more than 5 sec
>   (autosuspend delay of the GPU), the GPU will be powered down and
>   the HDA device will become inaccessible, regardless of the runtime
>   PM ref still being held (because vga_switcheroo_set_dynamic_switch()
>   doesn't check the refcount of the HDA device).
>
> * The DRM device is afforded direct-complete but the HDA device is not.
>   If the GPU is handled earlier by dpm_suspend(), then runtime PM will
>   have been disabled on the GPU and thus the HDA device will fail to
>   runtime resume before system sleep.
>
> Rafael's series allows representation of such inter-device dependencies
> in the PM core and can thus replace kludgy and broken "solutions" like
> the one above.
>
> There's one thing that I haven't understood myself though:  In an e-mail
> exchange in September Rafael has argued that the above-mentioned hybrid
> graphics use case "isn't a good [example] IMO.  That clearly is a case
> when two (or more) devices share power resources controlled by a single
> on/off switch.  Which is a clear use case for a PM domain."
>
> The same seems to apply to Marek's SYSMMU use case.  When applying device
> links to SYSMMU or hybrid graphics, we select one of the devices in the
> PM domain as master and have the other one depend on it as slave, i.e.
> a synthetic hierarchical relationship is established.
>
> I've responded to Rafael on September 18 that this can't be solved with
> a struct dev_pm_domain, but haven't received a reply since:
> https://lkml.org/lkml/2016/9/18/103

Well, that clearly fell off my radar, sorry about that.

The idea, roughly, is that if there is a single on/off switch acting
on multiple devices, you can (a) set up a PM domain tracking all of
those device's runtime PM invocations and (b) maintaining a reference
counter of devices still not suspended.  This way it would only turn
the switch off when all of the devices in question had been suspended.
Analogously, it would turn the switch on before resuming the first
device in the domain.  Of course, that code isn't available as a
library, you would need to implement it (or use genpd, but chances are
it is too heavy weight for the job).

In theory, it shouldn't really matter where the switch is and how it
is operated as long as the PM domain "driver" knows how to access it.
However, for that to work something would need to bind that "driver"
to the domain and something would need to know which devices needed to
be added to the PM domains during enumeration and the ordering of
things bringup matters a lot here, which is a problem.

So in short, you are right that for the GPU/HDA thing device links
would likely to be a simpler to use and still get the job done.

Thanks,
Rafael
