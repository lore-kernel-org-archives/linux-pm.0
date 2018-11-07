From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v5 03/15] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Date: Wed, 7 Nov 2018 14:19:49 +0000
Message-ID: <20181107141949.GF14309@e110439-lin>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-4-patrick.bellasi@arm.com>
 <20181107121908.GO9781@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181107121908.GO9781@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 07-Nov 13:19, Peter Zijlstra wrote:
> On Mon, Oct 29, 2018 at 06:32:57PM +0000, Patrick Bellasi wrote:
> > +struct uclamp_se {
> > +	unsigned int value		: SCHED_CAPACITY_SHIFT + 1;
> > +	unsigned int group_id		: order_base_2(UCLAMP_GROUPS);
> 
> Are you sure about ob2() ? seems weird we'll end up with 0 for
> UCLAMP_GROUPS==1.

So, we have:

   #define UCLAMP_GROUPS (CONFIG_UCLAMP_GROUPS_COUNT + 1)

because one clamp group is always reserved for defaults.
Thus, ob2(in) is always called with n>=2.

... should be safe no ?

However, will check better again on v6 for possible corner-cases...

> > +	unsigned int mapped		: 1;
> > +};

-- 
#include <best/regards.h>

Patrick Bellasi
