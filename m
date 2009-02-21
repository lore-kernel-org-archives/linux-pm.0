From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFD] Automatic suspend
Date: Sat, 21 Feb 2009 11:52:38 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902211135170.7396-100000__15772.0194584273$1235235431$gmane$org@netrider.rowland.org>
References: <200902210040.50344.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902210040.50344.rjw@sisk.pl>
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 21 Feb 2009, Rafael J. Wysocki wrote:

> > I think everything that uses a "trigger" logic from user space is not
> > a good idea. This will necessary introduce a race between the decision
> > and the execution during which circumstances can change.
> 
> Well, in this particulare case if the circumstances change in the meantime,
> the kernel will just refuse to suspend.  Also, even if the kernel starts
> automatic suspend, it _still_ is possible that the conditions change in the
> meantime (for example, one of the tasks may enter a state in which it wouldn't
> like to the suspend to happen just after the operation is started and before
> it's frozen).
> 
> > So it seems to me that an allow/disallow system from user space
> > would be better.
> 
> I don't really see the benefit, but I can easily see drawbacks (the handling
> of graphics that requires user space quirks, for instance).

This discussion is circling around an important point: How should 
auto-sleep be initiated?

If userspace holds any wakelocks then the system mustn't auto-sleep.  
So auto-sleep can be initiated when the last userspace wakelock is
released.  That requires calling into the kernel anyway, so it isn't a
problem.

But what about kernel wakelocks?  Again, the simplest approach is to 
initiate an auto-sleep when the last one is released.  But now this 
depends on how the implementation works.

In Rafael's scheme there isn't really such a thing as a kernel 
wakelock.  Instead there are driver methods, so the only way to find 
out whether auto-sleep is allowed is to poll every driver.  This is not 
good for systems that want to auto-sleep as soon as possible.

A variant on the scheme would use a new field in the dev_pm_info 
structure.  I don't know if this is better or worse the a new method; 
it seems likely that the new method would have to work by checking the 
value of some field anyway.  In any case, it shares the drawback that 
polling is required.

If kernel wakelocks were implemented more like refcounts, then
releasing the last one could immediately initiate an auto-sleep.  The 
problem with refcounts is that you can't tell (for accounting or 
debugging purposes) who owns the outstanding references.  However we 
ought to be able to come up with something intermediate between a 
full-blown wakelock and a simple refcount that would satisfy everybody.  

For example, we could use _both_ a new field in dev_pm_info and a 
refcount.  Or even a per-cpu refcount, to avoid cache-line contention 
since drivers are likely to acquire and release these things quite 
often.

What about the overhead of having a permanent kernel thread that does
nothing but handle auto-sleeps?  This might well be an acceptable
tradeoff for many people.  Besides, you need something like it if a
driver wants to release the last wakelock while in interrupt context.  
Unless you fall back on polling -- and then you need a thread to do the
polling.

Alan Stern
