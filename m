From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [RFCv6 PATCH 03/10] sched: scheduler-driven cpu frequency
 selection
Date: Sat, 19 Dec 2015 13:54:32 +0800
Message-ID: <20151219055432.GB23305@leoy-linaro>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-4-git-send-email-smuckle@linaro.org>
 <20151216034825.GA11303@leoy-linaro>
 <56720EE8.1090507@linaro.org>
 <20151217071733.GB6195@leoy-linaro>
 <56745B35.5050704@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35601 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbbLSFyk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 19 Dec 2015 00:54:40 -0500
Received: by mail-pa0-f49.google.com with SMTP id jx14so42158376pad.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Dec 2015 21:54:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56745B35.5050704@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ricky Liang <jcliang@chromium.org>

Hi Steve,

On Fri, Dec 18, 2015 at 11:15:01AM -0800, Steve Muckle wrote:
> On 12/16/2015 11:17 PM, Leo Yan wrote:
> > Could you check if below corner case will introduce logic error?
> > The task still will be removed from rq if timer tick is triggered
> > between two time's set_current_state().
> > 
> > set_current_state(TASK_INTERRUPTIBLE);
> >            `-------> timer_tick and
> >                      schedule();
> > do_something...
> > set_current_state(TASK_RUNNING);
> > 
> > It will be safe for combination for set_current_state()/schedule()
> > with waken_up_process():
> > 
> > Thread_A:                                       Thread_B:
> > 
> > set_current_state(TASK_INTERRUPTIBLE);
> >              `-------> timer_tick and
> >                        schedule();
> > ....
> >                                                 wake_up_process(Thread_A);
> >                            <---------------------/
> > schedule();
> > 
> > The first time's schedule() will remove task from rq which is caused
> > by timer tick and call schedule(), and the second time schdule() will
> > be equal yeild().
> 
> I was initially concerned about preemption while task state =
> TASK_INTERRUPTIBLE as well, but a task with state TASK_INTERRUPTIBLE is
> not dequeued if it is preempted. See core.c:__schedule():
> 
>         if (!preempt && prev->state) {
>                 if (unlikely(signal_pending_state(prev->state, prev))) {
>                         prev->state = TASK_RUNNING;
>                 } else {
>                         deactivate_task(rq, prev, DEQUEUE_SLEEP);
>                         prev->on_rq = 0;
> 
> I knew this had to be the case, because this design pattern is used in
> many other places in the kernel, so many things would be very broken if
> this were a problem.

You are right, I went through the code again and sched tick irq will
call preempt_schedule_irq() and __schedule(true); so finally set the
parameter "preempt" = true. Sorry for noise :p

---8<---

arch/arm64/kernel/entry.S:

#ifdef CONFIG_PREEMPT
el1_preempt:
        mov     x24, lr
1:      bl      preempt_schedule_irq            // irq en/disable is done inside
        ldr     x0, [tsk, #TI_FLAGS]            // get new tasks TI_FLAGS
        tbnz    x0, #TIF_NEED_RESCHED, 1b       // needs rescheduling?
        ret     x24
#endif

Thanks,
Leo Yan
