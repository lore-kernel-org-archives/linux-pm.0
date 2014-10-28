From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [RFC/PATCH] PM / Sleep: Timer quiesce in freeze state
Date: Tue, 28 Oct 2014 12:39:53 +0800
Message-ID: <544F1E19.5030606@linux.intel.com>
References: <5446787E.60202@linux.intel.com> <20141024153656.GM12706@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141024153656.GM12706@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "alan@linux.intel.com" <alan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, "linux-pm@vger.kernel.org >> Linux PM list" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2014/10/24 23:36, Peter Zijlstra wrote:
>> +
>> +static void freezer_idle(int cpu)
>> +{
>> +	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
>> +	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
>> +
>> +	stop_critical_timings();
>> +
>> +	while (suspend_freeze_wake == -1) {
>> +		int next_state;
>> +
>> +		/*
>> +		 * interrupt must be disabled before cpu enters idle
>> +		 */
>> +		local_irq_disable();
>> +
>> +		next_state = cpuidle_select(drv, dev);
>> +		if (next_state < 0) {
>> +			arch_cpu_idle();
>> +			continue;
>> +		}
>> +		/*
>> +		 * cpuidle_enter will return with interrupt enabled
>> +		 */
>> +		cpuidle_enter(drv, dev, next_state);
>> +	}
>> +
>> +	if (suspend_freeze_wake == cpu)
>> +		kick_all_cpus_sync();
>> +
> 
> So I disabled IRQs here
> 
>> +	start_critical_timings();
>> +}
>> +
>> +static void freezer_resume_tk(int cpu)
>> +{
>> +	if (tick_do_timer_cpu != cpu)
>> +		return;
>> +
>>  	cpuidle_pause();
>>  	cpuidle_use_deepest_state(false);
>> +
> 
> Such that they would still be disabled here
> 
>> +	local_irq_disable();
>> +	timekeeping_resume();
>> +	local_irq_enable();
>> +}
>> +
>> +static void freezer_resume_clkevt(int cpu)
>> +{
>> +	if (tick_do_timer_cpu == cpu)
>> +		return;
>> +
>> +	touch_softlockup_watchdog();
>> +	clockevents_notify(CLOCK_EVT_NOTIFY_RESUME, NULL);
> 
> And here.
> 
>> +	local_irq_disable();
>> +	hrtimers_resume();
>> +	local_irq_enable();
>> +}
>> +
>> +typedef void (*freezer_fn)(int);
>> +
>> +static freezer_fn freezer_func[FREEZER_EXIT] = {
>> +	NULL,
>> +	freezer_pick_tk,
>> +	freezer_suspend_clkevt,
>> +	freezer_suspend_tk,
>> +	freezer_idle,
>> +	freezer_resume_tk,
>> +	freezer_resume_clkevt,
>> +};
> 
> Because this is a stop_machine callback, which are nominally run with
> IRQs disabled.
> 
>> +static int freezer_stopper_fn(void *arg)
>> +{
>> +	struct freezer_data *fd = arg;
>> +	enum freezer_state state = FREEZER_NONE;
>> +	int cpu = smp_processor_id();
>> +
>> +	do {
>> +		cpu_relax();
>> +		if (fd->state != state) {
>> +			state = fd->state;
>> +			if (freezer_func[state])
>> +				(*freezer_func[state])(cpu);
>> +			ack_state(fd);
>> +		}
>> +	} while (fd->state != FREEZER_EXIT);
>> +	return 0;
>> +}
> 
> Now I suppose the problem is with cpu_pause() which needs IPIs to
> complete? 

Yes, cpu_pause() will invoke smp IPI functions which need interrupt is
enabled. So I changed irq ops like above. Actually, I have an early
version to move cpuidle_pause()/cpuidle_resume() out of stop_machine(),
that might be a better solution?

Thanks,
-Aubrey
