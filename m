From: Nathan Lynch <ntl@pobox.com>
Subject: Re: [patch 2/2] sched: fix nr_uninterruptible accounting
 of frozen tasks really
Date: Sat, 18 Jul 2009 18:59:55 -0500
Message-ID: <1247961595.5256.63.camel__24593.5423336507$1247961839$gmane$org@localhost.localdomain>
References: <20090717121545.489258927@linutronix.de>
	<20090717122103.225652146@linutronix.de>
	<1247833910.15751.61.camel@twins>
	<20090717152235.GA5878@count0.beaverton.ibm.com>
	<1247849254.6522.75.camel@laptop>
	<1247864134.17553.30.camel@localhost.localdomain>
	<1247921791.6597.5.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1247921791.6597.5.camel@laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, containers@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, stable@kernel.org, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sat, 2009-07-18 at 14:56 +0200, Peter Zijlstra wrote:
> On Fri, 2009-07-17 at 15:55 -0500, Nathan Lynch wrote:
> > On Fri, 2009-07-17 at 18:47 +0200, Peter Zijlstra wrote:
> > > On Fri, 2009-07-17 at 08:22 -0700, Matt Helsley wrote:
> > > 
> > > > The job scheduler in question does not use FROZEN as a transient state and
> > > > does not use checkpoint/restart at all since c/r is still a work in progress.
> > 
> > Right, the job scheduler uses the cgroup freezer as a mechanism to
> > preempt a low priority job for a higher priority job.  (It had used
> > SIGSTOP in the past.)  So in this scenario a frozen cgroup may remain in
> > that state for a while.  Load average is consulted as a measure of
> > system utilization.
> 
> I think that this is an utterly broken use for it, if you want something
> like that make a signal cgroup or something and deliver SIGSTOP to all
> of them.
> 
> In other words, why is the freezer any better than the SIGSTOP approach?

Documentation/cgroups/freezer-subsystem.txt happens to document this use
case and the disadvantages of SIGSTOP/SIGCONT.  Does that change your
opinion at all?


> > > > Even when used for power management it seems wrong to count frozen tasks
> > > > towards the loadavg since they aren't using CPU time or waiting for IO.
> > > 
> > > You're abusing it for _WHAT_?
> > 
> > I think Matt was referring to system-wide suspend/resume/hibernate, not
> > a behavior of the job scheduler, if that's your concern.
> 
> I understood he referred to the crazy use-case you mentioned above, IMHO
> frozen should be a temporary state used for things like
> snapshot/migrate.

But snapshot (or checkpoint) and migration aren't possible with mainline
at this time.  As far as I know, the use case to which you object is the
primary use of the cgroup freezer on production systems.
