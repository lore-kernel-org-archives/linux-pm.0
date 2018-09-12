From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v4 02/16] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Date: Wed, 12 Sep 2018 18:52:02 +0100
Message-ID: <20180912175202.GK1413@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-3-patrick.bellasi@arm.com>
 <20180912134945.GZ24106@hirez.programming.kicks-ass.net>
 <20180912155619.GG1413@e110439-lin>
 <20180912161218.GW24082@hirez.programming.kicks-ass.net>
 <20180912173515.GH1413@e110439-lin>
 <20180912174236.GB24106@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180912174236.GB24106@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 12-Sep 19:42, Peter Zijlstra wrote:
> On Wed, Sep 12, 2018 at 06:35:15PM +0100, Patrick Bellasi wrote:
> > On 12-Sep 18:12, Peter Zijlstra wrote:
> 
> > > No idea; but if you want to go all fancy you can replace he whole
> > > uclamp_map thing with something like:
> > > 
> > > struct uclamp_map {
> > > 	union {
> > > 		struct {
> > > 			unsigned long v : 10;
> > > 			unsigned long c : BITS_PER_LONG - 10;
> > > 		};
> > > 		atomic_long_t s;
> > > 	};
> > > };
> > 
> > That sounds really cool and scary at the same time :)
> > 
> > The v:10 requires that we never set SCHED_CAPACITY_SCALE>1024
> > or that we use it to track a percentage value (i.e. [0..100]).
> 
> Or we pick 11 bits, it seems unlikely that capacity be larger than 2k.

Just remembered a past experience where we had unaligned access traps
on some machine because... don't you see any potentially issue on
using bitfleds like you suggest above ?

I'm thinking to:

   commit 317d359df95d ("sched/core: Force proper alignment of 'struct util_est'")

-- 
#include <best/regards.h>

Patrick Bellasi
