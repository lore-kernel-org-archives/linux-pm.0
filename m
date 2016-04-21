From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [PATCH] sched/cpufreq: don't trigger cpufreq update w/o real
 rt/deadline tasks running
Date: Thu, 21 Apr 2016 20:12:59 +0800
Message-ID: <CANRm+Cxx=vdYOra98rb_ovdfEONd7T6qNJHFHw1YCt4sT4GneA@mail.gmail.com>
References: <1460958684-32105-1-git-send-email-wanpeng.li@hotmail.com>
	<6087716.bi8vDPiZNy@vostro.rjw.lan>
	<20160420140117.GZ3448@twins.programming.kicks-ass.net>
	<CANRm+CzGm5axJC_y=rqhmi=DLkfpXfo2NLzFyRyjeZE89Aty4Q@mail.gmail.com>
	<57180293.1040809@intel.com>
	<CANRm+CwW_STS21Fu0iKs5gVps9OF8GFKB4ksqLqT=33O-hoOWg@mail.gmail.com>
	<5718B576.1020306@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36548 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbcDUMNA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 08:13:00 -0400
In-Reply-To: <5718B576.1020306@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wanpeng Li <wanpeng.li@hotmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>

2016-04-21 19:11 GMT+08:00 Rafael J. Wysocki <rafael.j.wysocki@intel.com>:
> On 4/21/2016 3:09 AM, Wanpeng Li wrote:
>>
>> 2016-04-21 6:28 GMT+08:00 Rafael J. Wysocki <rafael.j.wysocki@intel.com>:
>>>
>>> On 4/21/2016 12:24 AM, Wanpeng Li wrote:
>>>>
>>>> 2016-04-20 22:01 GMT+08:00 Peter Zijlstra <peterz@infradead.org>:
>>>>>
>>>>> On Wed, Apr 20, 2016 at 02:32:35AM +0200, Rafael J. Wysocki wrote:
>>>>>>
>>>>>> On Monday, April 18, 2016 01:51:24 PM Wanpeng Li wrote:
>>>>>>>
>>>>>>> Sometimes update_curr() is called w/o tasks actually running, it is
>>>>>>> captured by:
>>>>>>>       u64 delta_exec = rq_clock_task(rq) - curr->se.exec_start;
>>>>>>> We should not trigger cpufreq update in this case for rt/deadline
>>>>>>> classes, and this patch fix it.
>>>>>>>
>>>>>>> Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
>>>>>>
>>>>>> The signed-off-by tag should agree with the From: header.  One way to
>>>>>> achieve
>>>>>> that is to add an extra From: line at the start of the changelog.
>>>>>>
>>>>>> That said, this looks like a good catch that should go into 4.6 to me.
>>>>>>
>>>>>> Peter, what do you think?
>>>>>
>>>>> I'm confused by the Changelog. *what* ?
>>>>
>>>> Sometimes .update_curr hook is called w/o tasks actually running, it is
>>>> captured by:
>>>>
>>>>           u64 delta_exec = rq_clock_task(rq) - curr->se.exec_start;
>>>>
>>>> We should not trigger cpufreq update in this case for rt/deadline
>>>> classes, and this patch fix it.
>>>
>>>
>>> That's what you wrote in the changelog, no need to repeat that.
>>>
>>> I guess Peter is asking for more details, though.  I actually would like
>>> to
>>> get some more details here too.  Like an example of when the situation in
>>> question actually happens.
>>
>> I add a print to print when delta_exec is zero for rt class, something
>> like below:
>>
>>        watchdog/5-48    [005] d...   568.449095: update_curr_rt: rt
>> delta_exec is zero
>>        watchdog/5-48    [005] d...   568.449104: <stack trace>
>>   => pick_next_task_rt
>>   => __schedule
>>   => schedule
>>   => smpboot_thread_fn
>>   => kthread
>>   => ret_from_fork
>>        watchdog/5-48    [005] d...   568.449105: update_curr_rt: rt
>> delta_exec is zero
>>        watchdog/5-48    [005] d...   568.449111: <stack trace>
>>   => put_prev_task_rt
>>   => pick_next_task_idle
>>   => __schedule
>>   => schedule
>>   => smpboot_thread_fn
>>   => kthread
>>   => ret_from_fork
>>        watchdog/6-56    [006] d...   568.510094: update_curr_rt: rt
>> delta_exec is zero
>>        watchdog/6-56    [006] d...   568.510103: <stack trace>
>>   => pick_next_task_rt
>>   => __schedule
>>   => schedule
>>   => smpboot_thread_fn
>>   => kthread
>>   => ret_from_fork
>>        watchdog/6-56    [006] d...   568.510105: update_curr_rt: rt
>> delta_exec is zero
>>        watchdog/6-56    [006] d...   568.510111: <stack trace>
>>   => put_prev_task_rt
>>   => pick_next_task_idle
>>   => __schedule
>>   => schedule
>>   => smpboot_thread_fn
>>   => kthread
>>   => ret_from_fork
>> [...]
>
>
> And the statement in your changelog follows from this I suppose. How does it
> follow, exactly?

For example, rt task A will go to sleep, an rt task B is the next
candidate to run.

__schedule()
    -> deactivate_task(A, DEQUEUE_SLEEP)
        -> dequeue_task_rt()
            -> update_curr_rt()
                -> cpufreq_trigger_update()
                -> delta_exec = rq_clock_task(rq) - curr->se.exec_start;
    [...]
    -> pick_next_task_rt()
        -> update_curr_rt()          =>   rq->curr is still A currently
            -> cpufreq_trigger_update()
            -> delta_exec = rq_clock_task(rq) - curr->se.exec_start;
  => delta == 0, actually A is not running between these two updates
    if (likely(prev != next)) {
        rq->curr = B;
       [...]
     }

Regards,
Wanpeng Li
