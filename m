From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFC PATCH v4 03/12] PM: Introduce an Energy Model management
 framework
Date: Mon, 9 Jul 2018 20:07:31 +0200
Message-ID: <4341d199-8018-21e1-c2ce-9af8f7719297@arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-4-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180628114043.24724-4-quentin.perret@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>, peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mingo@redhat.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/28/2018 01:40 PM, Quentin Perret wrote:

[...]

> +/**
> + * em_rescale_cpu_capacity() - Re-scale capacity values of the Energy Model
> + *
> + * This re-scales the capacity values for all capacity states of all frequency
> + * domains of the Energy Model. This should be used when the capacity values
> + * of the CPUs are updated at run-time, after the EM was registered.
> + */
> +void em_rescale_cpu_capacity(void)
> +{
> +	struct em_cs_table *old_table, *new_table;
> +	struct em_freq_domain *fd;
> +	int nr_states, cpu;
> +
> +	mutex_lock(&em_fd_mutex);
> +	rcu_read_lock();
> +	for_each_possible_cpu(cpu) {
> +		/* Re-scale only once per frequency domain. */
> +		fd = READ_ONCE(per_cpu(em_data, cpu));
> +		if (!fd || cpu != cpumask_first(to_cpumask(fd->cpus)))
> +			continue;
> +
> +		/* Copy the existing table. */
> +		old_table = rcu_dereference(fd->cs_table);
> +		nr_states = old_table->nr_cap_states;
> +		new_table = alloc_cs_table(nr_states);
> +		if (!new_table)
> +			goto out;
> +		memcpy(new_table->state, old_table->state,
> +					nr_states * sizeof(*new_table->state));
> +
> +		/* Re-scale the capacity values of the copy. */
> +		fd_update_cs_table(new_table,
> +					cpumask_first(to_cpumask(fd->cpus)));
> +
> +		/* Replace the fd table with the re-scaled version. */
> +		rcu_assign_pointer(fd->cs_table, new_table);
> +		call_rcu(&old_table->rcu, rcu_free_cs_table);
> +	}
> +out:
> +	rcu_read_unlock();
> +	mutex_unlock(&em_fd_mutex);
> +}
> +EXPORT_SYMBOL_GPL(em_rescale_cpu_capacity);

This em_rescale_cpu_capacity() function is still very much specific to 
systems with asymmetric cpu capacity (Arm big.Little/DynamIQ). Only 
after cpufreq is up we can determine the capacity of a CPU, hence we 
need this one to set the CPU capacity values for the individual 
performance states.

Can you not calculate capacity 'on the fly' just using freq and max freq 
as well as arch_scale_cpu_capacity() which gives you max capacity?

capacity = arch_scale_cpu_capacity() * freq / max_freq

In this case we could get rid of the 'ugly' EM rescaling infrastructure.

[...]
