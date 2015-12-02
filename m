From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V2 06/10] cpufreq: governor: Keep single copy of information
 common to policy->cpus
Date: Wed, 02 Dec 2015 13:43:59 -0800
Message-ID: <565F661F.1020204@codeaurora.org>
References: <cover.1434713657.git.viresh.kumar@linaro.org> <efd892126475600e751c0e1206553270ebba5c00.1434713657.git.viresh.kumar@linaro.org> <1448625400.3689.103.camel@pengutronix.de> <20151130051915.GH3373@ubuntu> <1448879672.8275.15.camel@pengutronix.de> <20151130110327.GC4899@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55200 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbbLBVoC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2015 16:44:02 -0500
In-Reply-To: <20151130110327.GC4899@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, ke.wang@spreadtrum.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de

On 11/30/2015 03:03 AM, Viresh Kumar wrote:
> On 30-11-15, 11:34, Lucas Stach wrote:
>> The timer_mutex is one of the top contended locks already on a quad core
>> system.
>
> My new series (un-committed) should fix that to some level hopefully:
>
> http://marc.info/?l=linux-pm&m=144612165211091&w=2
>
>> That really doesn't look right, as the timer is quite low
>> frequency. It's causing excessive wake ups, as all 4 CPUs wake up to
>> handle the WQ, 3 of them directly go back to sleep waiting for the mutex
>> to be released, then same thing happens for CPUs-1 until we rippled down
>> to a single CPU.
>
> There is a reason why we need to do this on all CPUs today. The timers
> are deferrable by nature, as we shouldn't wake up a CPU to change it
> frequency. Now group of CPUs that change their DVFS state together, or
> that change their voltage/clock rails are part of the same
> cpufreq-policy. We need to take load of all the CPUs, that are part of
> the policy, while update the frequency of the group.
>
> If we queue the timer on any one CPU, then that CPU can go into idle
> and the deferred timer will not fire. But the other CPUs of the policy
> can still be active and the frequency of the group wouldn't change
> with load.
>
> Hope that answers the query related to timers on all CPUs.
>
>> I would say it's still worth fixing. Perhaps by not waking all the
>> workqueues at the same time, but spreading the wake times out over a
>> jiffy.
>
> Maybe.
>

There's a separate thread where we proposed a fix to deferrable timers 
that are stored globally if they are not CPU bound. That way, even if 
one CPU is up, they get handled. But TGLX had some valid concerns with 
cache thrashing and impact on some network code. So, last I heard, he 
was going to rewrite and fixed the deferrable timer problem by having 
the "orphaned" (because CPU has gone idle) deferrable timers being 
adopted by other CPUs while the original CPU is idle.

Once that's fixed, we just need one timer per policy. Long story short, 
CPU freq is working around a poor API semantic of deferrable timers.

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
