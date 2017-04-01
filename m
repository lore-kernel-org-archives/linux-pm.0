From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC v3 1/5] sched/core: add capacity constraints to CPU
 controller
Date: Sat, 1 Apr 2017 17:25:11 +0100
Message-ID: <20170401162511.GA14490@derkdell>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <1488292722-19410-2-git-send-email-patrick.bellasi@arm.com>
 <20170320171511.GB3623@htj.duckdns.org>
 <20170320180837.GB28391@e110439-lin>
 <CAPM31RJtWrvAk54gnjtDqpjmRf98D-aEqvcO39Qz7BiJWc457A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751736AbdDAQZT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 1 Apr 2017 12:25:19 -0400
Content-Disposition: inline
In-Reply-To: <CAPM31RJtWrvAk54gnjtDqpjmRf98D-aEqvcO39Qz7BiJWc457A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Turner <pjt@google.com>
Cc: Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

Hi Paul,

On 30-Mar 14:15, Paul Turner wrote:
> On Mon, Mar 20, 2017 at 11:08 AM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:
> > On 20-Mar 13:15, Tejun Heo wrote:
> >> Hello,
> >>
> >> On Tue, Feb 28, 2017 at 02:38:38PM +0000, Patrick Bellasi wrote:
> >> > This patch extends the CPU controller by adding a couple of new
> >> > attributes, capacity_min and capacity_max, which can be used to enforce
> >> > bandwidth boosting and capping. More specifically:
> >> >
> >> > - capacity_min: defines the minimum capacity which should be granted
> >> >                 (by schedutil) when a task in this group is running,
> >> >                 i.e. the task will run at least at that capacity
> >> >
> >> > - capacity_max: defines the maximum capacity which can be granted
> >> >                 (by schedutil) when a task in this group is running,
> >> >                 i.e. the task can run up to that capacity
> >>
> >> cpu.capacity.min and cpu.capacity.max are the more conventional names.
> >
> > Ok, should be an easy renaming.
> >
> >> I'm not sure about the name capacity as it doesn't encode what it does
> >> and is difficult to tell apart from cpu bandwidth limits.  I think
> >> it'd be better to represent what it controls more explicitly.
> >
> > In the scheduler jargon, capacity represents the amount of computation
> > that a CPU can provide and it's usually defined to be 1024 for the
> > biggest CPU (on non SMP systems) running at the highest OPP (i.e.
> > maximum frequency).
> >
> > It's true that it kind of overlaps with the concept of "bandwidth".
> > However, the main difference here is that "bandwidth" is not frequency
> > (and architecture) scaled.
> > Thus, for example, assuming we have only one CPU with these two OPPs:
> >
> >    OPP | Frequency | Capacity
> >      1 |    500MHz |      512
> >      2 |      1GHz |     1024
> 
> I think exposing capacity in this manner is extremely challenging.
> It's not normalized in any way between architectures, which places a
> lot of the ABI in the API.

Capacities of CPUs are already exposed, at least for ARM platforms, using
a platform independent definition which is documented here:

   http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/arm/cpus.txt#L245

As the notes in the documentation highlight, it's not a perfect
metrics but still it allows to distinguish between computational
capabilities of different (micro)architectures and/or OPPs.

Within the scheduler we use SCHED_CAPACITY_SCALE:
   http://lxr.free-electrons.com/ident?i=SCHED_CAPACITY_SCALE
for everything related to actual CPU computational capabilities.

That's why in the current implementation we expose the same metric to
define capacity constraints.

We considered also the idea to expose a more generic percentage value
[0..100], do you think that could be better?
Consider that at the end we will still have to scale 100% to 1024.

> Have you considered any schemes for normalizing this in a reasonable fashion?

For each specific target platform, capacities are already normalized
to 1024, which is the capacity of the most capable CPU running at the
highest OPP. Thus, 1024 always represents 100% of the available
computational capabilities of the most preforming system's CPU.

Perhaps I cannot completely get what what you mean when you say that
it should be "normalized between architectures".
Can you explain better, maybe with an example?

[...]

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
