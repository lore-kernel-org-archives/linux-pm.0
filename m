From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v3 07/14] sched/core: uclamp: enforce last task UCLAMP_MAX
Date: Thu, 16 Aug 2018 18:27:02 +0100
Message-ID: <20180816172702.GH2960@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-8-patrick.bellasi@arm.com>
 <2366fe11-db1f-4f39-df03-960535611319@arm.com>
 <20180816164745.GF2960@e110439-lin>
 <e99cef73-3bd8-9982-1d09-17de7ec8f76a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e99cef73-3bd8-9982-1d09-17de7ec8f76a@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 16-Aug 19:10, Dietmar Eggemann wrote:
> On 08/16/2018 06:47 PM, Patrick Bellasi wrote:
> >On 16-Aug 17:43, Dietmar Eggemann wrote:
> >>On 08/06/2018 06:39 PM, Patrick Bellasi wrote:
> >>>When a util_max clamped task sleeps, its clamp constraints are removed
> >>>from the CPU. However, the blocked utilization on that CPU can still be
> >>>higher than the max clamp value enforced while that task was running.
> >>>This max clamp removal when a CPU is going to be idle could thus allow
> >>>unwanted CPU frequency increases, right while the task is not running.
> >>
> >>So 'rq->uclamp.flags == UCLAMP_FLAG_IDLE' means CPU is IDLE because
> >>non-clamped tasks are tracked as well ((group_id = 0)).
> >
> >Right, but... with (group_id = 0) you mean that "non-clamped tasks are
> >tracked" in the first clamp group?
> 
> Yes. I was asking myself what will happen if there are only non-clamped
> tasks runnable ...

Non clamped tasks is kind-of ambiguous, since you can have:
a) tasks with util_max = UCLAMP_NOT_VALID (the default for all tasks)
b) tasks with util_max = SCHED_CAPACITY_SCALE as a task specific
    clamp value

They are both technically not clamped but, for case b there should not
be issue, since we will track SCHED_CAPACITY_SCALE as idle hold value.

For case a instead is a bit different, especially when they mix with
tasks with a valid task specific clamp value, as I've just commented
in this posting:

   Message-ID: <20180816172016.GG2960@e110439-lin>

> 
> >
> >>Maybe this is worth mentioning here?
> >
> >Maybe I can explicitely say that we detect that there are not RUNNABLE
> >tasks because all the clamp groups are in UCLAMP_NOT_VALID status.
> 
> Yes, would have helped me the grasp this earlier ...

Right, I'm going to add a bit of text on that.

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
