From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: schedutil: Fix sugov_start versus sugov_update_shared race
Date: Wed, 12 Jul 2017 23:33:28 +0200
Message-ID: <3085275.N7bM571b3X@aspire.rjw.lan>
References: <1499363600-10732-1-git-send-email-markivx@codeaurora.org> <20170707032509.GC1523@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62910 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754270AbdGLVlL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2017 17:41:11 -0400
In-Reply-To: <20170707032509.GC1523@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Vikram Mulukutla <markivx@codeaurora.org>
Cc: juri.lelli@arm.com, skannan@codeaurora.org, linux-pm@vger.kernel.org

On Friday, July 07, 2017 08:55:09 AM Viresh Kumar wrote:
> On 06-07-17, 10:53, Vikram Mulukutla wrote:
> > With a shared policy in place, when one of the CPUs in the policy is
> > hotplugged out and then brought back online, sugov_stop and
> > sugov_start are called in order.
> > 
> > sugov_stop removes utilization hooks for each CPU in the policy and
> > does nothing else in the for_each_cpu loop. sugov_start on the other
> > hand iterates through the CPUs in the policy and re-initializes the
> > per-cpu structure _and_ adds the utilization hook. This implies that
> > the scheduler is allowed to invoke a CPU's utilization update hook
> > when the rest of the per-cpu structures have yet to be re-inited.
> > 
> > Apart from some strange values in tracepoints this doesn't cause a
> > problem, but if we do end up accessing a pointer from the per-cpu
> > sugov_cpu structure somewhere in the sugov_update_shared path,
> > we will likely see crashes since the memset for another CPU in the
> > policy is free to race with sugov_update_shared from the CPU that is
> > ready to go. So let's fix this now to first init all per-cpu
> > structures, and then add the per-cpu utilization update hooks all at
> > once.
> > 
> > Signed-off-by: Vikram Mulukutla <markivx@codeaurora.org>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 076a2e3..29a3970 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -610,6 +610,11 @@ static int sugov_start(struct cpufreq_policy *policy)
> >  		sg_cpu->sg_policy = sg_policy;
> >  		sg_cpu->flags = SCHED_CPUFREQ_RT;
> >  		sg_cpu->iowait_boost_max = policy->cpuinfo.max_freq;
> > +	}
> > +
> > +	for_each_cpu(cpu, policy->cpus) {
> > +		struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
> > +
> >  		cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util,
> >  					     policy_is_shared(policy) ?
> >  							sugov_update_shared :
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!
