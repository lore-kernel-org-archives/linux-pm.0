From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/3] sched: cpufreq: Allow remote cpufreq callbacks
Date: Thu, 27 Jul 2017 08:53:27 +0530
Message-ID: <20170727032327.GC352@vireshk-i7>
References: <cover.1501060871.git.viresh.kumar@linaro.org>
 <8797d4993baa6580e3af741d081be492032ce9dd.1501060871.git.viresh.kumar@linaro.org>
 <4472861.L87TWDhBo0@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34030 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbdG0DXb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jul 2017 23:23:31 -0400
Received: by mail-pf0-f178.google.com with SMTP id q85so78222917pfq.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Jul 2017 20:23:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4472861.L87TWDhBo0@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org, linux-kernel@vger.kernel.org

On 26-07-17, 19:42, Rafael J. Wysocki wrote:
> On Wednesday, July 26, 2017 02:52:32 PM Viresh Kumar wrote:

> > +	/* Don't allow remote callbacks */
> > +	if (smp_processor_id() != data->cpu)
> > +		return;
> 
> You can do this check against cpu->cpu, however.
> 
> > +	/* Don't allow remote callbacks */
> > +	if (smp_processor_id() != data->cpu)
> > +		return;
> 
> And same here.
> 
> > +
> >  	if (flags & SCHED_CPUFREQ_IOWAIT) {
> >  		cpu->iowait_boost = int_tofp(1);
> >  	} else if (cpu->iowait_boost) {
> > diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> > index d2be2ccbb372..8256a8f35f22 100644
> > --- a/include/linux/sched/cpufreq.h
> > +++ b/include/linux/sched/cpufreq.h
> > @@ -16,6 +16,7 @@
> >  #ifdef CONFIG_CPU_FREQ
> >  struct update_util_data {
> >         void (*func)(struct update_util_data *data, u64 time, unsigned int flags);
> > +       unsigned int cpu;
> 
> So it looks like you don't need this.
> 
> schedutil doesn't need it as per patch [2/3].

Hmm, so your comments are exactly same as what Peter suggested few
days back.

sugov_get_util() uses it in 2/3, as we need to know the target CPU
anyway.

But I think it would be better to add the cpu variable in sugov_cpu
structure instead as only schedutil needs it. I will do that change
and send V5.

-- 
viresh
