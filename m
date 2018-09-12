From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v4 02/16] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Date: Wed, 12 Sep 2018 11:32:01 +0100
Message-ID: <20180912103201.GD1413@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-3-patrick.bellasi@arm.com>
 <CAJuCfpF36-VZm0JVVNnOnGm-ukVejzxbPhH33X3z9gAQ06t9gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJuCfpF36-VZm0JVVNnOnGm-ukVejzxbPhH33X3z9gAQ06t9gQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suren Baghdasaryan <surenb@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

Hi Suren,

On 08-Sep 16:47, Suren Baghdasaryan wrote:

[...]

> > + * A clamp group is not free if there is at least one SE which is sing a clamp
> 
> typo in the sentence

Right, s/is sing/is using/

+1

[...]

> > +static int
> > +uclamp_group_find(int clamp_id, unsigned int clamp_value)
> > +{
> > +       struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
> > +       int free_group_id = UCLAMP_NOT_VALID;
> > +       unsigned int group_id = 0;
> > +
> > +       for ( ; group_id <= CONFIG_UCLAMP_GROUPS_COUNT; ++group_id) {
> > +               /* Keep track of first free clamp group */
> > +               if (uclamp_group_available(clamp_id, group_id)) {
> > +                       if (free_group_id == UCLAMP_NOT_VALID)
> > +                               free_group_id = group_id;
> > +                       continue;
> > +               }
> 
> Not a big improvement but reordering the two conditions in this loop
> would avoid finding and recording free_group_id if the very first
> group is the one we are looking for.

Right, indeed with:

   uclamp_group_put()
       uclamp_group_reset()
           uclamp_group_init()

we always ensure that:

   uc_map[group_id].value == UCLAMP_NOT_VALID

for free groups. Thus, it should be safe to swap this two checks and
we likely save few instructions for a likely common case of non
clamped tasks.

+1

I'll also get the chance to remove the two simple comments. ;)

> > +               /* Return index of first group with same clamp value */
> > +               if (uc_map[group_id].value == clamp_value)
> > +                       return group_id;
> > +       }
> > +
> > +       if (likely(free_group_id != UCLAMP_NOT_VALID))
> > +               return free_group_id;
> > +
> > +       return -ENOSPC;
> > +}

[...]

> > +static inline void uclamp_group_put(int clamp_id, int group_id)

> Is the size and the number of invocations of this function small
> enough for inlining? Same goes for uclamp_group_get() and especially
> for __setscheduler_uclamp().

Right... yes, we could let the scheduler do its job and remove inline
from these functions... at least for those not in the critical path.

+1

[...]

> > +       if (likely(uc_map[group_id].se_count))
> > +               uc_map[group_id].se_count -= 1;
> > +#ifdef SCHED_DEBUG
> > +       else {
> 
> nit: no need for braces
> 
> > +               WARN(1, "invalid SE clamp group [%d:%d] refcount\n",
> > +                    clamp_id, group_id);

Since the above statement is multi-line, we actually need it for code
code-style requirements.

> > +       }
> > +#endif

[...]

> > +static void uclamp_fork(struct task_struct *p, bool reset)
> > +{
> > +       int clamp_id;
> > +
> > +       if (unlikely(!p->sched_class->uclamp_enabled))
> > +               return;
> > +
> > +       for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> > +               int next_group_id = p->uclamp[clamp_id].group_id;
> > +               struct uclamp_se *uc_se = &p->uclamp[clamp_id];
> 
> Might be easier to read if after the above assignment you use
> uc_se->xxx instead of p->uclamp[clamp_id].xxx in the code below.

Yes, that's actually the intent of the above assigmenet... but I've
forgot a couple of usages! +1

> > +
> > +               if (unlikely(reset)) {
> > +                       next_group_id = 0;
> > +                       p->uclamp[clamp_id].value = uclamp_none(clamp_id);
> > +               }
> > +
> > +               p->uclamp[clamp_id].group_id = UCLAMP_NOT_VALID;
> > +               uclamp_group_get(clamp_id, next_group_id, uc_se,
> > +                                p->uclamp[clamp_id].value);
> > +       }
> > +}

[...]

> Thanks,
> Suren.

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
