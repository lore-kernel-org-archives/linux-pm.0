From: Luca Abeni <luca.abeni@unitn.it>
Subject: Re: [RFCv6 PATCH 09/10] sched: deadline: use deadline bandwidth in
 scale_rt_capacity
Date: Mon, 14 Dec 2015 22:12:31 +0100
Message-ID: <20151214221231.39b5bc4e@luca-1225C>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
	<1449641971-20827-10-git-send-email-smuckle@linaro.org>
	<20151214151729.GQ6357@twins.programming.kicks-ass.net>
	<CAKfTPtAVmS6BHWcGz4cB0bpEE91QzU5sSmMWZB9j_vpK0qjwHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKfTPtAVmS6BHWcGz4cB0bpEE91QzU5sSmMWZB9j_vpK0qjwHg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 14 Dec 2015 16:56:17 +0100
Vincent Guittot <vincent.guittot@linaro.org> wrote:
[...]
> >> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> >> index 08858d1..e44c6be 100644
> >> --- a/kernel/sched/sched.h
> >> +++ b/kernel/sched/sched.h
> >> @@ -519,6 +519,8 @@ struct dl_rq {
> >>  #else
> >>       struct dl_bw dl_bw;
> >>  #endif
> >> +     /* This is the "average utilization" for this runqueue */
> >> +     s64 avg_bw;
> >>  };
> >
> > So I don't think this is right. AFAICT this projects the WCET as the
> > amount of time actually used by DL. This will, under many
> > circumstances, vastly overestimate the amount of time actually
> > spend on it. Therefore unduly pessimisme the fair capacity of this
> > CPU.
> 
> I agree that if the WCET is far from reality, we will underestimate
> available capacity for CFS. Have you got some use case in mind which
> overestimates the WCET ?
> If we can't rely on this parameters to evaluate the amount of capacity
> used by deadline scheduler on a core, this will imply that we can't
> also use it for requesting capacity to cpufreq and we should fallback
> on a monitoring mechanism which reacts to a change instead of
> anticipating it.
I think a more "theoretically sound" approach would be to track the
_active_ utilisation (informally speaking, the sum of the utilisations
of the tasks that are actually active on a core - the exact definition
of "active" is the trick here).
As done, for example, here:
https://github.com/lucabe72/linux-reclaiming/tree/track-utilisation-v2
(in particular, see
https://github.com/lucabe72/linux-reclaiming/commit/49fc786a1c453148625f064fa38ea538470df55b
)
I understand this approach might look too complex... But I think it is
much less pessimistic while still being "safe".
If there is something that I can do to make that code more acceptable,
let me know.


			Luca
