From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC v3 1/5] sched/core: add capacity constraints to CPU
 controller
Date: Thu, 23 Mar 2017 10:32:54 +0000
Message-ID: <20170323103254.GA11362@e110439-lin>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <1488292722-19410-2-git-send-email-patrick.bellasi@arm.com>
 <20170320171511.GB3623@htj.duckdns.org>
 <20170320180837.GB28391@e110439-lin>
 <CAEi0qNmQWxc+SWYPfbf7jzz3w4-k-uatUHT1r2m_68EOFAVp=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751660AbdCWKdD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Mar 2017 06:33:03 -0400
Content-Disposition: inline
In-Reply-To: <CAEi0qNmQWxc+SWYPfbf7jzz3w4-k-uatUHT1r2m_68EOFAVp=A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

On 22-Mar 17:28, Joel Fernandes (Google) wrote:
> Hi,
> 
> On Mon, Mar 20, 2017 at 11:08 AM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:
> > On 20-Mar 13:15, Tejun Heo wrote:
> >> Hello,
> >>
> >> On Tue, Feb 28, 2017 at 02:38:38PM +0000, Patrick Bellasi wrote:
> [..]
> >> > These attributes:
> >> > a) are tunable at all hierarchy levels, i.e. root group too
> >>
> >> This usually is problematic because there should be a non-cgroup way
> >> of configuring the feature in case cgroup isn't configured or used,
> >> and it becomes awkward to have two separate mechanisms configuring the
> >> same thing.  Maybe the feature is cgroup specific enough that it makes
> >> sense here but this needs more explanation / justification.
> >
> > In the previous proposal I used to expose global tunables under
> > procfs, e.g.:
> >
> >  /proc/sys/kernel/sched_capacity_min
> >  /proc/sys/kernel/sched_capacity_max
> >
> 
> But then we would lose out on being able to attach capacity
> constraints to specific tasks or groups of tasks?

Yes, right. If CGroups are not available than you cannot specify
per-task constraints. This is just a system-wide global tunable.

Question is: does this overall proposal makes sense outside the scope
of task groups classification? (more on that afterwards)

> > which can be used to defined tunable root constraints when CGroups are
> > not available, and becomes RO when CGroups are.
> >
> > Can this be eventually an acceptable option?
> >
> > In any case I think that this feature will be mainly targeting CGroup
> > based systems. Indeed, one of the main goals is to collect
> > "application specific" information from "informed run-times". Being
> > "application specific" means that we need a way to classify
> > applications depending on the runtime context... and that capability
> > in Linux is ultimately provided via the CGroup interface.
> 
> I think the concern raised is more about whether CGroups is the right
> interface to use for attaching capacity constraints to task or groups
> of tasks, or is there a better way to attach such constraints?

Notice that CGroups based classification allows to easily enforce
the concept of "delegation containment". I think this feature should
be nice to have whatever interface we choose.

However, potentially we can define a proper per-task API; are you
thinking to something specifically?

> I am actually looking at a workload where its desirable to attach such
> constraints to only 1 thread or task, in this case it would be a bit
> overkill to use CGroups to attach such property just for 1 task with
> specific constraints

Well, perhaps it depends on how and when CGroups are created.
If we think about using a proper "Organize Once and Control" model,
(i.e. every app gets its own CGroup at creation time and there it
lives, for the rest of its time, while the user-space run-time
eventually tunes the assigned resources) than run-time overheads
should not be a major concerns.

AFAIK, Cgroups main overheads are associated to tasks migration and
tuning. Tuning will not be an issue for the kind of actions required
by capacity clamping. Regarding migrations, they should be avoided as
much as possible when CGroups are in use.

> and it would be beneficial that along with the
> CGroup interface, there's also an interface to attach it to individual
> tasks.

IMO a dual interface to do the same things will be at least confusing
and also more complicated to maintain.

> The other advantage of such interface is we don't have to
> create a separate CGroup for every new constraint limit and can have
> several tasks with different unique constraints.

That's still possible using CGroups and IMO it will not be the "most
common case".
Don't you think that in general we will need to set constraints at
applications level, thus group of tasks?

As a general rule we should probably go for an interface which makes
easy the most common case.

> Regards,
> Joel

-- 
#include <best/regards.h>

Patrick Bellasi
