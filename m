From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC/RFT][PATCH] cpufreq: schedutil: Reduce frequencies slower
Date: Wed, 12 Apr 2017 14:33:34 +0530
Message-ID: <20170412090334.GE5910@vireshk-i7>
References: <1514608.eWxQqcMBcc@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33698 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753448AbdDLJDi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Apr 2017 05:03:38 -0400
Received: by mail-pf0-f178.google.com with SMTP id s16so11085496pfs.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Apr 2017 02:03:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1514608.eWxQqcMBcc@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, John <john.ettedgui@gmail.com>

On 30-03-17, 23:36, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The schedutil governor reduces frequencies too fast in some
> situations which cases undesirable performance drops to
> appear.
> 
> To address that issue, make schedutil reduce the frequency slower by
> setting it to the average of the value chosen during the previous
> iteration of governor computations and the new one coming from its
> frequency selection formula.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=194963
> Reported-by: John <john.ettedgui@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This addresses a practical issue, but one in the "responsiveness" or
> "interactivity" category which is quite hard to represent quantitatively.
> 
> As reported by John in BZ194963, schedutil does not ramp up P-states quickly
> enough which causes audio issues to appear in his gaming setup.  At least it
> evidently is worse than ondemand in this respect and the patch below helps.
> 
> The patch essentially repeats the trick added some time ago to the load-based
> P-state selection algorithm in intel_pstate, which allowed us to make it viable
> for performance-oriented users, and which is to reduce frequencies at a slower
> pace.
> 
> The reason why I chose the average is because it is computationally cheap
> and pretty much the max reasonable slowdown and the idea is that in case
> there's something about to run that we don't know about yet, it is better to
> stay at a higher level for a while more to avoid having to get up from the floor
> every time.
> 
> But technically speaking it is a filter. :-)
> 
> So among other things I'm wondering if that leads to substantial increases in
> energy consumption anywhere.
> 
> Thanks,
> Rafael
> 
> ---
>  kernel/sched/cpufreq_schedutil.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> @@ -101,6 +101,9 @@ static void sugov_update_commit(struct s
>  	if (sg_policy->next_freq == next_freq)
>  		return;
>  

Maybe add a comment over here on why we are adding this workaround .

> +	if (sg_policy->next_freq > next_freq)
> +		next_freq = (sg_policy->next_freq + next_freq) >> 1;
> +
>  	sg_policy->next_freq = next_freq;
>  	sg_policy->last_freq_update_time = time;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
