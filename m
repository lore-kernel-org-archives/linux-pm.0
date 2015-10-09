From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFCv5 PATCH 25/46] sched: Add over-utilization/tipping point
 indicator
Date: Fri, 9 Oct 2015 13:49:34 +0100
Message-ID: <20151009124933.GA30293@e105550-lin.cambridge.arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-26-git-send-email-morten.rasmussen@arm.com>
 <20150813173533.GZ19282@twins.programming.kicks-ass.net>
 <20150814130247.GD29326@e105550-lin.cambridge.arm.com>
 <560AEFCE.1070905@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <560AEFCE.1070905@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 29, 2015 at 01:08:46PM -0700, Steve Muckle wrote:
> On 08/14/2015 06:02 AM, Morten Rasmussen wrote:
> > To be sure not to break smp_nice, we have defined over-utilization as
> > when:
> > 
> > cpu_rq(any)::cfs::avg::util_avg + margin > cpu_rq(any)::capacity
> > 
> > is true for any cpu in the system. IOW, as soon as one cpu is (nearly)
> > 100% utilized, we switch to load_avg to factor in priority.
> > 
> > Now with this definition, we can skip periodic load-balance as no cpu
> > has an always-running task when the system is not over-utilized. All
> > tasks will be periodic and we can balance them at wake-up. This
> > conservative condition does however mean that some scenarios that could
> > benefit from energy-aware decisions even if one cpu is fully utilized
> > would not get those benefits.
> > 
> > For system where some cpus might have reduced capacity on some cpus
> > (RT-pressure and/or big.LITTLE), we want periodic load-balance checks as
> > soon a just a single cpu is fully utilized as it might one of those with
> > reduced capacity and in that case we want to migrate it.
> > 
> > I haven't found any reasonably easy-to-track conditions that would work
> > better. Suggestions are very welcome.
> 
> Workloads with a single heavy task and many small tasks are pretty
> common. I'm worried about the single heavy task tripping the
> over-utilization condition on a b.L system, EAS getting turned off, and
> small tasks running on big CPUs, leading to an increase in power
> consumption.
> 
> Perhaps an extension to the over-utilization logic such as the following
> could cause big CPUs being saturated by a single task to be ignored?
> 
> util(cpu X) + margin > capacity(cpu X) &&
>   (capacity(cpu X) != max_capacity ? 1 : nr_running(cpu X) > 1)

I have had the same thought as well. I think it could work. nr_running()
doesn't take into account blocked tasks, so we could in theory see fewer
tasks than there is, but those scenarios are currently ignored by
load-balancing anyway and if the cpu is seriously over-utilized we are
quite likely to have nr_running() > 1.

I'm in favor of giving it a try and see what explodes :-)
