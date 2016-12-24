From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 3/3] dmaengine: pl330: Don't require irq-safe runtime PM
Date: Sat, 24 Dec 2016 11:19:41 +0200
Message-ID: <20161224091941.GA4254@kozik-lap>
References: <1482408689-21971-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161222121159epcas1p2e64486c51ae3b824f35ffb082d04f178@epcas1p2.samsung.com>
 <1482408689-21971-4-git-send-email-m.szyprowski@samsung.com>
 <20161223024832.GA4178@kozik-lap>
 <7e12d7cc-2dc1-2708-cabe-987d650ba3c5@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f193.google.com ([209.85.210.193]:34389 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752505AbcLXJTy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Dec 2016 04:19:54 -0500
Content-Disposition: inline
In-Reply-To: <7e12d7cc-2dc1-2708-cabe-987d650ba3c5@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Inki Dae <inki.dae@samsung.com>

On Fri, Dec 23, 2016 at 11:38:19AM +0100, Marek Szyprowski wrote:

(...)

> >>The main assumption for it is an
> >>observation that there can be only one slave device using each DMA channel.
> >Wait, observation, real requirement or assumption?
> >
> >Later in the code I see adding such requirement.
> 
> Well, observation which result in assumption. I cannot imagine a hardware
> which
> shares slave DMA channel between devices. Also none of the existing platform
> does it.

OK for me.

> 
> >>Using recently introduced device dependencies (links) infrastructure one can
> >>ensure proper runtime PM state of PL330 DMA controller. In this approach in
> >>pl330_alloc_chan_resources() function a new dependency is being created
> >>between PL330 DMA controller device (as supplier) and given slave device
> >>(as consumer). This way PL330 DMA controller device runtime active counter
> >>is increased when the slave device is resumed and decreased the same time
> >>when given slave device is put to suspend. This way it has been ensured to
> >>keep PL330 DMA controller runtime active if there is an active used of any
> >>of its DMA channels. Slave device pointer is initially stored in per-channel
> >>data in of_dma_xlate callback. This is similar to what has been already
> >>implemented in Exynos IOMMU driver in commit 2f5f44f205cc958b
> >>("iommu/exynos: Use device dependency links to control runtime pm").
> >Sounds convincing... Interesting approach!
> >
> >My doubts are:
> >1. What with more then one slave device? (assumption?)
> 
> See above, there are no such cases.
> 
> >2. If slave device does not implement runtime PM, then pl330 will be
> >    active all the time?
> 
> Right, but the goal is to have runtime pm added to all devices in the
> system.
> 
> >3. If slave device implements runtime PM in a way that it's enabled in
> >    probe and released in remove, then pl330 will be active all the time?
> 
> Then it will force power domain to be turned on all the time and even
> optional
> fine-grained irq-safe runtiem pm in pl330 driver won't help much to reduce
> power
> consumption. I assume that the real goal with runtime pm is to let
> respective
> power domains to be turned off, what gives the best results in terms of
> power
> saving.

Indeed existing runtime PM for pl330 was not bringing much benefits of
its own - only clocks were enabled/disabled.

Thanks for clarifications.

(...)

> >>@@ -2113,14 +2089,63 @@ static struct dma_chan *of_dma_pl330_xlate(struct of_phandle_args *dma_spec,
> >>  	if (chan_id >= pl330->num_peripherals)
> >>  		return NULL;
> >>+	if (!pl330->peripherals[chan_id].slave)
> >>+		pl330->peripherals[chan_id].slave = slave;
> >>+	else if (pl330->peripherals[chan_id].slave != slave) {
> >>+		dev_err(pl330->ddma.dev,
> >>+			"Can't use same channel with multiple slave devices!\n");
> >>+		return NULL;
> >>+	}
> >This could be nicely split into separate patch.
> 
> Okay, if you want, I can move this change to separate patch.

Yes, please do it. Beside that patch looked fine to me.

Best regards,
Krzysztof
