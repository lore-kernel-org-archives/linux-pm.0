From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] cpuidle: fix ARCH_NEEDS_CPU_IDLE_COUPLED dependency warning
Date: Fri, 7 Jun 2013 21:21:58 +0200
Message-ID: <201306072121.58719.arnd@arndb.de>
References: <1370626856-2876-1-git-send-email-daniel.lezcano@linaro.org> <51B21D65.3040604@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:64319 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608Ab3FGTWh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2013 15:22:37 -0400
In-Reply-To: <51B21D65.3040604@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@sisk.pl, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Colin Cross <ccross@android.com>

On Friday 07 June 2013, Santosh Shilimkar wrote:
> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > index f49cd51..831e89e 100644
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -83,7 +83,7 @@ config ARCH_OMAP4
> >       depends on ARCH_OMAP2PLUS
> >       depends on ARCH_MULTI_V7
> >       select ARCH_HAS_OPP
> > -     select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
> > +     select ARCH_NEEDS_CPU_IDLE_COUPLED if (SMP && CPU_IDLE)
>
> I remember Colin mentioning about above dependency is taken care
> already in design [1]

It's a matter of how it gets represented in Kconfig. Right now 
the ARCH_NEEDS_CPU_IDLE_COUPLED symbol has a dependency on CPU_IDLE,
so we cannot select it if CPU_IDLE is not set (or get a build time
warning).

I originally suggested removing the dependency, but Daniel preferred
to leave it there as an explicit dependency so it is required to
do this change instead.

	Arnd
