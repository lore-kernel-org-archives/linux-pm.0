From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 2/5] cpufreq: schedutil: support scheduler cpufreq
 callbacks on remote CPUs
Date: Thu, 19 May 2016 15:59:39 -0700
Message-ID: <20160519225939.GA15383@graphite.smuckle.net>
References: <1462828814-32530-1-git-send-email-smuckle@linaro.org>
 <1462828814-32530-3-git-send-email-smuckle@linaro.org>
 <CAJZ5v0jcFNdYMXdaBDaTzyxCaPn9=q2YxUMqziEaprwiOm=5dA@mail.gmail.com>
 <20160519184055.GD17223@graphite.smuckle.net>
 <CAJZ5v0jt6r38kiAE=Qf3y8vpquMdQnnLEDqjg2v7QoKgKzOcuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33096 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755083AbcESW7o (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 18:59:44 -0400
Received: by mail-pa0-f50.google.com with SMTP id xk12so33191932pac.0
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2016 15:59:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jt6r38kiAE=Qf3y8vpquMdQnnLEDqjg2v7QoKgKzOcuw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>

On Thu, May 19, 2016 at 10:55:23PM +0200, Rafael J. Wysocki wrote:
> >> > +static inline bool sugov_queue_remote_callback(struct sugov_policy *sg_policy,
> >> > +                                        int cpu)
> >> > +{
> >> > +       struct cpufreq_policy *policy = sg_policy->policy;
> >> > +
> >> > +       if (!cpumask_test_cpu(smp_processor_id(), policy->cpus)) {
> >>
> >> This check is overkill for policies that aren't shared (and we have a
> >> special case for them already).
> >
> > I don't see why it is overkill -
> 
> Because it requires more computation, memory accesses etc than simply
> comparing smp_processor_id() with cpu.

Do you have a preference on how to restructure this? Otherwise I'll
create a second version of sugov_update_commit, factoring out as much of
it as I can into two inline sub-functions. 

...
> 
> > but it seems like an odd inconsistency for the governor to trace unchanged
> > frequencies when fast switches are enabled but not otherwise. It'd be
> > useful I think for profiling and tuning if the tracing was consistent.
> 
> Well, fair enough.
> 
> > This behavioral change is admittedly not part of the purpose of the
> > patch and could be split out if needbe.
> 
> No need to split IMO, but it might be prudent to mention that change
> in behavior in the changelog.

Will do.

thanks,
Steve
