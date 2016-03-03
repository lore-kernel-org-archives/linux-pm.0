From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH 1/6] cpufreq: Reduce cpufreq_update_util() overhead a bit
Date: Thu, 3 Mar 2016 11:47:01 +0000
Message-ID: <20160303114701.GT18792@e106622-lin>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <3575770.L1lplNLqVv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3575770.L1lplNLqVv@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On 02/03/16 03:04, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 

[...]

> @@ -95,18 +98,24 @@ EXPORT_SYMBOL_GPL(cpufreq_set_update_uti
>   *
>   * This function is called by the scheduler on every invocation of
>   * update_load_avg() on the CPU whose utilization is being updated.
> + *
> + * It can only be called from RCU-sched read-side critical sections.
>   */
>  void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
>  {
>  	struct update_util_data *data;
>  
> -	rcu_read_lock();
> +#ifdef CONFIG_LOCKDEP
> +	WARN_ON(debug_locks && !rcu_read_lock_sched_held());
> +#endif
>  
>  	data = rcu_dereference(*this_cpu_ptr(&cpufreq_update_util_data));

I think you need to s/rcu_dereference/rcu_dereference_sched/ here or
RCU will complain:

[    0.106313] ===============================
[    0.106322] [ INFO: suspicious RCU usage. ]
[    0.106334] 4.5.0-rc6+ #93 Not tainted
[    0.106342] -------------------------------
[    0.106353] /media/hdd1tb/work/integration/kernel/drivers/cpufreq/cpufreq.c:113 suspicious rcu_dereference_check() usage!
[    0.106361]
[    0.106361] other info that might help us debug this:
[    0.106361]
[    0.106375]
[    0.106375] rcu_scheduler_active = 1, debug_locks = 1
[    0.106387] 1 lock held by swapper/0/0:
[    0.106395]  #0:  (&rq->lock){-.....}, at: [<ffffffc000743204>] __schedule+0xec/0xadc
[    0.106436]
[    0.106436] stack backtrace:
[    0.106450] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.5.0-rc6+ #93
[    0.106459] Hardware name: ARM Juno development board (r2) (DT)
[    0.106468] Call trace:
[    0.106483] [<ffffffc00008a8a8>] dump_backtrace+0x0/0x210
[    0.106496] [<ffffffc00008aad8>] show_stack+0x20/0x28
[    0.106511] [<ffffffc0004261a4>] dump_stack+0xa8/0xe0
[    0.106526] [<ffffffc000120e9c>] lockdep_rcu_suspicious+0xd4/0x114
[    0.106540] [<ffffffc0005d8180>] cpufreq_update_util+0xd4/0xd8
[    0.106554] [<ffffffc000105b9c>] set_next_entity+0x540/0xf7c
[    0.106569] [<ffffffc00010f78c>] pick_next_task_fair+0x9c/0x754
[    0.106580] [<ffffffc00074351c>] __schedule+0x404/0xadc
[    0.106592] [<ffffffc000743de0>] schedule+0x40/0xa0
[    0.106603] [<ffffffc000744094>] schedule_preempt_disabled+0x1c/0x2c
[    0.106617] [<ffffffc000741190>] rest_init+0x14c/0x164
[    0.106631] [<ffffffc0009f9990>] start_kernel+0x3c0/0x3d4
[    0.106642] [<ffffffc0000811b4>] 0xffffffc0000811b4

Best,

- Juri
