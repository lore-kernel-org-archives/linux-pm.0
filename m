From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Wakeup-events implementation
Date: Mon, 16 Aug 2010 15:22:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1008161428400.1688-100000@iolanthe.rowland.org>
References: <AANLkTin43EBo-v0dxGitqtCCU1K8W+mRzwG+oE94orXi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTin43EBo-v0dxGitqtCCU1K8W+mRzwG+oE94orXi@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 13 Aug 2010, Arve Hj=F8nnev=E5g wrote:

> > Rafael and I spent some time discussing all this during LinuxCon.
> > Combining what he thought with my own ideas led us to decide that the
> > wakeup information should be stored in a separate structure, not in
> > dev_pm_info. =A0These structures will be allocated dynamically when a
> > device is enabled for remote wakeup (and presumably deallocated if a
> > device is disabled for remote wakeup). =A0A pointer to the new structure
> > will be stored in dev_pm_info. =A0We expect that most devices won't need
> > a wakeup structure, because most devices aren't wakeup sources.
> >
> > This new structure (as yet unnamed) will be a lot like your
> > suspend_blocker structure, but with some differences. =A0It won't need a
> > name, since the device already has a name.
> =

> A name is still useful if we allocate multiple handles per device (see
> below for why one handle per device is not enough).

Are the input queues are the only place where this is needed?

And BTW, I'm puzzled with regard to something you wrote earlier:

> > ... I can see how relying on devices alone
> > wouldn't give enough information.  There could be two separate programs
> > both reading input events, and you wouldn't know which one was
> > responsible for failing to drain its queue.
> >
> We don't know which one now either since we don't give them unique
> names, but we know that one of them is not reading (and it is usually
> not the normal input path).

If you don't keep track of the input queues by name, why do you need a
separate wakeup structure for each queue?

> >=A0It won't have a timer, if
> > we can get away with leaving one out.
> =

> The suspend_blocker structure does not have a timer, it has a timeout.
> This was intentional, since it avoids unnecessary timers from firing
> but it also means it takes a lot less space than the stats. We do need
> the timeout in the structure to support some of our drivers since they
> mix wake_lock_timeout and wake_unlock.

A timeout is okay.

> > The device argument will become mandatory for pm_stay_awake, pm_relax,
> > and pm_wakeup_event, so that the counter fields can be updated
> > properly.
> >
> I think this is a step in the right direction, but it is not enough to
> support mixing timeouts and pm_relax in all the drivers.

We'll figure out the best approach.  You mentioned that when the
timeouts and pm_relax do get mixed, the timeout value is around 1 or 2
seconds.  For these cases, would it be so terrible just to use the
timeout alone and forget about pm_relax?

> Maintaining an out of mainline driver to export allow user space to
> block suspend seems like a more appealing solution than adding another
> process for everyone to depend on. Having a user space interface to
> block suspend in the mainline kernel would still be valuable, though.
> Like I mentioned in another message, this would allow some low level
> services, like the user-space battery monitor some devices have, to
> not be android specific.

Adding out-of-mainline drivers is of course always possible.  As for
your second point, I guess it's a matter of perspective.  You see the
kernel as always trying to suspend, with userspace needing to do
something special to keep it awake.  Rafael and I see it as userspace
occasionally asking the kernel to suspend, and the kernel delaying or
aborting if a wakeup event occurs.  This is because we believe that
suspends should be initiated by userspace, not by the kernel.  From our
point of view there doesn't have to be a user interface to block
suspends; you only need a way for one part of userspace to tell another
to stop requesting a suspend.

This could become non-Android-specific as well, if people decide on =

some standard way for system management programs to decide when the =

system should go to sleep.

> > In the end, the best answer may be to keep a count of pending wakeup
> > events in the new wakeup structure (as well as a global count of the
> > number of devices whose pending count is > 0). =A0Then pm_stay_awake
> > would increment the count, pm_relax would decrement it, and there could
> > be a variant of pm_stay_awake that would increment the count only if it
> > was currently equal to 0.
> >
> =

> If I correctly understand what you are suggesting, that does not work.
> If two subsystems use the same device an one of them expects the
> pm_stay_awake call to be nested and the other one does not, then the
> subsystem that uses the non-nested api is not preventing suspend if
> the other subsystem was preventing suspend when it called
> pm_stay_awake_if_not_zero (the non-nested pm_relax variant would cause
> similar problems).

Do you have any examples where two subsystems use the same device but
with differing expectations?  In the examples I can think of, the
non-nesting call is used only when a wakeup request is received (which
happens only when the device is at low power), so the nesting calls
can't interfere.

> Also, to support all our existing drivers we need
> multiple handles per device. For each input device we have a wakelock
> with a timeout per client. We only allow suspend when all the clients
> have emptied their queue or had their wakelock timeout.

We may end up attaching these wakeup structures not just to devices but
also to input queues (or other kernel->userspace communication
channels).

> > Bugs in the kernel can be tracked down and fixed.
> >
> =

> Yes, bugs can be fixed, but not all bugs are discovered quickly and
> products ship before some bugs are fixed. For instance, when applying
> our patch that holds a wakelock when the input queue is not empty to
> this weeks kernel, I noticed that someone had fixed a bug where a
> queue overflow could leave the queue empty. If you hit this bug with
> the wakelock with timeout implementation that we currently use, then
> it would cause suspend to be blocked for 5 seconds (less if another
> event occurred or the file descriptor was closed). With the patch that
> uses a suspend blocker without a timeout, it would block suspend until
> another event from the same device occurred or user space closes the
> device. With a nesting api like the current pm_stay_awake/pm_relax, it
> will prevent suspend forever (unless another driver has the opposite
> bug).
> =

> Do we need the nested api for something? We need a non-nested api to
> mix timeouts and pm_relax, and unless we need the nested variants, it
> is easier to just make all the calls non-nesting.

Here's an example where nested pm_stay_awake calls are needed.  =

Suppose a USB root hub is enabled for wakeup (in other words, plugging
or unplugging a USB device into the computer should wake the system
up).  Suppose the root hub is at low power (autosuspended) when a
wakeup event occurs.  The interrupt handler calls pm_stay_awake and
indirectly invokes the USB runtime-resume routine.  This routine
brings the root hub back to full power, informs the hub driver, and
then calls pm_relax.

But the hub driver carries out its main work in a separate kernel
thread (i.e., khubd).  So the hub_resume routine has to call
pm_stay_awake, and then khubd calls pm_relax when it is finished
processing the root hub's event.  Thus we end up with:

	usb_runtime_resume:	call pm_stay_awake (1)
				call hub_resume
		hub_resume:		call pm_stay_awake (2)
	usb_runtime_resume:	call pm_relax (balances 1)
	khubd:			call pm_relax (balances 2)

As you can see, this won't work right if the pm wakeup calls aren't
cumulative.  ("Nested" isn't quite the right word.)  The system would
be allowed to sleep before khubd could process the root hub's wakeup
event.

Alan Stern
