From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] sched/cpufreq: don't trigger cpufreq update w/o real
 rt/deadline tasks running
Date: Thu, 21 Apr 2016 19:07:51 +0200
Message-ID: <CAJZ5v0j1krY6HO34QKY-NzJoc5jdS8C+qDQvDmWEZeOxE=5SQg@mail.gmail.com>
References: <1460958684-32105-1-git-send-email-wanpeng.li@hotmail.com>
	<6087716.bi8vDPiZNy@vostro.rjw.lan>
	<20160420140117.GZ3448@twins.programming.kicks-ass.net>
	<CANRm+CzGm5axJC_y=rqhmi=DLkfpXfo2NLzFyRyjeZE89Aty4Q@mail.gmail.com>
	<57180293.1040809@intel.com>
	<CANRm+CwW_STS21Fu0iKs5gVps9OF8GFKB4ksqLqT=33O-hoOWg@mail.gmail.com>
	<20160421123341.GJ3408@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34085 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbcDURHx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 13:07:53 -0400
In-Reply-To: <20160421123341.GJ3408@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <kernellwp@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wanpeng Li <wanpeng.li@hotmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>

On Thu, Apr 21, 2016 at 2:33 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Apr 21, 2016 at 09:09:43AM +0800, Wanpeng Li wrote:
>> >> Sometimes .update_curr hook is called w/o tasks actually running, it is
>> >> captured by:
>> >>
>> >>          u64 delta_exec = rq_clock_task(rq) - curr->se.exec_start;
>> >>
>> >> We should not trigger cpufreq update in this case for rt/deadline
>> >> classes, and this patch fix it.
>
>> I add a print to print when delta_exec is zero for rt class, something
>
> So its zero, so what?
>
>> like below:
>
>>       watchdog/5-48    [005] d...   568.449105: update_curr_rt: rt
>> delta_exec is zero
>>       watchdog/5-48    [005] d...   568.449111: <stack trace>
>>  => put_prev_task_rt
>>  => pick_next_task_idle
>
> So we'll go idle, but as of this point we're still running the rt task.

Skipping the update in that case might be the right thing to do, though.

It doesn't matter in 4.6-rc, because the current governors don't use
util/max anyway, so they just get an extra call they can use to
evaluate things.

However, it matters for schedutil, because it will (over)react to the
special util/max combination then.  So this looks like a change to
make in 4.7.
