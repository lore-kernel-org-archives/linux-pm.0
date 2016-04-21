From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/10] cpufreq: Get rid of cpufreq-dt's platform data
Date: Thu, 21 Apr 2016 22:10:27 +0200
Message-ID: <1487853.W42huqXPTb@vostro.rjw.lan>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59190 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751583AbcDUUHe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 16:07:34 -0400
In-Reply-To: <cover.1461228504.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, sboyd@codeaurora.org, arnd.bergmann@linaro.org, andrew@lunn.ch, gregory.clement@free-electrons.com, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com, thomas.petazzoni@free-electrons.com

On Thursday, April 21, 2016 02:28:52 PM Viresh Kumar wrote:
> Hi Guys,
> 
> The aim of the series is to kill the users of cpufreq-dt's platform
> data, i.e. mvebu. And because that required a new API to the OPP core,
> this just became a mix of cpufreq and OPP patches.
> 
> The first four patches does some sort of cleanup of the OPP core to base
> the next patches. Fifth one sets the shared_opp flag in opp-tables
> (required by later patches). Sixth one adds a new API for opp-v1 users,
> to get the CPUs sharing an OPP table.
> 
> Seventh to tenth update cpufreq-dt and mvebu to get rid of platform
> data.
> 
> @Rafael: The last patch touches the compatible-list array in
> cpufreq-dt-platdev.c, which is also touched by
> '[PATCH 0/8] cpufreq: dt: Don't create platform-device from platform code'.
> 
> So, the last one has some sort of dependency on that series, otherwise
> all other patches can be applied cleanly.
> 
> @Arnd: Can you please look at patches 7-10 ..
> 
> Viresh Kumar (10):
>   PM / OPP: Propagate the error returned by _find_opp_table()
>   PM / OPP: Add missing doc style comments
>   PM / OPP: dev_pm_opp_set_sharing_cpus() doesn't depend on CONFIG_OF
>   PM / OPP: Relocate dev_pm_opp_set_sharing_cpus()
>   PM / OPP: Mark shared-opp for non-dt case
>   PM / OPP: Add dev_pm_opp_get_sharing_cpus()
>   cpufreq: dt: Identify cpu-sharing for platforms without
>     operating-points-v2
>   mvebu: Use dev_pm_opp_set_sharing_cpus() to mark OPP tables as shared
>   cpufreq: dt: Kill platform-data
>   cpufreq: mvebu: Use generic platdev driver
> 
>  arch/arm/mach-mvebu/pmsu.c           |  14 ++-
>  drivers/base/power/opp/cpu.c         | 187 +++++++++++++++++++++++++++--------
>  drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
>  drivers/cpufreq/cpufreq-dt.c         |  22 ++---
>  include/linux/cpufreq-dt.h           |  24 -----
>  include/linux/pm_opp.h               |  18 ++--
>  6 files changed, 176 insertions(+), 91 deletions(-)
>  delete mode 100644 include/linux/cpufreq-dt.h

As usual, I'd like to get some ACKs for the OPP stuff from Stephen or other
people with vested interest.

Thanks,
Rafael

