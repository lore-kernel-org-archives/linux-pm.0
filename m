From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v4 03/12] PM: Introduce an Energy Model management
 framework
Date: Thu, 5 Jul 2018 17:06:29 +0200
Message-ID: <20180705150629.GP2458@hirez.programming.kicks-ass.net>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-4-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180628114043.24724-4-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 28, 2018 at 12:40:34PM +0100, Quentin Perret wrote:
> +/* fd_update_cs_table() - Computes the capacity values of a cs_table
> + *
> + * This assumes a linear relation between capacity and frequency. As such,
> + * the capacity of a CPU at the n^th capacity state is computed as:
> + *           capactity(n) = max_capacity * freq(n) / freq_max
> + */

Broken comment style

> +static void fd_update_cs_table(struct em_cs_table *cs_table, int cpu)
> +{
> +	unsigned long cmax = arch_scale_cpu_capacity(NULL, cpu);
> +	int max_cap_state = cs_table->nr_cap_states - 1;
> +	unsigned long fmax = cs_table->state[max_cap_state].frequency;
> +	int i;
> +
> +	for (i = 0; i < cs_table->nr_cap_states; i++) {
> +		u64 cap = (u64)cmax * cs_table->state[i].frequency;
> +		do_div(cap, fmax);
> +		cs_table->state[i].capacity = (unsigned long)cap;

I prefer div64_*() over do_div(), the calling convention the latter
always confuses the heck out of me.

So this then becomes something like:

		cs_table->state[i].capacity =
			div64_u64(cmax * cs_table->state[i].frequency, fmax);

> +	}
> +}
