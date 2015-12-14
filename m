From: Luca Abeni <luca.abeni@unitn.it>
Subject: Re: [RFCv6 PATCH 09/10] sched: deadline: use deadline bandwidth in
 scale_rt_capacity
Date: Mon, 14 Dec 2015 22:31:13 +0100
Message-ID: <20151214223113.5732201a@luca-1225C>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
	<1449641971-20827-10-git-send-email-smuckle@linaro.org>
	<20151214151729.GQ6357@twins.programming.kicks-ass.net>
	<CAKfTPtAVmS6BHWcGz4cB0bpEE91QzU5sSmMWZB9j_vpK0qjwHg@mail.gmail.com>
	<20151214165128.GU6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151214165128.GU6357@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 14 Dec 2015 17:51:28 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Dec 14, 2015 at 04:56:17PM +0100, Vincent Guittot wrote:
> > I agree that if the WCET is far from reality, we will underestimate
> > available capacity for CFS. Have you got some use case in mind which
> > overestimates the WCET ?
> 
> Pretty much any 'correct' WCET is pessimistic. There's heaps of smart
> people working on improving WCET bounds, but they're still out there.
> This is mostly because of the .00001% tail cases that 'never' happen
> but would make your tokamak burn a hole just when you're outside.
As I mentioned in a previous email, you do not even need to consider
these extreme cases... If a task has a highly variable execution time
(I always mention video players and compressed video processing, but
collegues working on computer vision told me that some video tracking
algorithms have similar characteristics) you might want to allocate the
runtime based on the maximum execution time (or a time near to the
maximum)... But the task will consume less than that a lot of times.


> > If we can't rely on this parameters to evaluate the amount of
> > capacity used by deadline scheduler on a core, this will imply that
> > we can't also use it for requesting capacity to cpufreq and we
> > should fallback on a monitoring mechanism which reacts to a change
> > instead of anticipating it.
> 
> No, since the WCET can and _will_ happen, its the best you can do with
> cpufreq. If you were to set it lower you could not be able to execute
> correctly in your 'never' tail cases.
> 
> There 'might' be smart pants ways around this, where you run part of
> the execution at lower speed and switch to a higher speed to 'catch'
> up if you exceed some boundary, such that, on average, you run at the
> same speed the WCET mandates, but I'm not sure that's worth it.
> Juri/Luca might know.
Some previous works (see for example
https://www.researchgate.net/profile/Giuseppe_Lipari/publication/220800940_Using_resource_reservation_techniques_for_power-aware_scheduling/links/09e41513639b2703fc000000.pdf
) investigated the usage of the "active utilisation" for switching the
CPU frequency. This "active utilisation tracking" mechanism is the same
I mentioned in the previous email, and implemented here:
https://github.com/lucabe72/linux-reclaiming/commit/49fc786a1c453148625f064fa38ea538470df55b .

I suspect the "inactive timer" I used to decrease the utilisation at
the so called 0-lag time might be problematic, but I did not find any
way to implement (or approximate) the active utilisation tracking
without this timer... Anyway, if there is interest I am willing to
adapt/rework/modify my patches as needed.


				Luca
