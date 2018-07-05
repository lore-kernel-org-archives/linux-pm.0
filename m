From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v4 03/12] PM: Introduce an Energy Model management
 framework
Date: Thu, 5 Jul 2018 16:39:01 +0200
Message-ID: <20180705143901.GO2458@hirez.programming.kicks-ass.net>
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
> +/**
> + * em_fd_nr_cap_states() - Get the number of capacity states of a freq. domain
> + * @fd		: frequency domain for which want to do this
> + *
> + * Return: the number of capacity state in the frequency domain table
> + */
> +static inline int em_fd_nr_cap_states(struct em_freq_domain *fd)
> +{
> +	struct em_cs_table *table;
> +	int nr_states;
> +
> +	rcu_read_lock();
> +	table = rcu_dereference(fd->cs_table);
> +	nr_states = table->nr_cap_states;
> +	rcu_read_unlock();

So right here, we can continue to free @table...

> +
> +	return nr_states;
> +}

and then what does the value we return mean?
