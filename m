From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 1/5] cpufreq: ondemand: Drop unnecessary locks from update_sampling_rate()
Date: Wed, 28 Oct 2015 06:54:27 +0100
Message-ID: <4304226.RJrgDykfyW@vostro.rjw.lan>
References: <cover.1444723240.git.viresh.kumar@linaro.org> <9152551.Va141R8GGE@vostro.rjw.lan> <20151028044451.GA30039@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53337 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751945AbbJ1FZb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 01:25:31 -0400
In-Reply-To: <20151028044451.GA30039@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Preeti U Murthy <preeti@linux.vnet.ibm.com>, open list <linux-kernel@vger.kernel.org>

On Wednesday, October 28, 2015 10:14:51 AM Viresh Kumar wrote:
> On 28-10-15, 05:05, Rafael J. Wysocki wrote:
> > On Tuesday, October 13, 2015 01:39:01 PM Viresh Kumar wrote:
> > > 'timer_mutex' is required to sync work-handlers of policy->cpus.
> > > update_sampling_rate() is just canceling the works and queuing them
> > > again. This isn't protecting anything at all in update_sampling_rate()
> > > and is not gonna be of any use.
> > > 
> > > Even if a work-handler is already running for a CPU,
> > > cancel_delayed_work_sync() will wait for it to finish.
> > > 
> > > Drop these unnecessary locks.
> > > 
> > > Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> > I'm queuing this up for 4.4, although I think that the changelog is not right.
> > 
> > While at it, what are the race conditions the lock is protecting against?
> 
> In cases where a single policy controls multiple CPUs, a timer is
> queued for every cpu present in policy->cpus. When we reach the timer
> handler (which can be on multiple CPUs together) on any CPU, we trace
> CPU load for all policy->cpus and update the frequency accordingly.

That would be in dbs_timer(), right?

> The lock is for protecting multiple CPUs to do the same thing
> together, as only its required to be done by a single CPU. Once any
> CPUs handler has completed, it updates the last update time and drops
> the mutex. At that point of time, other blocked handler (if any) check
> the last update time and return early.

Well, that would mean we only needed to hold the lock around the
need_load_eval() evaluation in dbs_timer() if I'm not mistaken.

We also should acquire it around updates of the sampling rate, which
essentially is set_sampling_rate().

Is there any reason to acquire it in cpufreq_governor_limits(), then,
for example?

> And then there are enough minute things that can go wrong if multiple
> CPUs do the load evaluation and freq-update at the same time, apart
> from it being an time wasting effort.
> 
> And so I still think that the commit log isn't that bad. The
> timer_mutex lock isn't required in other parts of the governor, they
> are just for synchronizing the work-handlers of CPUs belonging to the
> same policy.

I agree that it doesn't serve any purpose in the piece of code you're
removing it from (which is why I agree with the patch), but the changelog
is incomplete and confusing.

Thanks,
Rafael

