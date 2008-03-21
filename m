From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and
 hibernation callbacks (rev. 2)
Date: Thu, 20 Mar 2008 22:53:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803202229060.16520-100000__995.993862352584$1206068216$gmane$org@netrider.rowland.org>
References: <200803210314.55149.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803210314.55149.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Fri, 21 Mar 2008, Rafael J. Wysocki wrote:

> > One trivial problem is that your dpm_prepare and dpm_complete routines 
> > go through the list in the wrong order.
> 
> I'm not all so sure that the order is actually wrong.  What would be the
> advantage of the forward order over the current one?

The advantage is that races no longer matter.

Suppose you're going through the list backwards and a race occurs, so
that a child is registered while the parent's prepare() is running.  
That new child will of course be at the end of dpm_active, so the loop
in dpm_prepare won't see it (assuming you adopt the approach of using
only a single list).  But if you go through the list forwards and a new
child is added, you will naturally see the child when you reach the end
of the list.  You don't even have to go through the business about
changing the parent's state back to DPM_ON.

There are other ways of describing the situation, but they all come 
down to the same thing.  For instance, this is the way Ben was talking 
about doing things.

> > Since dpm_prepare is supposed to go through the list in the forward
> > direction, logically the "root" of the device tree should be the first
> > thing "prepared".  This means you should not allow parentless devices
> > to be registered any time after dpm_prepare has started.  Is that 
> > liable to cause problems?
> 
> I'm still not seeing the advantage of the forward direction in the first place.
> 
> Although I don't see what particular problems that may cause, I think the
> current approach (first, block registrations of new children for each
> ->prepare()d device and finally block any registrations of new devices) is
> more natural.

I suppose for parentless devices it doesn't really matter.  You could
safely allow them to be registered any time up until dpm_prepare()  
finishes -- which is what your patch does.  Perhaps the "all_inactive"
flag should be renamed to "all_prepared".

> > There may be similar problems with complete().  A number of drivers
> > check during their resume method for the presence of new children
> > plugged in while the system was asleep.  All these drivers would have
> > to be converted over to the new scheme if they weren't permitted to
> > register the new children before complete() was called.  Of course,
> > this is easily fixed by permitting new children starting from when
> > resume() is called rather than when complete() is called.
> 
> Well, the problem here was the protection of the correct ordering of the
> various lists.  However, if the approach with changing 'status' is adopted
> instead, which seems to be better, we'll be able to unblock the registering
> of new children before ->resume().

Yep.  The only thing to watch out for is in device_pm_remove(); it
would be a disaster if somehow a device was removed while it was being
prepared/suspended/resumed/completed/whatever.  I know that's not
supposed to happen but there's nothing to prevent it, especially if
the device in question doesn't have a driver.  No doubt you can invent
a way to allow this to happen safely.

Alan Stern
