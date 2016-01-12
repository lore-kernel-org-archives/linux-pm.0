From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Tue, 12 Jan 2016 16:12:12 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601121609460.3575@nanos>
References: <1452093774-17831-1-git-send-email-daniel.lezcano@linaro.org> <1452093774-17831-3-git-send-email-daniel.lezcano@linaro.org> <alpine.DEB.2.11.1601081631380.3575@nanos> <5694F490.3040300@linaro.org> <alpine.DEB.2.11.1601121441330.3575@nanos>
 <56950ACC.4090001@linaro.org> <alpine.DEB.2.11.1601121523070.3575@nanos> <5695133A.8090301@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5695133A.8090301@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

On Tue, 12 Jan 2016, Daniel Lezcano wrote:
> On 01/12/2016 03:26 PM, Thomas Gleixner wrote:
> > You better implement the switching part in the cpuidle core first, i.e.
> > proper
> > callbacks when a governor is switched in/out. Then make use of this
> > switcheroo
> > right away. Doing it the other way round is just wrong.
> 
> The problem is this code is not another governor but a 'predictor' where the
> scheduler will use the information to ask the cpuidle to go to a specific idle
> state without going through the governor code, so into the governor's
> callbacks. It is on top of cpuidle. The scheduler will become the governor.
> 
> The current straightforward code, does the switch in the cpu_idle_loop
> idle_task's function:
> 
> [ ... ]
> 
> if (cpu_idle_force_poll || tick_check_broadcast_expired())
> 	cpu_idle_poll();
> else {
> 	if (sched_idle_enabled()) {
> 		int latency = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
> 		s64 duration = sched_idle_next_wakeup();
> 		sched_idle(duration, latency);
> 	} else {
> 		cpuidle_idle_call();
> 	}
> }
> 
> Due to the complexity of the code, this first step introduce a mechanism to
> predict the next event and re-use it trivially in the idle task.

This looks really wrong. Why on earth don't you implement a proper governor
and just get rid of this extra hackery?

Thanks,

	tglx
