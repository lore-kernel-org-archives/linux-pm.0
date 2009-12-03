From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: System sleep vs. runtime PM
Date: Thu, 3 Dec 2009 11:53:46 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912031025530.4795-100000@iolanthe.rowland.org>
References: <200912030119.30595.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912030119.30595.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 3 Dec 2009, Rafael J. Wysocki wrote:

> > > > > However this requires the driver to know when a system sleep is in
> > > > > progress -- it's not enough merely to know whether the device is
> > > > > suspended.  We could make things easier for the driver by failing
> > > > > runtime-resume requests when the device's power.status isn't DPM_ON or
> > > > > DPM_RESUMING.  Does that make sense?
> > > >
> > > > That is not a good idea as it needs error handling in all drivers
> > > > for a rare corner case. That's bound to cause many bugs.
> > > 
> > > Drivers are likely to need error handling for failed resumes
> > > regardless, rare though they are.  Besides, the alternative is for
> > 
> > But then they just return -EIO. That's simple. Queuing data isn't.
> > 
> > > drivers to be aware of the distinction between runtime-suspended and
> > > waiting-for-system-sleep, which is also a rare corner case.
> > > 
> > > How would you solve this problem?
> 
> I think such drivers will need to implement the ->prepare() and ->complete()
> suspend/resume callbacks and make them handle this.  That also may be done at
> the bus type level.

I prefer Oliver's argument.  Once processes are frozen, trouble can be
caused only by kernel threads submitting or carrying out I/O requests.  
(For example, the block layer could ask usb-storage's thread to
transfer data to/from a USB drive after the drive has been suspended.)  
The question is: Do we need to worry about this or can we assume it
won't arise?

The simplest solution is to make pm_runtime_resume() abort the sleep
transition if it is called for a device not in the DPM_ON or
DPM_PREPARING states -- and do a WARN_ON if the device isn't
wakeup-enabled to let people know what went wrong.

Alternatively, if pm_runtime_resume() is called for a device that isn't
in DPM_ON or DPM_PREPARING and isn't wakeup-enabled, it could block
until the system sleep is over.  But this is likely to deadlock with
the system resume, so I don't think it will work.


> > > I suppose during "prepare", the PM core could runtime-resume any device
> > > with differing wakeup settings, even the ones that don't need it.
> > 
> > This is necessary.
> 
> In fact, I'd leave that to the bus type level code, because the core doesn't
> even know what "differing wakeup settings" actually mean.

But the core does know how to tell whether the settings are different.  
Centralizing this seems like a good idea, and I don't think too many 
devices would be affected.  Individual bus subsystems could still 
runtime-resume devices that the PM core missed, if they wanted to.


> > > > > If a remote-wakeup request should abort the system sleep, how do we
> > > > > make this happen?
> > > >
> > > > Good question. I have no answer.
> > > 
> > > Clearly it will depend on how the request is handled.  No doubt a
> > > common approach will be to submit a runtime-resume request.  (That's
> > > not what USB will do though; it will queue its own work item on the
> > > runtime PM workqueue).  We could detect at such points whether a sleep
> > > transition has started and set a flag to abort it.  The PM core could
> > > even export a routine for drivers to call when they want to abort a
> > > system sleep.
> > 
> > Yes, I have no thoughts on that.

I had some thoughts last night.  Starting just before processes are
frozen, we should make a check every time a wakeup request is added to
the PM workqueue.  If the device is enabled for remote wakeup, we abort
the system sleep.

It's easy enough to check workqueue additions in runtime.c, but drivers
may want to add their own work items to the PM workqueue.  There are
two ways to handle this.  First, we could make the workqueue private
and export functions to enqueue suspend and resume work items.  
Second, we could make the workqueue public and export a function for
drivers to call when they enqueue a resume request (the function would
check if the device is wakeup-enabled and abort the system sleep if it
is).  I don't know which alternative is better.  Any suggestions?

The details of how the sleep transition gets aborted don't matter.  
It can be something as simple as a flag that gets checked at various 
stages.


> On PCI there is the problem that you may need to reprogram devices for
> system wakeup, so generally you need to resume them during system suspend
> if they have been run-time suspended.  In such a case there's no way we can
> handle a wakeup request that comes in after the device has been resumed
> (during the system suspend) due to the way in which ACPI wakeup GPEs are set
> up (it happens after the I/O devices' suspend and suspend_noirq callbacks have
> been executed).

Wouldn't the GPE cause the system to wake up immediately, as soon as it
goes to sleep?  That's just as good as aborting the sleep.


> > > There's yet another issue to discuss.  Suppose a device is
> > > runtime-suspended when a system sleep starts.  When the system wakes
> > > up, should the device be runtime-resumed?  (Assume that the wakeup
> > > settings don't differ; otherwise it has to be.)

Let me discuss this is some detail.  I'm not so much concerned about 
missing wakeup requests but rather about making sure that (1) we don't 
resume devices unnecessarily and (2) the device's physical power state 
agrees with what the system thinks it is.

None of this matters for devices that are runtime-active when a system
sleep starts.  This is only about devices that are runtime-suspended.  
Also, I expect the decisions discussed here will be made at the bus
subsystem or driver level, not by the PM core.

First, consider resume from hibernation (the RESTORE transition).  In
this case we have no idea what the device's physical state is, so the
only safe thing to do is make sure it is powered on and runtime-active.  
The normal restore method call should leave the device powered on; the
question is how to get it into RPM_ACTIVE without confusing the driver,
the bus subsystem, or the PM core.

Now consider the THAW and RESUME transitions.  Here the driver does
know the device's physical state.  Under what circumstances should it
avoid powering-up the device?  As I see it:

	The device might need to be active in order to change the
	wakeup settings.

	If the usage_count > 1 then the device will likely be used 
	soon, so it should be powered up.  (Remember that the 
	usage_count is always at least 1 because the PM core increments 
	it during a system sleep.)

There might be other device-specific or bus-specific reasons (e.g.,
reset-resume needed for USB), but in general this seems good enough.  
If none of the exceptions applies then we might as well leave the
device turned off.  But if the driver does decide to power-up the
device, we face the same problem as above: How to get it into
RPM_ACTIVE without confusing everybody?

Probably the best answer is for the bus subsystem or driver to call
pm_runtime_resume().  Of course, they would then have to be smart
enough to handle runtime_resume method calls correctly when the device
is already active.

Is it reasonable for the resume and thaw methods to inform the PM core
as to whether they skipped the power-up?  For instance, they could
return -ERESTART in such cases.  Then the PM core could automatically
call pm_runtime_resume() when needed.

There's one issue I skipped over.  Suppose a device is left suspended,
but one of its children needs to be resumed.  The only way to do it
would be to do a runtime resume on the child, because only then would
the parent device get woken up first.  Does this mean that the best way
to implement resume and thaw is to have them simply call
pm_runtime_resume()?

Alan Stern
