From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv2 5/6] sched/fair: Tune task wake-up logic to pack jitter
 tasks
Date: Wed, 15 May 2019 18:43:00 +0200
Message-ID: <20190515164300.GX2589@hirez.programming.kicks-ass.net>
References: <20190515135322.19393-1-parth@linux.ibm.com>
 <20190515135322.19393-6-parth@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190515135322.19393-6-parth@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Parth Shah <parth@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, dsmythies@telus.net
List-Id: linux-pm@vger.kernel.org

On Wed, May 15, 2019 at 07:23:21PM +0530, Parth Shah wrote:
> @@ -6704,6 +6773,31 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  	return -1;
>  }
>  
> +#ifdef CONFIG_SCHED_SMT
> +/*
> + * Select all tasks of type 1(jitter) for task packing
> + */
> +static int turbosched_select_idle_sibling(struct task_struct *p, int prev_cpu,
> +					  int target)
> +{
> +	int new_cpu;
> +
> +	if (unlikely(task_group(p)->turbo_sched_enabled)) {

So if you build without cgroups, this is a NULL dereference.

Also, this really should not be group based.

> +		new_cpu = select_non_idle_core(p, prev_cpu);
> +		if (new_cpu >= 0)
> +			return new_cpu;
> +	}
> +
> +	return select_idle_sibling(p, prev_cpu, target);
> +}
> +#else
