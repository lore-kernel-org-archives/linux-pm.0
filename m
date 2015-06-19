From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 00/10] cpufreq: governor: Avoid invalid state-transitions
Date: Fri, 19 Jun 2015 23:38:00 +0530
Message-ID: <55845A80.7010103@linux.vnet.ibm.com>
References: <cover.1434713657.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e19.ny.us.ibm.com ([129.33.205.209]:53817 "EHLO
	e19.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754668AbbFSSIQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 14:08:16 -0400
Received: from /spool/local
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Fri, 19 Jun 2015 14:08:15 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 385836E803F
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2015 13:59:59 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5JI8CGj33030330
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2015 18:08:12 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5JI89Og006473
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2015 14:08:11 -0400
In-Reply-To: <cover.1434713657.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/19/2015 05:18 PM, Viresh Kumar wrote:
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

This series has been tested on powerpc, by running governor switching in
parallel and another test where  hotplug, governor switching were run in
parallel.So,

Tested-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
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
>   cpufreq: governor: Keep single copy of information common to
>     policy->cpus
>   cpufreq: governor: split out common part of {cs|od}_dbs_timer()
>   cpufreq: governor: Avoid invalid states with additional checks
>   cpufreq: governor: Don't WARN on invalid states
>   cpufreq: propagate errors returned from __cpufreq_governor()
> 
>  drivers/cpufreq/cpufreq.c              |  22 ++--
>  drivers/cpufreq/cpufreq_conservative.c |  25 ++---
>  drivers/cpufreq/cpufreq_governor.c     | 196 ++++++++++++++++++++++++---------
>  drivers/cpufreq/cpufreq_governor.h     |  40 ++++---
>  drivers/cpufreq/cpufreq_ondemand.c     |  67 ++++++-----
>  5 files changed, 220 insertions(+), 130 deletions(-)
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
