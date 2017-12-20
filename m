From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH 2/4] sched: cpufreq: Keep track of cpufreq utilization
 update flags
Date: Wed, 20 Dec 2017 15:01:16 +0000
Message-ID: <20171220150116.GL19821@e110439-lin>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
 <20171220132826.kcu5zqkva5h6nmfk@hirez.programming.kicks-ass.net>
 <20171220143100.GJ19821@e110439-lin>
 <2145782.LdFHderQvS@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755542AbdLTPBV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Dec 2017 10:01:21 -0500
Content-Disposition: inline
In-Reply-To: <2145782.LdFHderQvS@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, juri.lelli@redhat.com, tkjos@android.com, joelaf@google.com, linux-kernel@vger.kernel.org

On 20-Dec 15:52, Rafael J. Wysocki wrote:
> On Wednesday, December 20, 2017 3:31:00 PM CET Patrick Bellasi wrote:
> > On 20-Dec 14:28, Peter Zijlstra wrote:
> > > On Wed, Dec 20, 2017 at 12:55:46PM +0000, Patrick Bellasi wrote:
> > > > On 20-Dec 09:31, Peter Zijlstra wrote:
> > > 
> > > > > Didn't juri have patches to make DL do something sane? But yes, I think
> > > > > those flags are part of the problem.
> > > > 
> > > > He recently reposted them here:
> > > > 
> > > >   https://lkml.kernel.org/r/20171204102325.5110-1-juri.lelli@redhat.com
> > > 
> > > Yeah, just found them and actually munged them into my queue; did all
> > > the modifications you suggested too. Lets see if it comes apart.
> > > 
> > > > > > - From the utilization handler, we check runqueues of all three sched
> > > > > >   classes to see if they have some work pending (this can be done
> > > > > >   smartly by checking only RT first and skipping other checks if RT
> > > > > >   has some work).
> > > > > 
> > > > > No that's wrong. DL should provide a minimum required based on existing
> > > > > reservations, we can add the expected CFS average on top and request
> > > > > that.
> > > > > 
> > > > > And for RT all we need to know is if current is of that class, otherwise
> > > > > we don't care.
> > > > 
> > > > So, this:
> > > > 
> > > >    https://marc.info/?i=20171130114723.29210-3-patrick.bellasi%40arm.com
> > > 
> > > Right, I was actually looking for those patches, but I'm searching
> > > backwards and hit upon Juri's patches first.
> > > 
> > > > was actually going in this direction, although still working on top of
> > > > flags to not change the existing interface too much.
> > > > 
> > > > IMO, the advantage of flags is that they are a sort-of "pro-active"
> > > > approach, where the scheduler notify sensible events to schedutil.
> > > > But keep adding flags seems to overkilling to me too.
> > > > 
> > > > If we remove flags then we have to query the scheduler classes "on
> > > > demand"... but, as Peter suggests, once we have DL bits Juri posted,
> > > > the only issue if to know if an RT task is running.
> > > > This the patch above can be just good enough, with no flags at all and
> > > > with just a check for current being RT (or DL for the time being).
> > > 
> > > Well, we still need flags for crap like IO-WAIT IIRC. That's sugov
> > > internal state and not something the scheduler actually already knows.
> > 
> > Right, that flag is set from:
> > 
> >     core.c::io_schedule_prepare()
> > 
> > for the current task, which is going to be dequeued soon.
> > 
> > Once it wakes up the next time, at enqueue time we trigger a boosting
> > by passing schedutil that flag.
> > 
> > Thus, unless we are happy to delay the boosting until the task is
> > actually picked for execution (don't think so), then we need to keep
> > the flag and signal schedutil at enqueue time.
> > 
> > However, was wondering one thing: should't we already have a vruntime
> > bonus for IO sleeping tasks? Because in that case, the task is likely
> > to be on CPU quite soon... and thus, perhaps by removing the flag and
> > moving the schedutil notification into core.c at the end of
> > __schedule() should be working to detect both RT and FAIR::IOWAIT
> > boosted tasks.
> 
> schedutil is not the only user of this flag.

Sure, but with the idea above (not completely sure it makes sense)
intel_pstate_update_util() can still get the IIOWAIT information.

We just get that info from current->in_iowait instead of checking a
flag which is passed in via callback.

> Thanks,
> Rafael
> 

-- 
#include <best/regards.h>

Patrick Bellasi
