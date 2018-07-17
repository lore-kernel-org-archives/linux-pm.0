From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 00/12] Add utilization clamping support
Date: Tue, 17 Jul 2018 06:03:57 -0700
Message-ID: <20180717130357.GA17824@joelaf.mtv.corp.google.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180716082906.6061-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 16, 2018 at 09:28:54AM +0100, Patrick Bellasi wrote:
> This is a respin of:
> 
>    https://lore.kernel.org/lkml/20180409165615.2326-1-patrick.bellasi@arm.com
> 
> which addresses all the feedbacks collected from the LKML discussion as well
> as during the presentation at last OSPM Summit:
> 
>    https://www.youtube.com/watch?v=0Yv9smm9i78
> 
> Further comments and feedbacks are more than welcome!
> 
[...] 
> 
> Patrick Bellasi (12):
>   sched/core: uclamp: extend sched_setattr to support utilization
>     clamping
>   sched/core: uclamp: map TASK's clamp values into CPU's clamp groups
>   sched/core: uclamp: add CPU's clamp groups accounting
>   sched/core: uclamp: update CPU's refcount on clamp changes
>   sched/cpufreq: uclamp: add utilization clamping for FAIR tasks
>   sched/cpufreq: uclamp: add utilization clamping for RT tasks
>   sched/core: uclamp: enforce last task UCLAMP_MAX
>   sched/core: uclamp: extend cpu's cgroup controller
>   sched/core: uclamp: map TG's clamp values into CPU's clamp groups
>   sched/core: uclamp: use TG's clamps to restrict Task's clamps
>   sched/core: uclamp: update CPU's refcount on TG's clamp changes
>   sched/core: uclamp: use percentage clamp values
> 
>  Documentation/admin-guide/cgroup-v2.rst |  25 +
>  include/linux/sched.h                   |  53 ++
>  include/uapi/linux/sched.h              |   4 +-
>  include/uapi/linux/sched/types.h        |  66 +-
>  init/Kconfig                            |  63 ++
>  kernel/sched/core.c                     | 876 ++++++++++++++++++++++++

While I'm reviewing these patches, I had a quick thought. core.c is already
7k+ lines. Based on this diffstat, does it make sense for uclamp to be in its
own kernel/sched/uclamp.c file?

thanks,

- Joel
 
