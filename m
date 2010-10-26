From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 14:14:21 -0400
Message-ID: <20101026181421.GA30090__28677.7963083752$1288116973$gmane$org@Krystal>
References: <1287488171-25303-3-git-send-email-trenn@suse.de>
	<1288049630-10947-1-git-send-email-trenn@suse.de>
	<20101026071020.GC13036@elte.hu>
	<AANLkTikWCLTgAGJJ_eH0e016kPfB2K8LtR9g25wbPJXF@mail.gmail.com>
	<4CC6FC03.708@linux.intel.com>
	<AANLkTinrmhBkjnXE+xQGgrsv_OR_ckz=dyH4EoDB59X_@mail.gmail.com>
	<1288115894.3673.12.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1288115894.3673.12.camel@laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <greg@kroah.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pierre Tardy <tardyp@gmail.com>, Arjan van de Ven <arjan@linux.intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

* Peter Zijlstra (peterz@infradead.org) wrote:
> On Tue, 2010-10-26 at 11:56 -0500, Pierre Tardy wrote:
> > 
> > +       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
> >         atomic_inc(&dev->power.usage_count); 
> 
> That's terribly racy..

Looking at the original code, it looks racy even without considering the
tracepoint:

int __pm_runtime_get(struct device *dev, bool sync)
 {
        int retval;

+       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
        atomic_inc(&dev->power.usage_count);
        retval = sync ? pm_runtime_resume(dev) : pm_request_resume(dev);

There is no implied memory barrier after "atomic_inc". So either all these
inc/dec are protected with mutexes or spinlocks, in which case one might wonder
why atomic operations are used at all, or it's a racy mess. (I vote for the
second option)

kref should certainly be used there.

About the instrumentation, well... the only way to have something that's not
racy would be to instrument kref directly, and use atomic_add_return() in both
the get/put paths. But I fear that the performance impact on many architectures
might be significant (turning atomic_add + smp_mb() into a cmpxchg()). Maybe it
could be acceptable as a kernel debug option.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
