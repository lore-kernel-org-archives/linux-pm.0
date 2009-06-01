From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Date: Mon, 1 Jun 2009 18:16:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906011726150.3972-100000__37485.5019538247$1243894656$gmane$org@iolanthe.rowland.org>
References: <200906012158.26658.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906012158.26658.rjw@sisk.pl>
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
Cc: paul@pwsan.com, linux-sh@vger.kernel.org, gregkh@suse.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 1 Jun 2009, Rafael J. Wysocki wrote:

> > With USB at least, this isn't true.  Some work items shouldn't be
> > dequeued, namely, various sorts of resume requests generated while the
> > driver is in interrupt context.  If they were dequeued during a system
> > suspend then the device wouldn't ever be woken up, because usbcore
> > doesn't pass system-resume messages to an autosuspended device.  The
> > idea is if a device was autosuspended before the system sleep then it
> > should remain autosuspended after the system wakes up.
> 
> Hmm, well, I'm not sure, really.  During a system-wide resume, does it really
> matter if devices were autosuspended before the preceding suspend or they have
> been suspended by the PM core?

It's partly a question of avoiding unnecessary activity.  Is there any
reason to resume a device if it's just going to be autosuspended again
a few seconds later?

It's also a matter of principle.  A system sleep should be as
transparent as possible (except for the passage of time, of course).  
When the sleep is over, devices should be in the same state as before
it began.

>  Also, what happens if the platform firmware
> resumes the autosuspended devices before passing control to the kernel during
> system-wide resume?  How do we handle that?

In the case of USB, it's not possible to resume a suspended device
without first resuming and using a host controller.  The host
controller driver will realize that the firmware has taken over the
controller and will reset the controller.

For devices that were not autosuspended, this action converts an
ordinary resume into a reset-resume.  A different driver method is
called, and drivers that don't support reset-resume are automatically
unbound from their devices (and then reprobed afterward).

For devices that were autosuspended, the controller reset will put them 
back into a suspended state.  They will remain that way until they are 
autoresumed -- and of course it will be an "auto-reset-resume".

What happens if the firmware is sufficiently sneaky that it manages to
fool the host controller driver?  In that case we end up with a device
that really is at full power even though the kernel thinks it is
autosuspended.  When we finally try to autoresume it, we will realize
that it wasn't suspended after all.

> Moreover, what if the autosuspended device is no longer present in the system
> after a system-wide resume.  Are we still going to attempt to autoresume it?

When the device or perhaps its parent hub is resumed, we will realize 
the device is gone.  An attempted autoresume will simply fail.  Until 
that happens, the kernel may believe the device is present when in fact 
it isn't.

> > Furthermore, even if the existing work items were dequeued, you'd still 
> > have to worry about new work items added on by drivers before they get 
> > suspended.  If the workqueue were allowed to run freely, we might find 
> > devices being autoresumed in the middle of the sleep transition!
> 
> Unless there's some other kind of synchronization between the workqueue and the
> core suspend-resume code.

So the work routine would somehow be aware when a system sleep is in
progress, at which point it would return immediately without doing
anything?  That seems racey.  Isn't it easier just to freeze the
workqueue?

> IMO, it would be convenient to treat every system-wide suspend (or hibernation)
> as a cancellation point for all of the pending autosuspend and autoresume
> requests and to treat devices autosuspended before that point as just
> suspended.  Of course, the bus type and device driver suspend callbacks would
> have to be prepared to handle this situation cleanly.

For pending autosuspend, okay.  The device was powered up before the
system sleep, it remains powered up afterward, and another autosuspend
will occur in due course.

For pending autoresume requests coming from user I/O calls, again okay.  
There can't be any of these because userspace is frozen, and besides,
they wouldn't go through the workqueue anyway.

For autoresume requests coming from an interrupt handler, I'm not so 
sure.  I don't know of any good examples -- in fact there don't seem to 
be any examples at the moment.  (The USB core supports autoresume 
requests in interrupt context, AFAICS no driver uses them.)  So maybe 
it's premature to worry about this case.

Lastly, we have resume requests coming from a device -- i.e., remote
wakeup requests.  This is a little tricky.  Suppose you have remote
wakeup enabled, and you press a key on your USB keyboard just as the
computer is going to sleep.  Should this cause the sleep to be aborted?  
Should it cause the computer to wake back up again right away?  Should
the keystroke be ignored?

More to the point, suppose you plug in a new USB device as the computer
is going to sleep.  When the computer wakes up, shouldn't it realize
that a new device has been connected?  This is the same problem that
other people have been discussing -- what should happen to wakeup IRQs
during the time the system is suspending?  Will they get delivered 
later on (and when drivers are ready to receive them)?

Alan Stern
