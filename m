From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v4 07/16] sched/core: uclamp: extend cpu's cgroup
 controller
Date: Wed, 29 Aug 2018 09:53:58 +0100
Message-ID: <20180829085358.GO2960@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-8-patrick.bellasi@arm.com>
 <ad7a1f15-d1ad-84f2-6b4d-cbfc4560a7a4@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ad7a1f15-d1ad-84f2-6b4d-cbfc4560a7a4@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 28-Aug 11:29, Randy Dunlap wrote:
> On 08/28/2018 06:53 AM, Patrick Bellasi wrote:
> > +config UCLAMP_TASK_GROUP
> > +	bool "Utilization clamping per group of tasks"
> > +	depends on CGROUP_SCHED
> > +	depends on UCLAMP_TASK
> > +	default n
> > +	help
> > +	  This feature enables the scheduler to track the clamped utilization
> > +	  of each CPU based on RUNNABLE tasks currently scheduled on that CPU.
> > +
> > +	  When this option is enabled, the user can specify a min and max
> > +	  CPU bandwidth which is allowed for each single task in a group.
> > +	  The max bandwidth allows to clamp the maximum frequency a task
> > +	  can use, while the min bandwidth allows to define a minimum
> > +	  frequency a task will always use.
> > +
> > +	  When task group based utilization clamping is enabled, an eventually
> > +          specified task-specific clamp value is constrained by the cgroup
> > +	  specified clamp value. Both minimum and maximum task clamping cannot
> > +          be bigger than the corresponding clamping defined at task group level.
> 
> The 4 lines above should all be indented the same (one tab + 2 spaces).

Right... then there's definitively something broken with my vim
reformat shortcut, which sometimes uses spaces instead of tabs :(

Unfortunately this pattern is not covered by checkpatch, which
returns not errors/warnings on this patch.

> > +
> > +	  If in doubt, say N.
> > +

Anyway, thanks for spotting it... easy fix for the next respin.

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
