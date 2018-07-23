From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v2 02/12] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Date: Mon, 23 Jul 2018 14:36:15 +0100
Message-ID: <20180723133615.GB2683@e110439-lin>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-3-patrick.bellasi@arm.com>
 <CAJuCfpF6=L=0LrmNnJrTNPazT4dWKqNv+thhN0dwpKCgUzs9sg@mail.gmail.com>
 <20180720151156.GA31421@e110439-lin>
 <CAJuCfpGvpX5U9rED+vX=wW624GLZo8f=-2kOLGrY1UJSEXRh6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJuCfpGvpX5U9rED+vX=wW624GLZo8f=-2kOLGrY1UJSEXRh6g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

On 20-Jul 17:25, Suren Baghdasaryan wrote:

[...]

> > ---8<---
> >
> > /* Uclamp flags */
> > #define SCHED_FLAG_UTIL_CLAMP_STRICT    0x11 /* Roll-back on failure */
> > #define SCHED_FLAG_UTIL_CLAMP_MIN       0x12 /* Update util_min */
> > #define SCHED_FLAG_UTIL_CLAMP_MAX       0x14 /* Update util_max */
> > #define SCHED_FLAG_UTIL_CLAMP           ( \
> >                 SCHED_FLAG_UTIL_CLAMP_MIN | SCHED_FLAG_UTIL_CLAMP_MAX)
> >
> 
> Having ability to update only min or only max this way might be indeed
> very useful.
> Instead of rolling back on failure I would suggest to check both
> inputs first to make sure there won't be any error before updating.
> This would remove the need for SCHED_FLAG_UTIL_CLAMP_STRICT (which I
> think any user would want to set to 1 anyway).
> Looks like uclamp_group_get() can fail only if uclamp_group_find()
> fails to find a slot for uclamp_value or a free slot. So one way to do
> this search before update is to call uclamp_group_find() for both
> UCLAMP_MIN and UCLAMP_MAX beforehand and if they succeed then pass
> obtained next_group_ids into uclamp_group_get() to avoid doing the
> same search twice. This requires some refactoring of
> uclamp_group_get() but I think the end result would be a cleaner and
> more predictable solution.

Yes, that sound possible... provided we check all the groups under the
same uclamp_mutex, it should be possible to find the group_ids before
actually increasing the refcount.

... will look into this for the next reposting.

-- 
#include <best/regards.h>

Patrick Bellasi
