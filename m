From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/1] thermal: Exynos: Add missing dependency
Date: Thu, 15 Nov 2012 12:14:26 +0800
Message-ID: <1352952866.2143.25.camel@rzhang1-mobl4>
References: <1352875704-2178-1-git-send-email-sachin.kamat@linaro.org>
	 <1352938284.2143.5.camel@rzhang1-mobl4>
	 <CAK9yfHzCmWwaQa79JFoa2Y1Q6-tjdFS+M8vScXwwCTnfgP9nUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41647 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767553Ab2KOEOa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 14 Nov 2012 23:14:30 -0500
In-Reply-To: <CAK9yfHzCmWwaQa79JFoa2Y1Q6-tjdFS+M8vScXwwCTnfgP9nUA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, durgadoss.r@intel.com, patches@linaro.org, akpm@linux-foundation.org, Amit Daniel Kachhap <amit.kachhap@linaro.org>

On Thu, 2012-11-15 at 08:52 +0530, Sachin Kamat wrote:
> Hi Zhang,
> 
> Thanks for your review comments.
> 
> On 15 November 2012 05:41, Zhang Rui <rui.zhang@intel.com> wrote:
> > Hi, Sachin,
> >
> > thanks for catching the problem.
> >
> > On Wed, 2012-11-14 at 12:18 +0530, Sachin Kamat wrote:
> >> CPU_FREQ_TABLE depends on CPU_FREQ. Selecting CPU_FREQ_TABLE without checking
> >> for dependencies gives the following compilation warnings:
> >> warning: (ARCH_TEGRA_2x_SOC && ARCH_TEGRA_3x_SOC && UX500_SOC_DB8500 &&
> >> CPU_THERMAL && EXYNOS_THERMAL) selects CPU_FREQ_TABLE which has unmet
> >> direct dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ)
> >>
> > Amit,
> >
> > how is exynos driver supposed to work?
> > do you want the exynos driver still be loaded without CPU_THERMAL?
> > If yes, EXYNOS_THERMAL should not select CPU_FREQ_TABLE.
> > If no, EXYNOS_THERMAL should depends on CPU_THERMAL instead of THERMAL.
> > and CPU_THERMAL will select CPU_FREQ_TABLE instead.
> >
> > IMO, either of the above solution will be more proper to fix this
> > warning.
> 
> I will discuss with Amit and send an updated patch to fix this.
> 
I checked the code of exynos driver, it fails to load if no
cpufreq_cooling device found, which means it depends on CPU_THERMAL.

I'm not sure if this is the behavior you want, but IMO, exynos driver
should register its critical trip point to the generic thermal layer
instead, when CPU_THERMAL is not set.

thanks,
rui
> 
> >
> > thanks,
> > rui
> >
> >> Cc: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> >> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> >> ---
> >> Build tested using exynos4_defconfig on linux-next tree of 20121114.
> >> ---
> >>  drivers/thermal/Kconfig |    2 +-
> >>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> >> index 266c15e..197b7db 100644
> >> --- a/drivers/thermal/Kconfig
> >> +++ b/drivers/thermal/Kconfig
> >> @@ -50,7 +50,7 @@ config RCAR_THERMAL
> >>
> >>  config EXYNOS_THERMAL
> >>       tristate "Temperature sensor on Samsung EXYNOS"
> >> -     depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5) && THERMAL
> >> +     depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5) && THERMAL && CPU_FREQ
> >>       select CPU_FREQ_TABLE
> >>       help
> >>         If you say yes here you get support for TMU (Thermal Managment
> >
> >
> 
> 
> 


