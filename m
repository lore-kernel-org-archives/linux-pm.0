From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC 1/3] sched/fair: add util_est on top of PELT
Date: Mon, 4 Sep 2017 12:13:40 +0100
Message-ID: <20170904111340.GC2618@e110439-lin>
References: <20170825102008.4626-1-patrick.bellasi@arm.com>
 <20170825102008.4626-2-patrick.bellasi@arm.com>
 <CAEU1=PnypZ7V5yL6K3fT_OpfTosK15ju0vcztk8NpDj9xVu4xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEU1=PnypZ7V5yL6K3fT_OpfTosK15ju0vcztk8NpDj9xVu4xw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@arm.com>, Tim Murray <timmurray@google.com>, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 29-Aug 10:06, Pavan Kondeti wrote:
> Hi Patrick,
> 
> On Fri, Aug 25, 2017 at 3:50 PM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:
> > The util_avg signal computed by PELT is too variable for some use-cases.
> > For example, a big task waking up after a long sleep period will have its
> > utilization almost completely decayed. This introduces some latency before
> > schedutil will be able to pick the best frequency to run a task.
> >
> > The same issue can affect task placement. Indeed, since the task
> > utilization is already decayed at wakeup, when the task is enqueued in a
> > CPU, this can results in a CPU running a big task as being temporarily
> > represented as being almost empty. This leads to a race condition where
> > other tasks can be potentially allocated on a CPU which just started to run
> > a big task which slept for a relatively long period.
> >
> > Moreover, the utilization of a task is, by PELT definition, a continuously
> > changing metrics. This contributes in making almost instantly outdated some
> > decisions based on the value of the PELT's utilization.
> >
> > For all these reasons, a more stable signal could probably do a better job
> > of representing the expected/estimated utilization of a SE/RQ. Such a
> > signal can be easily created on top of PELT by still using it as an
> > estimator which produces values to be aggregated once meaningful events
> > happens.
> >
> > This patch adds a simple implementation of util_est, a new signal built on
> > top of PELT's util_avg where:
> >
> >     util_est(se) = max(se::util_avg, f(se::util_avg@dequeue_times))
> >
> 
> I don't see any wrapper function in this patch that implements this
> signal. You want to use this signal in the task placement path as a
> replacement of task_util(), right?

You right, I should update this changelog which is a bit misleading.

What I'm writing above is the way we combine a task's estimated
utilization with its util_avg. That's what you find in the code of the
following patches, but strictly speacking we do not have a wrapper
function.

> Thanks,
> Pavan

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
