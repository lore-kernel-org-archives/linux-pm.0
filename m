From: Luca Abeni <luca.abeni@unitn.it>
Subject: Re: [RFCv6 PATCH 09/10] sched: deadline: use deadline bandwidth in
 scale_rt_capacity
Date: Tue, 15 Dec 2015 14:30:07 +0100
Message-ID: <567015DF.6090206@unitn.it>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-10-git-send-email-smuckle@linaro.org>
 <20151214151729.GQ6357@twins.programming.kicks-ass.net>
 <CAKfTPtAVmS6BHWcGz4cB0bpEE91QzU5sSmMWZB9j_vpK0qjwHg@mail.gmail.com>
 <20151214165128.GU6357@twins.programming.kicks-ass.net>
 <20151214223113.5732201a@luca-1225C>
 <20151215123859.GC6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37062 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933190AbbLONaL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 08:30:11 -0500
Received: by mail-wm0-f47.google.com with SMTP id n186so25817693wmn.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2015 05:30:10 -0800 (PST)
In-Reply-To: <20151215123859.GC6357@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On 12/15/2015 01:38 PM, Peter Zijlstra wrote:
> On Mon, Dec 14, 2015 at 10:31:13PM +0100, Luca Abeni wrote:
>
>>> There 'might' be smart pants ways around this, where you run part of
>>> the execution at lower speed and switch to a higher speed to 'catch'
>>> up if you exceed some boundary, such that, on average, you run at the
>>> same speed the WCET mandates, but I'm not sure that's worth it.
>>> Juri/Luca might know.
>
>> Some previous works (see for example
>> https://www.researchgate.net/profile/Giuseppe_Lipari/publication/220800940_Using_resource_reservation_techniques_for_power-aware_scheduling/links/09e41513639b2703fc000000.pdf
>> ) investigated the usage of the "active utilisation" for switching the
>> CPU frequency. This "active utilisation tracking" mechanism is the same
>> I mentioned in the previous email, and implemented here:
>> https://github.com/lucabe72/linux-reclaiming/commit/49fc786a1c453148625f064fa38ea538470df55b .
>
> I have stuck the various PDFs and commits you've linked into my todo
> list ;-) Thanks!
You are welcome :)


>> I suspect the "inactive timer" I used to decrease the utilisation at
>> the so called 0-lag time might be problematic, but I did not find any
>> way to implement (or approximate) the active utilisation tracking
>> without this timer... Anyway, if there is interest I am willing to
>> adapt/rework/modify my patches as needed.
>
> So I remember something else from the BFQ code, which also had to track
> entries for the 0-lag stuff, and I just had a quick peek at that code
> again. And what they appear to do is keep inactive entries with a lag
> deficit in a separate tree (the idle tree).
>
> And every time they update the vtime, they also push fwd the idle tree
> and expire entries on that.
I am not sure if I understand correctly the idea (I do not know the BFQ
code; I'll have a look), but I think I tried something similar:
- When a task blocks, instead of arming the inactive timer I can insert
   the task in an "active non contending" tree (to use GRUB terminology)
- So, when some sched deadline function is invoked, I check the "0-lag
   time" of the first task in the "active non contending" tree, and if
   that time is passed I remove the task from the tree and adjust the
   active utilisation

The resulting code ended up being more complex (basically, I needed to
handle the "active non contending" tree and to check it in task_tick_dl()
and update_curr_dl()). But maybe I did it wrong... I'll try this approach
again, after looking ad the BFQ code.


			Thanks,
				Luca
>
> Or that is what I can make of it in a quick few minutes staring at that
> code -- look for bfq_forget_idle().
>

