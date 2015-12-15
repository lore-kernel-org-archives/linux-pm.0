From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFCv6 PATCH 09/10] sched: deadline: use deadline bandwidth in scale_rt_capacity
Date: Tue, 15 Dec 2015 05:59:31 +0100
Message-ID: <CAKfTPtDT----aVGF-3T90PZQQvsOJay_Y-js19W+NNZpvk7J_w@mail.gmail.com>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-10-git-send-email-smuckle@linaro.org> <20151214151729.GQ6357@twins.programming.kicks-ass.net>
 <CAKfTPtAVmS6BHWcGz4cB0bpEE91QzU5sSmMWZB9j_vpK0qjwHg@mail.gmail.com> <20151214221231.39b5bc4e@luca-1225C>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35658 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932909AbbLOE7w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2015 23:59:52 -0500
Received: by lfdl133 with SMTP id l133so135156359lfd.2
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2015 20:59:51 -0800 (PST)
In-Reply-To: <20151214221231.39b5bc4e@luca-1225C>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Luca Abeni <luca.abeni@unitn.it>
Cc: Peter Zijlstra <peterz@infradead.org>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On 14 December 2015 at 22:12, Luca Abeni <luca.abeni@unitn.it> wrote:
> On Mon, 14 Dec 2015 16:56:17 +0100
> Vincent Guittot <vincent.guittot@linaro.org> wrote:
> [...]
>> >> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> >> index 08858d1..e44c6be 100644
>> >> --- a/kernel/sched/sched.h
>> >> +++ b/kernel/sched/sched.h
>> >> @@ -519,6 +519,8 @@ struct dl_rq {
>> >>  #else
>> >>       struct dl_bw dl_bw;
>> >>  #endif
>> >> +     /* This is the "average utilization" for this runqueue */
>> >> +     s64 avg_bw;
>> >>  };
>> >
>> > So I don't think this is right. AFAICT this projects the WCET as the
>> > amount of time actually used by DL. This will, under many
>> > circumstances, vastly overestimate the amount of time actually
>> > spend on it. Therefore unduly pessimisme the fair capacity of this
>> > CPU.
>>
>> I agree that if the WCET is far from reality, we will underestimate
>> available capacity for CFS. Have you got some use case in mind which
>> overestimates the WCET ?
>> If we can't rely on this parameters to evaluate the amount of capacity
>> used by deadline scheduler on a core, this will imply that we can't
>> also use it for requesting capacity to cpufreq and we should fallback
>> on a monitoring mechanism which reacts to a change instead of
>> anticipating it.
> I think a more "theoretically sound" approach would be to track the
> _active_ utilisation (informally speaking, the sum of the utilisations
> of the tasks that are actually active on a core - the exact definition
> of "active" is the trick here).

The point is that we probably need 2 definitions of "active" tasks.
The 1st one would be used to scale the frequency. From a power saving
point of view, it have to reflect the minimum frequency needed at the
current time to handle all works without missing deadline. This one
should be updated quite often with the wake up and the sleep of tasks
as well as the throttling.
The 2nd definition is used to compute the remaining capacity for the
CFS scheduler. This one doesn't need to be updated at each wake/sleep
of a deadline task but should reflect the capacity used by deadline in
a larger time scale. The latter will be used by the CFS scheduler  at
the periodic load balance pace

> As done, for example, here:
> https://github.com/lucabe72/linux-reclaiming/tree/track-utilisation-v2
> (in particular, see
> https://github.com/lucabe72/linux-reclaiming/commit/49fc786a1c453148625f064fa38ea538470df55b
> )
> I understand this approach might look too complex... But I think it is
> much less pessimistic while still being "safe".
> If there is something that I can do to make that code more acceptable,
> let me know.
>
>
>                         Luca
