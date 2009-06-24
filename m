From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update 3] PM: Introduce core framework for
 run-time PM of I/O devices
Date: Wed, 24 Jun 2009 10:51:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906241014170.3199-100000__9417.66079417921$1245855150$gmane$org@iolanthe.rowland.org>
References: <200906240217.39608.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906240217.39608.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Wed, 24 Jun 2009, Rafael J. Wysocki wrote:

> > One question still remains: If the counter is 0 at the end of a
> > successful pm_runtime_resume, should the core then call pm_notify_idle?  
> > Or should we make the driver responsible for that too?
> 
> Good question. :-)
> 
> I think the core may call pm_notify_idle() in that case, but not necessarily in
> the synchronous case.

I'm not sure; we may want to do it even for synchronous resumes.  
Otherwise the callers would be forced to do it.

There's also the other side of the coin.  What if the counter is 0 at
the end of a failed pm_runtime_suspend?

For example, suppose the driver's runtime_suspend method decides that
the device hasn't been idle for long enough, so it wants to fail the
suspend attempt with -EBUSY and queue a new delayed autosuspend
request.  But at this point the status is RPM_SUSPENDING, so new
suspend requests won't be accepted (N.B., the test for this in the most
recent patch doesn't look right).

Even with a queued notification, there's no guarantee that the
notification won't be sent before the status changes from
RPM_SUSPENDING to RPM_ACTIVE.  So we really do need the notification to
be sent by pm_runtime_suspend, after it has updated the status and
dropped the lock.


There's another totally separate issue worth discussing here.  This 
will affect the USB implementation of the new runtime PM framework.

The difficulty is that some USB interface drivers require remote wakeup
to be enabled while their interfaces are suspended.  But remote wakeup
is a global setting; it doesn't take effect until the entire physical
device is suspended.  (To put it another way, USB has no notion of
suspending interfaces.)  This means we must not allow these interfaces
to be suspended before the whole device is.  But the whole device is
the parent of the interfaces -- if we can't suspend the children before
suspending the parent then we're stuck.

Clearly this is something the USB stack has to deal with; it shouldn't
affect the general PM framework.  However the only solution I can think
of involves subverting the framework, which isn't very nice.  The idea
is to ignore runtime_suspend callbacks for these interface drivers;
allow them to keep on running even though the PM core thinks they are
suspended.  Then suspend and resume them as part of the callbacks for
the entire device.  (For interface drivers that don't require remote
wakeup there is no problem; it doesn't matter when they get suspended.)

This will work, but it's a hack.  Does anybody have a better idea?

Alan Stern
