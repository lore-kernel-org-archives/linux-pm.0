From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v4 2/2] iommu/exynos: Add proper runtime pm support
Date: Tue, 8 Nov 2016 23:14:37 +0100
Message-ID: <20161108221437.GC13978@wotan.suse.de>
References: <1475136751-31340-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20160929081240eucas1p231c1ab5c5936886cbec6bc3f5267c940@eucas1p2.samsung.com>
 <1475136751-31340-3-git-send-email-m.szyprowski@samsung.com>
 <20161006173756.GK3296@wotan.suse.de>
 <87aeb58b-bda0-93c5-e51d-ab9be0b9d518@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51352 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751095AbcKHWOm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Nov 2016 17:14:42 -0500
Content-Disposition: inline
In-Reply-To: <87aeb58b-bda0-93c5-e51d-ab9be0b9d518@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski.k@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lars-Peter Clausen <lars@metafoo.de>, Dmitry Torokhov <dmitry.>

On Mon, Oct 10, 2016 at 03:32:06PM +0200, Marek Szyprowski wrote:
> Hi Luis
> 
> 
> On 2016-10-06 19:37, Luis R. Rodriguez wrote:
> > On Thu, Sep 29, 2016 at 10:12:31AM +0200, Marek Szyprowski wrote:
> > > This patch uses recently introduced device links to track the runtime pm
> > > state of the master's device. This way each SYSMMU controller is runtime
> > > activated when its master's device is active
> > instead of?
> 
> instead of keeping SYSMMU controller runtime active all the time.

I thought Rafael's work was for suspend/resume, not for runtime suspend.
Is it for both ? Because as far as I can tell this was painted to help
with suspend/resume ?

> > BTW what is the master device of a SYSMMU? I have no clue about these
> > IOMMU devices here.
> 
> Here is a more detailed description of IOMMU hardware I wrote a few days ago
> for Ulf:
> http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1231006.html
> 
> In short: there is a SYSMMU controller and its master device - a device,
> which performs DMA operations. That SYSMMU sits in between system memory
> and the master device, so it performs mapping of DMA addresses to physical
> memory addresses on each DMA operation.

So you seek a run time power optimization ? Or a fix on suspend? Or both?

> > > and can save/restore its state instead of being enabled all the time.
> > I take it this means currently even if the master device is disabled
> > (whatever that is) all SYSMMU controllers are kept enabled, is that right?
> > The issue here is this wastes power? Or what is the issue?
> 
> Yes, the issue here is the fact that SYSMMU is kept active all the time,
> what in turn prevent the power domain for turning off even if master device
> doesn't do anything and is already suspended. This directly (some clocks
> enabled) and in-directly (leakage current) causes power looses.

Thanks for the confirmation so really the biggest concern here was run time PM.

> > > This way SYSMMU controllers no
> > > longer prevents respective power domains to be turned off when master's
> > > device is not used.
> > So when the master device is idle we want to also remove power from the
> > controllers ? How much power does this save on a typical device in the
> > market BTW ?
> 
> The main purpose of this patchset is to let power domains to be turned off,
> because with the current code all domains are all the time turned on,
> because
> SYSMMU controllers prevent them from turning them off.

I see.. I think the audio folks already addressed this with DAPM, but granted
this was for audio. Then I was also referred to the DRM / Audio component
framework, has this been looked into? v4l folks have v4l async stuff but
its not clear if that help with run time PM. I'm mentioning these given it'd be
silly to re-invent the wheel, additionally if we now have a generic solution
everyone can jump on board with there is quite a bit of work we can do to
dump a lot of old legacy crap.

> If you want I can measure the power consumption of the idle board with all
> domains enabled and disabled if you want to see the numbers. On the other
> board
> disabling most power domains in idle state (the clocks were already
> disabled)
> gave me about 20mA savings (at 3.7V), what is a significant value for the
> battery powered device.

Thanks, this means nothing to me, however it would be value-add to the commit log
as anyone reviewing  this can understand what the goal / savings was for exactly.

> > 
> > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > ---
> > >   drivers/iommu/exynos-iommu.c | 225 ++++++++++++++++++-------------------------
> > >   1 file changed, 94 insertions(+), 131 deletions(-)
> > I'm reviewing the device link patches now but since this is a demo of
> > use of that I'll note the changes here are pretty large and it makes
> > it terribly difficult for review. Is there any way this patch can be split
> > up in to logical atomic pieces that only do one task upon change ?
> 
> I will try to split it a bit, but I cannot promise that much can be done
> to improve readability for someone not very familiar with the driver
> internals.

I've heard this before, I don't buy it but lets see!

  Luis
