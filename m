From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 0/4] cpufreq/opp: Turbo/boost mode support
Date: Tue, 28 Jul 2015 13:55:41 +0200
Message-ID: <2445844.9YDNy0YEZL@amdc1976>
References: <cover.1438081962.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:59989 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913AbbG1L40 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 07:56:26 -0400
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NS701LSU55TNV70@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 28 Jul 2015 20:56:24 +0900 (KST)
In-reply-to: <cover.1438081962.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, sboyd@codeaurora.org


Hi,

On Tuesday, July 28, 2015 04:49:59 PM Viresh Kumar wrote:
> Hi Rafael,
> 
> This is based of my opp-v2 series and so is sent as reply to that one.
> 
> Bartlomiej had few patches that he wanted to get into 4.3. I have picked
> two of those and dropped one (the one that adds another field to
> platform data). The dropped one is replaced with two patches from me.
> There are minor modifications done in first two patches, based on the
> review comments I gave to him earlier.

Thanks for working on this.

> Completely Untested.
> 
> @Bartlomiej: Can you please give them some testing ?

Could you please tell me first how do you want me to fix the issue
with setting boost_supported flag in cpufreq driver structure?

For exynos-cpufreq driver we currently have:

#ifdef CONFIG_ARM_EXYNOS_CPU_FREQ_BOOST_SW
	.boost_supported = true,
#endif

With my original patches the config option stayed the same and
the flag was enabled if necessary in Exynos platform code and
passed through platform data to cpufreq-dt driver.  This is no
longer possible with your changes.

Should I enable it unconditionally in cpufreq-dt driver or add new
config option for cpufreq-dt driver (CONFIG_CPUFREQ_DT_BOOST_SW?)
for enabling boost_supported flag if necessary?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Bartlomiej Zolnierkiewicz (2):
>   opp: add dev_pm_opp_is_turbo() helper
>   cpufreq: Update boost flag while initializing freq table from OPPs
> 
> Viresh Kumar (2):
>   cpufreq: Allow drivers to enable boost support after registering
>     driver
>   cpufreq: dt: Add support for turbo/boost mode
> 
>  drivers/base/power/opp.c      | 30 ++++++++++++++++++++
>  drivers/cpufreq/cpufreq-dt.c  |  8 ++++++
>  drivers/cpufreq/cpufreq.c     | 66 ++++++++++++++++++++++++++++++-------------
>  drivers/cpufreq/cpufreq_opp.c |  4 +++
>  drivers/cpufreq/freq_table.c  | 15 ++++++++++
>  include/linux/cpufreq.h       | 12 ++++++++
>  include/linux/pm_opp.h        |  7 +++++
>  7 files changed, 122 insertions(+), 20 deletions(-)

