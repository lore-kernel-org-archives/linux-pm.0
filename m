From: Alan Stern <stern@rowland.harvard.edu>
Subject: Bugs in MMC [was: [Bug 10030] Suspend doesn't work when
 SD card is inserted]
Date: Sun, 24 Feb 2008 10:33:34 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0802240941440.29504-100000__45094.1348834478$1203867347$gmane$org@netrider.rowland.org>
References: <200802241500.41969.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802241500.41969.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Ossman <drzeus-mmc@drzeus.cx>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sun, 24 Feb 2008, Rafael J. Wysocki wrote:

> > In fact this turns out to be exactly the problem with the MMC
> > subsystem.  It uses a dedicated workqueue (kmmcd) to handle state
> > changes, and mmc_suspend_host() does a flush_workqueue().  If the
> > workqueue contains an entry to register or unregister a device, this is
> > guaranteed to deadlock -- and that's exactly what happens when Zdenek 
> > inserts or removes a card during the disk-drive spindown time of a 
> > system sleep.
> > 
> > It looks like the best solution is for mmc_suspend_host() not to flush
> > the workqueue; instead the workqueue should prevent itself from
> > running during a suspend.  Right now the easiest way to accomplish this
> > is for the workqueue routines (mmc_detect() and siblings) to acquire
> > the mmc_host's device semaphore.  If in the future the MMC subsystem
> > adds dynamic PM support then a more complicated arrangement will be 
> > needed.
> > 
> > So the patch below, in combination with the previous patch, might just 
> > fix the whole problem.
> 
> The patch looks sane and I think you're right.

Well, the patch itself isn't really adequate; it was just a first pass 
intended to illustrate the nature of the problem.

The problems in the MMC subsystem go deeper.

The first is the way it uses flush_workqueue().  This is almost always 
a bad function to call, because it introduces unnecessary dependencies.  
cancel_delayed_work_sync() is much better.

But even changing that won't solve the second issue, which is a genuine
bug.  There is a race between detect events and suspend events.  The
mmc_suspend_host() routine starts out by flushing the kmmcd workqueue
before calling the host's suspend routine.  So what happens if another
detect event occurs in between?

This whole area of synchronization between card insertion, card
removal, suspend, and resume needs to be thought out better.  
Especially keeping in mind that device registration or unregistration
during a system sleep is likely to block until the sleep is over.

Lastly, there are some other questions about confusing aspects of the
subsystem.  What's the story with __mmc_claim_host()?  Is it really
nothing more than an abortable mutex_lock()?  Why does it ever need to
be aborted?  Why is its second argument an atomic_t instead of a normal
int?

Why are mmc_detect() and related routines described in comments as
"Card detection callback from host"?  They don't handle card
_detection_ -- they handle card _removal_.

What's the purpose of the card-counting loop in 
host/omap.c:mmc_omap_switch_handler()?  It looks like dead code.

Alan Stern
