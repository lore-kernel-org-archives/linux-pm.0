From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] PM: Wakeup sources and async suspend
	error path bug fix
Date: Mon, 4 Oct 2010 22:30:04 +0200
Message-ID: <201010042230.04579.rjw__35784.8807042048$1286225153$gmane$org@sisk.pl>
References: <201009201957.40995.rjw@sisk.pl> <201010040104.09789.rjw@sisk.pl>
	<20101004032903.GC4439@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101004032903.GC4439@gvim.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, October 04, 2010, mark gross wrote:
> On Mon, Oct 04, 2010 at 01:04:09AM +0200, Rafael J. Wysocki wrote:
> > On Monday, October 04, 2010, mark gross wrote:
> > > On Mon, Sep 20, 2010 at 07:57:40PM +0200, Rafael J. Wysocki wrote:
> > > > Hi,
> > > > 
> > > > The following two patches are ready to go into linux-next from my point of
> > > > view, so please let me know if there are any objections:
> > > > 
> > > > [1/2] - PM / Wakeup: Introduce wakeup source objects and event statistics (v3)
> > > > 
> > > > [2/2] - PM: Fix potential issue with failing asynchronous suspend
> > > > 
> > > > Thanks,
> > > > Rafael
> > > 
> > > Sorry for the late response but, what user feed back will this provide
> > > to the OS stack looking to put the system in a low power state?
> > > 
> > > There are 2 cases I can think of:
> > > 1) system wakes from an event that user mode needs to handle (i.e. key
> > > press or phone ring or alarm events)
> > > 2) system wakes (or more likely, is blocked from suspending) by a
> > > kernel critical section, say if USB-OTG is connected.
> > > 
> > > When wake's are of the type 1, then the power manager service could
> > > simply wait for a user mode wake lock be taken and released from the
> > > usermode before re-attempting to suspend.
> > > 
> > > When the wakes are of type 2, a power manager service thread would need
> > > to do a select on a system file and be woken up to re-try the suspend
> > > after the suspend-blocking is no longer needed.
> > 
> > IMO it is more convenient to implement that in a different way, but
> > generally I think you're right.
> > 
> > > Do you think I should cobble together an android PM driver that plugs
> > > into your code to expose an ABI for the 2 cases listed above?
> > 
> > Well, I'm not sure if I understand correctly, can you elaborate a bit, please?
> 
> Well, before I saw your patch I was thinking about implementing an
> Android PM driver that would request a pm_qos active request that would
> be notified and interface with your wake event code.  It would also
> expose a misc /dev/susped_blocked node that would be signaled when the
> pm_qos active request went to zero.
> 
> Now I'm sort of making things up as I go but, some sort of non-poling
> mechanism to re-attempt the suspend, for type 2, is needed but I'm not
> sure where to put it now.

There always will be some kind of "polling" involved, because some operations
will have to be retried, but that should still be fine as long as the power
manager puts itself to sleep whenever it sees that suspend is "blocked".

Reading from /sys/power/wakeup_count blocks until events_in_progress is zero
and there should be some IPC between the power manager and the user space
tasks allowed to "block suspend" that will put the power manager to sleep
until it's OK to try suspending.

> Also, we may want to think about registering events that user mode will
> handle, and all others are treated as type 2 events.
> 
> 
> > > Also, with this do we want to revisit a pm_qos class for "active"
> > > systems?  Or do you think thats redundant now?
> > 
> > I don't really think the pm_qos for "active" systems is really necessary at
> > this point.
> >
> 
> I'm still studying the patch but, you are likely right.  I need to look
> at how much overhead changing the suspend blocking/unblocking is
> handled.  I expect that some drivers will be hitting it on hot code
> paths.

That involves taking two spinlocks that shouldn't be contended for
(one in struct  dev_pm_info and one in struct wakeup_source) and one (for
blocking) or two (for unblocking) atomic variables.   For unblocking there
also is a spinlock to take in del_timer() if the timer is pending, but that
only happens if there's a timeout.

Thanks,
Rafael
