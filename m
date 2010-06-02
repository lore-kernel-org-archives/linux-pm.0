From: =?ISO-8859-1?Q?Vin=EDcius_Bonk?= <vinicius@anti-christ.net>
Subject: Re: linux-pm Digest, Vol 69, Issue 9
Date: Wed, 2 Jun 2010 00:28:00 -0300
Message-ID: <AANLkTimEINY0uG8KTdvwqkGENDV_LR9lrBwpY3L3P01P@mail.gmail.com>
References: <mailman.21.1275447103.27620.linux-pm@lists.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8483703595358268847=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <mailman.21.1275447103.27620.linux-pm@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============8483703595358268847==
Content-Type: multipart/alternative; boundary=00504502cc334a5f20048803ad15

--00504502cc334a5f20048803ad15
Content-Type: text/plain; charset=ISO-8859-1

Is there a way to emulate a really primitive Windows software that
communicates via COM1 port to a device? The software is only a way to post
data to the device.

2010/6/1 <linux-pm-request@lists.linux-foundation.org>

> Send linux-pm mailing list submissions to
>        linux-pm@lists.linux-foundation.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>        https://lists.linux-foundation.org/mailman/listinfo/linux-pm
> or, via email, send a message with subject or body 'help' to
>        linux-pm-request@lists.linux-foundation.org
>
> You can reach the person managing the list at
>        linux-pm-owner@lists.linux-foundation.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of linux-pm digest..."
>
>
> Today's Topics:
>
>   1. Re: [PATCH 1/2] suspend: Move NVS save/restore code to
>      generic suspend functionality (Rafael J. Wysocki)
>   2. Re: [PATCH 0/8] Suspend block api (version 8) (Neil Brown)
>   3. Re: [PATCH 0/8] Suspend block api (version 8) (Arve Hj?nnev?g)
>   4. Re: [PATCH 0/8] Suspend block api (version 8) (mark gross)
>   5. Re: [PATCH 0/8] Suspend block api (version 8) (mark gross)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Wed, 2 Jun 2010 01:34:46 +0200
> From: "Rafael J. Wysocki" <rjw@sisk.pl>
> Subject: Re: [linux-pm] [PATCH 1/2] suspend: Move NVS save/restore
>        code to generic suspend functionality
> To: Maxim Levitsky <maximlevitsky@gmail.com>
> Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
>        linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett
>        <mjg@redhat.com>
> Message-ID: <201006020134.46962.rjw@sisk.pl>
> Content-Type: Text/Plain;  charset="utf-8"
>
> On Wednesday 02 June 2010, Maxim Levitsky wrote:
> > On Wed, 2010-06-02 at 00:40 +0200, Rafael J. Wysocki wrote:
> > > On Tuesday 01 June 2010, Maxim Levitsky wrote:
> > > > On Tue, 2010-06-01 at 23:31 +0200, Rafael J. Wysocki wrote:
> > > > > On Tuesday 01 June 2010, Maxim Levitsky wrote:
> > > > > > Saving platform non-volatile state may be required for suspend to
> RAM as
> > > > > > well as hibernation. Move it to more generic code.
> > > > > >
> > > > > > Signed-off-by: Matthew Garrett <mjg@redhat.com>
> > > > > > Signed-off-by: Matthew Garrett <maximlevitsky@gmail.com>
> > > > >
> > > > > You made a mistake here.
> > > > >
> > > > > Also, why are you resending the Matthews patches?  I think Len has
> seen them
> > > > > already.
> > > > Yea, a copypaste.
> > > >
> > > > (I was told that if one submits modified patch, it adds his
> > > > Signed-off-by.)
> > > >
> > > > I rebased these on top of
> > > > ACPI / EC / PM: Fix race between EC transactions and system suspend'
> > > >
> > > > To be honest, I just want to get some feedback on this.
> > > > This was major issue that kept me from using otherwise prefect
> suspend
> > > > to ram.
> > >
> > > I think this is a change we should try, but there is a chance it will
> break
> > > some systems.
> > I doubt that. BIOSes are tested against windows, and since it has this
> > behavior, all systems this patch could break wouldn't work in windows
> > ether.
>
> Still, some systems were broken by the saving-restoring NVS over
> hibernation.
>
> > I was doing all kinds of attempts to fix this bug, and finally I found
> > the cause for it.
>
> I know and I'm not objecting to the patches.  I'm only saying we should be
> careful with them.
>
> Rafael
>
>
> ------------------------------
>
> Message: 2
> Date: Wed, 2 Jun 2010 10:43:18 +1000
> From: Neil Brown <neilb@suse.de>
> Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
> To: Alan Stern <stern@rowland.harvard.edu>
> Cc: Peter Zijlstra <peterz@infradead.org>, LKML
>        <linux-kernel@vger.kernel.org>, Florian Mickler <
> florian@mickler.org>,
>        Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner
>        <tglx@linutronix.de>,   Linux OMAP Mailing List
>        <linux-omap@vger.kernel.org>,   Felipe Balbi <
> felipe.balbi@nokia.com>,
>        Alan Cox <alan@lxorguk.ukuu.org.uk>
> Message-ID: <20100602104318.0c41b3cd@notabene.brown>
> Content-Type: text/plain; charset=US-ASCII
>
> On Tue, 1 Jun 2010 10:47:49 -0400 (EDT)
> Alan Stern <stern@rowland.harvard.edu> wrote:
>
> > On Tue, 1 Jun 2010, Neil Brown wrote:
> >
> > > > With wakeup events the problem isn't so bad.  Wakeup events are
> always
> > > > noticed, and if the system is designed properly they will either
> abort
> > > > a suspend-in-progress or else cause the system to resume as soon as
> the
> > > > suspend is complete.  (Linux is not yet properly designed in this
> > > > sense.)
> > >
> > > This is exactly the issue.  Linux doesn't get this right.  A wakeup
> that is
> > > processed by the driver just before suspend may not get all the way out
> to
> > > it's final destination (possibly in meat-space) until after some other
> event
> > > wakes the device.  It is not possible to guarantee full delivery of a
> wakeup
> > > event with Linux in its current state.  This is a bug.
> >
> > That wasn't what I meant.  An important requirement is that a wakeup
> > event received after the device has been suspended, but before the
> > system suspend is complete, should cause the system suspend to abort.
> > This is one of the things suspend blockers were meant to help with.  In
> > theory it should already work correctly -- but it doesn't.  That's a
> > real bug.
> >
> > The other things you're talking about aren't really bugs.  That is,
> > they are things which the kernel _ought_ to do but it wasn't _intended_
> > to do.  They are misfeatures: failures of design, not failures of
> > execution.
>
> A fairly subtle distinction, but I can accept it.  We are working with a
> design failure.
> But when a design failure results in a feature not being usable in a
> race-free way, I would still call that failure of design a bug - a bug in
> the
> design.
>
> >
> > > I don't think I'm missing that.  Wakeup events are the only events of
> > > interest.  But wakeup events are more than just low-level hardware
> events.
> > > They are also the virtual events that are a direct consequence of the
> > > original hardware event.
> >
> > This is a matter of semantics and it is highly debatable.
> >
> > > A UART asserts 'data ready' which is routed to an IO interrupt line
> that
> > > wakes the device.  This is a wakeup event.
> >
> > Yes.
> >
> > > So are the bits that appear on the data line which represent the data
> > > So are the characters that appear on the serial port
> > > So is the "here is a message from the GSM processor" event
> > > So is the "there is a new TXT message" event
> > > So is the "'beep beep beep' out the speaker" event
> >
> > None of those things can cause the system to wake up after it is
> > suspended.  Indeed, they can't happen at all if the CPU isn't running
> > (unless the GSM processor runs autonomously -- let's ignore such
> > details).  Hence it makes little sense to call them "wakeup" events.
> >
>
> I think we are seeing this very differently.  In my mind these are in one
> sense all the same event, just represented in different ways.
>
> One of the reasons that we have an OS is to support levels of abstraction.
> A disk drives stores sectors, but I want to store files
> A monitor displays pixels, but I want to display text
> A network sends packets, but I want to send Email.
>
> The OS (including but not only the kernel) handles the conversion.
> It is still my Email that is going out over the network even though the
> network card has no concept of 'email'.
>
> Similarly the event of importance above in the notification that a TXT has
> arrived.
> At the lowest level, it appears as 'data-ready' on a UART.  At the highest
> level is it sound-waves in the air.  But it is the same event.  And the
> role
> of the OS is to allow me to treat it all as one event - one abstract
> concept.
>
> Obviously the involvement of the kernel ends when the event reaches or
> crosses the boundary to user-space, and user-space must be responsible for
> taking it to the boundary to meat-space.
> But the kernel needs to ensure that this holistic wake-up event can be
> handled without racing with a suspend request.
> If you just protect the lowest level representation of the event, but don't
> allow the higher level representations to be protected, then it is a bit
> like
> a filesystem that requires you to send SCSI commands to the disk drive if
> you
> want to be sure your data is safe.
>
> > > All these events are wakeup events, and should abort or instant-resume
> the
> > > system.  Currently only the first can be guaranteed to do this (... and
> maybe
> > > the second, depending on the details of the implementation).
> > > suspend-blocks effectively pass a lock from one event to the next to
> ensure
> > > that all of these event block the suspend.  There are various other
> ways to
> > > achieve the same thing, and I think it can be done with no significant
> change
> > > to the API.  But some how we need to allow all of these events to be
> > > linked wake-up events, not just the first one.
> >
> > That's not entirely clear.  Yes, for Android's use case that's what you
> > want.  But in other situations maybe you don't.  Consider the example
> > of someone who closes the lid of their laptop and throws it in a
> > backpack.  The computer should suspend immediately; it shouldn't be
> > delayed by these "virtual wakeup" events.
>
> Completely agree.  Old behaviour must remain unchanged, new behaviour must
> be
> explicitly requested.
>
> At each level, it must be explicitly stated that an event is to be treated
> like a wake-up event.  I believe that is already the case in drivers - they
> need to explicitly configure the interrupt to cause a wake-from-suspend.
>
> I've considered several possibilities for how user-space could explicitly
> say
> that events are wake-event.  My current favourite is to use fcntl(F_SETOWN)
> to request a signal be sent to the process that is initiating the suspend
> when the relevant events are ready to be consumed by user-space.
> This would work for events that come through the input system (button
> press)
> or through the network, or rtc alarm events.  I suspect all potential
> wake-events could be made to use this scheme, but I don't have an
> exhausting
> list at present.
>
> So a suspend request waits just long enough to close any race, checks if
> there are signals pending, and proceeds with the suspend if there aren't.
> The "just long enough" is a little tricky to measure, though the in-kernel
> part of suspend-blockers presumably can be used to get that right.
>
> If the suspending process hasn't requested the delivery of these signals,
> the
> suspend will possibly pause to make sure that any events-in-transit in the
> kernel have reached their in-kernel destination (milliseconds at most) and
> then proceed with the suspend as normal.
>
> So yes, there are different use cases and we should support all of them,
> both "I shut the lid and my laptop really stays asleep" and "I never miss a
> TXT because my phone went to sleep at a bad time".  The process that
> initiates the suspend has a role in choosing what can wake it up.
>
> Thanks,
> NeilBrown
>
>
> ------------------------------
>
> Message: 3
> Date: Tue, 1 Jun 2010 18:10:42 -0700
> From: Arve Hj?nnev?g <arve@android.com>
> Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
> To: James Bottomley <James.Bottomley@suse.de>
> Cc: Neil Brown <neilb@suse.de>, tytso@mit.edu,  Peter Zijlstra
>        <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
>  Florian
>        Mickler <florian@mickler.org>,  Alan Cox <alan@lxorguk.ukuu.org.uk
> >,
>        mark.gross@intel.com,   Thomas Gleixner <tglx@linutronix.de>,
> Linux OMAP
>        Mailing List <linux-omap@vger.kernel.org>,      Linux PM
>        <linux-pm@lists.linux-foundation.org>, felipe.balbi@nokia.com
> Message-ID:
>        <AANLkTikObnAZbyOxeYAhXcEbimO3XTTO-HlC9CD_HH6t@mail.gmail.com>
> Content-Type: text/plain; charset=ISO-8859-1
>
> On Tue, Jun 1, 2010 at 3:36 PM, James Bottomley <James.Bottomley@suse.de>
> wrote:
> > On Wed, 2010-06-02 at 00:24 +0200, Rafael J. Wysocki wrote:
> >> On Tuesday 01 June 2010, James Bottomley wrote:
> >> > On Tue, 2010-06-01 at 14:51 +0100, Matthew Garrett wrote:
> >> > > On Mon, May 31, 2010 at 04:21:09PM -0500, James Bottomley wrote:
> >> > >
> >> > > > You're the one mentioning x86, not me. ?I already explained that
> some
> >> > > > MSM hardware (the G1 for example) has lower power consumption in
> S3
> >> > > > (which I'm using as an ACPI shorthand for suspend to ram) than any
> >> > > > suspend from idle C state. ?The fact that current x86 hardware has
> the
> >> > > > same problem may be true, but it's not entirely relevant.
> >> > >
> >> > > As long as you can set a wakeup timer, an S state is just a C state
> with
> >> > > side effects. The significant one is that entering an S state stops
> the
> >> > > process scheduler and any in-kernel timers. I don't think Google
> care at
> >> > > all about whether suspend is entered through an explicit transition
> or
> >> > > something hooked into cpuidle - the relevant issue is that they want
> to
> >> > > be able to express a set of constraints that lets them control
> whether
> >> > > or not the scheduler keeps on scheduling, and which doesn't let them
> >> > > lose wakeup events in the process.
> >> >
> >> > Exactly, so my understanding of where we currently are is:
> >>
> >> Thanks for the recap.
> >>
> >> > ? ? ?1. pm_qos will be updated to be able to express the android
> suspend
> >> > ? ? ? ? blockers as interactivity constraints (exact name TBD, but
> >> > ? ? ? ? probably /dev/cpu_interactivity)
> >>
> >> I think that's not been decided yet precisely enough. ?I saw a few ideas
> >> here and there in the thread, but which of them are we going to follow?
> >
> > Well, android only needs two states (block and don't block), so that
> > gets translated as 2 s32 values (say 0 and INT_MAX). ?I've seen defines
> > like QOS_INTERACTIVE and QOS_NONE (or QOS_DRECKLY or QOS_MANANA) to
> > describe these, but if all we're arguing over is the define name, that's
> > progress.
>
> I think we need separate state constraints for suspend and idle low
> power modes. On the msm platform only a subset of the interrupts can
> wake up from the low power mode, so we block the use if the low power
> mode from idle while other interrupts are enabled. We do not block
> suspend however if those interrupts are not marked as wakeup
> interrupts. Most constraints that prevent suspend are not hardware
> specific and should not prevent entering low power modes from idle. In
> other words we may need to prevent low power idle modes while allowing
> suspend, and we may need to prevent suspend while allowing low power
> idle modes.
>
> It would also be good to not have an implementation that gets slower
> and slower the more clients you have. With binary constraints this is
> trivial.
>
> >
> > The other piece they need is the suspend block name, which comes with
> > the stats API, and finally we need to decide what the actual constraint
> > is called (which is how the dev node gets its name) ...
> >
> >> > ? ? ?2. pm_qos will be updated to be callable from atomic context
> >> > ? ? ?3. pm_qos will be updated to export statistics initially closely
> >> > ? ? ? ? matching what suspend blockers provides (simple update of the
> rw
> >> > ? ? ? ? interface?)
>
> 4. It would be useful to change pm_qos_add_request to not allocate
> anything so can add constraints from init functions that currently
> cannot fail.
>
> >> >
> >> > After this is done, the current android suspend block patch becomes a
> >> > re-expression in kernel space in terms of pm_qos, with the current
> >> > userspace wakelocks being adapted by the android framework into pm_qos
> >> > requirements expressed to /dev/cpu_interactivity (or whatever name is
> >> > chosen). ?Then opportunistic suspend is either a small add-on kernel
> >> > patch they have in their tree to suspend when the interactivity
> >> > constraint goes to NONE, or it could be done entirely by a userspace
> >> > process. ?Long term this could migrate to the freezer and suspend from
> >> > idle approach as the various problem timers get fixed.
> >> >
> >> > I think the big unresolved issue is the stats extension. ?For android,
> >> > we need just a name written along with the value, so we have something
> >> > to hang the stats off ... current pm_qos userspace users just write a
> >> > value, so the name would be optional. ?From the kernel, we probably
> just
> >> > need an additional API that takes a stats name or NULL if none
> >> > (pm_qos_add_request_named()?). ?Then reading the stats could be done
> by
> >> > implementing a fops read routine on the misc device.
> >>
> >> Is the original idea of having that information in debugfs
> objectionable?
> >
> > Well ... debugfs is usually used to get around the sysfs rules. ?In this
> > case, pm_qos has a dev interface ... I don't specifically object to
> > using debugfs, but I don't see any reason to forbid it from being a
> > simple dev read interface either.
> >
>
> We don't currently have a dev interface for stats so this is not an
> immediate requirement. The suspend blocker debugfs interface is just
> as good as the proc interface we have for wakelocks.
>
> --
> Arve Hj?nnev?g
>
>
> ------------------------------
>
> Message: 4
> Date: Tue, 1 Jun 2010 19:45:38 -0700
> From: mark gross <640e9920@gmail.com>
> Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
> To: James Bottomley <James.Bottomley@suse.de>
> Cc: tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>,
>        felipe.balbi@nokia.com, LKML <linux-kernel@vger.kernel.org>,
>  Florian
>        Mickler <florian@mickler.org>,  Thomas Gleixner <tglx@linutronix.de
> >,
>        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,   Linux PM
>        <linux-pm@lists.linux-foundation.org>,  Alan Cox
>        <alan@lxorguk.ukuu.org.uk>
> Message-ID: <20100602024538.GA5764@gvim.org>
> Content-Type: text/plain; charset=us-ascii
>
> On Tue, Jun 01, 2010 at 04:01:25PM -0500, James Bottomley wrote:
> > On Tue, 2010-06-01 at 14:51 +0100, Matthew Garrett wrote:
> > > On Mon, May 31, 2010 at 04:21:09PM -0500, James Bottomley wrote:
> > >
> > > > You're the one mentioning x86, not me.  I already explained that some
> > > > MSM hardware (the G1 for example) has lower power consumption in S3
> > > > (which I'm using as an ACPI shorthand for suspend to ram) than any
> > > > suspend from idle C state.  The fact that current x86 hardware has
> the
> > > > same problem may be true, but it's not entirely relevant.
> > >
> > > As long as you can set a wakeup timer, an S state is just a C state
> with
> > > side effects. The significant one is that entering an S state stops the
> > > process scheduler and any in-kernel timers. I don't think Google care
> at
> > > all about whether suspend is entered through an explicit transition or
> > > something hooked into cpuidle - the relevant issue is that they want to
> > > be able to express a set of constraints that lets them control whether
> > > or not the scheduler keeps on scheduling, and which doesn't let them
> > > lose wakeup events in the process.
> >
> > Exactly, so my understanding of where we currently are is:
> >
> >      1. pm_qos will be updated to be able to express the android suspend
> >         blockers as interactivity constraints (exact name TBD, but
> >         probably /dev/cpu_interactivity)
> >      2. pm_qos will be updated to be callable from atomic context
> >      3. pm_qos will be updated to export statistics initially closely
> >         matching what suspend blockers provides (simple update of the rw
> >         interface?)
> >
> > After this is done, the current android suspend block patch becomes a
> > re-expression in kernel space in terms of pm_qos, with the current
> > userspace wakelocks being adapted by the android framework into pm_qos
> > requirements expressed to /dev/cpu_interactivity (or whatever name is
> > chosen).  Then opportunistic suspend is either a small add-on kernel
> > patch they have in their tree to suspend when the interactivity
> > constraint goes to NONE, or it could be done entirely by a userspace
> > process.  Long term this could migrate to the freezer and suspend from
> > idle approach as the various problem timers get fixed.
>
> This is all nice but, all this does is implement the exact same thing as
> the wake lock / suspend blocker API as a pm_qos request-class.  It
> leaves the overlapping constraint issue from ISR to user mode in place
> depending on exactly how the oppertunistic suspend is implemented.
>
> I expect it will be via a notifier on the pm_qos request-class update
> that would do exactly what the wake lock code does today.  just load up
> an a "suspend_on_non_interactivity" driver that registers for the call
> back, have it enabled by the user mode PM, and you have the equivelent
> architecture as what was proposed by the wake lock patches.
>
> it gives the Android guys what they want, without adding a new
> subsystem, minimizing the changes and makes most of the architecture
> much more politicaly acceptible.
>
> But doesn't it have the same issues with getting the overlapping
> constraints right from wake up source to user mode and dealing with the
> wake up envents in a sane way?  Instead of sprinkling suspend-blockers
> about the kernel we'll sprinkle pm_qos_requests about.  I like getting
> more users of pm_qos, but isn't this the same thing?
>
> >
> > I think the big unresolved issue is the stats extension.  For android,
> > we need just a name written along with the value, so we have something
> > to hang the stats off ... current pm_qos userspace users just write a
> > value, so the name would be optional.  From the kernel, we probably just
> > need an additional API that takes a stats name or NULL if none
> > (pm_qos_add_request_named()?).  Then reading the stats could be done by
> > implementing a fops read routine on the misc device.
>
> I don't think the status would be a big deal to add.
>
>
> However; I am really burned out by this discussion.  I am willing to
> stub this out ASAP if it puts this behind us if the principles in the
> discussion are in more or less agreement.
>
> --mgross
>
> For the record, I still like my low power event idea, which could
> coexist with the above.
>
>
>
>
> ------------------------------
>
> Message: 5
> Date: Tue, 1 Jun 2010 19:51:23 -0700
> From: mark gross <640e9920@gmail.com>
> Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
> To: Florian Mickler <florian@mickler.org>
> Cc: 640e9920@gmail.com, markgross@thegnar.org,  Peter Zijlstra
>        <peterz@infradead.org>, Brian Swetland <swetland@google.com>,
> Ingo
>        Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
>  Linux PM
>        <linux-pm@lists.linux-foundation.org>,  Thomas Gleixner
>        <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
> Message-ID: <20100602025123.GB5764@gvim.org>
> Content-Type: text/plain; charset=iso-8859-1
>
> On Tue, Jun 01, 2010 at 09:07:37AM +0200, Florian Mickler wrote:
> > On Mon, 31 May 2010 16:26:17 -0700
> > mark gross <640e9920@gmail.com> wrote:
> >
> > > On Mon, May 31, 2010 at 11:38:55PM +0200, Rafael J. Wysocki wrote:
> > > > On Monday 31 May 2010, Arve Hj?nnev?g wrote:
> > > > > 2010/5/29 Alan Stern <stern@rowland.harvard.edu>:
> > > > > > On Sat, 29 May 2010, Arve Hj?nnev?g wrote:
> > > > > >
> > > > > >> > In place of in-kernel suspend blockers, there will be a new
> type of QoS
> > > > > >> > constraint -- call it QOS_EVENTUALLY.  It's a very weak
> constraint,
> > > > > >> > compatible with all cpuidle modes in which runnable threads
> are allowed
> > > > > >> > to run (which is all of them), but not compatible with
> suspend.
> > > > > >> >
> > > > > >> This sound just like another API rename. It will work, but given
> that
> > > > > >> suspend blockers was the name least objectionable last time
> around,
> > > > > >> I'm not sure what this would solve.
> > > > > >
> > > > > > It's not just a rename.  By changing this into a QoS constraint,
> we
> > > > > > make it more generally useful.  Instead of standing on its own,
> it
> > > > > > becomes part of the PM-QOS framework.
> > > > > >
> > > > >
> > > > > We cannot use the existing pm-qos framework. It is not safe to call
> > > > > from atomic context.
> > > >
> > > > We've just merged a patch that fixed that if I'm not mistaken.  Mark,
> did your
> > > > PM QoS update fix that?
> > > >
> > >
> > > I'm pretty sure it can be called in atomic context, and if its not I'm
> > > sure we can fix that.  It can be called in atomic context.  I don't
> > > think it was ever a problem to call it in atomic context.  The problem
> it
> > > had was that crappy list of string compares.  Thats been fixed.
> > >
> > > --mgross
> > >
> >
> > Well, the register call uses kzalloc. Apart from that I
> > think we're good.
>
> registering shouldn't need to be called in atomic context.  Its the
> update_request that needs to be callible form atomic context.
>
> --mgross
>
>
>
>
> ------------------------------
>
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>
> End of linux-pm Digest, Vol 69, Issue 9
> ***************************************
>

--00504502cc334a5f20048803ad15
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Is there a way to emulate a really primitive Windows software that communic=
ates via COM1 port to a device? The software is only a way to post data to =
the device.<br><br><div class=3D"gmail_quote">2010/6/1  <span dir=3D"ltr">&=
lt;<a href=3D"mailto:linux-pm-request@lists.linux-foundation.org">linux-pm-=
request@lists.linux-foundation.org</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">Send linux-pm mai=
ling list submissions to<br>
 =A0 =A0 =A0 =A0<a href=3D"mailto:linux-pm@lists.linux-foundation.org">linu=
x-pm@lists.linux-foundation.org</a><br>
<br>
To subscribe or unsubscribe via the World Wide Web, visit<br>
 =A0 =A0 =A0 =A0<a href=3D"https://lists.linux-foundation.org/mailman/listi=
nfo/linux-pm" target=3D"_blank">https://lists.linux-foundation.org/mailman/=
listinfo/linux-pm</a><br>
or, via email, send a message with subject or body &#39;help&#39; to<br>
 =A0 =A0 =A0 =A0<a href=3D"mailto:linux-pm-request@lists.linux-foundation.o=
rg">linux-pm-request@lists.linux-foundation.org</a><br>
<br>
You can reach the person managing the list at<br>
 =A0 =A0 =A0 =A0<a href=3D"mailto:linux-pm-owner@lists.linux-foundation.org=
">linux-pm-owner@lists.linux-foundation.org</a><br>
<br>
When replying, please edit your Subject line so it is more specific<br>
than &quot;Re: Contents of linux-pm digest...&quot;<br>
<br>
<br>
Today&#39;s Topics:<br>
<br>
 =A0 1. Re: [PATCH 1/2] suspend: Move NVS save/restore code to<br>
 =A0 =A0 =A0generic suspend functionality (Rafael J. Wysocki)<br>
 =A0 2. Re: [PATCH 0/8] Suspend block api (version 8) (Neil Brown)<br>
 =A0 3. Re: [PATCH 0/8] Suspend block api (version 8) (Arve Hj?nnev?g)<br>
 =A0 4. Re: [PATCH 0/8] Suspend block api (version 8) (mark gross)<br>
 =A0 5. Re: [PATCH 0/8] Suspend block api (version 8) (mark gross)<br>
<br>
<br>
----------------------------------------------------------------------<br>
<br>
Message: 1<br>
Date: Wed, 2 Jun 2010 01:34:46 +0200<br>
From: &quot;Rafael J. Wysocki&quot; &lt;<a href=3D"mailto:rjw@sisk.pl">rjw@=
sisk.pl</a>&gt;<br>
Subject: Re: [linux-pm] [PATCH 1/2] suspend: Move NVS save/restore<br>
 =A0 =A0 =A0 =A0code to generic suspend functionality<br>
To: Maxim Levitsky &lt;<a href=3D"mailto:maximlevitsky@gmail.com">maximlevi=
tsky@gmail.com</a>&gt;<br>
Cc: &quot;<a href=3D"mailto:linux-acpi@vger.kernel.org">linux-acpi@vger.ker=
nel.org</a>&quot; &lt;<a href=3D"mailto:linux-acpi@vger.kernel.org">linux-a=
cpi@vger.kernel.org</a>&gt;,<br>
 =A0 =A0 =A0 =A0linux-pm &lt;<a href=3D"mailto:linux-pm@lists.linux-foundat=
ion.org">linux-pm@lists.linux-foundation.org</a>&gt;, Matthew Garrett<br>
 =A0 =A0 =A0 =A0&lt;<a href=3D"mailto:mjg@redhat.com">mjg@redhat.com</a>&gt=
;<br>
Message-ID: &lt;<a href=3D"mailto:201006020134.46962.rjw@sisk.pl">201006020=
134.46962.rjw@sisk.pl</a>&gt;<br>
Content-Type: Text/Plain; =A0charset=3D&quot;utf-8&quot;<br>
<br>
On Wednesday 02 June 2010, Maxim Levitsky wrote:<br>
&gt; On Wed, 2010-06-02 at 00:40 +0200, Rafael J. Wysocki wrote:<br>
&gt; &gt; On Tuesday 01 June 2010, Maxim Levitsky wrote:<br>
&gt; &gt; &gt; On Tue, 2010-06-01 at 23:31 +0200, Rafael J. Wysocki wrote:<=
br>
&gt; &gt; &gt; &gt; On Tuesday 01 June 2010, Maxim Levitsky wrote:<br>
&gt; &gt; &gt; &gt; &gt; Saving platform non-volatile state may be required=
 for suspend to RAM as<br>
&gt; &gt; &gt; &gt; &gt; well as hibernation. Move it to more generic code.=
<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Signed-off-by: Matthew Garrett &lt;<a href=3D"mail=
to:mjg@redhat.com">mjg@redhat.com</a>&gt;<br>
&gt; &gt; &gt; &gt; &gt; Signed-off-by: Matthew Garrett &lt;<a href=3D"mail=
to:maximlevitsky@gmail.com">maximlevitsky@gmail.com</a>&gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; You made a mistake here.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Also, why are you resending the Matthews patches? =A0I =
think Len has seen them<br>
&gt; &gt; &gt; &gt; already.<br>
&gt; &gt; &gt; Yea, a copypaste.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; (I was told that if one submits modified patch, it adds his<=
br>
&gt; &gt; &gt; Signed-off-by.)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I rebased these on top of<br>
&gt; &gt; &gt; ACPI / EC / PM: Fix race between EC transactions and system =
suspend&#39;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; To be honest, I just want to get some feedback on this.<br>
&gt; &gt; &gt; This was major issue that kept me from using otherwise prefe=
ct suspend<br>
&gt; &gt; &gt; to ram.<br>
&gt; &gt;<br>
&gt; &gt; I think this is a change we should try, but there is a chance it =
will break<br>
&gt; &gt; some systems.<br>
&gt; I doubt that. BIOSes are tested against windows, and since it has this=
<br>
&gt; behavior, all systems this patch could break wouldn&#39;t work in wind=
ows<br>
&gt; ether.<br>
<br>
Still, some systems were broken by the saving-restoring NVS over hibernatio=
n.<br>
<br>
&gt; I was doing all kinds of attempts to fix this bug, and finally I found=
<br>
&gt; the cause for it.<br>
<br>
I know and I&#39;m not objecting to the patches. =A0I&#39;m only saying we =
should be<br>
careful with them.<br>
<br>
Rafael<br>
<br>
<br>
------------------------------<br>
<br>
Message: 2<br>
Date: Wed, 2 Jun 2010 10:43:18 +1000<br>
From: Neil Brown &lt;<a href=3D"mailto:neilb@suse.de">neilb@suse.de</a>&gt;=
<br>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)<br>
To: Alan Stern &lt;<a href=3D"mailto:stern@rowland.harvard.edu">stern@rowla=
nd.harvard.edu</a>&gt;<br>
Cc: Peter Zijlstra &lt;<a href=3D"mailto:peterz@infradead.org">peterz@infra=
dead.org</a>&gt;, LKML<br>
 =A0 =A0 =A0 =A0&lt;<a href=3D"mailto:linux-kernel@vger.kernel.org">linux-k=
ernel@vger.kernel.org</a>&gt;, Florian Mickler &lt;<a href=3D"mailto:floria=
n@mickler.org">florian@mickler.org</a>&gt;,<br>
 =A0 =A0 =A0 =A0Linux PM &lt;<a href=3D"mailto:linux-pm@lists.linux-foundat=
ion.org">linux-pm@lists.linux-foundation.org</a>&gt;, Thomas Gleixner<br>
 =A0 =A0 =A0 =A0&lt;<a href=3D"mailto:tglx@linutronix.de">tglx@linutronix.d=
e</a>&gt;, =A0 Linux OMAP Mailing List<br>
 =A0 =A0 =A0 =A0&lt;<a href=3D"mailto:linux-omap@vger.kernel.org">linux-oma=
p@vger.kernel.org</a>&gt;, =A0 Felipe Balbi &lt;<a href=3D"mailto:felipe.ba=
lbi@nokia.com">felipe.balbi@nokia.com</a>&gt;,<br>
 =A0 =A0 =A0 =A0Alan Cox &lt;<a href=3D"mailto:alan@lxorguk.ukuu.org.uk">al=
an@lxorguk.ukuu.org.uk</a>&gt;<br>
Message-ID: &lt;20100602104318.0c41b3cd@notabene.brown&gt;<br>
Content-Type: text/plain; charset=3DUS-ASCII<br>
<br>
On Tue, 1 Jun 2010 10:47:49 -0400 (EDT)<br>
Alan Stern &lt;<a href=3D"mailto:stern@rowland.harvard.edu">stern@rowland.h=
arvard.edu</a>&gt; wrote:<br>
<br>
&gt; On Tue, 1 Jun 2010, Neil Brown wrote:<br>
&gt;<br>
&gt; &gt; &gt; With wakeup events the problem isn&#39;t so bad. =A0Wakeup e=
vents are always<br>
&gt; &gt; &gt; noticed, and if the system is designed properly they will ei=
ther abort<br>
&gt; &gt; &gt; a suspend-in-progress or else cause the system to resume as =
soon as the<br>
&gt; &gt; &gt; suspend is complete. =A0(Linux is not yet properly designed =
in this<br>
&gt; &gt; &gt; sense.)<br>
&gt; &gt;<br>
&gt; &gt; This is exactly the issue. =A0Linux doesn&#39;t get this right. =
=A0A wakeup that is<br>
&gt; &gt; processed by the driver just before suspend may not get all the w=
ay out to<br>
&gt; &gt; it&#39;s final destination (possibly in meat-space) until after s=
ome other event<br>
&gt; &gt; wakes the device. =A0It is not possible to guarantee full deliver=
y of a wakeup<br>
&gt; &gt; event with Linux in its current state. =A0This is a bug.<br>
&gt;<br>
&gt; That wasn&#39;t what I meant. =A0An important requirement is that a wa=
keup<br>
&gt; event received after the device has been suspended, but before the<br>
&gt; system suspend is complete, should cause the system suspend to abort.<=
br>
&gt; This is one of the things suspend blockers were meant to help with. =
=A0In<br>
&gt; theory it should already work correctly -- but it doesn&#39;t. =A0That=
&#39;s a<br>
&gt; real bug.<br>
&gt;<br>
&gt; The other things you&#39;re talking about aren&#39;t really bugs. =A0T=
hat is,<br>
&gt; they are things which the kernel _ought_ to do but it wasn&#39;t _inte=
nded_<br>
&gt; to do. =A0They are misfeatures: failures of design, not failures of<br=
>
&gt; execution.<br>
<br>
A fairly subtle distinction, but I can accept it. =A0We are working with a<=
br>
design failure.<br>
But when a design failure results in a feature not being usable in a<br>
race-free way, I would still call that failure of design a bug - a bug in t=
he<br>
design.<br>
<br>
&gt;<br>
&gt; &gt; I don&#39;t think I&#39;m missing that. =A0Wakeup events are the =
only events of<br>
&gt; &gt; interest. =A0But wakeup events are more than just low-level hardw=
are events.<br>
&gt; &gt; They are also the virtual events that are a direct consequence of=
 the<br>
&gt; &gt; original hardware event.<br>
&gt;<br>
&gt; This is a matter of semantics and it is highly debatable.<br>
&gt;<br>
&gt; &gt; A UART asserts &#39;data ready&#39; which is routed to an IO inte=
rrupt line that<br>
&gt; &gt; wakes the device. =A0This is a wakeup event.<br>
&gt;<br>
&gt; Yes.<br>
&gt;<br>
&gt; &gt; So are the bits that appear on the data line which represent the =
data<br>
&gt; &gt; So are the characters that appear on the serial port<br>
&gt; &gt; So is the &quot;here is a message from the GSM processor&quot; ev=
ent<br>
&gt; &gt; So is the &quot;there is a new TXT message&quot; event<br>
&gt; &gt; So is the &quot;&#39;beep beep beep&#39; out the speaker&quot; ev=
ent<br>
&gt;<br>
&gt; None of those things can cause the system to wake up after it is<br>
&gt; suspended. =A0Indeed, they can&#39;t happen at all if the CPU isn&#39;=
t running<br>
&gt; (unless the GSM processor runs autonomously -- let&#39;s ignore such<b=
r>
&gt; details). =A0Hence it makes little sense to call them &quot;wakeup&quo=
t; events.<br>
&gt;<br>
<br>
I think we are seeing this very differently. =A0In my mind these are in one=
<br>
sense all the same event, just represented in different ways.<br>
<br>
One of the reasons that we have an OS is to support levels of abstraction.<=
br>
A disk drives stores sectors, but I want to store files<br>
A monitor displays pixels, but I want to display text<br>
A network sends packets, but I want to send Email.<br>
<br>
The OS (including but not only the kernel) handles the conversion.<br>
It is still my Email that is going out over the network even though the<br>
network card has no concept of &#39;email&#39;.<br>
<br>
Similarly the event of importance above in the notification that a TXT has<=
br>
arrived.<br>
At the lowest level, it appears as &#39;data-ready&#39; on a UART. =A0At th=
e highest<br>
level is it sound-waves in the air. =A0But it is the same event. =A0And the=
 role<br>
of the OS is to allow me to treat it all as one event - one abstract concep=
t.<br>
<br>
Obviously the involvement of the kernel ends when the event reaches or<br>
crosses the boundary to user-space, and user-space must be responsible for<=
br>
taking it to the boundary to meat-space.<br>
But the kernel needs to ensure that this holistic wake-up event can be<br>
handled without racing with a suspend request.<br>
If you just protect the lowest level representation of the event, but don&#=
39;t<br>
allow the higher level representations to be protected, then it is a bit li=
ke<br>
a filesystem that requires you to send SCSI commands to the disk drive if y=
ou<br>
want to be sure your data is safe.<br>
<br>
&gt; &gt; All these events are wakeup events, and should abort or instant-r=
esume the<br>
&gt; &gt; system. =A0Currently only the first can be guaranteed to do this =
(... and maybe<br>
&gt; &gt; the second, depending on the details of the implementation).<br>
&gt; &gt; suspend-blocks effectively pass a lock from one event to the next=
 to ensure<br>
&gt; &gt; that all of these event block the suspend. =A0There are various o=
ther ways to<br>
&gt; &gt; achieve the same thing, and I think it can be done with no signif=
icant change<br>
&gt; &gt; to the API. =A0But some how we need to allow all of these events =
to be<br>
&gt; &gt; linked wake-up events, not just the first one.<br>
&gt;<br>
&gt; That&#39;s not entirely clear. =A0Yes, for Android&#39;s use case that=
&#39;s what you<br>
&gt; want. =A0But in other situations maybe you don&#39;t. =A0Consider the =
example<br>
&gt; of someone who closes the lid of their laptop and throws it in a<br>
&gt; backpack. =A0The computer should suspend immediately; it shouldn&#39;t=
 be<br>
&gt; delayed by these &quot;virtual wakeup&quot; events.<br>
<br>
Completely agree. =A0Old behaviour must remain unchanged, new behaviour mus=
t be<br>
explicitly requested.<br>
<br>
At each level, it must be explicitly stated that an event is to be treated<=
br>
like a wake-up event. =A0I believe that is already the case in drivers - th=
ey<br>
need to explicitly configure the interrupt to cause a wake-from-suspend.<br=
>
<br>
I&#39;ve considered several possibilities for how user-space could explicit=
ly say<br>
that events are wake-event. =A0My current favourite is to use fcntl(F_SETOW=
N)<br>
to request a signal be sent to the process that is initiating the suspend<b=
r>
when the relevant events are ready to be consumed by user-space.<br>
This would work for events that come through the input system (button press=
)<br>
or through the network, or rtc alarm events. =A0I suspect all potential<br>
wake-events could be made to use this scheme, but I don&#39;t have an exhau=
sting<br>
list at present.<br>
<br>
So a suspend request waits just long enough to close any race, checks if<br=
>
there are signals pending, and proceeds with the suspend if there aren&#39;=
t.<br>
The &quot;just long enough&quot; is a little tricky to measure, though the =
in-kernel<br>
part of suspend-blockers presumably can be used to get that right.<br>
<br>
If the suspending process hasn&#39;t requested the delivery of these signal=
s, the<br>
suspend will possibly pause to make sure that any events-in-transit in the<=
br>
kernel have reached their in-kernel destination (milliseconds at most) and<=
br>
then proceed with the suspend as normal.<br>
<br>
So yes, there are different use cases and we should support all of them,<br=
>
both &quot;I shut the lid and my laptop really stays asleep&quot; and &quot=
;I never miss a<br>
TXT because my phone went to sleep at a bad time&quot;. =A0The process that=
<br>
initiates the suspend has a role in choosing what can wake it up.<br>
<br>
Thanks,<br>
NeilBrown<br>
<br>
<br>
------------------------------<br>
<br>
Message: 3<br>
Date: Tue, 1 Jun 2010 18:10:42 -0700<br>
From: Arve Hj?nnev?g &lt;<a href=3D"mailto:arve@android.com">arve@android.c=
om</a>&gt;<br>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)<br>
To: James Bottomley &lt;<a href=3D"mailto:James.Bottomley@suse.de">James.Bo=
ttomley@suse.de</a>&gt;<br>
Cc: Neil Brown &lt;<a href=3D"mailto:neilb@suse.de">neilb@suse.de</a>&gt;, =
<a href=3D"mailto:tytso@mit.edu">tytso@mit.edu</a>, =A0Peter Zijlstra<br>
 =A0 =A0 =A0 =A0&lt;<a href=3D"mailto:peterz@infradead.org">peterz@infradea=
d.org</a>&gt;, LKML &lt;<a href=3D"mailto:linux-kernel@vger.kernel.org">lin=
ux-kernel@vger.kernel.org</a>&gt;, =A0 =A0Florian<br>
 =A0 =A0 =A0 =A0Mickler &lt;<a href=3D"mailto:florian@mickler.org">florian@=
mickler.org</a>&gt;, =A0Alan Cox &lt;<a href=3D"mailto:alan@lxorguk.ukuu.or=
g.uk">alan@lxorguk.ukuu.org.uk</a>&gt;,<br>
 =A0 =A0 =A0 =A0<a href=3D"mailto:mark.gross@intel.com">mark.gross@intel.co=
m</a>, =A0 Thomas Gleixner &lt;<a href=3D"mailto:tglx@linutronix.de">tglx@l=
inutronix.de</a>&gt;, =A0 Linux OMAP<br>
 =A0 =A0 =A0 =A0Mailing List &lt;<a href=3D"mailto:linux-omap@vger.kernel.o=
rg">linux-omap@vger.kernel.org</a>&gt;, =A0 =A0 =A0Linux PM<br>
 =A0 =A0 =A0 =A0&lt;<a href=3D"mailto:linux-pm@lists.linux-foundation.org">=
linux-pm@lists.linux-foundation.org</a>&gt;, <a href=3D"mailto:felipe.balbi=
@nokia.com">felipe.balbi@nokia.com</a><br>
Message-ID:<br>
 =A0 =A0 =A0 =A0&lt;<a href=3D"mailto:AANLkTikObnAZbyOxeYAhXcEbimO3XTTO-HlC=
9CD_HH6t@mail.gmail.com">AANLkTikObnAZbyOxeYAhXcEbimO3XTTO-HlC9CD_HH6t@mail=
.gmail.com</a>&gt;<br>
Content-Type: text/plain; charset=3DISO-8859-1<br>
<br>
On Tue, Jun 1, 2010 at 3:36 PM, James Bottomley &lt;<a href=3D"mailto:James=
.Bottomley@suse.de">James.Bottomley@suse.de</a>&gt; wrote:<br>
&gt; On Wed, 2010-06-02 at 00:24 +0200, Rafael J. Wysocki wrote:<br>
&gt;&gt; On Tuesday 01 June 2010, James Bottomley wrote:<br>
&gt;&gt; &gt; On Tue, 2010-06-01 at 14:51 +0100, Matthew Garrett wrote:<br>
&gt;&gt; &gt; &gt; On Mon, May 31, 2010 at 04:21:09PM -0500, James Bottomle=
y wrote:<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; &gt; You&#39;re the one mentioning x86, not me. ?I alrea=
dy explained that some<br>
&gt;&gt; &gt; &gt; &gt; MSM hardware (the G1 for example) has lower power c=
onsumption in S3<br>
&gt;&gt; &gt; &gt; &gt; (which I&#39;m using as an ACPI shorthand for suspe=
nd to ram) than any<br>
&gt;&gt; &gt; &gt; &gt; suspend from idle C state. ?The fact that current x=
86 hardware has the<br>
&gt;&gt; &gt; &gt; &gt; same problem may be true, but it&#39;s not entirely=
 relevant.<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; As long as you can set a wakeup timer, an S state is jus=
t a C state with<br>
&gt;&gt; &gt; &gt; side effects. The significant one is that entering an S =
state stops the<br>
&gt;&gt; &gt; &gt; process scheduler and any in-kernel timers. I don&#39;t =
think Google care at<br>
&gt;&gt; &gt; &gt; all about whether suspend is entered through an explicit=
 transition or<br>
&gt;&gt; &gt; &gt; something hooked into cpuidle - the relevant issue is th=
at they want to<br>
&gt;&gt; &gt; &gt; be able to express a set of constraints that lets them c=
ontrol whether<br>
&gt;&gt; &gt; &gt; or not the scheduler keeps on scheduling, and which does=
n&#39;t let them<br>
&gt;&gt; &gt; &gt; lose wakeup events in the process.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Exactly, so my understanding of where we currently are is:<br=
>
&gt;&gt;<br>
&gt;&gt; Thanks for the recap.<br>
&gt;&gt;<br>
&gt;&gt; &gt; ? ? ?1. pm_qos will be updated to be able to express the andr=
oid suspend<br>
&gt;&gt; &gt; ? ? ? ? blockers as interactivity constraints (exact name TBD=
, but<br>
&gt;&gt; &gt; ? ? ? ? probably /dev/cpu_interactivity)<br>
&gt;&gt;<br>
&gt;&gt; I think that&#39;s not been decided yet precisely enough. ?I saw a=
 few ideas<br>
&gt;&gt; here and there in the thread, but which of them are we going to fo=
llow?<br>
&gt;<br>
&gt; Well, android only needs two states (block and don&#39;t block), so th=
at<br>
&gt; gets translated as 2 s32 values (say 0 and INT_MAX). ?I&#39;ve seen de=
fines<br>
&gt; like QOS_INTERACTIVE and QOS_NONE (or QOS_DRECKLY or QOS_MANANA) to<br=
>
&gt; describe these, but if all we&#39;re arguing over is the define name, =
that&#39;s<br>
&gt; progress.<br>
<br>
I think we need separate state constraints for suspend and idle low<br>
power modes. On the msm platform only a subset of the interrupts can<br>
wake up from the low power mode, so we block the use if the low power<br>
mode from idle while other interrupts are enabled. We do not block<br>
suspend however if those interrupts are not marked as wakeup<br>
interrupts. Most constraints that prevent suspend are not hardware<br>
specific and should not prevent entering low power modes from idle. In<br>
other words we may need to prevent low power idle modes while allowing<br>
suspend, and we may need to prevent suspend while allowing low power<br>
idle modes.<br>
<br>
It would also be good to not have an implementation that gets slower<br>
and slower the more clients you have. With binary constraints this is<br>
trivial.<br>
<br>
&gt;<br>
&gt; The other piece they need is the suspend block name, which comes with<=
br>
&gt; the stats API, and finally we need to decide what the actual constrain=
t<br>
&gt; is called (which is how the dev node gets its name) ...<br>
&gt;<br>
&gt;&gt; &gt; ? ? ?2. pm_qos will be updated to be callable from atomic con=
text<br>
&gt;&gt; &gt; ? ? ?3. pm_qos will be updated to export statistics initially=
 closely<br>
&gt;&gt; &gt; ? ? ? ? matching what suspend blockers provides (simple updat=
e of the rw<br>
&gt;&gt; &gt; ? ? ? ? interface?)<br>
<br>
4. It would be useful to change pm_qos_add_request to not allocate<br>
anything so can add constraints from init functions that currently<br>
cannot fail.<br>
<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; After this is done, the current android suspend block patch b=
ecomes a<br>
&gt;&gt; &gt; re-expression in kernel space in terms of pm_qos, with the cu=
rrent<br>
&gt;&gt; &gt; userspace wakelocks being adapted by the android framework in=
to pm_qos<br>
&gt;&gt; &gt; requirements expressed to /dev/cpu_interactivity (or whatever=
 name is<br>
&gt;&gt; &gt; chosen). ?Then opportunistic suspend is either a small add-on=
 kernel<br>
&gt;&gt; &gt; patch they have in their tree to suspend when the interactivi=
ty<br>
&gt;&gt; &gt; constraint goes to NONE, or it could be done entirely by a us=
erspace<br>
&gt;&gt; &gt; process. ?Long term this could migrate to the freezer and sus=
pend from<br>
&gt;&gt; &gt; idle approach as the various problem timers get fixed.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I think the big unresolved issue is the stats extension. ?For=
 android,<br>
&gt;&gt; &gt; we need just a name written along with the value, so we have =
something<br>
&gt;&gt; &gt; to hang the stats off ... current pm_qos userspace users just=
 write a<br>
&gt;&gt; &gt; value, so the name would be optional. ?From the kernel, we pr=
obably just<br>
&gt;&gt; &gt; need an additional API that takes a stats name or NULL if non=
e<br>
&gt;&gt; &gt; (pm_qos_add_request_named()?). ?Then reading the stats could =
be done by<br>
&gt;&gt; &gt; implementing a fops read routine on the misc device.<br>
&gt;&gt;<br>
&gt;&gt; Is the original idea of having that information in debugfs objecti=
onable?<br>
&gt;<br>
&gt; Well ... debugfs is usually used to get around the sysfs rules. ?In th=
is<br>
&gt; case, pm_qos has a dev interface ... I don&#39;t specifically object t=
o<br>
&gt; using debugfs, but I don&#39;t see any reason to forbid it from being =
a<br>
&gt; simple dev read interface either.<br>
&gt;<br>
<br>
We don&#39;t currently have a dev interface for stats so this is not an<br>
immediate requirement. The suspend blocker debugfs interface is just<br>
as good as the proc interface we have for wakelocks.<br>
<br>
--<br>
Arve Hj?nnev?g<br>
<br>
<br>
------------------------------<br>
<br>
Message: 4<br>
Date: Tue, 1 Jun 2010 19:45:38 -0700<br>
From: mark gross &lt;<a href=3D"mailto:640e9920@gmail.com">640e9920@gmail.c=
om</a>&gt;<br>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)<br>
To: James Bottomley &lt;<a href=3D"mailto:James.Bottomley@suse.de">James.Bo=
ttomley@suse.de</a>&gt;<br>
Cc: <a href=3D"mailto:tytso@mit.edu">tytso@mit.edu</a>, Peter Zijlstra &lt;=
<a href=3D"mailto:peterz@infradead.org">peterz@infradead.org</a>&gt;,<br>
 =A0 =A0 =A0 =A0<a href=3D"mailto:felipe.balbi@nokia.com">felipe.balbi@noki=
a.com</a>, LKML &lt;<a href=3D"mailto:linux-kernel@vger.kernel.org">linux-k=
ernel@vger.kernel.org</a>&gt;, =A0 =A0Florian<br>
 =A0 =A0 =A0 =A0Mickler &lt;<a href=3D"mailto:florian@mickler.org">florian@=
mickler.org</a>&gt;, =A0Thomas Gleixner &lt;<a href=3D"mailto:tglx@linutron=
ix.de">tglx@linutronix.de</a>&gt;,<br>
 =A0 =A0 =A0 =A0Linux OMAP Mailing List &lt;<a href=3D"mailto:linux-omap@vg=
er.kernel.org">linux-omap@vger.kernel.org</a>&gt;, =A0 Linux PM<br>
 =A0 =A0 =A0 =A0&lt;<a href=3D"mailto:linux-pm@lists.linux-foundation.org">=
linux-pm@lists.linux-foundation.org</a>&gt;, =A0Alan Cox<br>
 =A0 =A0 =A0 =A0&lt;<a href=3D"mailto:alan@lxorguk.ukuu.org.uk">alan@lxorgu=
k.ukuu.org.uk</a>&gt;<br>
Message-ID: &lt;<a href=3D"mailto:20100602024538.GA5764@gvim.org">201006020=
24538.GA5764@gvim.org</a>&gt;<br>
Content-Type: text/plain; charset=3Dus-ascii<br>
<br>
On Tue, Jun 01, 2010 at 04:01:25PM -0500, James Bottomley wrote:<br>
&gt; On Tue, 2010-06-01 at 14:51 +0100, Matthew Garrett wrote:<br>
&gt; &gt; On Mon, May 31, 2010 at 04:21:09PM -0500, James Bottomley wrote:<=
br>
&gt; &gt;<br>
&gt; &gt; &gt; You&#39;re the one mentioning x86, not me. =A0I already expl=
ained that some<br>
&gt; &gt; &gt; MSM hardware (the G1 for example) has lower power consumptio=
n in S3<br>
&gt; &gt; &gt; (which I&#39;m using as an ACPI shorthand for suspend to ram=
) than any<br>
&gt; &gt; &gt; suspend from idle C state. =A0The fact that current x86 hard=
ware has the<br>
&gt; &gt; &gt; same problem may be true, but it&#39;s not entirely relevant=
.<br>
&gt; &gt;<br>
&gt; &gt; As long as you can set a wakeup timer, an S state is just a C sta=
te with<br>
&gt; &gt; side effects. The significant one is that entering an S state sto=
ps the<br>
&gt; &gt; process scheduler and any in-kernel timers. I don&#39;t think Goo=
gle care at<br>
&gt; &gt; all about whether suspend is entered through an explicit transiti=
on or<br>
&gt; &gt; something hooked into cpuidle - the relevant issue is that they w=
ant to<br>
&gt; &gt; be able to express a set of constraints that lets them control wh=
ether<br>
&gt; &gt; or not the scheduler keeps on scheduling, and which doesn&#39;t l=
et them<br>
&gt; &gt; lose wakeup events in the process.<br>
&gt;<br>
&gt; Exactly, so my understanding of where we currently are is:<br>
&gt;<br>
&gt; =A0 =A0 =A01. pm_qos will be updated to be able to express the android=
 suspend<br>
&gt; =A0 =A0 =A0 =A0 blockers as interactivity constraints (exact name TBD,=
 but<br>
&gt; =A0 =A0 =A0 =A0 probably /dev/cpu_interactivity)<br>
&gt; =A0 =A0 =A02. pm_qos will be updated to be callable from atomic contex=
t<br>
&gt; =A0 =A0 =A03. pm_qos will be updated to export statistics initially cl=
osely<br>
&gt; =A0 =A0 =A0 =A0 matching what suspend blockers provides (simple update=
 of the rw<br>
&gt; =A0 =A0 =A0 =A0 interface?)<br>
&gt;<br>
&gt; After this is done, the current android suspend block patch becomes a<=
br>
&gt; re-expression in kernel space in terms of pm_qos, with the current<br>
&gt; userspace wakelocks being adapted by the android framework into pm_qos=
<br>
&gt; requirements expressed to /dev/cpu_interactivity (or whatever name is<=
br>
&gt; chosen). =A0Then opportunistic suspend is either a small add-on kernel=
<br>
&gt; patch they have in their tree to suspend when the interactivity<br>
&gt; constraint goes to NONE, or it could be done entirely by a userspace<b=
r>
&gt; process. =A0Long term this could migrate to the freezer and suspend fr=
om<br>
&gt; idle approach as the various problem timers get fixed.<br>
<br>
This is all nice but, all this does is implement the exact same thing as<br=
>
the wake lock / suspend blocker API as a pm_qos request-class. =A0It<br>
leaves the overlapping constraint issue from ISR to user mode in place<br>
depending on exactly how the oppertunistic suspend is implemented.<br>
<br>
I expect it will be via a notifier on the pm_qos request-class update<br>
that would do exactly what the wake lock code does today. =A0just load up<b=
r>
an a &quot;suspend_on_non_interactivity&quot; driver that registers for the=
 call<br>
back, have it enabled by the user mode PM, and you have the equivelent<br>
architecture as what was proposed by the wake lock patches.<br>
<br>
it gives the Android guys what they want, without adding a new<br>
subsystem, minimizing the changes and makes most of the architecture<br>
much more politicaly acceptible.<br>
<br>
But doesn&#39;t it have the same issues with getting the overlapping<br>
constraints right from wake up source to user mode and dealing with the<br>
wake up envents in a sane way? =A0Instead of sprinkling suspend-blockers<br=
>
about the kernel we&#39;ll sprinkle pm_qos_requests about. =A0I like gettin=
g<br>
more users of pm_qos, but isn&#39;t this the same thing?<br>
<br>
&gt;<br>
&gt; I think the big unresolved issue is the stats extension. =A0For androi=
d,<br>
&gt; we need just a name written along with the value, so we have something=
<br>
&gt; to hang the stats off ... current pm_qos userspace users just write a<=
br>
&gt; value, so the name would be optional. =A0From the kernel, we probably =
just<br>
&gt; need an additional API that takes a stats name or NULL if none<br>
&gt; (pm_qos_add_request_named()?). =A0Then reading the stats could be done=
 by<br>
&gt; implementing a fops read routine on the misc device.<br>
<br>
I don&#39;t think the status would be a big deal to add.<br>
<br>
<br>
However; I am really burned out by this discussion. =A0I am willing to<br>
stub this out ASAP if it puts this behind us if the principles in the<br>
discussion are in more or less agreement.<br>
<br>
--mgross<br>
<br>
For the record, I still like my low power event idea, which could<br>
coexist with the above.<br>
<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 5<br>
Date: Tue, 1 Jun 2010 19:51:23 -0700<br>
From: mark gross &lt;<a href=3D"mailto:640e9920@gmail.com">640e9920@gmail.c=
om</a>&gt;<br>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)<br>
To: Florian Mickler &lt;<a href=3D"mailto:florian@mickler.org">florian@mick=
ler.org</a>&gt;<br>
Cc: <a href=3D"mailto:640e9920@gmail.com">640e9920@gmail.com</a>, <a href=
=3D"mailto:markgross@thegnar.org">markgross@thegnar.org</a>, =A0Peter Zijls=
tra<br>
 =A0 =A0 =A0 =A0&lt;<a href=3D"mailto:peterz@infradead.org">peterz@infradea=
d.org</a>&gt;, Brian Swetland &lt;<a href=3D"mailto:swetland@google.com">sw=
etland@google.com</a>&gt;, =A0 Ingo<br>
 =A0 =A0 =A0 =A0Molnar &lt;<a href=3D"mailto:mingo@elte.hu">mingo@elte.hu</=
a>&gt;, LKML &lt;<a href=3D"mailto:linux-kernel@vger.kernel.org">linux-kern=
el@vger.kernel.org</a>&gt;, =A0 =A0Linux PM<br>
 =A0 =A0 =A0 =A0&lt;<a href=3D"mailto:linux-pm@lists.linux-foundation.org">=
linux-pm@lists.linux-foundation.org</a>&gt;, =A0Thomas Gleixner<br>
 =A0 =A0 =A0 =A0&lt;<a href=3D"mailto:tglx@linutronix.de">tglx@linutronix.d=
e</a>&gt;, Alan Cox &lt;<a href=3D"mailto:alan@lxorguk.ukuu.org.uk">alan@lx=
orguk.ukuu.org.uk</a>&gt;<br>
Message-ID: &lt;<a href=3D"mailto:20100602025123.GB5764@gvim.org">201006020=
25123.GB5764@gvim.org</a>&gt;<br>
Content-Type: text/plain; charset=3Diso-8859-1<br>
<br>
On Tue, Jun 01, 2010 at 09:07:37AM +0200, Florian Mickler wrote:<br>
&gt; On Mon, 31 May 2010 16:26:17 -0700<br>
&gt; mark gross &lt;<a href=3D"mailto:640e9920@gmail.com">640e9920@gmail.co=
m</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; On Mon, May 31, 2010 at 11:38:55PM +0200, Rafael J. Wysocki wrote=
:<br>
&gt; &gt; &gt; On Monday 31 May 2010, Arve Hj?nnev?g wrote:<br>
&gt; &gt; &gt; &gt; 2010/5/29 Alan Stern &lt;<a href=3D"mailto:stern@rowlan=
d.harvard.edu">stern@rowland.harvard.edu</a>&gt;:<br>
&gt; &gt; &gt; &gt; &gt; On Sat, 29 May 2010, Arve Hj?nnev?g wrote:<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;&gt; &gt; In place of in-kernel suspend blockers, t=
here will be a new type of QoS<br>
&gt; &gt; &gt; &gt; &gt;&gt; &gt; constraint -- call it QOS_EVENTUALLY. =A0=
It&#39;s a very weak constraint,<br>
&gt; &gt; &gt; &gt; &gt;&gt; &gt; compatible with all cpuidle modes in whic=
h runnable threads are allowed<br>
&gt; &gt; &gt; &gt; &gt;&gt; &gt; to run (which is all of them), but not co=
mpatible with suspend.<br>
&gt; &gt; &gt; &gt; &gt;&gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;&gt; This sound just like another API rename. It wi=
ll work, but given that<br>
&gt; &gt; &gt; &gt; &gt;&gt; suspend blockers was the name least objectiona=
ble last time around,<br>
&gt; &gt; &gt; &gt; &gt;&gt; I&#39;m not sure what this would solve.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; It&#39;s not just a rename. =A0By changing this in=
to a QoS constraint, we<br>
&gt; &gt; &gt; &gt; &gt; make it more generally useful. =A0Instead of stand=
ing on its own, it<br>
&gt; &gt; &gt; &gt; &gt; becomes part of the PM-QOS framework.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; We cannot use the existing pm-qos framework. It is not =
safe to call<br>
&gt; &gt; &gt; &gt; from atomic context.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; We&#39;ve just merged a patch that fixed that if I&#39;m not=
 mistaken. =A0Mark, did your<br>
&gt; &gt; &gt; PM QoS update fix that?<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; I&#39;m pretty sure it can be called in atomic context, and if it=
s not I&#39;m<br>
&gt; &gt; sure we can fix that. =A0It can be called in atomic context. =A0I=
 don&#39;t<br>
&gt; &gt; think it was ever a problem to call it in atomic context. =A0The =
problem it<br>
&gt; &gt; had was that crappy list of string compares. =A0Thats been fixed.=
<br>
&gt; &gt;<br>
&gt; &gt; --mgross<br>
&gt; &gt;<br>
&gt;<br>
&gt; Well, the register call uses kzalloc. Apart from that I<br>
&gt; think we&#39;re good.<br>
<br>
registering shouldn&#39;t need to be called in atomic context. =A0Its the<b=
r>
update_request that needs to be callible form atomic context.<br>
<br>
--mgross<br>
<br>
<br>
<br>
<br>
------------------------------<br>
<br>
_______________________________________________<br>
linux-pm mailing list<br>
<a href=3D"mailto:linux-pm@lists.linux-foundation.org">linux-pm@lists.linux=
-foundation.org</a><br>
<a href=3D"https://lists.linux-foundation.org/mailman/listinfo/linux-pm" ta=
rget=3D"_blank">https://lists.linux-foundation.org/mailman/listinfo/linux-p=
m</a><br>
<br>
End of linux-pm Digest, Vol 69, Issue 9<br>
***************************************<br>
</blockquote></div><br>

--00504502cc334a5f20048803ad15--

--===============8483703595358268847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8483703595358268847==--
