From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv7 PATCH 03/10] sched: scheduler-driven cpu frequency
 selection
Date: Thu, 3 Mar 2016 14:03:09 +0100
Message-ID: <20160303130309.GO6356@twins.programming.kicks-ass.net>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
 <1456190570-4475-4-git-send-email-smuckle@linaro.org>
 <8427745.Y8N2bqC3SO@vostro.rjw.lan>
 <56CF9D8F.7010607@linaro.org>
 <20160302074910.10178.35029@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160302074910.10178.35029@quark.deferred.io>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ricky Liang <jcliang@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 01, 2016 at 11:49:10PM -0800, Michael Turquette wrote:
> 
> In my over-simplified view of the scheduler, it would be great if we
> could have a backdoor mechanism to place the frequency transition
> kthread onto a runqueue from within the schedule() context and dispense
> with the irq_work stuff in Steve's series altogether.

This is actually very very hard :/

So while there is something similar for workqueues,
try_to_wake_up_local(), that will not work for the cpufreq stuff.

The main problem is that schedule() is done with rq->lock held, but
wakeups need p->pi_lock, but it so happens that rq->lock nests inside of
p->pi_lock.

Now, the workqueue stuff with try_to_wake_up_local() can get away with
dropping rq->lock, because of where it is called, way early in
schedule() before we really muck things up.

The cpufreq hook otoh is called all over the place.

The second problem is that doing a wakeup will in fact also end up
calling the cpufreq hook, so you're back in recursion hell.

The third problem is that cpufreq is called from wakeups, which would
want to do another wakeup (see point 2), but this also means we have to
nest p->pi_lock, and we can't really do that either.
