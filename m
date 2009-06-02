From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Date: Tue, 2 Jun 2009 10:51:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906020954110.3074-100000__15809.6832842149$1243954449$gmane$org@iolanthe.rowland.org>
References: <200906020121.38946.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906020121.38946.rjw@sisk.pl>
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
Cc: paul@pwsan.com, linux-sh@vger.kernel.org, gregkh@suse.de, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2 Jun 2009, Rafael J. Wysocki wrote:

> > It's partly a question of avoiding unnecessary activity.  Is there any
> > reason to resume a device if it's just going to be autosuspended again
> > a few seconds later?
> 
> Well, I'm not sure if we know in advance what's going to happen to the device
> right after a system-wide resume.  It may be a totally different situation from
> the device activity point of view.

We _never_ know in advance what's going to happen.  An autosuspended
device may have to wake up at any time in order to carry out some work
-- that's true whether or not a system sleep has taken place.  IMO it
doesn't make sense to wake up an autosuspended device for no reason
other than that it _may_ need to do something; we should let it stay in
a low-power mode until we _know_ it has to wake up.

> > It's also a matter of principle.  A system sleep should be as
> > transparent as possible (except for the passage of time, of course).  
> > When the sleep is over, devices should be in the same state as before
> > it began.
> 
> As a matter of fact, this need not be true at all.  For example, consider a
> wireless network adapter that was assosicated with specific access point
> before a system-wide suspend, but this access point is not present any more
> after the subsequent system-wide resume.

This example doesn't prove your point.  Sure, conditions may have
changed while the system was asleep.  They might also change while the
system is awake.  In general, whether or not the system was asleep
shouldn't make any difference -- to as great an extent as possible we
should strive to pretend that the entire sleep took no time at all (or
simply didn't happen).

So: Suppose the system had been awake when the access point
disappeared.  What would the wireless adapter driver do then?  It
should try to do exactly the same thing if the access point disappears
while the system is asleep.

You see?  The sleep should be transparent.

> I really don't think we can predict what's going to happen to a device after
> a system-wide resume, so IMO we should assume that the device will be necessary
> immediately after the resume and we should resume it.  It still can autosuspend
> normally afterwards if it's not needed after all.

This is highly debatable.  I'd like to hear some thoughts from other 
people.


> > >  Also, what happens if the platform firmware
> > > resumes the autosuspended devices before passing control to the kernel during
> > > system-wide resume?  How do we handle that?
> > 
> > In the case of USB, it's not possible to resume a suspended device
> > without first resuming and using a host controller.  The host
> > controller driver will realize that the firmware has taken over the
> > controller and will reset the controller.
...

> I'm not sure if this is doable so easily for PCI devices, for one example.
> Most probably, they will come up in D0 after the system-wide suspend and
> the PCI resume code will have to suspend them directly so that they remain
> "autosuspended" after the resume.

Clearly the behavior will need to vary among buses.  What's appropriate
for USB won't be appropriate for PCI.  Furthermore, the overhead of
waking a PCI device unnecessarily might be a lot lower than the
overhead of waking a USB device, so it might make sense always to
resume autosuspended PCI devices during a system resume.


> > So the work routine would somehow be aware when a system sleep is in
> > progress, at which point it would return immediately without doing
> > anything?  That seems racey.  Isn't it easier just to freeze the
> > workqueue?
> 
> Well, yes and no.  Namely, if we freeze the workqueue, all of the bus types
> using it will have to check the vaildity of operations carried out by it,
> because of the possibility that system-wide power transition took place in the
> meantime and changed the state of the device.  Also, please take the PCI
> example into consideration.

Freezability doesn't matter; you can prevent items from being added to
the workqueue during a power transition just as easily regardless of
whether it is freezable or not.  In fact, it's easier if the workqueue
is freezable.  You don't have to prevent anything from being added; you
just have to cancel everything on the workqueue before unfreezing it.

One solution would be to have the bus types cancel their own pending
work items explicitly.  Another is to have two freezable PM workqueues,
one with automatic cancellation and the other without.


> > For autoresume requests coming from an interrupt handler, I'm not so 
> > sure.  I don't know of any good examples -- in fact there don't seem to 
> > be any examples at the moment.  (The USB core supports autoresume 
> > requests in interrupt context, AFAICS no driver uses them.)  So maybe 
> > it's premature to worry about this case.
> 
> Hmm.  Can you please describe a theoretical situation in which this kind
> of autoresume request will appear?  I'm not really sure what you mean here. :-)

Well, here's something people discussed but which hasn't been
implemented (and may never be implemented).  A suspended USB keyboard
doesn't have enough power to turn on any LEDs.  So suppose a system has
two keyboards, and kbd-A is autosuspended when the user engages
CapsLock on kbd-B.  The input layer wants to turn on the CapsLock LED
on all the keyboards, which means it has to autoresume kbd-A.  But all
this action takes place in interrupt context, so an autoresume request
would have to be queued.


> > Lastly, we have resume requests coming from a device -- i.e., remote
> > wakeup requests.  This is a little tricky.  Suppose you have remote
> > wakeup enabled, and you press a key on your USB keyboard just as the
> > computer is going to sleep.  Should this cause the sleep to be aborted?  
> > Should it cause the computer to wake back up again right away?  Should
> > the keystroke be ignored?
> 
> This is a difficult problem in general.  I _think_ we should ignore such
> autoresume requests for devices that are not marked as wake-up ones
> and we should abort the suspend if there's a request from a wake-up device.

It _is_ difficult.  Right now USB ignores such requests, because the
threads that handle them are all freezable.  But the information isn't
lost; it is stored in the hardware and when the system wakes up the
requests will be seen.

Except for wakeup requests from root hubs.  If they arrive at just the 
right time then they are not stored in the hardware -- instead they are 
stored as work items on the ksuspend_usbd workqueue!  In essence, the 
workqueue serves as a software mechanism for saving IRQs which were 
delivered but couldn't be acted on.

That's why I don't want to erase the work items; it would be logically 
equivalent to dropping interrupts.


> Anyway, below is a prototype implementation of a generic runtime PM workqueue,
> just for discussion.
> 
> pm_schedule_suspend() and pm_schedule_resume() are to be called by bus types
> that are requesting the autosuspend or autoresume, respectively, of a device.
> The supposed control flow is like this:
> * bus type calls pm_schedule_suspend() to schedule autosuspend of a device
> * at the right time the PM workqueue executes the bus type's ->autosuspend()
>   callback which is responsible for calling the device driver to suspend the
>   device (the way in which this is done is totally bus type-specific)
> * if there's a resume event for the device, it's delivered to the bus type
>   driver (in a bus type-specific way) and the bus type schedules autoresume of
>   the device by calling pm_schedule_resume()
> * the PM workqueue executes the bus type's ->autoresume() as soon as it can
>   and this callback is responsible for calling the device driver to resume the
>   device (the way in which this is done is totally bus type-specific).

It looks like the only benefits provided by this patch are the
workqueue itself and the embedded delayed_work structure.  The ability
to cancel the work items (or prevent them from being added) during a
system sleep is questionable, as discussed above.  There isn't any
value added by the new functions or methods.

In short, it would be just as useful simply to add the delayed_work 
structure and export two PM workqueues, both freezable, with automatic
cancellation for one of them.

Alan Stern
