From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v2 10/12] sched/core: uclamp: use TG's clamps to restrict
 Task's clamps
Date: Tue, 24 Jul 2018 10:56:18 +0100
Message-ID: <20180724095550.GA3162@e110439-lin>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-11-patrick.bellasi@arm.com>
 <CAJuCfpFnj2g3+ZpR4fP4yqfxs0zd=c-Zehr2XM7m_C+WdL9jNA@mail.gmail.com>
 <20180723154025.GF2683@e110439-lin>
 <CAJuCfpHJ=O1QVFZZ2dpaDDQe+dX1aGkzWdcd76c9zZpxw2fNtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJuCfpHJ=O1QVFZZ2dpaDDQe+dX1aGkzWdcd76c9zZpxw2fNtA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

On 23-Jul 10:11, Suren Baghdasaryan wrote:
> On Mon, Jul 23, 2018 at 8:40 AM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:
> > On 21-Jul 20:05, Suren Baghdasaryan wrote:
> >> On Mon, Jul 16, 2018 at 1:29 AM, Patrick Bellasi

[...]

> >> So to satisfy both TG and syscall requirements I think you would
> >> need to choose the largest value for UCLAMP_MIN and the smallest one
> >> for UCLAMP_MAX, meaning the most boosted and most clamped range.
> >> Current implementation choses the least boosted value, so
> >> effectively one of the UCLAMP_MIN requirements (either from TG or
> >> from syscall) are being ignored...  Could you please clarify why
> >> this choice is made?
> >
> > The TG values are always used to specify a _restriction_ on
> > task-specific values.
> >
> > Thus, if you look or example at the CPU mask for a task, you can have
> > a task with affinity to CPUs 0-1, currently running on a cgroup with
> > cpuset.cpus=0... then the task can run only on CPU 0 (althought its
> > affinity includes CPU1 too).
> >
> > Same we do here: if a task has util_min=10, but it's running in a
> > cgroup with cpu.util_min=0, then it will not be boosted.
> >
> > IOW, this allows to implement a "nice" policy at task level, where a
> > task (via syscall) can decide to be less boosted with respect to its
> > group but never more boosted. The same task can also decide to be more
> > clamped, but not less clamped then its current group.
> >
> 
> The fact that boost means "at least this much" to me seems like we can
> safely choose higher CPU bandwidth (as long as it's lower than
> UCLAMP_MAX)

I understand your view point, which actually is matching my first
implementation for util_min aggregation:

   https://lore.kernel.org/lkml/20180409165615.2326-5-patrick.bellasi@arm.com/


> but from your description sounds like TG's UCLAMP_MIN means "at most
> this much boost" and it's not safe to use CPU bandwidth higher than
> TG's UCLAMP_MIN.

Indeed, after this discussion with Tejun:

   https://lore.kernel.org/lkml/20180409222417.GK3126663@devbig577.frc2.facebook.com/

I've convinced myself that for the cgroup interface we have to got for
a "restrictive" interface where a parent value must set the upper
bound for all its descendants values. AFAIU, that's one of the basic
principles of the "delegation model" implemented by cgroups and the
common behavior implemented by all controllers.

> So instead of specifying min CPU bandwidth for a task it specifies
> the max allowed boost. Seems like a discrepancy to me but maybe
> there are compelling usecases when this behavior is necessary?

I don't think it's strictly related to use-cases, you can always
describe a give use-case in one model or the other.  It all depends on
how you configure your hierarchy and where you place your tasks.

For our Android use cases, we are still happy to say that all tasks of
a CGroup can be boosted up to a certain value and then we can either:
- don't configure tasks: and thus get the CG defined boost
- configure a task: and explicitly give back what we don't need

This model works quite well with containers, where the parent want to
precisely control how much resources are (eventually) usable by a
given container.

> In that case would be good to spell them out to explain why this
> choice is made.

Yes, well... if I understand it correctly is really just the
recommended way cgroups must be used to re-partition resources.

I'll try to better explain this behavior in the changelog for this
patch.

[...]

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
