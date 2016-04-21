From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] sched/cpufreq: don't trigger cpufreq update w/o real
 rt/deadline tasks running
Date: Thu, 21 Apr 2016 13:11:50 +0200
Message-ID: <5718B576.1020306@intel.com>
References: <1460958684-32105-1-git-send-email-wanpeng.li@hotmail.com>
 <6087716.bi8vDPiZNy@vostro.rjw.lan>
 <20160420140117.GZ3448@twins.programming.kicks-ass.net>
 <CANRm+CzGm5axJC_y=rqhmi=DLkfpXfo2NLzFyRyjeZE89Aty4Q@mail.gmail.com>
 <57180293.1040809@intel.com>
 <CANRm+CwW_STS21Fu0iKs5gVps9OF8GFKB4ksqLqT=33O-hoOWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANRm+CwW_STS21Fu0iKs5gVps9OF8GFKB4ksqLqT=33O-hoOWg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wanpeng Li <kernellwp@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wanpeng Li <wanpeng.li@hotmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 4/21/2016 3:09 AM, Wanpeng Li wrote:
> 2016-04-21 6:28 GMT+08:00 Rafael J. Wysocki <rafael.j.wysocki@intel.com>:
>> On 4/21/2016 12:24 AM, Wanpeng Li wrote:
>>> 2016-04-20 22:01 GMT+08:00 Peter Zijlstra <peterz@infradead.org>:
>>>> On Wed, Apr 20, 2016 at 02:32:35AM +0200, Rafael J. Wysocki wrote:
>>>>> On Monday, April 18, 2016 01:51:24 PM Wanpeng Li wrote:
>>>>>> Sometimes update_curr() is called w/o tasks actually running, it is
>>>>>> captured by:
>>>>>>       u64 delta_exec = rq_clock_task(rq) - curr->se.exec_start;
>>>>>> We should not trigger cpufreq update in this case for rt/deadline
>>>>>> classes, and this patch fix it.
>>>>>>
>>>>>> Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
>>>>> The signed-off-by tag should agree with the From: header.  One way to
>>>>> achieve
>>>>> that is to add an extra From: line at the start of the changelog.
>>>>>
>>>>> That said, this looks like a good catch that should go into 4.6 to me.
>>>>>
>>>>> Peter, what do you think?
>>>> I'm confused by the Changelog. *what* ?
>>> Sometimes .update_curr hook is called w/o tasks actually running, it is
>>> captured by:
>>>
>>>           u64 delta_exec = rq_clock_task(rq) - curr->se.exec_start;
>>>
>>> We should not trigger cpufreq update in this case for rt/deadline
>>> classes, and this patch fix it.
>>
>> That's what you wrote in the changelog, no need to repeat that.
>>
>> I guess Peter is asking for more details, though.  I actually would like to
>> get some more details here too.  Like an example of when the situation in
>> question actually happens.
> I add a print to print when delta_exec is zero for rt class, something
> like below:
>
>        watchdog/5-48    [005] d...   568.449095: update_curr_rt: rt
> delta_exec is zero
>        watchdog/5-48    [005] d...   568.449104: <stack trace>
>   => pick_next_task_rt
>   => __schedule
>   => schedule
>   => smpboot_thread_fn
>   => kthread
>   => ret_from_fork
>        watchdog/5-48    [005] d...   568.449105: update_curr_rt: rt
> delta_exec is zero
>        watchdog/5-48    [005] d...   568.449111: <stack trace>
>   => put_prev_task_rt
>   => pick_next_task_idle
>   => __schedule
>   => schedule
>   => smpboot_thread_fn
>   => kthread
>   => ret_from_fork
>        watchdog/6-56    [006] d...   568.510094: update_curr_rt: rt
> delta_exec is zero
>        watchdog/6-56    [006] d...   568.510103: <stack trace>
>   => pick_next_task_rt
>   => __schedule
>   => schedule
>   => smpboot_thread_fn
>   => kthread
>   => ret_from_fork
>        watchdog/6-56    [006] d...   568.510105: update_curr_rt: rt
> delta_exec is zero
>        watchdog/6-56    [006] d...   568.510111: <stack trace>
>   => put_prev_task_rt
>   => pick_next_task_idle
>   => __schedule
>   => schedule
>   => smpboot_thread_fn
>   => kthread
>   => ret_from_fork
> [...]

And the statement in your changelog follows from this I suppose. How 
does it follow, exactly?

Thanks,
Rafael
