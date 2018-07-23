From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v2 08/12] sched/core: uclamp: extend cpu's cgroup
 controller
Date: Mon, 23 Jul 2018 16:17:24 +0100
Message-ID: <20180723151724.GE2683@e110439-lin>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-9-patrick.bellasi@arm.com>
 <CAJuCfpE4FbtrwbXNCjj=pXAvTiTLw7z1aLS4+-28X=y4V+SJ-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJuCfpE4FbtrwbXNCjj=pXAvTiTLw7z1aLS4+-28X=y4V+SJ-Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

On 20-Jul 19:37, Suren Baghdasaryan wrote:
> On Mon, Jul 16, 2018 at 1:29 AM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:

[...]

> > +#ifdef CONFIG_UCLAMP_TASK_GROUP
> > +static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
> > +                                 struct cftype *cftype, u64 min_value)
> > +{
> > +       struct task_group *tg;
> > +       int ret = -EINVAL;
> > +
> > +       if (min_value > SCHED_CAPACITY_SCALE)
> > +               return -ERANGE;
> > +
> > +       mutex_lock(&uclamp_mutex);
> > +       rcu_read_lock();
> > +
> > +       tg = css_tg(css);
> > +       if (tg->uclamp[UCLAMP_MIN].value == min_value) {
> > +               ret = 0;
> > +               goto out;
> > +       }
> > +       if (tg->uclamp[UCLAMP_MAX].value < min_value)
> > +               goto out;
> > +
> 
> + tg->uclamp[UCLAMP_MIN].value = min_value;
> + ret = 0;
> 
> Are these assignments missing or am I missing something? Same for
> cpu_util_max_write_u64().

They are introduced in the following patch, to keep this one focus
just on CGroups integration.

I'm also returning -EINVAL at this stage since, with just this patch
in, we are not really providing any good service to user-space, i.e.
it's like clamp groups not being available...

Maybe I can call this out better in the change log ;)

> > +out:
> > +       rcu_read_unlock();
> > +       mutex_unlock(&uclamp_mutex);
> > +
> > +       return ret;
> > +}

[...]

-- 
#include <best/regards.h>

Patrick Bellasi
