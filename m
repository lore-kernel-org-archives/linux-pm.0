From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Adding pm_schedule_idle(),
	maybe removing pm_schedule_suspend()
Date: Fri, 27 Nov 2009 01:53:30 +0100
Message-ID: <200911270153.30724.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0911261106490.16753-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0911261106490.16753-100000@netrider.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 26 November 2009, Alan Stern wrote:
> On Wed, 25 Nov 2009, Rafael J. Wysocki wrote:
> 
> > On Wednesday 25 November 2009, Alan Stern wrote:
> > > Rafael:
> > > 
> > > It turns out that I need a pm_schedule_idle() routine.  
> > > pm_schedule_suspend() just doesn't do what I want -- I need the 
> > > runtime_idle() callback to be invoked when the timer expires, not 
> > > runtime_suspend().
> > > 
> > > Adding the routine itself is easy enough, but the obvious way to
> > > implement it is to use dev->power.request to tell the timer function
> > > whether it should queue an idle or a suspend.  This leads to a problem:
> > > It becomes impossible to queue an idle request if there's a scheduled
> > > suspend.  The reason is that power.request has to remain set to
> > > indicate that a suspend should be queued when the timer expires, so it
> > > can't be changed to RPM_REQ_IDLE.
> > > 
> > > One possible way around this would be to have pm_schedule_idle() 
> > > completely replace pm_schedule_suspend().  This seems like a reasonable 
> > > approach -- at the time of the function call we don't know what 
> > > conditions will be like in the future, so when the timer expires we 
> > > should check again to see if a suspend is appropriate.
> > > 
> > > What do you think?
> > 
> > I'm against that.  In fact I have a usage case that would be broken by this
> > change.
> > 
> > What exactly is your usage scenario?
> 
> Never mind, I figured out how to do what I want without it.  This
> involves lying a little to the runtime PM core.  I'm going to tell it
> that the interfaces in a USB device are suspended whenever their usage
> counts drop to 0, even though the interface drivers' suspend routines
> won't get called until the overall device is suspended.  Likewise, I'll
> call the drivers' resume routines when the device is resumed, even
> though the PM core will still think the interfaces are suspended.

I don't see any problems with that.
 
> I don't think that will cause any problems.  The alternative --
> informing the PM core about the interfaces' true states -- is a lot
> more troublesome.  (Even when the interfaces are idle and have a usage
> count of 0, the fact that they aren't actually suspended will prevent
> idle notifications from being delivered for the device, making it
> difficult to know when the device should be suspended.)

Agreed.

> Here's a related matter for you to consider.  Let's say I want a device
> to suspend after N milliseconds of inactivity.  Thus, when an I/O
> operation completes I will call pm_schedule_suspend(dev, N).  That's
> fine if the amount of activity is low.
> 
> However if the device is very active, like a disk drive or network
> interface in constant use, this will add a significant overhead to
> every I/O.  An alternative approach is simply to store the time when an
> I/O completes, without rescheduling the suspend.  Then the
> runtime_suspend method can compare the current time to the stored time,
> and fail with -EAGAIN if the difference is less than N ms.  The
> runtime_idle method will be called, and it can schedule another suspend
> in the future.
> 
> This is perfectly workable, although I don't know how active the device
> has to be before this strategy is preferable.  How many times do you
> have to reschedule a timer before it requires more overhead than just
> letting the timer expire and the workqueue run?  Probably a lot -- it's
> not easy to tell.  Somewhere between 100 and 1000 maybe?

Unfortunately I don't have much experience with that, so I can't really say.

> Anyway, the one drawback of this approach (not very significant) is
> that it requires the runtime_suspend method to do the time check.  In
> principle, such checks should be performed instead by the runtime_idle
> method.  But that's not possible here without the ability to schedule
> an idle notification in the future.
> 
> Like I said, this is a very minor drawback.

Agreed again.

Thanks,
Rafael
