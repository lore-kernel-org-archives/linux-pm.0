From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 0/4] cpufreq: use generic cpufreq drivers for Exynos5250
 platform
Date: Wed, 22 Apr 2015 19:37:43 +0200
Message-ID: <4008289.pQOxzKW0Ir@amdc1032>
References: <1428946441-17058-1-git-send-email-b.zolnierkie@samsung.com>
 <5439319.JYC6t7bzy4@amdc1032> <7hsibtavuz.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:52978 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbbDVRh4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2015 13:37:56 -0400
In-reply-to: <7hsibtavuz.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, linux-samsung-soc@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-arm-kernel@lists.infradead.org


On Tuesday, April 21, 2015 04:45:56 PM Kevin Hilman wrote:
> Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> writes:
> 
> > On Monday, April 20, 2015 02:07:33 PM Kevin Hilman wrote:
> >> Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> writes:
> >> 
> >> > Hi,
> >> >
> >> > This patch series removes the use of Exynos5250 specific support
> >> > from exynos-cpufreq driver and enables the use of cpufreq-dt driver
> >> > for this platform.  The exynos-cpufreq driver itself is also removed
> >> > as it is no longer used/needed after Exynos5250 support removal.
> >> >
> >> > This patch series has been tested on Exynos5250 based Arndale board.
> >> >
> >> > Depends on:
> >> > - next-20150330 branch of linux-next kernel tree
> >> > - "[PATCH 0/6] cpufreq: use generic cpufreq drivers for Exynos4210
> >> >   platform" [1]
> >> > - "[PATCH 0/6] cpufreq: use generic cpufreq drivers for Exynos4x12
> >> >   platform" [2]
> >> > - "[PATCH] cpufreq: exynos: remove dead ->need_apll_change method" [3]
> >> 
> >> Any chance you could prepare a branch with all the dependencies for easy
> >> testing?
> >
> > All cpufreq changes with needed dependencies are now availble in
> >
> >     https://github.com/bzolnier/linux.git
> >
> > repository and the branch is
> >
> >     next-20150330-generic-cpufreq-exynos5420-5800-v2
> 
> Great, thanks.
> 
> >> Also, The previous version from Thomas was v12, and this one is neither
> >> versioned nor has any reference to what may have changed since that
> >
> > Please note that Thomas' patchset was split on separate parts (this is
> > part #3) and heavily modified so the previous versioning was dropped.
> >
> > The cover letter of part #1 ("[PATCH 0/6] cpufreq: use generic cpufreq
> > drivers for Exynos4210 platform") contains detailed changelog on what has
> > been changed since Thomas' original v12 patch series.  Individual Thomas'
> > patches which were modified by me also contain such information.
> >
> > Part #2 ("[PATCH 0/6] cpufreq: use generic cpufreq drivers for Exynos4x12
> > platform") was entirely new code when compared to Thomas' v12 patchset so
> > its cover letter doesn't contain such detailed changelog as part #1.
> >
> > The newly posted part #4 ("[PATCH 0/8] cpufreq: add generic cpufreq driver
> > support for Exynos5250/5800 platforms" https://lkml.org/lkml/2015/4/21/314)
> > also contains the detailed changelog.
> >
> > However for part #3 (this one, "[PATCH 0/4] cpufreq: use generic cpufreq
> > drivers for Exynos5250 platform") such summary changelog got missed for
> > some reason.  Here it is:
> > - split Exynos5250 support from the original patch
> > - moved E5250_CPU_DIV[0,1]() macros to clk-exynos5250.c
> > - added CPU regulator supply property for Google Spring board
> > - removed exynos-cpufreq driver entirely as it is no longer used/needed
> 
> Great, thanks for clarifying.
> 
> >> version.  Also, on v12, I had several comments[1] and wonder if they've
> >> been addressed.
> >
> > All issues previously reported should have been fixed.  If you still see
> > some problems please let me know.
> >
> > [ I see now that exynos5420-arndale-octa.dts, exynos5420-peach-pit.dts,
> >   exynos5420-smdk5420.dts and exynos5800-peach-pi.dts should also have
> >   been updated to contain CPU cluster regulator supply properties or else
> >   if the default vdd_arm/vdd_kfc regulator state is set to too low value
> >   there may be problems with stability when switching to higher than
> >   default frequencies.  I have posted v2 version of patch #2/8 of part #4
> >   and pushed v2 combined branch on github.  Sorry for the inconvenience. ]
> 
> I've now tested your v2 branch with the bL switcher disabled, CPUidle
> enabled and CPUfreq enabled.  
> 
> With the default governor set to performance, it fails to boot.  The last
> kernel messages on the console are:

[ Small explanation for people not following the discussion from
  the start:

  This testing is relevant to part #4 of the rework: "[PATCH 0/8]
  cpufreq: add generic cpufreq driver support for Exynos5250/5800
  platforms" (https://lkml.org/lkml/2015/4/21/314"), not this one
  which is part #3 and has no known issues. ]

> [...]
> [    3.426021] cpu cpu0: bL_cpufreq_init: CPU 0 initialized
> [    3.431189] cpu cpu4: bL_cpufreq_init: CPU 4 initialized
> 
> However, with the default governor set to userspace it boots fine until
> my userspace (ubuntu) tries to enable the ondemand governor, and then it
> hangs. 
> 
> For it to boot, I have to disable the ondemand governor, and set the
> default governor to userspace.

I've tried with ARM big.LITTLE cpuidle support enabled (I've just noticed
that it is not turned on in exynos_defconfig) and my ODROID-XU3 board
fails to boot.  This happens even with cpufreq support disabled (hard
lockup happens during mmc initialization which is done just after cpufreq
initialization).

Could you please check if disabling cpuidle support helps?

> As I reported earlier on Thomas' series, I suspect this is related to
> the fact that the higher OPPs aren't really functional without voltage
> scaling also supported. 

Part #4 contains voltage scaling support for arm_big_little[_dt] driver
so this should not be a problem any longer.

You may try next-20150330-generic-cpufreq-exynos5420-5800-v2-debug
branch from my github (with cpufreq debugging printks enabled) to check
whether the voltage scaling is indeed done on your board.

> I'm also seeing the wait_until_divider_stable errors when switching
> between the available A7 OPPs.  I'd reported this one earlier as well,
> along with the script to reproduce it.

I've tried your script and it works fine for me (I only needed to change
cpu4 to cpu0 as on ODROID-XU3 CPUs 0,5,6,7 are A7 and 1,2,3,4 are A15).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

