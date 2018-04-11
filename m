From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v2] cpufreq/schedutil: Cleanup, document and fix iowait
 boost
Date: Wed, 11 Apr 2018 15:39:21 +0100
Message-ID: <20180411143921.GP14248@e110439-lin>
References: <20180410155931.31973-1-patrick.bellasi@arm.com>
 <20180410193708.GE4043@hirez.programming.kicks-ass.net>
 <20180411104445.GM14248@e110439-lin>
 <20180411105828.GL4082@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180411105828.GL4082@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
List-Id: linux-pm@vger.kernel.org

On 11-Apr 12:58, Peter Zijlstra wrote:
> On Wed, Apr 11, 2018 at 11:44:45AM +0100, Patrick Bellasi wrote:
> > > > - sugov_set_iowait_boost: is now in charge only to set/increase the IO
> > > >      wait boost, every time a task wakes up from an IO wait.
> > > > 
> > > > - sugov_iowait_boost: is now in charge to reset/reduce the IO wait
> > > >      boost, every time a sugov update is triggered, as well as
> > > >      to (eventually) enforce the currently required IO boost value.
> > > 
> > > I'm not sold on those function names; feels like we can do better,
> > > although I'm struggling to come up with anything sensible just now.
> > 
> > What about something like:
> > 
> >  sugov_iowait_init()
> >  since here we are mainly initializing the iowait boost
> > 
> >  sugov_iowait_boost()
> >  since here we are mainly applying the proper boost to each cpu
> > 
> > Although they are not really so different...
> 
> How about:
> 
>   sugov_iowait_boost() -- does the actual impulse/boost
>   sugov_iowait_apply() -- applies the boost state
> 
> ?

Whould say it can work too, and it also allows to add a:

    sugov_iowait_reset() -- resets boots state after
                            TICK_NSEC CPU idle time

Viresh, Rafael, Joel: any preferences or other suggestions?

-- 
#include <best/regards.h>

Patrick Bellasi
