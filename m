From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFCv6 PATCH 03/10] sched: scheduler-driven cpu frequency
 selection
Date: Mon, 14 Dec 2015 18:02:27 -0800
Message-ID: <566F74B3.4020203@linaro.org>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-4-git-send-email-smuckle@linaro.org>
 <20151211110443.GA6645@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33462 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602AbbLOCCa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2015 21:02:30 -0500
Received: by pabur14 with SMTP id ur14so114044060pab.0
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2015 18:02:29 -0800 (PST)
In-Reply-To: <20151211110443.GA6645@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <Juri.Lelli@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ricky Liang <jcliang@chromium.org>

Hi Juri,

Thanks for the review.

On 12/11/2015 03:04 AM, Juri Lelli wrote:
>> +config CPU_FREQ_GOV_SCHED
>> +	bool "'sched' cpufreq governor"
>> +	depends on CPU_FREQ
> 
> We depend on IRQ_WORK as well, which in turn I think depends on SMP. As
> briefly discussed with Peter on IRC, we might want to use
> smp_call_function_single_async() instead to break this dependecies
> chain (and be able to use this governor on UP as well).

FWIW I don't see an explicit dependency of IRQ_WORK on SMP
(init/Kconfig), nevertheless I'll take a look at moving to
smp_call_function_single_async() to reduce the dependency list of
sched-freq.

...
>> +	/* avoid race with cpufreq_sched_stop */
>> +	if (!down_write_trylock(&policy->rwsem))
>> +		return;
>> +
>> +	__cpufreq_driver_target(policy, freq, CPUFREQ_RELATION_L);
>> +
>> +	gd->throttle = ktime_add_ns(ktime_get(), gd->throttle_nsec);
> 
> As I think you proposed at Connect, we could use post frequency
> transition notifiers to implement throttling. Is this something that you
> already tried implementing/planning to experiment with?

I started to do this a while back and then decided to hold off. I think
(though I can't recall for sure) it may have been so I could
artificially throttle the rate of frequency change events further by
specifying an inflated frequency change time. That's useful to have as
we experiment with policy.

We probably want both of these mechanisms. Throttling at a minimum based
on transition end notifiers, and the option of throttling further for
policy purposes (at least for now, or as a debug option). Will look at
this again.

...
>> +static int cpufreq_sched_thread(void *data)
>> +{
>> +	struct sched_param param;
>> +	struct cpufreq_policy *policy;
>> +	struct gov_data *gd;
>> +	unsigned int new_request = 0;
>> +	unsigned int last_request = 0;
>> +	int ret;
>> +
>> +	policy = (struct cpufreq_policy *) data;
>> +	gd = policy->governor_data;
>> +
>> +	param.sched_priority = 50;
>> +	ret = sched_setscheduler_nocheck(gd->task, SCHED_FIFO, &param);
>> +	if (ret) {
>> +		pr_warn("%s: failed to set SCHED_FIFO\n", __func__);
>> +		do_exit(-EINVAL);
>> +	} else {
>> +		pr_debug("%s: kthread (%d) set to SCHED_FIFO\n",
>> +				__func__, gd->task->pid);
>> +	}
>> +
>> +	do {
>> +		set_current_state(TASK_INTERRUPTIBLE);
>> +		new_request = gd->requested_freq;
>> +		if (new_request == last_request) {
>> +			schedule();
>> +		} else {
> 
> Shouldn't we have to do the following here?
> 
> 
> @@ -125,9 +125,9 @@ static int cpufreq_sched_thread(void *data)
>  	}
>  
>  	do {
> -		set_current_state(TASK_INTERRUPTIBLE);
>  		new_request = gd->requested_freq;
>  		if (new_request == last_request) {
> +			set_current_state(TASK_INTERRUPTIBLE);
>  			schedule();
>  		} else {
>  			/*
> 
> Otherwise we set task to INTERRUPTIBLE state right after it has been
> woken up.

The state must be set to TASK_INTERRUPTIBLE before the data used to
decide whether to sleep or not is read (gd->requested_freq in this case).

If it is set after, then once gd->requested_freq is read but before the
state is set to TASK_INTERRUPTIBLE, the other side may update
gd->requested_freq and issue a wakeup on the freq thread. The wakeup
will have no effect since the freq thread would still be TASK_RUNNING at
that time. The freq thread would proceed to go to sleep and the update
would be lost.

thanks,
Steve
