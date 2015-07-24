From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFCv5, 01/46] arm: Frequency invariant scheduler load-tracking
 support
Date: Fri, 24 Jul 2015 10:43:28 +0100
Message-ID: <20150724094327.GD21785@e105550-lin.cambridge.arm.com>
References: <1436293469-25707-2-git-send-email-morten.rasmussen@arm.com>
 <20150721154145.GA23852@leoy-linaro>
 <20150722133103.GA21785@e105550-lin.cambridge.arm.com>
 <20150722145904.GA18354@leoy-linaro>
 <20150723110626.GC21785@e105550-lin.cambridge.arm.com>
 <20150723142216.GA21773@leoy-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43817 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753502AbbGXJkc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 24 Jul 2015 05:40:32 -0400
Content-Disposition: inline
In-Reply-To: <20150723142216.GA21773@leoy-linaro>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Russell King <linux@arm.linux.org.uk>

On Thu, Jul 23, 2015 at 10:22:16PM +0800, Leo Yan wrote:
> On Thu, Jul 23, 2015 at 12:06:26PM +0100, Morten Rasmussen wrote:
> > Yes. We have patches for arm64 if you are interested. We are using them
> > for the Juno platforms.
> 
> If convenience, please share with me related patches, so i can
> directly apply them and do some profiling works.

Will do.

> 
> > > Just now roughly went through the driver
> > > "drivers/cpufreq/intel_pstate.c"; that's true it has different
> > > implementation comparing to usual ARM SoCs. So i'd like to ask this
> > > question with another way: should cpufreq framework provides helper
> > > functions for getting related cpu frequency scaling info? If the
> > > architecture has specific performance counters then it can ignore
> > > these helper functions.
> > 
> > That is the idea with the notifiers. If the architecture code a specific
> > architecture wants to be poked by cpufreq when the frequency is changed
> > it should have a way to subscribe to those. Another way of implementing
> > it is to let the architecture code call a helper function in cpufreq
> > every time the scheduler calls into the architecture code to get the
> > scaling factor (arch_scale_freq_capacity()). We actually did it that way
> > a couple of versions back using weak functions. It wasn't as clean as
> > using the notifiers, but if we make the necessary changes to cpufreq to
> > let the architecture code call into cpufreq that could be even better.
> > 
> > > 
> > > > That said, the above solution is not handling changes to policy->max
> > > > very well. Basically, we don't inform the scheduler if it has changed
> > > > which means that the OPP represented by "100%" might change. We need
> > > > cpufreq to keep track of the true max frequency when policy->max is
> > > > changed to work out the correct scaling factor instead of having it
> > > > relative to policy->max.
> > > 
> > > i'm not sure understand correctly here. For example, when thermal
> > > framework limits the cpu frequency, it will update the value for
> > > policy->max, so scheduler will get the correct scaling factor, right?
> > > So i don't know what's the issue at here.
> > > 
> > > Further more, i noticed in the later patches for
> > > arch_scale_cpu_capacity(); the cpu capacity is calculated by the
> > > property passed by DT, so it's a static value. In some cases, system
> > > may constraint the maximum frequency for CPUs, so in this case, will
> > > scheduler get misknowledge from arch_scale_cpu_capacity after system
> > > has imposed constraint for maximum frequency?
> > 
> > The issue is first of all to define what 100% means. Is it
> > policy->cur/policy->max or policy->cur/uncapped_max? Where uncapped max
> > is the max frequency supported by the hardware when not capped in any
> > way by governors or thermal framework.
> > 
> > If we choose the first definition then we have to recalculate the cpu
> > capacity scaling factor (arch_scale_cpu_capacity()) too whenever
> > policy->max changes such that capacity_orig is updated appropriately.
> > 
> > The scale-invariance code in the scheduler assumes:
> > 
> > arch_scale_cpu_capacity()*arch_scale_freq_capacity() = current capacity
> 
> This is an important concept, thanks for the explaining.

No problem, thanks for reviewing the patches.

> > ...and that capacity_orig = arch_scale_cpu_capacity() is the max
> > available capacity. If we cap the frequency to say, 50%, by setting
> > policy->max then we have to reduce arch_scale_cpu_capacity() to 50% to
> > still get the right current capacity using the expression above.
> > 
> > Using the second definition arch_scale_cpu_capacity() can be a static
> > value and arch_scale_freq_capacity() is always relative to uncapped_max.
> > It seems simpler, but capacity_orig could then be an unavailable
> > capacity and hence we would need to introduce a third capacity to track
> > the current max capacity and use that for scheduling decisions.
> > As you have already discovered the current code is a combination of both
> > which is broken when policy->max is reduced.
> > 
> > Thinking more about it, I would suggest to go with the first definition.
> > The scheduler doesn't need to know about currently unavailable compute
> > capacity it should balance based on the current situation, so it seems
> > to make sense to let capacity_orig reflect the current max capacity.
> 
> Agree.
> 
> > I would suggest that we fix arch_scale_cpu_capacity() to take
> > policy->max changes into account. We need to know the uncapped max
> > frequency somehow to do that. I haven't looked into if we can get that
> > from cpufreq. Also, we need to make sure that no load-balance code
> > assumes that cpus have a capacity of 1024.
> 
> Cpufreq framework provides API *cpufreq_quick_get_max()* and
> *cpufreq_quick_get()* for inquiry current frequency and max frequency,
> but i'm curious if these two functions can be directly called by
> scheduler, due they acquire and release locks internally.

The arch_scale_{cpu,freq}_capacity() functions are called from contexts
where blocking/sleeping is not allowed, so that rules out calling
function that takes locks. We currently avoid that by using atomics.

However, even if we had non-sleeping functions to call into cpufreq, we
would still need some code in arch/* to make that call so it is only the
variables storing the current frequencies that we can move into cpufreq.
But it would naturally belong there, so I guess it is worth it.
