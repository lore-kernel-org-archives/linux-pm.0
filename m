From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: System sleep vs. runtime PM
Date: Thu, 3 Dec 2009 01:19:30 +0100
Message-ID: <200912030119.30595.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0912021638020.3041-100000@iolanthe.rowland.org>
	<200912030002.46692.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912030002.46692.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 03 December 2009, Oliver Neukum wrote:
> Am Mittwoch, 2. Dezember 2009 23:20:24 schrieb Alan Stern:
> > On Wed, 2 Dec 2009, Oliver Neukum wrote:
> > > Am Mittwoch, 2. Dezember 2009 19:35:34 schrieb Alan Stern:
> > > > Rafael and Oliver:
> > > >
> > > > I'm in the midst of converting USB over to the runtime PM framework,
> > > > and I'm getting stuck on the interaction between system sleep and
> > > > runtime PM.  In fact, I'm so confused about it that it's hard to
> > > > formulate a coherent set of questions.  So bear with me...
> > > >
> > > > If a driver gets an output request and its device is runtime-suspended,
> > > > then the driver should do a runtime-resume before sending the output to
> > > > the device.  If the output request arrives during a system sleep
> > > > transition then the output should be refused or left to sit in a queue
> > > > (presumably this won't happen, but it might).
> > >
> > > How can it happen? As the freezer has run before drivers learn
> > > about a sleep transition, the request would come from a kernel thread.
> > 
> > Exactly.  Or a timer routine, or an interrupt handler, ...
> 
> Yes, but in these cases you cannot sleep anyway and must use an
> asynchronous resume. These cases are rare. HID mainly. Generally
> the freezer is your guarantee.
> 
> If you must use an asynchronous resumption request, the problem
> becomes moot. You queue IO in all cases and the resumption will
> be deferred until after the system will have woken up as the work
> queue is frozen.
> 
> > > > However this requires the driver to know when a system sleep is in
> > > > progress -- it's not enough merely to know whether the device is
> > > > suspended.  We could make things easier for the driver by failing
> > > > runtime-resume requests when the device's power.status isn't DPM_ON or
> > > > DPM_RESUMING.  Does that make sense?
> > >
> > > That is not a good idea as it needs error handling in all drivers
> > > for a rare corner case. That's bound to cause many bugs.
> > 
> > Drivers are likely to need error handling for failed resumes
> > regardless, rare though they are.  Besides, the alternative is for
> 
> But then they just return -EIO. That's simple. Queuing data isn't.
> 
> > drivers to be aware of the distinction between runtime-suspended and
> > waiting-for-system-sleep, which is also a rare corner case.
> > 
> > How would you solve this problem?

I think such drivers will need to implement the ->prepare() and ->complete()
suspend/resume callbacks and make them handle this.  That also may be done at
the bus type level.

> I just love the freezer.
> 
> > In other words, if the device is enabled for remote wakeup during
> > system sleep (which is -- or soon will be -- different from supporting
> > remote wakeup during runtime suspend).
> 
> Yes.
> 
> > > > What if the device is enabled for runtime remote wakeup and not for
> > > > wakeup from system sleep?  There will be a window during which the
> > > > wakeup settings are wrong.  Should a wakeup request from such a device
> > > > be allowed to abort a sleep transition?
> > >
> > > The core should prevent that window. If necessary devices with
> > > different wakeup settings should be resumed before starting system sleep.
> > 
> > This is a little difficult.  Only the bus subsystem or the driver --
> > not the PM core -- knows if the extra wakeup is needed, and the core
> > doesn't send out a general announcement prior to starting the sleep.
> > The closest we come is the "prepare" stage.
> > 
> > I suppose during "prepare", the PM core could runtime-resume any device
> > with differing wakeup settings, even the ones that don't need it.
> 
> This is necessary.

In fact, I'd leave that to the bus type level code, because the core doesn't
even know what "differing wakeup settings" actually mean.

> > > > If a remote-wakeup request should abort the system sleep, how do we
> > > > make this happen?
> > >
> > > Good question. I have no answer.
> > 
> > Clearly it will depend on how the request is handled.  No doubt a
> > common approach will be to submit a runtime-resume request.  (That's
> > not what USB will do though; it will queue its own work item on the
> > runtime PM workqueue).  We could detect at such points whether a sleep
> > transition has started and set a flag to abort it.  The PM core could
> > even export a routine for drivers to call when they want to abort a
> > system sleep.
> 
> Yes, I have no thoughts on that.
> 
> > > > If a remote-wakeup request doesn't abort the system sleep, then what
> > > > happens to it?  Obviously it should get serviced when the system wakes
> > > > up again.  But what if the device was runtime-suspended when the sleep
> > > > began?  How do we make sure it gets runtime-resumed when the sleep
> > > > ends?
> > > >
> > > > I can see two possibilities here.  One is that the remote-wakeup
> > > > request triggered an asynchronous pm_request_wakeup().  In this case
> > > > the request is sitting on the PM workqueue and it will automatically be
> > >
> > > That sounds very reasonable.
> > 
> > Actually this question no longer applies.  We have agreed that a
> > remote-wakeup request received during a sleep transition should always
> > abort the sleep, because otherwise the device wouldn't be enabled for
> > remote wakeup.
> 
> An evil thought, do we have devices that will always request remote wakeup,
> without an option to switch it off? What about OTG?
> 
> > There's yet another issue to discuss.  Suppose a device is
> > runtime-suspended when a system sleep starts.  When the system wakes
> > up, should the device be runtime-resumed?  (Assume that the wakeup
> > settings don't differ; otherwise it has to be.)
> 
> That depends on how sure we are to never drop a remote wakeup,
> not even if requests race or for any other reason. And we must always
> know what woke us up.

On PCI there is the problem that you may need to reprogram devices for
system wakeup, so generally you need to resume them during system suspend
if they have been run-time suspended.  In such a case there's no way we can
handle a wakeup request that comes in after the device has been resumed
(during the system suspend) due to the way in which ACPI wakeup GPEs are set
up (it happens after the I/O devices' suspend and suspend_noirq callbacks have
been executed).

Thanks,
Rafael
