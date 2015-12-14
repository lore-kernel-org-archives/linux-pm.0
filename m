From: Luca Abeni <luca.abeni@unitn.it>
Subject: Re: [RFCv6 PATCH 09/10] sched: deadline: use deadline bandwidth in
 scale_rt_capacity
Date: Mon, 14 Dec 2015 22:19:11 +0100
Message-ID: <20151214221911.56cd38db@luca-1225C>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
	<1449641971-20827-10-git-send-email-smuckle@linaro.org>
	<20151214151729.GQ6357@twins.programming.kicks-ass.net>
	<CAKfTPtAVmS6BHWcGz4cB0bpEE91QzU5sSmMWZB9j_vpK0qjwHg@mail.gmail.com>
	<20151214160759.GD16007@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151214160759.GD16007@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <Juri.Lelli@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 14 Dec 2015 16:07:59 +0000
Juri Lelli <Juri.Lelli@arm.com> wrote:
[...]
> > I agree that if the WCET is far from reality, we will underestimate
> > available capacity for CFS. Have you got some use case in mind which
> > overestimates the WCET ?
> 
> I guess simply the fact that one task can be admitted to the system,
> but then in practice sleep, waiting from some event to happen.
My favourite example (since 1998 :) is a video player (but every task
processing compressed video should work as an example): there is a
noticeable difference between the time needed to process large I frames
with a lot of movement (that is about the WCET) and the time needed to
process small B frames with not much movement. And if we want to avoid
too much jitter in the video playback we have to allocate the runtime
based on the maximum time needed to process a video frame.


> > If we can't rely on this parameters to evaluate the amount of
> > capacity used by deadline scheduler on a core, this will imply that
> > we can't also use it for requesting capacity to cpufreq and we
> > should fallback on a monitoring mechanism which reacts to a change
> > instead of anticipating it.
> > 
> 
> There is at least one way in the middle: use utilization of active
> servers (as I think Luca was already mentioning). This solution should
> remove some of the pessimism, but still be safe for our needs.
If you track the active utilisation as done by the GRUB algorithm
( http://retis.sssup.it/~lipari/papers/lipariBaruah2000.pdf ) and by my
patches, you can remove _all_ the pessimism :)


			Luca
