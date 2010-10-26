From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 17:33:56 -0400
Message-ID: <20101026213356.GA21495__43027.9144006365$1288128894$gmane$org@Krystal>
References: <20101026181421.GA30090@Krystal>
	<Pine.LNX.4.44L0.1010261447090.1634-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1010261447090.1634-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Pierre Tardy <tardyp@gmail.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Frederic Weisbecker <fweisbec@gmail.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

* Alan Stern (stern@rowland.harvard.edu) wrote:
> On Tue, 26 Oct 2010, Mathieu Desnoyers wrote:
> 
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
> I don't understand.  What's the problem?  The inc/dec are atomic 
> because they are not protected by spinlocks, but everything else is 
> (aside from the tracepoint, which is new).
> 
> > kref should certainly be used there.
> 
> What for?

kref has the following "get":

        atomic_inc(&kref->refcount);
        smp_mb__after_atomic_inc();

What seems to be missing in __pm_runtime_get() and pm_runtime_get_noresume() is
the memory barrier after the atomic increment. The atomic increment is free to
be reordered into the following spinlock (within pm_request_resume or pm_request
resume execution) because taking a spinlock only acts as a memory barrier with
acquire semantic, not a full memory barrier.

So AFAIU, the failure scenario would be as follows (sorry for the 80+ columns):

initial conditions: usage_count = 1

CPU A                                                       CPU B
1) __pm_runtime_get() (sync = true)
2)   atomic_inc(&usage_count) (not committed to memory yet)
3)   pm_runtime_resume()
4)     spin_lock_irqsave(&dev->power.lock, flags);
5)     retval = __pm_request_resume(dev);
6)     (execute the body of __pm_request_resume and return)
7)                                                          __pm_runtime_put() (sync = true) 
8)                                                          if (atomic_dec_and_test(&dev->power.usage_count))
                                                              (still see usage_count == 1 before decrement,
                                                               thus decrement to 0)
9)                                                             pm_runtime_idle()
10)  spin_unlock_irqrestore(&dev->power.lock, flags)
11)                                                            spin_lock_irq(&dev->power.lock);
12)                                                            retval = __pm_runtime_idle(dev);
13)                                                            spin_unlock_irq(&dev->power.lock);

So we end up in a situation where CPU A expects the device to be resumed, but
the last action performed has been to bring it to idle.

A smp_mb__after_atomic_inc() between lines 2 and 3 would fix this.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
