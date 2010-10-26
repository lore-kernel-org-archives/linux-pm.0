From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 17:38:17 -0400
Message-ID: <20101026213817.GB21495__32409.6801611178$1288129402$gmane$org@Krystal>
References: <1287488171-25303-3-git-send-email-trenn@suse.de>
	<1288115894.3673.12.camel@laptop> <20101026181421.GA30090@Krystal>
	<201010262104.21851.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201010262104.21851.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pierre Tardy <tardyp@gmail.com>, Peter Zijlstra <peterz@infradead.org>, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, Frederic Weisbecker <fweisbec@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Frank Eigler <fche@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

* Rafael J. Wysocki (rjw@sisk.pl) wrote:
> On Tuesday, October 26, 2010, Mathieu Desnoyers wrote:
> > * Peter Zijlstra (peterz@infradead.org) wrote:
> > > On Tue, 2010-10-26 at 11:56 -0500, Pierre Tardy wrote:
> > > > 
> > > > +       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
> > > >         atomic_inc(&dev->power.usage_count); 
> > > 
> > > That's terribly racy..
> > 
> > Looking at the original code, it looks racy even without considering the
> > tracepoint:
> > 
> > int __pm_runtime_get(struct device *dev, bool sync)
> >  {
> >         int retval;
> > 
> > +       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
> >         atomic_inc(&dev->power.usage_count);
> >         retval = sync ? pm_runtime_resume(dev) : pm_request_resume(dev);
> > 
> > There is no implied memory barrier after "atomic_inc". So either all these
> > inc/dec are protected with mutexes or spinlocks, in which case one might wonder
> > why atomic operations are used at all, or it's a racy mess. (I vote for the
> > second option)
> 
> No, it isn't.
> 
> > kref should certainly be used there.
> 
> No, it shouldn't.
> 
> Please try to understand the code you're commenting on first.

Please see my reply to Alan Stern:

http://www.spinics.net/lists/linux-omap/msg39382.html

Thanks,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
