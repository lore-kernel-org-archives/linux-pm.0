From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v5 7/7] iommu/exynos: Use device dependency links to
 control runtime pm
Date: Thu, 10 Nov 2016 01:12:10 +0100
Message-ID: <20161110001210.GO13978@wotan.suse.de>
References: <1476948173-21093-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161020072336eucas1p24a2b020f69b6ae1f55e1760e6e0e94f9@eucas1p2.samsung.com>
 <1476948173-21093-8-git-send-email-m.szyprowski@samsung.com>
 <20161107214747.GJ1764@wotan.suse.de>
 <4bc652ce-6cf9-f4df-4793-e126cf81079d@samsung.com>
 <20161108153044.GA6983@wunner.de>
 <20161109235526.GN13978@wotan.suse.de>
 <CAJZ5v0g_UX_==q7JMRZfE=1COpFu28Z8NN1W_TpJ2sa7U79hKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g_UX_==q7JMRZfE=1COpFu28Z8NN1W_TpJ2sa7U79hKw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Marek Szyprowski <m.szyprowski@samsung.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Kevin Hilman <khilman@kernel.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.d>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 10, 2016 at 01:05:42AM +0100, Rafael J. Wysocki wrote:
> On Thu, Nov 10, 2016 at 12:55 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > On Tue, Nov 08, 2016 at 04:30:44PM +0100, Lukas Wunner wrote:
> >> On Tue, Nov 08, 2016 at 08:27:12AM +0100, Marek Szyprowski wrote:
> >> > On 2016-11-07 22:47, Luis R. Rodriguez wrote:
> >> > > Has there been any review of the existing similar solutions out there
> >> > > such as the DRM / audio component framework? Would that help ?
> >> >
> >> > Nope, none of that solution deals with runtime pm.
> >>
> >> Well, they do.  Hybrid graphics laptops often have an HDA controller
> >> on the discrete GPU and I assume that's what Luis meant. There's code
> >> in drivers/gpu/vga/vga_switcheroo.c to make this (only sort of) work:
> >>
> >> * When the GPU is powered up/down, the HDA controller's driver is
> >>   instructed to pm_runtime_get/put the HDA device (see call to
> >>   set_audio_state() in vga_switcheroo_set_dynamic_switch()).
> >>
> >> * When a runtime PM ref is acquired on the HDA device, the
> >>   GPU is powered up (see vga_switcheroo_runtime_resume_hdmi_audio()).
> >>
> >>
> >> Unfortunately this is all fairly broken, e.g.:
> >>
> >> * If a runtime PM ref on the HDA device is held for more than 5 sec
> >>   (autosuspend delay of the GPU), the GPU will be powered down and
> >>   the HDA device will become inaccessible, regardless of the runtime
> >>   PM ref still being held (because vga_switcheroo_set_dynamic_switch()
> >>   doesn't check the refcount of the HDA device).
> >>
> >> * The DRM device is afforded direct-complete but the HDA device is not.
> >>   If the GPU is handled earlier by dpm_suspend(), then runtime PM will
> >>   have been disabled on the GPU and thus the HDA device will fail to
> >>   runtime resume before system sleep.
> >>
> >> Rafael's series allows representation of such inter-device dependencies
> >> in the PM core and can thus replace kludgy and broken "solutions" like
> >> the one above.
> >>
> >> There's one thing that I haven't understood myself though:  In an e-mail
> >> exchange in September Rafael has argued that the above-mentioned hybrid
> >> graphics use case "isn't a good [example] IMO.  That clearly is a case
> >> when two (or more) devices share power resources controlled by a single
> >> on/off switch.  Which is a clear use case for a PM domain."
> >>
> >> The same seems to apply to Marek's SYSMMU use case.  When applying device
> >> links to SYSMMU or hybrid graphics, we select one of the devices in the
> >> PM domain as master and have the other one depend on it as slave, i.e.
> >> a synthetic hierarchical relationship is established.
> >>
> >> I've responded to Rafael on September 18 that this can't be solved with
> >> a struct dev_pm_domain, but haven't received a reply since:
> >> https://lkml.org/lkml/2016/9/18/103
> >
> > Rafael note:
> >
> > The one he asked here.
> 
> OK, so please see the message I've just sent. :-)
> 
> The bottom line is that there may be multiple ways to approach a
> problem like this and which of them works best really depends on the
> particular case.
> 
> You seem to be thinking that the device links infrastructure may not
> be necessary after all if there are other ways to address the problems
> it is intended for, but those other ways may still be less viable
> practically due to the complexity involved and similar.  Also they may
> lead to code duplication in different places that try to address those
> problems in a similar fashion, but slightly differently.

I was not arguing that, I have been suggesting that pre-existing solutions
should at least be reviewed and considered, if they are sub-par and
the device links infrastructure is much simpler and provides the same
solution folks should be alert and consider embracing it. If not and
its the other way around and we could generalize the others, it should
mean we could learn from them.

>From what I gather from Plumbers its not clear to me any of this review
was done, that's all. This leaves a series of open questions about those
existing solutions.

> All this is about providing people with reasonably straightforward and
> common ways to deal with certain class of problems showing up in
> multiple places.  It is not about getting the driver probe ordering
> right magically in one go.

Right, I just want us to avoid re-inventing the wheel.

  Luis
> 
> Thanks,
> Rafael
> 

-- 
Luis Rodriguez, SUSE LINUX GmbH
Maxfeldstrasse 5; D-90409 Nuernberg
