From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v4 14/16] sched/core: uclamp: request CAP_SYS_ADMIN by
 default
Date: Wed, 26 Sep 2018 18:51:07 +0100
Message-ID: <20180926175106.GA22286@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-15-patrick.bellasi@arm.com>
 <20180904134748.GA4974@localhost.localdomain>
 <20180906144053.GD25636@e110439-lin>
 <20180914111003.GC24082@hirez.programming.kicks-ass.net>
 <20180914140732.GR1413@e110439-lin>
 <20180914142813.GM24124@hirez.programming.kicks-ass.net>
 <20180917122723.GS1413@e110439-lin>
 <20180921091308.GD24082@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180921091308.GD24082@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

Hi Peter,

On 21-Sep 11:13, Peter Zijlstra wrote:
> On Mon, Sep 17, 2018 at 01:27:23PM +0100, Patrick Bellasi wrote:

[...]

While going back to one of our previous conversation, I noted these
comments:

> > Thus, the capacity of little CPUs, or the exact capacity of an OPP, is
> > something we don't care to specify exactly, since:

[...]

> >  - certain platforms don't even expose OPPs, but just "performance
> >    levels"... which ultimately are a "percentage"
> 
> Well, the whole capacity thing is a 'percentage', it's just that 1024 is
> much nicer to work with (for computers) than 100 is (also it provides a
> wee bit more resolution).

Here above I was referring to the Intel's HWP support [1],
specifically at the:

  Ability of HWP to allow software to set an energy/performance
  preference hint in the IA32_HWP_REQUEST MSR.

which is detailed in section "14.4.4 Managing HWP".

The {Minimum,Maximum}_Performance registers represent what I consider
the best semantics for UtilClamp.

In the HWP case we use 256 range values, and thus for UtilClamp as
well it would make more sense to use a 1024 scale as suggested by
Peter, even just to have a bit more room, while still considering the
clamp values _as a percentage_, with just one decimal digit of
resolution

I think the important bit here is the abstraction between what we
the user can require and what the platform can provided.

If HWP does not allow the OS to pinpoint a specific frequency, why
should a user-space interface be designed to pinpoint a specific
capacity ?

Can we find here a common ground around the idea that UtilClamp values
represent a 1024 range percentage of minimum/maximum performance
expected by a task ?

Would be really nice to know what Rafael thing about all that...

Cheers Patrick

[1] https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-vol-3b-part-2-manual.pdf

-- 
#include <best/regards.h>

Patrick Bellasi
