From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC][PATCH v2 2/2] cpufreq: schedutil: Avoid decreasing
 frequency of busy CPUs
Date: Tue, 21 Mar 2017 12:10:44 +0530
Message-ID: <20170321064044.GO25659@vireshk-i7>
References: <4366682.tsferJN35u@aspire.rjw.lan>
 <2185243.flNrap3qq1@aspire.rjw.lan>
 <3300960.HE4b3sK4dn@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3300960.HE4b3sK4dn@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

On 20-03-17, 22:46, Rafael J. Wysocki wrote:
> Index: linux-pm/kernel/sched/cpufreq_schedutil.c

> +static void sugov_update_commit(struct sugov_cpu *sg_cpu,
> +				struct sugov_policy *sg_policy,
> +				u64 time, unsigned int next_freq)
>  {
>  	struct cpufreq_policy *policy = sg_policy->policy;
>  
> +	if (sugov_cpu_is_busy(sg_cpu) && next_freq < sg_policy->next_freq)
> +		next_freq = sg_policy->next_freq;
> +

In the earlier version you said that we want to be opportunistic and
don't want to do heavy computation and so check only for current CPU.

But in this version, all those computations are already done by now.
Why shouldn't we check all CPUs in the policy now? I am asking as we
will still have the same problem, we are trying to work-around if the
current CPU isn't busy but others sharing the policy are.

Also, why not return directly from within the if block? To run
trace_cpu_frequency()?

I don't remember exactly, but why don't we run that for !fast-switch
case? We can simplify the code a bit if we check for no freq change at
the top of the routine.

-- 
viresh
