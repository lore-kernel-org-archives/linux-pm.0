From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 00/10] cpufreq: governor: Avoid invalid state-transitions
Date: Sat, 18 Jul 2015 00:15:02 +0200
Message-ID: <2874468.iRvuV1Y9DI@vostro.rjw.lan>
References: <cover.1434713657.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63110 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752007AbbGQVsW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2015 17:48:22 -0400
In-Reply-To: <cover.1434713657.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, ke.wang@spreadtrum.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On Friday, June 19, 2015 05:18:00 PM Viresh Kumar wrote:
> Hi Rafael/Preeti,
> 
> This is another attempt to fix the crashes reported by Preeti. They work
> quite well for me now, and I hope they would work well for Preeti as
> well :)
> 
> So, patches [1-7,9] are already Reviewed by Preeti.
> 
> The first 5 patches are minor cleanups, 6th & 7th try to optimize few
> things to make code less complex.
> 
> Patches 8-10 actually solve (or try to solve :)) the synchronization
> problems, or the crashes I was getting.
> 
> V1->V2:
> - 7/11 is dropped and only 8/11 is updated, which is 8/10 now.
> - Avoid taking the same mutex in both cpufreq_governor_dbs() and
>   work-handler as that has given us some locdeps, classic ABBA stuff.
> - And so timer_mutex, responsible for synchronizing governor
>   work-handlers is kept as is.
> - Later patches are almost same with minor updates.
> - Invalid state-transitions are sensed better now with improved checks.
> - I have run enough tests on my exynos dual core board and failed to
>   crash at all. Not that I wanted to crash :)
> 
> Rebased over pm/bleeeding-edge.
> 
> Viresh Kumar (10):
>   cpufreq: governor: Name delayed-work as dwork
>   cpufreq: governor: Drop unused field 'cpu'
>   cpufreq: governor: Rename 'cpu_dbs_common_info' to 'cpu_dbs_info'
>   cpufreq: governor: name pointer to cpu_dbs_info as 'cdbs'
>   cpufreq: governor: rename cur_policy as policy

The above are all fine by me, so I'm queuing them up for 4.3.

The one below needs a small update in my view which will propagate to the
next ones.

>   cpufreq: governor: Keep single copy of information common to
>     policy->cpus
>   cpufreq: governor: split out common part of {cs|od}_dbs_timer()
>   cpufreq: governor: Avoid invalid states with additional checks
>   cpufreq: governor: Don't WARN on invalid states
>   cpufreq: propagate errors returned from __cpufreq_governor()

Thanks,
Rafael

