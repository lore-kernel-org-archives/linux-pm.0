From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: Re: [PATCH 2/4] ARM: exynos: cpuidle: Use the common cpuidle
 register routine
Date: Mon, 22 Jul 2013 11:35:10 +0200
Message-ID: <1445208.tM84QonONK@amdc1032>
References: <1374152070-21008-1-git-send-email-daniel.lezcano@linaro.org>
 <4097491.3y6BBYmzze@amdc1032> <51ECB6DE.9060701@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:29809 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757104Ab3GVJfZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2013 05:35:25 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MQB00HS5ZYYP970@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 22 Jul 2013 18:35:23 +0900 (KST)
In-reply-to: <51ECB6DE.9060701@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kgene.kim@samsung.com, rjw@sisk.pl, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org

On Monday, July 22, 2013 06:36:46 AM Daniel Lezcano wrote:
> On 07/19/2013 06:03 PM, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Hi,
> > 
> > On Thursday, July 18, 2013 02:54:28 PM Daniel Lezcano wrote:
> >> Now we have the same routine than the one handled by the cpuidle framework.
> > 
> > Small nitpick:
> > 
> > To be exact the routine is not the same, on error cpuidle_register() does
> > complete unregister operation of the cpuidle driver, exynos4_init_cpuidle()
> > just stops the registration procedure. 
> > 
> > The change itself is okay but the patch description could be better.
> 
> Ok, I will fix the changelog.
> 
> > Anyway all patches (#1-4) look fine to me. Thanks for this work.
> 
> Thanks for the review. I assume it is an acked-by right ?

Yes.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> > Best regards,
> 
> Kukjin,
> 
> shall I take the patchset in my tree ?
> 
> Thanks
>   -- Daniel
> 
> > --
> > Bartlomiej Zolnierkiewicz
> > Samsung R&D Institute Poland
> > Samsung Electronics
> >  
> >> Let's use it.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
> >>  arch/arm/mach-exynos/cpuidle.c |   24 +-----------------------
> >>  1 file changed, 1 insertion(+), 23 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
> >> index cc4b097..d8fc1a2 100644
> >> --- a/arch/arm/mach-exynos/cpuidle.c
> >> +++ b/arch/arm/mach-exynos/cpuidle.c
> >> @@ -41,8 +41,6 @@ static int exynos4_enter_lowpower(struct cpuidle_device *dev,
> >>  				struct cpuidle_driver *drv,
> >>  				int index);
> >>  
> >> -static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device);
> >> -
> >>  static struct cpuidle_driver exynos4_idle_driver = {
> >>  	.name			= "exynos4_idle",
> >>  	.owner			= THIS_MODULE,
> >> @@ -188,29 +186,9 @@ static void __init exynos5_core_down_clk(void)
> >>  
> >>  static int __init exynos4_init_cpuidle(void)
> >>  {
> >> -	int cpu_id, ret;
> >> -	struct cpuidle_device *device;
> >> -
> >>  	if (soc_is_exynos5250())
> >>  		exynos5_core_down_clk();
> >>  
> >> -	ret = cpuidle_register_driver(&exynos4_idle_driver);
> >> -	if (ret) {
> >> -		printk(KERN_ERR "CPUidle failed to register driver\n");
> >> -		return ret;
> >> -	}
> >> -
> >> -	for_each_online_cpu(cpu_id) {
> >> -		device = &per_cpu(exynos4_cpuidle_device, cpu_id);
> >> -		device->cpu = cpu_id;
> >> -
> >> -		ret = cpuidle_register_device(device);
> >> -		if (ret) {
> >> -			printk(KERN_ERR "CPUidle register device failed\n");
> >> -			return ret;
> >> -		}
> >> -	}
> >> -
> >> -	return 0;
> >> +	return cpuidle_register(&exynos4_idle_driver, NULL);
> >>  }
> >>  device_initcall(exynos4_init_cpuidle);

