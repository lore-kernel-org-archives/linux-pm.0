From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update
 callbacks
Date: Wed, 10 Feb 2016 14:03:15 +0000
Message-ID: <20160210140315.GD11415@e106622-lin>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <56B93548.9090006@linaro.org>
 <CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
 <5387313.xAhVpzgZCg@vostro.rjw.lan>
 <20160210123342.GA11415@e106622-lin>
 <CAJZ5v0gWV+Qc2CM6YN90=s+TE2HCDOZVCRH7nOrKFW+kGiOpDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47511 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751729AbcBJOC3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 10 Feb 2016 09:02:29 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gWV+Qc2CM6YN90=s+TE2HCDOZVCRH7nOrKFW+kGiOpDA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On 10/02/16 14:23, Rafael J. Wysocki wrote:
> On Wed, Feb 10, 2016 at 1:33 PM, Juri Lelli <juri.lelli@arm.com> wrote:
> > Hi Rafael,
> >
> > On 09/02/16 21:05, Rafael J. Wysocki wrote:
> >
> > [...]
> >
> >> +/**
> >> + * cpufreq_update_util - Take a note about CPU utilization changes.
> >> + * @util: Current utilization.
> >> + * @max: Utilization ceiling.
> >> + *
> >> + * This function is called by the scheduler on every invocation of
> >> + * update_load_avg() on the CPU whose utilization is being updated.
> >> + */
> >> +void cpufreq_update_util(unsigned long util, unsigned long max)
> >> +{
> >> +     struct update_util_data *data;
> >> +
> >> +     rcu_read_lock();
> >> +
> >> +     data = rcu_dereference(*this_cpu_ptr(&cpufreq_update_util_data));
> >> +     if (data && data->func)
> >> +             data->func(data, cpu_clock(smp_processor_id()), util, max);
> >
> > Are util and max used anywhere?
> 
> They aren't yet, but they will be.
> 
> Maybe not in this cycle (it it takes too much time to integrate the
> preliminary changes), but we definitely are going to use those
> numbers.
> 

Oh OK. However, I was under the impression that this set was only
proposing a way to get rid of timers and use the scheduler as heartbeat
for cpufreq governors. The governors' sample based approach wouldn't
change, though. Am I wrong in assuming this?

Also, is linux-pm/bleeding-edge the one I want to fetch to try this set
out?

Thanks,

- Juri
