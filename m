From: Juri Lelli <Juri.Lelli@arm.com>
Subject: Re: [RFCv6 PATCH 03/10] sched: scheduler-driven cpu frequency
 selection
Date: Tue, 15 Dec 2015 10:31:30 +0000
Message-ID: <20151215103130.GF16007@e106622-lin>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-4-git-send-email-smuckle@linaro.org>
 <20151211110443.GA6645@e106622-lin>
 <566F74B3.4020203@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <566F74B3.4020203@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ricky Liang <jcliang@chromium.org>
List-Id: linux-pm@vger.kernel.org

On 14/12/15 18:02, Steve Muckle wrote:
> Hi Juri,
> 
> Thanks for the review.
> 
> On 12/11/2015 03:04 AM, Juri Lelli wrote:
> >> +config CPU_FREQ_GOV_SCHED
> >> +	bool "'sched' cpufreq governor"
> >> +	depends on CPU_FREQ
> > 
> > We depend on IRQ_WORK as well, which in turn I think depends on SMP. As
> > briefly discussed with Peter on IRC, we might want to use
> > smp_call_function_single_async() instead to break this dependecies
> > chain (and be able to use this governor on UP as well).
> 
> FWIW I don't see an explicit dependency of IRQ_WORK on SMP

Oh, right. I seemed to remember that, but now I couldn't find this
dependency anymore.

> (init/Kconfig), nevertheless I'll take a look at moving to
> smp_call_function_single_async() to reduce the dependency list of
> sched-freq.
> 

OK, great. I think there's still value in reducing the dependency list.

> ...
> >> +	/* avoid race with cpufreq_sched_stop */
> >> +	if (!down_write_trylock(&policy->rwsem))
> >> +		return;
> >> +
> >> +	__cpufreq_driver_target(policy, freq, CPUFREQ_RELATION_L);
> >> +
> >> +	gd->throttle = ktime_add_ns(ktime_get(), gd->throttle_nsec);
> > 
> > As I think you proposed at Connect, we could use post frequency
> > transition notifiers to implement throttling. Is this something that you
> > already tried implementing/planning to experiment with?
> 
> I started to do this a while back and then decided to hold off. I think
> (though I can't recall for sure) it may have been so I could
> artificially throttle the rate of frequency change events further by
> specifying an inflated frequency change time. That's useful to have as
> we experiment with policy.
> 
> We probably want both of these mechanisms. Throttling at a minimum based
> on transition end notifiers, and the option of throttling further for
> policy purposes (at least for now, or as a debug option). Will look at
> this again.
> 

Yeah, looks good.

> ...
> >> +static int cpufreq_sched_thread(void *data)
> >> +{
> >> +	struct sched_param param;
> >> +	struct cpufreq_policy *policy;
> >> +	struct gov_data *gd;
> >> +	unsigned int new_request = 0;
> >> +	unsigned int last_request = 0;
> >> +	int ret;
> >> +
> >> +	policy = (struct cpufreq_policy *) data;
> >> +	gd = policy->governor_data;
> >> +
> >> +	param.sched_priority = 50;
> >> +	ret = sched_setscheduler_nocheck(gd->task, SCHED_FIFO, &param);
> >> +	if (ret) {
> >> +		pr_warn("%s: failed to set SCHED_FIFO\n", __func__);
> >> +		do_exit(-EINVAL);
> >> +	} else {
> >> +		pr_debug("%s: kthread (%d) set to SCHED_FIFO\n",
> >> +				__func__, gd->task->pid);
> >> +	}
> >> +
> >> +	do {
> >> +		set_current_state(TASK_INTERRUPTIBLE);
> >> +		new_request = gd->requested_freq;
> >> +		if (new_request == last_request) {
> >> +			schedule();
> >> +		} else {
> > 
> > Shouldn't we have to do the following here?
> > 
> > 
> > @@ -125,9 +125,9 @@ static int cpufreq_sched_thread(void *data)
> >  	}
> >  
> >  	do {
> > -		set_current_state(TASK_INTERRUPTIBLE);
> >  		new_request = gd->requested_freq;
> >  		if (new_request == last_request) {
> > +			set_current_state(TASK_INTERRUPTIBLE);
> >  			schedule();
> >  		} else {
> >  			/*
> > 
> > Otherwise we set task to INTERRUPTIBLE state right after it has been
> > woken up.
> 
> The state must be set to TASK_INTERRUPTIBLE before the data used to
> decide whether to sleep or not is read (gd->requested_freq in this case).
> 
> If it is set after, then once gd->requested_freq is read but before the
> state is set to TASK_INTERRUPTIBLE, the other side may update
> gd->requested_freq and issue a wakeup on the freq thread. The wakeup
> will have no effect since the freq thread would still be TASK_RUNNING at
> that time. The freq thread would proceed to go to sleep and the update
> would be lost.
> 

Mmm, I suggested that because I was hitting this while testing:

[   34.816158] ------------[ cut here ]------------
[   34.816177] WARNING: CPU: 2 PID: 1712 at kernel/kernel/sched/core.c:7617 __might_sleep+0x90/0xa8()
[   34.816188] do not call blocking ops when !TASK_RUNNING; state=1 set at [<c007c1f8>] cpufreq_sched_thread+0x80/0x2b0
[   34.816198] Modules linked in:
[   34.816207] CPU: 2 PID: 1712 Comm: kschedfreq:1 Not tainted 4.4.0-rc2+ #401
[   34.816212] Hardware name: ARM-Versatile Express
[   34.816229] [<c0018874>] (unwind_backtrace) from [<c0013f60>] (show_stack+0x20/0x24)
[   34.816243] [<c0013f60>] (show_stack) from [<c0448c98>] (dump_stack+0x80/0xb4)
[   34.816257] [<c0448c98>] (dump_stack) from [<c0029930>] (warn_slowpath_common+0x88/0xc0)
[   34.816267] [<c0029930>] (warn_slowpath_common) from [<c0029a24>] (warn_slowpath_fmt+0x40/0x48)
[   34.816278] [<c0029a24>] (warn_slowpath_fmt) from [<c0054764>] (__might_sleep+0x90/0xa8)
[   34.816291] [<c0054764>] (__might_sleep) from [<c0578400>] (cpufreq_freq_transition_begin+0x6c/0x13c)
[   34.816303] [<c0578400>] (cpufreq_freq_transition_begin) from [<c0578714>] (__cpufreq_driver_target+0x180/0x2c0)
[   34.816314] [<c0578714>] (__cpufreq_driver_target) from [<c007c14c>] (cpufreq_sched_try_driver_target+0x48/0x74)
[   34.816324] [<c007c14c>] (cpufreq_sched_try_driver_target) from [<c007c1e8>] (cpufreq_sched_thread+0x70/0x2b0)
[   34.816336] [<c007c1e8>] (cpufreq_sched_thread) from [<c004ce30>] (kthread+0xf4/0x114)
[   34.816347] [<c004ce30>] (kthread) from [<c000fdd0>] (ret_from_fork+0x14/0x24)
[   34.816355] ---[ end trace 30e92db342678467 ]---

Maybe we could cope with what you are saying with an atomic flag
indicating that the kthread is currently servicing a request? Like
extending the finish_last_request thing to cover this case as well.

Best,

- Juri
