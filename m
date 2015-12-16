From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFCv6 PATCH 03/10] sched: scheduler-driven cpu frequency
 selection
Date: Tue, 15 Dec 2015 17:22:36 -0800
Message-ID: <5670BCDC.8060509@linaro.org>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-4-git-send-email-smuckle@linaro.org>
 <20151211110443.GA6645@e106622-lin> <566F74B3.4020203@linaro.org>
 <20151215103130.GF16007@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35350 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932784AbbLPBWj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 20:22:39 -0500
Received: by mail-pa0-f52.google.com with SMTP id hk6so14347346pad.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2015 17:22:39 -0800 (PST)
In-Reply-To: <20151215103130.GF16007@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <Juri.Lelli@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ricky Liang <jcliang@chromium.org>

On 12/15/2015 02:31 AM, Juri Lelli wrote:
>>>> +	do {
>>>> > >> +		set_current_state(TASK_INTERRUPTIBLE);
>>>> > >> +		new_request = gd->requested_freq;
>>>> > >> +		if (new_request == last_request) {
>>>> > >> +			schedule();
>>>> > >> +		} else {
>>> > > 
>>> > > Shouldn't we have to do the following here?
>>> > > 
>>> > > 
>>> > > @@ -125,9 +125,9 @@ static int cpufreq_sched_thread(void *data)
>>> > >  	}
>>> > >  
>>> > >  	do {
>>> > > -		set_current_state(TASK_INTERRUPTIBLE);
>>> > >  		new_request = gd->requested_freq;
>>> > >  		if (new_request == last_request) {
>>> > > +			set_current_state(TASK_INTERRUPTIBLE);
>>> > >  			schedule();
>>> > >  		} else {
>>> > >  			/*
>>> > > 
>>> > > Otherwise we set task to INTERRUPTIBLE state right after it has been
>>> > > woken up.
>> > 
>> > The state must be set to TASK_INTERRUPTIBLE before the data used to
>> > decide whether to sleep or not is read (gd->requested_freq in this case).
>> > 
>> > If it is set after, then once gd->requested_freq is read but before the
>> > state is set to TASK_INTERRUPTIBLE, the other side may update
>> > gd->requested_freq and issue a wakeup on the freq thread. The wakeup
>> > will have no effect since the freq thread would still be TASK_RUNNING at
>> > that time. The freq thread would proceed to go to sleep and the update
>> > would be lost.
>> > 
> Mmm, I suggested that because I was hitting this while testing:
> 
> [   34.816158] ------------[ cut here ]------------
> [   34.816177] WARNING: CPU: 2 PID: 1712 at kernel/kernel/sched/core.c:7617 __might_sleep+0x90/0xa8()
> [   34.816188] do not call blocking ops when !TASK_RUNNING; state=1 set at [<c007c1f8>] cpufreq_sched_thread+0x80/0x2b0
> [   34.816198] Modules linked in:
> [   34.816207] CPU: 2 PID: 1712 Comm: kschedfreq:1 Not tainted 4.4.0-rc2+ #401
> [   34.816212] Hardware name: ARM-Versatile Express
> [   34.816229] [<c0018874>] (unwind_backtrace) from [<c0013f60>] (show_stack+0x20/0x24)
> [   34.816243] [<c0013f60>] (show_stack) from [<c0448c98>] (dump_stack+0x80/0xb4)
> [   34.816257] [<c0448c98>] (dump_stack) from [<c0029930>] (warn_slowpath_common+0x88/0xc0)
> [   34.816267] [<c0029930>] (warn_slowpath_common) from [<c0029a24>] (warn_slowpath_fmt+0x40/0x48)
> [   34.816278] [<c0029a24>] (warn_slowpath_fmt) from [<c0054764>] (__might_sleep+0x90/0xa8)
> [   34.816291] [<c0054764>] (__might_sleep) from [<c0578400>] (cpufreq_freq_transition_begin+0x6c/0x13c)
> [   34.816303] [<c0578400>] (cpufreq_freq_transition_begin) from [<c0578714>] (__cpufreq_driver_target+0x180/0x2c0)
> [   34.816314] [<c0578714>] (__cpufreq_driver_target) from [<c007c14c>] (cpufreq_sched_try_driver_target+0x48/0x74)
> [   34.816324] [<c007c14c>] (cpufreq_sched_try_driver_target) from [<c007c1e8>] (cpufreq_sched_thread+0x70/0x2b0)
> [   34.816336] [<c007c1e8>] (cpufreq_sched_thread) from [<c004ce30>] (kthread+0xf4/0x114)
> [   34.816347] [<c004ce30>] (kthread) from [<c000fdd0>] (ret_from_fork+0x14/0x24)
> [   34.816355] ---[ end trace 30e92db342678467 ]---
> 
> Maybe we could cope with what you are saying with an atomic flag
> indicating that the kthread is currently servicing a request? Like
> extending the finish_last_request thing to cover this case as well.

Ah. I should be able to just set_current_state(TASK_RUNNING) at the top
of the else clause. Will include this change next time.

thanks,
Steve

