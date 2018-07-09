From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v4 09/12] sched/fair: Introduce an energy estimation
 helper function
Date: Mon, 9 Jul 2018 16:28:26 +0100
Message-ID: <20180709152825.GA17598@e108498-lin.cambridge.arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-10-quentin.perret@arm.com>
 <20180706131243.GV2458@hirez.programming.kicks-ass.net>
 <20180706151212.GD17577@e108498-lin.cambridge.arm.com>
 <20180706154949.GO2494@hirez.programming.kicks-ass.net>
 <20180706170443.GE17577@e108498-lin.cambridge.arm.com>
 <20180709120138.GQ2494@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180709120138.GQ2494@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday 09 Jul 2018 at 14:01:38 (+0200), Peter Zijlstra wrote:
> On Fri, Jul 06, 2018 at 06:04:44PM +0100, Quentin Perret wrote:
> > 'max_util' is basically the util we use to request an OPP. 'sum_util' is
> > how long the CPUs will be running.
> 
> A indeed. But yes bit of a mess, but it wants doing I think.

OK, understood.

> Perhaps a little something like the below... The alternative is two
> separate but closely related functions, not sure which is better.
> 
> 
> enum schedutil_type {
> 	frequency_util,
> 	energy_util,
> };

Hmm, this should work ... Should we also try to avoid the code
duplication in scale_rt_capacity() ? This doesn't want dependencies on
schedutil I assume so a little bit of extra work is required.

What about moving schedutil_freq_util() to sched.h and give it a more
generic name (total_cpu_util() ?) with no dependencies on
CONFIG_CPU_FREQ_GOV_SCHEDUTIL ? Also, 'energy_util' would have to be
renamed I guess (busy_time_util ?).

Then scale_rt_capacity() can be turned into something like (totally
untested):

static unsigned long scale_rt_capacity(int cpu)
{
	unsigned long util = total_cpu_util(cpu, 0, busy_time_util);

	return arch_scale_cpu_capacity(NULL, cpu) - util;
}

Thoughts ?

Thanks,
Quentin
