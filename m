From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update
 callbacks
Date: Thu, 11 Feb 2016 09:06:04 -0800
Message-ID: <56BCBF7C.2080404@linaro.org>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan> <56B93548.9090006@linaro.org>
 <CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
 <5387313.xAhVpzgZCg@vostro.rjw.lan> <56BA8C29.4090905@linaro.org>
 <20160211115959.GI6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36351 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbcBKRGH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2016 12:06:07 -0500
Received: by mail-pa0-f43.google.com with SMTP id yy13so31599001pab.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Feb 2016 09:06:06 -0800 (PST)
In-Reply-To: <20160211115959.GI6357@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Thomas Gleixner <tglx@linutronix.de>

Hi Peter,

On 02/11/2016 03:59 AM, Peter Zijlstra wrote:
>> I think additional hooks such as enqueue/dequeue would be needed in
>> > RT/DL. The task tick callbacks will only run if a task in that class is
>> > executing at the time of the tick. There could be intermittent RT/DL
>> > task activity in a frequency domain (the only task activity there, no
>> > CFS tasks) that doesn't happen to overlap the tick. Worst case the task
>> > activity could be periodic in such a way that it never overlaps the tick
>> > and the update is never made.
>
> No, for RT (RR/FIFO) we do not have enough information to do anything
> useful. Basically RR/FIFO should result in running 100% whenever we
> schedule such a task.
> 
> That means RR/FIFO want a hook in pick_next_task_rt() to bump the freq
> to 100% and leave it there until something else gets to run.
>
> For DL it basically wants to set a minimum freq based on reserved
> utilization, so that is __setparam_dl() or somewhere around there.
> 
> And we should either use CPPC hints for min freq or manually ensure that
> the CFS callback will not select something less than this.

Rafael's changes aren't specifying particular frequencies/capacities in
the scheduler hooks. They're just pokes to get cpufreq to run, in order
to eliminate cpufreq's timers.

My concern above is that pokes are guaranteed to keep occurring when
there is only RT or DL activity so nothing breaks.

thanks,
Steve
