From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v4 08/16] sched/core: uclamp: propagate parent clamps
Date: Wed, 12 Sep 2018 13:51:33 +0100
Message-ID: <20180912125133.GE1413@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-9-patrick.bellasi@arm.com>
 <CAJuCfpHaqNzgpbPCAUxsv+E4HL6vSDKem+sFh2njK1e9dX5ONA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJuCfpHaqNzgpbPCAUxsv+E4HL6vSDKem+sFh2njK1e9dX5ONA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suren Baghdasaryan <surenb@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

On 08-Sep 20:02, Suren Baghdasaryan wrote:
> On Tue, Aug 28, 2018 at 6:53 AM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:

[...]

> > +  cpu.util.min.effective
> > +        A read-only single value file which exists on non-root cgroups and
> > +        reports minimum utilization clamp value currently enforced on a task
> > +        group.
> > +
> > +        The actual minimum utilization in the range [0, 1023].
> > +
> > +        This value can be lower then cpu.util.min in case a parent cgroup
> > +        is enforcing a more restrictive clamping on minimum utilization.
> 
> IMHO if cpu.util.min=0 means "no restrictions" on UCLAMP_MIN then
> calling parent's lower cpu.util.min value "more restrictive clamping"
> is confusing. I would suggest to rephrase this to smth like "...in
> case a parent cgroup requires lower cpu.util.min clamping."

Right, it's slightly confusing... still I would like to call out that
a parent group can enforce something on its children. What about:

   "... a parent cgroup allows only smaller minimum utilization values."

Is that less confusing ?

Otherwise I think your proposal could work too.

[...]

> >  #ifdef CONFIG_UCLAMP_TASK_GROUP
> > +/**
> > + * cpu_util_update_hier: propagete effective clamp down the hierarchy
> 
> typo: propagate

+1

[...]

> > +                * Skip the whole subtrees if the current effective clamp is
> > +                * alredy matching the TG's clamp value.
> 
> typo: already

+1


Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
