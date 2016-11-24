From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 0/4] cpufreq: schedutil: move slow path from workqueue
 to SCHED_FIFO task
Date: Thu, 24 Nov 2016 09:34:04 +0530
Message-ID: <20161124040404.GB9376@vireshk-i7>
References: <cover.1479197311.git.viresh.kumar@linaro.org>
 <20161124030102.GA20047@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35374 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753943AbcKXEEc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2016 23:04:32 -0500
Received: by mail-pf0-f182.google.com with SMTP id i88so7123134pfk.2
        for <linux-pm@vger.kernel.org>; Wed, 23 Nov 2016 20:04:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161124030102.GA20047@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <smuckle.linux@gmail.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>

On 23-11-16, 19:01, Steve Muckle wrote:
> I know this has already gone in, but can you expand on the unmet
> guarantees mentioned here just for my own (and perhaps others')
> understanding?

Sure. This is the simplified form of your original patch:

@@ -71,7 +73,7 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 {
        s64 delta_ns;
 
-       if (sg_policy->work_in_progress)
+       if (sg_policy->thread_active)
                return false;
 
        if (unlikely(sg_policy->need_freq_update)) {
 
+static int sugov_thread(void *data)
 {
	...

+       do {

        ...

+               set_current_state(TASK_RUNNING);
+               /* Issue request. */
+               mutex_lock(&sg_policy->slow_lock);
+               __cpufreq_driver_target(sg_policy->policy,
+                                       sg_policy->next_freq,
+                                       CPUFREQ_RELATION_L);
+               mutex_unlock(&sg_policy->slow_lock);
+
+               sg_policy->thread_active = false;

        ...

+               schedule();
+
+       } while (!kthread_should_stop());
+       return 0;
 }
 
 static void sugov_irq_work(struct irq_work *irq_work)
@@ -349,7 +382,7 @@ static void sugov_irq_work(struct irq_work *irq_work)
        struct sugov_policy *sg_policy;
 
        sg_policy = container_of(irq_work, struct sugov_policy, irq_work);
-       schedule_work_on(smp_processor_id(), &sg_policy->work);
+       wake_up_process(sg_policy->thread);
 }

Consider that the thread has just got a chance to run and has set
'thread_active' to false from sugov_thread(), i.e. schedule() isn't called yet.

At this time if sugov_should_update_freq() gets called again, it will return
'true', and eventually we will land into sugov_irq_work() and that will call
wake_up_process(). But the process is already running and haven't slept yet.
I am not sure how it works but I don't expect the thread to go to sleep again at
this point of time.

And in this particular case we will end up not evaluating the load and doing
DVFS for period = 2 * rate_limit_us, whereas we wanted to do that every
rate_limit microseconds.

Of course a simple kthread would have been better instead of a kthread + work if
this wasn't the case.

Does that sound reasonable or Am I missing something ?

-- 
viresh
