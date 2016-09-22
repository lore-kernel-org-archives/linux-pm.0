From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v4 10/10] cpufreq: intel_pstate: Use CPPC to get max
 performance
Date: Thu, 22 Sep 2016 14:41:14 -0700
Message-ID: <1474580474.3916.238.camel@linux.intel.com>
References: <1474485552-141429-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <1474485552-141429-11-git-send-email-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0h3=JLw8mH=x4jXNec9CGZWiCt+pPmrD1L4=QutT8=g0Q@mail.gmail.com>
         <1474570233.3916.197.camel@linux.intel.com>
         <CAJZ5v0g5FhQWcNZdnfruxTZYPdKaCqinLnpwvuM1KiwASMdGBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0g5FhQWcNZdnfruxTZYPdKaCqinLnpwvuM1KiwASMdGBA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, jolsa@redhat.com
List-Id: linux-pm@vger.kernel.org

On Thu, 2016-09-22 at 22:58 +0200, Rafael J. Wysocki wrote:
> 
> > > so what if there are two CPU packages
> > > and there are highest_perf differences in both, and we first enumerate
> > > the first package entirely before getting to the second one?
> > > 
> > > In that case we'll schedule the work item after enumerating the first
> > > package and it may rebuild the sched domains before all priorities are
> > > set for the second package, may it not?
> > That is not a problem.  For the second package, all the cpu priorities
> > are initialized to the same value.  So even if we start to do
> > asym_packing in the scheduler for the whole system,
> > on the second package, all the cpus are treated equally by the scheduler.
> > We will operate as if there is no favored core till we update the
> > priorities of the cpu on the second package.
> OK
> 
> But updating those priorities after we have set the "ITMT capable"
> flag is not a problem?  Nobody is going to be confused and so on?
> 

Not a problem.  The worst thing that could happen is we schedule a job
to a cpu with a lesser max turbo freq first while the priorities update are in
progress.

> > 
> > That said, we don't enable ITMT automatically for 2 package system.
> > So the explicit sysctl command to enable ITMT and cause the sched domain
> > rebuild for 2 package system is most likely to come after
> > we have discovered and set all the cpu priorities.
> Right, but if that behavior is relied on, there should be a comment
> about that in the code (and relying on it would be kind of fragile for
> that matter).

No, we don't rely on this behavior of not enabling ITMT automatically
for 2 package system.  We could enable ITMT for 2
package system by default if we want to.  Then asym_packing will just
consider the second package's cpus to be equal priorities if they haven't
been set.  

> 
> > 
> > > 
> > > 
> > > This seems to require some more consideration.
> > > 
> > > > 
> > > > 
> > > > +               /*
> > > > +                * Since this function is in the hotcpu notifier callback
> > > > +                * path, submit a task to workqueue to call
> > > > +                * sched_set_itmt_support().
> > > > +                */
> > > > +               schedule_work(&sched_itmt_work);
> > > It doesn't make sense to do this more than once IMO and what if we
> > > attempt to schedule the work item again when it has been scheduled
> > > once already?  Don't we need any protection here?
> > It is not a problem for sched_set_itmt_support to be called more than
> > once.
> While it is not incorrect, it also is not particularly useful to
> schedule a work item just to find out later that it had nothing to do
> to begin with.

Setting ITMT capability is done per socket during system boot.  So there is no
performance impact at all so it should not be an issue.

Tim
