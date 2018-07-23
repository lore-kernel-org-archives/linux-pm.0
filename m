From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v2 07/12] sched/core: uclamp: enforce last task UCLAMP_MAX
Date: Mon, 23 Jul 2018 16:02:49 +0100
Message-ID: <20180723150249.GD2683@e110439-lin>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-8-patrick.bellasi@arm.com>
 <CAJuCfpH6CsDVG35Z3NV87mUgJW9TmoCuOs8GeW2TEqkP0K0f9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJuCfpH6CsDVG35Z3NV87mUgJW9TmoCuOs8GeW2TEqkP0K0f9g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

On 20-Jul 18:23, Suren Baghdasaryan wrote:
> Hi Patrick,

Hi Sure,
thank!

> On Mon, Jul 16, 2018 at 1:29 AM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:

[...]

> > @@ -977,13 +991,21 @@ static inline void uclamp_cpu_get_id(struct task_struct *p,
> >         uc_grp = &rq->uclamp.group[clamp_id][0];
> >         uc_grp[group_id].tasks += 1;
> >
> > +       /* Force clamp update on idle exit */
> > +       uc_cpu = &rq->uclamp;
> > +       clamp_value = p->uclamp[clamp_id].value;
> > +       if (unlikely(uc_cpu->flags & UCLAMP_FLAG_IDLE)) {
> 
> The condition below is not needed because UCLAMP_FLAG_IDLE is set only
> for UCLAMP_MAX clamp_id, therefore the above condition already covers
> the one below.

Not really, this function is called two times, the first time to
update UCLAMP_MIN and a second time to update UCLAMP_MAX.

For both clamp_id we want to force update uc_cpu->value[clamp_id],
thus the UCLAMP_FLAG_IDLE flag has to be cleared only the second time.

Maybe I can had the following comment to better explain the reason of
the check:

		/*
		 * This function is called for both UCLAMP_MIN (before) and
		 * UCLAMP_MAX (after). Let's reset the flag only the when
		 * we know that UCLAMP_MIN has been already updated.
		 */

> > +               if (clamp_id == UCLAMP_MAX)
> > +                       uc_cpu->flags &= ~UCLAMP_FLAG_IDLE;
> > +               uc_cpu->value[clamp_id] = clamp_value;
> > +               return;
> > +       }

[...]

-- 
#include <best/regards.h>

Patrick Bellasi
