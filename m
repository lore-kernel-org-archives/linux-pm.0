From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/4] ARM: exynos: cpuidle: Fallback to WFI,
 when AFTR is selected
Date: Wed, 24 Jul 2013 17:16:39 +0200
Message-ID: <2640946.7q3KRPlDWo@amdc1032>
References: <1374152070-21008-1-git-send-email-daniel.lezcano@linaro.org>
 <1566146.MINY8cDBRi@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:39411 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133Ab3GXPQ5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2013 11:16:57 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MQG005HX547S450@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Thu, 25 Jul 2013 00:16:56 +0900 (KST)
In-reply-to: <1566146.MINY8cDBRi@flatron>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Daniel Lezcano <daniel.lezcano@linaro.org>, kgene.kim@samsung.com, rjw@sisk.pl, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org


On Wednesday, July 24, 2013 10:32:47 AM Tomasz Figa wrote:
> Hi Daniel,
> 
> On Thursday 18 of July 2013 14:54:27 Daniel Lezcano wrote:
> > When there are several cpus online, the AFTR state does not work.
> > 
> > The AFTR must be selected only when there is one cpu online.
> > 
> > The previous code was already handling this case.
> > 
> > Simplified the code, especially the init routine to have the same init
> > pattern than the other drivers.
> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> >  arch/arm/mach-exynos/cpuidle.c |   13 ++-----------
> >  1 file changed, 2 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/arm/mach-exynos/cpuidle.c
> > b/arch/arm/mach-exynos/cpuidle.c index 17a18ff..cc4b097 100644
> > --- a/arch/arm/mach-exynos/cpuidle.c
> > +++ b/arch/arm/mach-exynos/cpuidle.c
> > @@ -147,16 +147,11 @@ static int exynos4_enter_lowpower(struct
> > cpuidle_device *dev, struct cpuidle_driver *drv,
> >  				int index)
> >  {
> > -	int new_index = index;
> > -
> >  	/* This mode only can be entered when other core's are offline */
> >  	if (num_online_cpus() > 1)
> > -		new_index = drv->safe_state_index;
> > +		return drv->states[0].enter(dev, drv, 0);
> > 
> > -	if (new_index == 0)
> > -		return arm_cpuidle_simple_enter(dev, drv, new_index);
> > -	else
> > -		return exynos4_enter_core0_aftr(dev, drv, new_index);
> > +	return exynos4_enter_core0_aftr(dev, drv, index);
> >  }
> > 
> >  static void __init exynos5_core_down_clk(void)
> > @@ -209,10 +204,6 @@ static int __init exynos4_init_cpuidle(void)
> >  		device = &per_cpu(exynos4_cpuidle_device, cpu_id);
> >  		device->cpu = cpu_id;
> > 
> > -		/* Support IDLE only */
> > -		if (cpu_id != 0)
> > -			device->state_count = 1;
> > -
> 
> Are you sure that this is okay? It means, assuming that you have CPU0 
> hotplug enabled, that you can enter the AFTR state if _any_ single core 
> remains plugged in, which is technically possible, but then wake-up will 
> occur on CPU0, which is not what cpuidle and hotplug code expect.

I worry that the current code is already broken in this respect as cpuidle
core is using driver->state_count for everything except creating/destroying
sysfs state entries. This is probably something that needs to be fixed in
the cpuidle core (I suspect that governors should use device->state_count
instead of driver->state_count but it would need confirmation from someone
that knows this code better) but in the meantime it could be fixed by adding
CPU0 check to exynos4_enter_lowpower() (if the last CPU != 0 then don't go
into AFTR mode).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> P.S. Please keep linux-samsung-soc@vger.kernel.org mailing list on Cc for 
> patches related to Samsung SoCs.
> 
> Best regards,
> Tomasz

