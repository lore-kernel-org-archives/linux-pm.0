From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH] cpuidle: fix ARCH_NEEDS_CPU_IDLE_COUPLED dependency warning
Date: Sun, 9 Jun 2013 14:38:35 -1000
Message-ID: <CAMbhsRQkiz2Wtsfi6rFcw0vXZM5uFbeuJD+3f4+R+637LCAS5A@mail.gmail.com>
References: <1370626856-2876-1-git-send-email-daniel.lezcano@linaro.org>
	<51B21D65.3040604@ti.com>
	<201306072121.58719.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:55962 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084Ab3FJAig (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 9 Jun 2013 20:38:36 -0400
Received: by mail-qc0-f169.google.com with SMTP id c10so2943266qcz.14
        for <linux-pm@vger.kernel.org>; Sun, 09 Jun 2013 17:38:35 -0700 (PDT)
In-Reply-To: <201306072121.58719.arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "patches@linaro.org" <patches@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>

On Fri, Jun 7, 2013 at 9:21 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Friday 07 June 2013, Santosh Shilimkar wrote:
> > > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > > index f49cd51..831e89e 100644
> > > --- a/arch/arm/mach-omap2/Kconfig
> > > +++ b/arch/arm/mach-omap2/Kconfig
> > > @@ -83,7 +83,7 @@ config ARCH_OMAP4
> > >       depends on ARCH_OMAP2PLUS
> > >       depends on ARCH_MULTI_V7
> > >       select ARCH_HAS_OPP
> > > -     select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
> > > +     select ARCH_NEEDS_CPU_IDLE_COUPLED if (SMP && CPU_IDLE)
> >
> > I remember Colin mentioning about above dependency is taken care
> > already in design [1]
>
> It's a matter of how it gets represented in Kconfig. Right now
> the ARCH_NEEDS_CPU_IDLE_COUPLED symbol has a dependency on CPU_IDLE,
> so we cannot select it if CPU_IDLE is not set (or get a build time
> warning).
>
> I originally suggested removing the dependency, but Daniel preferred
> to leave it there as an explicit dependency so it is required to
> do this change instead.

ARCH_NEEDS_CPU_IDLE_COUPLED should never have been moved inside "if
CPU_IDLE".  It was designed to be outside the CPU_IDLE dependency so
archs could select it without having to know about its dependencies.
Just move it back outside if CPU_IDLE in drivers/cpuidle/Kconfig and
you won't have to mess with every arch that uses it.  If CPU_IDLE=n
none if it will get compiled, so there is no need for the extra
dependency.
