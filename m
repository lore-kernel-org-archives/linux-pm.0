From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH 1/1] thermal: Exynos: Add missing dependency
Date: Thu, 15 Nov 2012 06:45:29 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B9092632572FD@SHSMSX101.ccr.corp.intel.com>
References: <1352875704-2178-1-git-send-email-sachin.kamat@linaro.org>
	<1352938284.2143.5.camel@rzhang1-mobl4>
	<CAK44p22wzbTE-u5QcasJhzYa9Ht7e9sNrJ63V2QX2+ZEp=vhSg@mail.gmail.com>
 <CAK9yfHyU_rPhR=j4QoPM4sPVAEX7kQ6Vhv1OaakfensXKvqNXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:13546 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752446Ab2KOGpd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Nov 2012 01:45:33 -0500
In-Reply-To: <CAK9yfHyU_rPhR=j4QoPM4sPVAEX7kQ6Vhv1OaakfensXKvqNXg@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>, Amit Kachhap <amit.kachhap@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "R, Durgadoss" <durgadoss.r@intel.com>, "patches@linaro.org" <patches@linaro.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>



> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Sachin Kamat
> Sent: Thursday, November 15, 2012 2:39 PM
> To: Amit Kachhap
> Cc: linux-pm@vger.kernel.org; R, Durgadoss; patches@linaro.org;
> akpm@linux-foundation.org
> Subject: Re: [PATCH 1/1] thermal: Exynos: Add missing dependency
> 
> On 15 November 2012 11:54, Amit Kachhap <amit.kachhap@linaro.org> wrote:
> > On 15 November 2012 05:41, Zhang Rui <rui.zhang@intel.com> wrote:
> >> Hi, Sachin,
> >>
> >> thanks for catching the problem.
> >>
> >> On Wed, 2012-11-14 at 12:18 +0530, Sachin Kamat wrote:
> >>> CPU_FREQ_TABLE depends on CPU_FREQ. Selecting CPU_FREQ_TABLE
> without
> >>> checking for dependencies gives the following compilation warnings:
> >>> warning: (ARCH_TEGRA_2x_SOC && ARCH_TEGRA_3x_SOC &&
> UX500_SOC_DB8500
> >>> && CPU_THERMAL && EXYNOS_THERMAL) selects CPU_FREQ_TABLE which has
> >>> unmet direct dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ)
> >>>
> >> Amit,
> >>
> >> how is exynos driver supposed to work?
> >> do you want the exynos driver still be loaded without CPU_THERMAL?
> >> If yes, EXYNOS_THERMAL should not select CPU_FREQ_TABLE.
> >> If no, EXYNOS_THERMAL should depends on CPU_THERMAL instead of
> THERMAL.
> >> and CPU_THERMAL will select CPU_FREQ_TABLE instead.
> >>
> >> IMO, either of the above solution will be more proper to fix this
> >> warning.
> >
> > Yes Rui, Currently exynos driver has dependency on CPU_THERMAL. There
> > is some code-refactoring work needed to remove this dependency.
> > As of now to fix the warning following changes may be sufficient.
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -50,7 +50,8 @@ config RCAR_THERMAL
> >
> >  config EXYNOS_THERMAL
> >         tristate "Temperature sensor on Samsung EXYNOS"
> > -       depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5) && THERMAL
> > +       depends on THERMAL
> 
> This is not needed as CPU_THERMAL depends on THERMAL.
> 
Agreed.
> > +       depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5) && CPU_THERMAL
> 
> 
> >         select CPU_FREQ_TABLE
> This can also be removed as CPU_THERMAL selects it.
> 
Agreed.

> I will resend my patch with the above changes.

No, you don't need to.
I'm refactoring drivers/thermal/Kconfig, and I'll send a patch based on this idea.
Will send out the patch soon.

Thanks,
rui

> >         help
> >           If you say yes here you get support for TMU (Thermal
> > Managment
> >
> > Thanks,
> > Amit Daniel
> >
> >>
> >> thanks,
> >> rui
> >>
> >>> Cc: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> >>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> >>> ---
> >>> Build tested using exynos4_defconfig on linux-next tree of 20121114.
> >>> ---
> >>>  drivers/thermal/Kconfig |    2 +-
> >>>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>>
> >>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index
> >>> 266c15e..197b7db 100644
> >>> --- a/drivers/thermal/Kconfig
> >>> +++ b/drivers/thermal/Kconfig
> >>> @@ -50,7 +50,7 @@ config RCAR_THERMAL
> >>>
> >>>  config EXYNOS_THERMAL
> >>>       tristate "Temperature sensor on Samsung EXYNOS"
> >>> -     depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5) && THERMAL
> >>> +     depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5) && THERMAL &&
> >>> + CPU_FREQ
> >>>       select CPU_FREQ_TABLE
> >>>       help
> >>>         If you say yes here you get support for TMU (Thermal
> >>> Managment
> >>
> >>
> 
> 
> 
> --
> With warm regards,
> Sachin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org More majordomo info
> at  http://vger.kernel.org/majordomo-info.html
