From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] cpufreq: exynos: allow modular build
Date: Sat, 31 Jan 2015 23:37:01 +0100
Message-ID: <2204000.ofqAym34Rh@wuerfel>
References: <1422451015-390439-1-git-send-email-arnd@arndb.de> <5048920.rXbXJT1FvO@wuerfel> <20150130215118.GA14374@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:51497 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbbAaWhM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 31 Jan 2015 17:37:12 -0500
In-Reply-To: <20150130215118.GA14374@developer.amazonguestwifi.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>, Zhang Rui <rui.zhang@intel.com>

On Friday 30 January 2015 17:51:24 Eduardo Valentin wrote:
> > > @@ -90,6 +84,20 @@ config ARM_EXYNOS_CPU_FREQ_BOOST_SW
> > >  
> > >       If in doubt, say N.
> > >  
> > > +config ARM_EXYNOS5440_CPUFREQ
> > > +   bool "SAMSUNG EXYNOS5440"
> > > +   depends on SOC_EXYNOS5440
> > > +   depends on HAVE_CLK && OF
> > > +   select PM_OPP
> > > +   default y
> > > +   help
> > > +     This adds the CPUFreq driver for Samsung EXYNOS5440
> > > +     SoC. The nature of exynos5440 clock controller is
> > > +     different than previous exynos controllers so not using
> > > +     the common exynos framework.
> > > +
> > > +     If in doubt, say N.
> > 
> > I believe this one also has to be tristate, for the same reason.
> > 
> 
> I agree with you that it is better if we make it tristate. So, on my
> side, I have no concerns changing it to tristate.
> 
> However, the exynos5440 cpufreq driver does not depend on of thermal as
> of today, and therefore, I did not touch this driver for this matter.
> Meaning, if it is not causing troubles, no need to mess with it.
> 
> But I can add this change. No issues, on my side.

Sorry, my mistake. I remembered incorrectly that the problem was
in both modules, but you are right that it does not exist in the exynos5440
one. It is not a mistake to turn this into tristate, but there is no
immediate neeed, so either version is fine.

	Arnd
