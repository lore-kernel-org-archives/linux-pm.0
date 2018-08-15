From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v3 03/14] sched/core: uclamp: add CPU's clamp groups
 accounting
Date: Wed, 15 Aug 2018 11:54:28 +0100
Message-ID: <20180815105428.GA7388@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-4-patrick.bellasi@arm.com>
 <a24def9b-57bb-d072-5064-0421076d2e43@arm.com>
 <20180814164905.GG2605@e110439-lin>
 <7c45c1a8-24cb-6798-5b6f-3b5dfc9b490d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7c45c1a8-24cb-6798-5b6f-3b5dfc9b490d@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 15-Aug 11:37, Dietmar Eggemann wrote:
> On 08/14/2018 06:49 PM, Patrick Bellasi wrote:
> >Hi Dietmar!
> >
> >On 14-Aug 17:44, Dietmar Eggemann wrote:
> >>On 08/06/2018 06:39 PM, Patrick Bellasi wrote:
> 
> [...]
> 
> >>This one indicates that there are some holes in your ref-counting.
> >
> >Not really, this has been added not because I've detected a refcount
> >issue... but because it was suggested as a possible safety check in a
> >previous code review comment:
> >
> >    https://lore.kernel.org/lkml/20180720151156.GA31421@e110439-lin/
> >
> >>It's probably easier to debug that there is still a task but the
> >>uc_grp[group_id].tasks value == 0 (A). I assume the other problem exists as
> >>well, i.e. last task and uc_grp[group_id].tasks > 1 (B)?
> >>
> >>You have uclamp_cpu_[get/put](_id)() in [enqueue/dequeue]_task.
> >>
> >>Patch 04/14 introduces its use in uclamp_task_update_active().
> >>
> >>Do you know why (A) (and (B)) are happening?
> >
> >I've never saw that warning in my tests so far so, again, the warning
> >is there just to support testing/debugging when refcounting code
> >is/will be touched in the future. That's also the reason why is
> >SCHED_DEBUG protected.
> 
> Ah, OK, I thought you really see it more often and that it also relate to
> Pavan's comment on 02/14 about the missing treatment of exiting tasks.
> 
> If this is only for testing/debugging, I would suggest a simple one line
> BUG_ON()

These are (eventually) considered as recoverable errors... thus,
AFAIK, using BUG_ON is overkilling and discouraged:
  https://elixir.bootlin.com/linux/latest/source/include/asm-generic/bug.h#L42

> You find CONFIG_SCHED_DEBUG=y in production kernels as well.

AFAIK, that setting is discouraged for production kernels...
Moreover, it's still better to WARN sometimes on a production kernel
the crash the device, isnt't it?

-- 
#include <best/regards.h>

Patrick Bellasi
