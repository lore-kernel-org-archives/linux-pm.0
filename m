From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 0/5] cpufreq: governor: Avoid invalid state-transitions
Date: Thu, 23 Jul 2015 23:00:28 +0200
Message-ID: <1750316.G8rvNjkg1G@vostro.rjw.lan>
References: <2874468.iRvuV1Y9DI@vostro.rjw.lan> <cover.1437199001.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46614 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754018AbbGWUdk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 16:33:40 -0400
In-Reply-To: <cover.1437199001.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On Saturday, July 18, 2015 11:30:58 AM Viresh Kumar wrote:
> Hi Rafael,
> 
> These are rest of the patches after replacing 'ccdbs' with 'shared' as
> you suggested.
> 
> Viresh Kumar (5):
>   cpufreq: governor: Keep single copy of information common to
>     policy->cpus
>   cpufreq: governor: split out common part of {cs|od}_dbs_timer()
>   cpufreq: governor: Avoid invalid states with additional checks
>   cpufreq: governor: Don't WARN on invalid states
>   cpufreq: propagate errors returned from __cpufreq_governor()
> 
>  drivers/cpufreq/cpufreq.c              |  31 ++++--
>  drivers/cpufreq/cpufreq_conservative.c |  25 ++---
>  drivers/cpufreq/cpufreq_governor.c     | 174 ++++++++++++++++++++++++++-------
>  drivers/cpufreq/cpufreq_governor.h     |  26 +++--
>  drivers/cpufreq/cpufreq_ondemand.c     |  58 +++++------
>  5 files changed, 210 insertions(+), 104 deletions(-)

All queued up for 4.3, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
