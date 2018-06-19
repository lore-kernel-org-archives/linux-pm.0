From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v8] powercap/drivers/idle_injection: Add an idle
 injection framework
Date: Tue, 19 Jun 2018 11:52:27 +0530
Message-ID: <20180619062227.uyan2t63fqwxj3eb@vireshk-i7>
References: <1529387906-3838-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1529387906-3838-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 19-06-18, 07:58, Daniel Lezcano wrote:
> +++ b/drivers/powercap/idle_injection.c
> @@ -0,0 +1,375 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018 Linaro Limited
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
> + * The idle injection framework proposes a way to force a cpu to enter
> + * an idle state during a specified amount of time for a specified
> + * period.
> + *
> + * It relies on the smpboot kthreads which handles, via its main loop,
> + * the common code for hotplugging and [un]parking.
> + *
> + * At init time, all the kthreads are created.
> + *
> + * A cpumask is specified as parameter for the idle injection
> + * registering function. The kthreads will be synchronized regarding
> + * this cpumask.
> + *
> + * The idle + run duration is specified via the helpers and then the
> + * idle injection can be started at this point.
> + *
> + * A kthread will call play_idle() with the specified idle duration
> + * from above.
> + *
> + * A timer is set after waking up all the tasks, to the next idle
> + * injection cycle.
> + *
> + * The task handling the timer interrupt will wakeup all the kthreads
> + * belonging to the cpumask.
> + *
> + * Stopping the idle injection is synchonuous, when the function

                                     synchronous

> + * returns, there is the guarantee there is no more idle injection
> + * kthread in activity.
> + *
> + * It is up to the user of this framework to provide a lock at an
> + * upper level to prevent stupid things to happen, like starting while
> + * we are unregistering.
> + */

> +static void idle_injection_wakeup(struct idle_injection_device *ii_dev)
> +{
> +	struct idle_injection_thread *iit;
> +	unsigned int cpu;
> +
> +	for_each_cpu_and(cpu, to_cpumask(ii_dev->cpumask), cpu_online_mask) {
> +		iit = per_cpu_ptr(&idle_injection_thread, cpu);
> +		iit->should_run = 1;
> +		wake_up_process(iit->tsk);
> +	}
> +}

Thread A                                        Thread B

                                                CPU3 hotplug out
                                                -> idle_injection_park()
                                                  iit(of-CPU3)->should_run = 0;

idle_injection_wakeup()
 for_each_cpu_and(online)..
   CPU3-selected
                                                clear CPU3 from cpu-online mask.


   iit(of-CPU3)->should_run = 1;
   wake_up_process()

With the above sequence of events, is it possible that the iit->should_run
variable is set to 1 while the CPU is offlined ? And so the crash we discussed
in the previous version may still exist ? Sorry I am not able to take my mind
away from thinking about these stupid races :(

> +
> +/**
> + * idle_injection_wakeup_fn - idle injection timer callback
> + * @timer: a hrtimer structure
> + *
> + * This function is called when the idle injection timer expires which
> + * will wake up the idle injection tasks and these ones, in turn, play
> + * idle a specified amount of time.
> + *
> + * Return: HRTIMER_RESTART.
> + */
> +static enum hrtimer_restart idle_injection_wakeup_fn(struct hrtimer *timer)
> +{
> +	unsigned int run_duration_ms;
> +	unsigned int idle_duration_ms;
> +	struct idle_injection_device *ii_dev =
> +		container_of(timer, struct idle_injection_device, timer);
> +
> +	run_duration_ms = READ_ONCE(ii_dev->run_duration_ms);
> +	idle_duration_ms = READ_ONCE(ii_dev->idle_duration_ms);
> +
> +	idle_injection_wakeup(ii_dev);
> +
> +	hrtimer_forward_now(timer,
> +			    ms_to_ktime(idle_duration_ms + run_duration_ms));
> +
> +	return HRTIMER_RESTART;
> +}
> +
> +/**
> + * idle_injection_fn - idle injection routine
> + * @cpu: the CPU number the task belongs to
> + *
> + * The idle injection routine will stay idle the specified amount of
> + * time
> + */
> +static void idle_injection_fn(unsigned int cpu)
> +{
> +	struct idle_injection_device *ii_dev;
> +	struct idle_injection_thread *iit;
> +
> +	ii_dev = per_cpu(idle_injection_device, cpu);
> +	iit = per_cpu_ptr(&idle_injection_thread, cpu);
> +
> +	/*
> +	 * Boolean used by the smpboot main loop and used as a
> +	 * flip-flop in this function
> +	 */
> +	iit->should_run = 0;
> +
> +	play_idle(READ_ONCE(ii_dev->idle_duration_ms));
> +}

Maybe we shouldn't change things now (too much effort already went into it
already), I just wanted to share an idea that popped up in my mind. Maybe we
could have used the msleep() or similar API with run_duration_ms from the
kthread instead of the whole hrtimer stuff. Maybe that would have been simpler
to manage? Maybe not :)

The patch looks fine otherwise. I don't have any other (negative) feedback :)

-- 
viresh
