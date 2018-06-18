From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V7] powercap/drivers/idle_injection: Add an idle injection
 framework
Date: Mon, 18 Jun 2018 12:35:59 +0200
Message-ID: <bb11af50-1089-43af-abfa-0824e0db1e77@linaro.org>
References: <1529054393-27077-1-git-send-email-daniel.lezcano@linaro.org>
 <20180618102245.x5cfei3i7voq65zc@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180618102245.x5cfei3i7voq65zc@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>
List-Id: linux-pm@vger.kernel.org

On 18/06/2018 12:22, Viresh Kumar wrote:
> On 15-06-18, 11:19, Daniel Lezcano wrote:
>> +/**
>> + * idle_injection_stop - stops the idle injections
>> + * @ii_dev: a pointer to an idle injection_device structure
>> + *
>> + * The function stops the idle injection and waits for the threads to
>> + * complete. If we are in the process of injecting an idle cycle, then
>> + * this will wait the end of the cycle.
>> + *
>> + * When the function returns there is no more idle injection
>> + * activity. The kthreads are scheduled out and the periodic timer is
>> + * off.
>> + */
>> +void idle_injection_stop(struct idle_injection_device *ii_dev)
>> +{
>> +	struct idle_injection_thread *iit;
>> +	unsigned int cpu;
>> +
>> +	pr_debug("Stopping injecting idle cycles on CPUs '%*pbl'\n",
>> +		 cpumask_pr_args(to_cpumask(ii_dev->cpumask)));
>> +
>> +	hrtimer_cancel(&ii_dev->timer);
>> +
>> +	/*
>> +	 * We want the guarantee we have a quescient point where
>> +	 * parked threads stay in there state while we are stopping
>> +	 * the idle injection. After exiting the loop, if any CPU is
>> +	 * plugged in, the 'should_run' boolean being false, the
>> +	 * smpboot main loop schedules the task out.
>> +	 */
>> +	cpu_hotplug_disable();
>> +
>> +	for_each_cpu_and(cpu, to_cpumask(ii_dev->cpumask), cpu_online_mask) {
> 
> Maybe you should do below for all CPUs in the mask. Is the below usecase
> possible ?
> 
> - CPU0-4 are part of the mask and are all online.
> - hrtimer fires and sets should_run for all of them to 1.

    ^^
hrtimer_cancel gives you the guarantee, the timer is no longer active
and there is no execution in the timer handler. So the timer can no
longer fire after hrtimer_cancel() is called (which is a blocking call).

> - Right at this time CPU3 goes offline, so the thread gets parked with
>   should_run == 1. Is there a reason why this can't happen ?
> - Now we unregister the stuff and CPU3 again comes online.
> - Because it had should_run as true, we again run the thread and Crash.
> 
> makes sense ?


>> +		iit = per_cpu_ptr(&idle_injection_thread, cpu);
>> +		iit->should_run = 0;
>> +
>> +		wait_task_inactive(iit->tsk, 0);
> 
> I am not very sure of what guarantees this will provide.

We get the guarantee any idle injection cycle is ended.

> @Peter: Do you see any more race scenarios here ?
> 
>> +	}
>> +
>> +	cpu_hotplug_enable();
>> +}
> 
>> +struct idle_injection_device *idle_injection_register(struct cpumask *cpumask)
>> +{
>> +	struct idle_injection_device *ii_dev;
>> +	int cpu;
>> +
>> +	ii_dev = kzalloc(sizeof(*ii_dev) + cpumask_size(), GFP_KERNEL);
>> +	if (!ii_dev)
>> +		return NULL;
>> +
>> +	cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
>> +	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>> +	ii_dev->timer.function = idle_injection_wakeup_fn;
>> +
>> +	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
>> +
>> +		if (per_cpu(idle_injection_device, cpu)) {
>> +			pr_err("cpu%d is already registered\n", cpu);
>> +			goto out_rollback_per_cpu;
>> +		}
>> +
>> +		per_cpu(idle_injection_device, cpu) = ii_dev;
>> +	}
>> +
>> +	return ii_dev;
>> +
>> +out_rollback_per_cpu:
>> +	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask))
>> +		per_cpu(idle_injection_device, cpu) = NULL;
> 
> So if two parts of the kernel call this routine with the same cpumask, then the
> second call will also overwrite the masks with NULL and return error. That will
> screw up things a bit here.

Apparently there is a misunderstanding :)

https://lkml.org/lkml/2018/5/29/209 (at the end)



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
