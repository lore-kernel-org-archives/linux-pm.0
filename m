From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] cpufreq/schedutil: Cleanup, document and fix iowait
 boost
Date: Wed, 11 Apr 2018 12:58:28 +0200
Message-ID: <20180411105828.GL4082@hirez.programming.kicks-ass.net>
References: <20180410155931.31973-1-patrick.bellasi@arm.com>
 <20180410193708.GE4043@hirez.programming.kicks-ass.net>
 <20180411104445.GM14248@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180411104445.GM14248@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 11, 2018 at 11:44:45AM +0100, Patrick Bellasi wrote:
> > > - sugov_set_iowait_boost: is now in charge only to set/increase the IO
> > >      wait boost, every time a task wakes up from an IO wait.
> > > 
> > > - sugov_iowait_boost: is now in charge to reset/reduce the IO wait
> > >      boost, every time a sugov update is triggered, as well as
> > >      to (eventually) enforce the currently required IO boost value.
> > 
> > I'm not sold on those function names; feels like we can do better,
> > although I'm struggling to come up with anything sensible just now.
> 
> What about something like:
> 
>  sugov_iowait_init()
>  since here we are mainly initializing the iowait boost
> 
>  sugov_iowait_boost()
>  since here we are mainly applying the proper boost to each cpu
> 
> Although they are not really so different...

How about:

  sugov_iowait_boost() -- does the actual impulse/boost
  sugov_iowait_apply() -- applies the boost state

?
