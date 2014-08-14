From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH] cpuidle: Fix the CPU stuck at C0 for 2-3s after PM_QOS
 back to DEFAULT
Date: Thu, 14 Aug 2014 14:12:27 -0700
Message-ID: <53ED263B.7030703@mit.edu>
References: <1407982309-4863-1-git-send-email-chuansheng.liu@intel.com> <CAKnoXLw3DrBAxCUWEkXtvCTf+E1w0xTHJSiSUY6Qd6xHXeGaoQ@mail.gmail.com> <20140814110040.GI16043@twins.programming.kicks-ass.net> <53EC9A29.8090408@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:46361 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbaHNVMb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Aug 2014 17:12:31 -0400
Received: by mail-pd0-f174.google.com with SMTP id fp1so2235731pdb.33
        for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2014 14:12:31 -0700 (PDT)
In-Reply-To: <53EC9A29.8090408@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Chuansheng Liu <chuansheng.liu@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, changcheng.liu@intel.com, xiaoming.wang@intel.com, souvik.k.chakravarty@intel.com

On 08/14/2014 04:14 AM, Daniel Lezcano wrote:
> On 08/14/2014 01:00 PM, Peter Zijlstra wrote:
>>
>> So seeing how you're from @intel.com I'm assuming you're using x86 here.
>>
>> I'm not seeing how this can be possible, MWAIT is interrupted by IPIs
>> just fine, which means we'll fall out of the cpuidle_enter(), which
>> means we'll cpuidle_reflect(), and then leave cpuidle_idle_call().
>>
>> It will indeed not leave the cpu_idle_loop() function and go right back
>> into cpuidle_idle_call(), but that will then call cpuidle_select() which
>> should pick a new C state.
>>
>> So the interrupt _should_ work. If it doesn't you need to explain why.
> 
> I think the issue is related to the poll_idle state, in
> drivers/cpuidle/driver.c. This state is x86 specific and inserted in the
> cpuidle table as the state 0 (POLL). There is no mwait for this state.
> It is a bit confusing because this state is not listed in the acpi /
> intel idle driver but inserted implicitly at the beginning of the idle
> table by the cpuidle framework when the driver is registered.
> 
> static int poll_idle(struct cpuidle_device *dev,
>                 struct cpuidle_driver *drv, int index)
> {
>         local_irq_enable();
>         if (!current_set_polling_and_test()) {
>                 while (!need_resched())
>                         cpu_relax();
>         }
>         current_clr_polling();
> 
>         return index;
> }

As the most recent person to have modified this function, and as an
avowed hater of pointless IPIs, let me ask a rather different question:
why are you sending IPIs at all?  As of Linux 3.16, poll_idle actually
supports the polling idle interface :)

Can't you just do:

if (set_nr_if_polling(rq->idle)) {
	trace_sched_wake_idle_without_ipi(cpu);
} else {
	spin_lock_irqsave(&rq->lock, flags);
	if (rq->curr == rq->idle)
		smp_send_reschedule(cpu);
	// else the CPU wasn't idle; nothing to do
	raw_spin_unlock_irqrestore(&rq->lock, flags);
}

In the common case (wake from C0, i.e. polling idle), this will skip the
IPI entirely unless you race with idle entry/exit, saving a few more
precious electrons and all of the latency involved in poking the APIC
registers.

--Andy

P.S. "30mV" in the patch description is presumably a typo.
