From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 4/7] drivers/cpufreq: Convert non-modular drivers to use
 builtin_driver_register
Date: Wed, 3 Jun 2015 16:59:30 -0400
Message-ID: <20150603205930.GO29898@windriver.com>
References: <1431287385-1526-1-git-send-email-paul.gortmaker@windriver.com>
 <1431287385-1526-5-git-send-email-paul.gortmaker@windriver.com>
 <20150512070444.GE32300@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:59323 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426AbbFCVAC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2015 17:00:02 -0400
Content-Disposition: inline
In-Reply-To: <20150512070444.GE32300@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

[Re: [PATCH 4/7] drivers/cpufreq: Convert non-modular drivers to use builtin_driver_register] On 12/05/2015 (Tue 12:34) Viresh Kumar wrote:

> On 10-05-15, 15:49, Paul Gortmaker wrote:
> > These files depend on Kconfig options all of which are a bool, so
> > we use the appropriate registration function, which avoids us
> > relying on an implicit inclusion of <module.h> which we are
> > doing currently.
> > 
> > While this currently works, we really don't want to be including
> > the module.h header in non-modular code, which we'd be forced
> > to do, pending some upcoming code relocation from init.h into
> > module.h.  So we fix it now by using the non-modular equivalent.
> > 
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Kukjin Kim <kgene@kernel.org>
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > ---
> >  drivers/cpufreq/exynos-cpufreq.c  | 2 +-
> 
> Exynos can be compiled as a module:
> 
> drivers/cpufreq/Kconfig.arm:
> 
> config ARM_EXYNOS_CPUFREQ
> 	tristate "SAMSUNG EXYNOS CPUfreq Driver"
> 	depends on CPU_EXYNOS4210 || SOC_EXYNOS4212 || SOC_EXYNOS4412 || SOC_EXYNOS5250

Thanks -- I think I managed to confuse myself into thinking it was
builtin always, courtesy of the "-y" in this Makefile line...

arm-exynos-cpufreq-y                    := exynos-cpufreq.o

I'll drop the exynos chunk from this patch and fix the implicit module.h
exynos usage in a new follow on patch, both to be sent shortly.

Paul.
--

> 
> --
> viresh
