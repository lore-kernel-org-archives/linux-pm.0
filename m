From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v2 00/12] Add utilization clamping support
Date: Tue, 17 Jul 2018 14:41:48 +0100
Message-ID: <20180717134148.GH32302@e110439-lin>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180717130357.GA17824@joelaf.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180717130357.GA17824@joelaf.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 17-Jul 06:03, Joel Fernandes wrote:
> On Mon, Jul 16, 2018 at 09:28:54AM +0100, Patrick Bellasi wrote:
> >  Documentation/admin-guide/cgroup-v2.rst |  25 +
> >  include/linux/sched.h                   |  53 ++
> >  include/uapi/linux/sched.h              |   4 +-
> >  include/uapi/linux/sched/types.h        |  66 +-
> >  init/Kconfig                            |  63 ++
> >  kernel/sched/core.c                     | 876 ++++++++++++++++++++++++
> 
> While I'm reviewing these patches, I had a quick thought. core.c is already
> 7k+ lines. Based on this diffstat, does it make sense for uclamp to be in its
> own kernel/sched/uclamp.c file?

Good point.

I've added it to core.c because it's logically part of the core
scheduler and we have some calls which are part of the fast path and
thus we want to avoid function calls.

I guess that, provided we can rely on LTOs, we can try to move it into
a separate file. Let see what Ingo and Peter thing about this.

> thanks,
> 
> - Joel

-- 
#include <best/regards.h>

Patrick Bellasi
