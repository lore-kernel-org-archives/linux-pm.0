From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/9] ARM: cpuidle: remove useless declaration
Date: Mon, 08 Apr 2013 22:50:21 +0200
Message-ID: <3144551.suxBcA9vOB@vostro.rjw.lan>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org> <515C1F3B.5040008@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:54445 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964875Ab3DHUmi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 8 Apr 2013 16:42:38 -0400
In-Reply-To: <515C1F3B.5040008@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, deepthi@linux.vnet.ibm.com, linaro-kernel@lists.linaro.org, swarren@wwwdotorg.org, patches@linaro.org, linux-pm@vger.kernel.org, rnayak@ti.com, nsekhar@ti.com, josephl@nvidia.com, linux-tegra@vger.kernel.org, horms+renesas@verge.net.au, linux-arm-kernel@lists.infradead.org, lenb@kernel.org

On Wednesday, April 03, 2013 02:23:23 PM Daniel Lezcano wrote:
> On 04/03/2013 02:15 PM, Daniel Lezcano wrote:
> > The noop functions code is not necessary because the header file is
> > included in files which are compiled when CONFIG_CPU_IDLE is on.
> >
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> I have been involved in the development of this file. I know Rob is no
> longer working on this neither monitoring the code.
> 
> Russell are you ok with this patch ? Rafael needs your ack to take this
> patch into its tree.

Well, since nothing in the cpuidle directory seems to really depend on this
patch, my suggestion is to merge it through the ARM tree when suitable.

Thanks,
Rafael


> > ---
> >  arch/arm/include/asm/cpuidle.h |    7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
> > index 2fca60a..7367787 100644
> > --- a/arch/arm/include/asm/cpuidle.h
> > +++ b/arch/arm/include/asm/cpuidle.h
> > @@ -1,13 +1,8 @@
> >  #ifndef __ASM_ARM_CPUIDLE_H
> >  #define __ASM_ARM_CPUIDLE_H
> >  
> > -#ifdef CONFIG_CPU_IDLE
> >  extern int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
> > -		struct cpuidle_driver *drv, int index);
> > -#else
> > -static inline int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
> > -		struct cpuidle_driver *drv, int index) { return -ENODEV; }
> > -#endif
> > +				    struct cpuidle_driver *drv, int index);
> >  
> >  /* Common ARM WFI state */
> >  #define ARM_CPUIDLE_WFI_STATE_PWR(p) {\
> 
> 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
