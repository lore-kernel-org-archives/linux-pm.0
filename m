From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC/RFT][PATCH 2/2] cpufreq: schedutil: Utilization aggregation
Date: Mon, 10 Apr 2017 12:26:07 +0100
Message-ID: <20170410112607.GD30804@e106622-lin>
References: <3498238.liCqOyIkGA@aspire.rjw.lan>
 <2242635.g1ACnTm5vK@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2242635.g1ACnTm5vK@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

thanks for this set. I'll give it a try (together with your previous
patch) in the next few days.

A question below.

On 10/04/17 02:11, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Due to the limitation of the rate of frequency changes the schedutil
> governor only estimates the CPU utilization entirely when it is about
> to update the frequency for the corresponding cpufreq policy.  As a
> result, the intermediate utilization values are discarded by it,
> but that is not appropriate in general (like, for example, when
> tasks migrate from one CPU to another or exit, in which cases the
> utilization measured by PELT may change abruptly between frequency
> updates).
> 
> For this reason, modify schedutil to estimate CPU utilization
> completely whenever it is invoked for the given CPU and store the
> maximum encountered value of it as input for subsequent new frequency
> computations.  This way the new frequency is always based on the
> maximum utilization value seen by the governor after the previous
> frequency update which effectively prevents intermittent utilization
> variations from causing it to be reduced unnecessarily.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

[...]

> -static void sugov_get_util(unsigned long *util, unsigned long *max)
> +static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned int flags)
>  {
> +	unsigned long cfs_util, cfs_max;
>  	struct rq *rq = this_rq();
> -	unsigned long cfs_max;
>  
> -	cfs_max = arch_scale_cpu_capacity(NULL, smp_processor_id());
> +	sg_cpu->flags |= flags & SCHED_CPUFREQ_RT_DL;
> +	if (sg_cpu->flags & SCHED_CPUFREQ_RT_DL)
> +		return;
>  

IIUC, with this you also keep track of any RT/DL tasks that woke up
during the last throttling period, and react accordingly as soon a
triggering event happens after the throttling period elapses.

Given that for RT (and still for DL as well) the next event is a
periodic tick, couldn't happen that the required frequency transition
for an RT task, that unfortunately woke up before the end of a throttling
period, gets delayed of a tick interval (at least 4ms on ARM)?
Don't we need to treat such wake up events (RT/DL) in a special way and
maybe set a timer to fire and process them as soon as the current
throttling period elapses? Might be a patch on top of this I guess.

Best,

- Juri
