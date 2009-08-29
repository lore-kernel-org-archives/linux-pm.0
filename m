From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/6] PM: Asynchronous resume of devices
Date: Fri, 28 Aug 2009 22:06:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908282146550.9540-100000__28459.7981757999$1251511648$gmane$org@netrider.rowland.org>
References: <200908290022.00446.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908290022.00446.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 29 Aug 2009, Rafael J. Wysocki wrote:

> On Friday 28 August 2009, Alan Stern wrote:
> > On Fri, 28 Aug 2009, Rafael J. Wysocki wrote:
> > 
> > > > Given this design, why bother to invoke device_resume() for the async 
> > > > devices?  Why not just start up a bunch of async threads, each of which 
> > > > calls async_resume() repeatedly until everything is finished?  (And 
> > > > rearrange async_resume() to scan the list first and do the actual 
> > > > resume second.)
> > > > 
> > > > The same goes for the noirq versions.
> > > 
> > > I thought about that, but there are a few things to figure out:
> > > - how many threads to start
> > 
> > That's a tough question.  Right now you start roughly as many threads
> > as there are async devices.  That seems like overkill.
> 
> In fact they are substantially fewer than that, for the following reasons.
> 
> First, the async framework will not start more than MAX_THREADS threads,
> which is 256 at the moment.  This number is less than the number of async
> devices to handle on an average system.

Okay, but MAX_THREADS isn't under your control.  Remember also that 
each thread takes up some memory, and during hibernation we are in a 
memory-constrained situation.

> Second, no new async threads are started while the main thread is handling the
> sync devices , so the existing threads have a chance to do their job.  If
> there's a "cluster" of sync devices in dpm_list, the number of async threads
> running is likely to drop rapidly while those devices are being handled.
> (BTW, if there were no sync devices, the whole thing would be much simpler,
> but I don't think it's realistic to assume we'll be able to get rid of them any
> time soon).

Perhaps not, but it would be interesting to see what happens if every 
device is async.  Maybe you can try it and get a meaningful result.

> Finally, but not least importantly, async threads are not started for the
> async devices that were previously handled "out of order" by the already
> running async threads (or by async threads that have already finished).  My
> testing shows that there are quite a few of them on the average.  For example,
> on the HP nx6325 typically there are as many as 580 async devices handled "out
> of order" during a _single_ suspend-resume cycle (including the "early" and
> "late" phases), while only a few (below 10) devices are waited for by at least
> one async thread.

That is a difficult sort of thing to know in advance.  It ought to be 
highly influenced by the percentage of async devices; that's another 
reason for wanting to know what happens when every device is async.

> > I would expect that a reasonably small number of threads would suffice 
> > to achieve most of the possible time savings.  Something on the order 
> > of 10 should work well.  If the majority of the time is spent 
> > handling N devices then N+1 threads would be enough.  Judging from some 
> > of the comments posted earlier, even 4 threads would give a big 
> > advantage.
> 
> That unfortunately is not the case with the set of async devices including
> PCI, ACPI and serio devices only.  The average time savings are between 5% to
> 14%, depending on the system and the phase of the cycle (the relative savings
> are typically greater for suspend).  Still, that amounts to .5 s in some cases.

Without context it's hard to be sure, but I don't think your numbers 
contradict what I said.  If you get between 5% and 14% time savings 
with 14 threads, then you might get between 4% and 10% savings with 
only 4 threads.

I must agree, 14 threads isn't a lot.  But at the moment that number is 
random, not under your control.

> > > - when to start them
> > 
> > You might as well start them at the beginning of dpm_resume and 
> > dpm_resume_noirq.  That way they can overlap with the synchronous 
> > operations.
> 
> In that case they would have to wait in the beginning, so I'd need a mechanism
> to wake them up.

You already have two such mechanisms: dpm_list_mtx and the embedded 
wait_queue_heads.  Although in the scheme I'm proposing, no async 
threads would ever have to wait on a per-device waitqueue.  A 
system-wide waitqueue might work out better (for use when a thread 
reaches the end of the list and then waits before starting over at the 
beginning).

> Alternatively, there could be a limit to the number of async threads started
> within the current design, but I'd prefer to leave that to the async framework
> (namely, if MAX_THREADS makes sense for boot, it's also likely to make sense
> for PM).

Strictly speaking, a new thread should be started only when needed.  
That is, only when all the existing threads are busy running a 
callback.  It shouldn't be too hard to keep track of when that happens.

> > It comes down to this: Should there be many threads, each of which 
> > browses the list only once, or should there be a few threads, each of 
> > which browses the list many times?
> 
> Well, quite obviously I prefer the many threads version. :-)

Okay, clearly it's a matter of taste.  To me the many-threads version 
seems less elegant and less well controlled.

Alan Stern
