From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Wakeup-events implementation
Date: Tue, 17 Aug 2010 11:53:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1008171109030.1656-100000@iolanthe.rowland.org>
References: <AANLkTikqWLShBVVB9-wCngO2ajrrgt-Nkmt_Bmys7b7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikqWLShBVVB9-wCngO2ajrrgt-Nkmt_Bmys7b7w@mail.gmail.com>
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

On Mon, 16 Aug 2010, Arve Hj=F8nnev=E5g wrote:

> >> A name is still useful if we allocate multiple handles per device (see
> >> below for why one handle per device is not enough).
> >
> > Are the input queues are the only place where this is needed?
> >
> =

> I don't know if it is the only place that is using more than one
> wakelock with a timeout per device. There are other drivers that use
> more than one wakelock, but it is possible they could use a single
> nested lock instead (with some detail loss in the the stats). I'm not
> sure every wakelock can be associated with a device though. For
> instance the mmc core wakelock does not have a corresponding device.

What other drivers need more than one wakelock per device?

For that matter, why does the MMC core need wakelocks at all?  I wasn't
aware that memory cards could generate wakeup events.

> > We'll figure out the best approach. =A0You mentioned that when the
> > timeouts and pm_relax do get mixed, the timeout value is around 1 or 2
> > seconds. =A0For these cases, would it be so terrible just to use the
> > timeout alone and forget about pm_relax?
> >
> =

> The timeout used when mixing timeouts and wake_unlock are generally
> longer than when only using only timeouts since the timeouts are used
> to cover edge cases were wake_unlock did not get called. Allowing
> timeouts and pm_relax to be mixed may allow a gradual path from using
> timeouts to block suspend only when needed (timeouts only -> timeouts
> for edge cases -> no timeouts).

In fact, I rather expected you would say that the combined
cancellations/timeouts were useful for pinpointing applications that
don't read their input events quickly enough.  If the wakelocks were
always allowed to time out instead of being cancelled when the data was
read, you wouldn't be able to tell whether the data was read in a
timely manner or not.

> We have also had bugs, where sensors generate input events whenever
> the system is not suspended. The 5 second timeout we have on input
> events is not short enough to allow the system to suspend at all in
> this case.

This sounds like the sort of bug that would be found very quickly and =

easily if you didn't have active cancellation.  It would be pretty =

obvious when the system didn't suspend at all.

> I see the kernel as trying to suspend if user space asked it to
> suspend (until it user space asks the kernel to stop suspending).
> Wakeup events that don't reach user space should not need user space
> support to reenter suspend.

That's debatable.  For example, consider a Wake-On-LAN magic packet.  =

It generally doesn't go anywhere -- it gets dropped once the system is =

awake.

> You want each suspend attempt to be initiated by user space. Suspend
> is initiated from user space in both cases, the difference is that you
> want the suspend request to be one-shot, which means that the kernel
> may cancel the user space suspend request, where I want user space to
> explicitly cancel the request.

Yes, that's a fair way to describe the situation.

> > Do you have any examples where two subsystems use the same device but
> > with differing expectations? =A0In the examples I can think of, the
> > non-nesting call is used only when a wakeup request is received (which
> > happens only when the device is at low power), so the nesting calls
> > can't interfere.
> >
> =

> The wakeup request need to block suspend until the driver has seen the
> event. If the driver and the wakeup code uses the same handle how can
> you avoid interference?

Let's say the interrupt handlers responsible for invoking
pm_request_resume use non-nesting calls.  This may happen several
times, depending on the wakeup and interrupt delivery mechanism, but
the end result is that the counter is incremented only once.  When the
pm_runtime_resume call ends, pm_relax does a single decrement.

Meanwhile, the driver uses nesting calls.  It can increment the counter
as much as it wants, and it has to perform an equal number of
decrements.  The key point is that pm_request_resume never gets called
while the driver has any outstanding pm_stay_awake requests.  Hence the =

non-nesting calls never got "lost", since the first one is always made =

while the counter is 0.

> > We may end up attaching these wakeup structures not just to devices but
> > also to input queues (or other kernel->userspace communication
> > channels).
> >
> =

> That is we do now (with wakelocks), but I think we need to pass this
> handle to the pm_stay_wake... calls, and not the device, for this to
> work.

You may be right.  Or we may need additional calls taking the handle as
an argument rather than the device.  The design requirements are still
simmering in my mind, and I'm waiting to hear what Rafael thinks.

> > Here's an example where nested pm_stay_awake calls are needed.
> > Suppose a USB root hub is enabled for wakeup (in other words, plugging
> > or unplugging a USB device into the computer should wake the system
> > up). =A0Suppose the root hub is at low power (autosuspended) when a
> > wakeup event occurs. =A0The interrupt handler calls pm_stay_awake and
> > indirectly invokes the USB runtime-resume routine. =A0This routine
> > brings the root hub back to full power, informs the hub driver, and
> > then calls pm_relax.
> >
> > But the hub driver carries out its main work in a separate kernel
> > thread (i.e., khubd). =A0So the hub_resume routine has to call
> > pm_stay_awake, and then khubd calls pm_relax when it is finished
> > processing the root hub's event. =A0Thus we end up with:
> >
> > =A0 =A0 =A0 =A0usb_runtime_resume: =A0 =A0 call pm_stay_awake (1)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0call hub=
_resume
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hub_resume: =A0 =A0 =A0 =A0 =A0 =A0 call=
 pm_stay_awake (2)
> > =A0 =A0 =A0 =A0usb_runtime_resume: =A0 =A0 call pm_relax (balances 1)
> > =A0 =A0 =A0 =A0khubd: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0call pm_relax =
(balances 2)
> >
> > As you can see, this won't work right if the pm wakeup calls aren't
> > cumulative. =A0("Nested" isn't quite the right word.) =A0The system wou=
ld
> > be allowed to sleep before khubd could process the root hub's wakeup
> > event.
> >
> =

> Too me this is an example of where two handles are needed, not where
> nesting is needed. Yes, you can use a single nested handle here, but
> the stats will not tell you which driver blocked suspend if there is a
> problem.

It sounds like you're suggesting that handles should be allocated =

per-driver rather than per-device.  That would tell you which driver =

blocked suspend, but not which device.

This raises a few other questions.

With Android-based handsets, you're in a setting where you have a
pretty good idea of what all the wakeup sources are and how they might
get used.  On a general system this isn't so.  Many devices are
potential wakeup sources, even though only a few of them end up getting
enabled.  In the example above, I said "Suppose a USB root hub is
enabled for wakeup".  But usually people won't want to do this; they
don't want their suspended laptops to wake up when a USB mouse is
unplugged or plugged in.

Allocating these wakeup structures for all possible wakeup sources
would be a big waste.  On the other hand, a driver generally doesn't
know until a suspend starts whether or not its devices should be
enabled for wakeup.  That makes things difficult, especially if you
contemplate having multiple structures for each device.  Have you
really sat down and thought about what wakelocks would be needed on a
general system such as a desktop or laptop machine?

Also, I frankly have to wonder why you demand such a large amount of
detailed debugging about the kernel's wakeup/wakelock subsystem (as
opposed to userspace wakelocks).  Yes, it's clear that if something
goes wrong then you will drain your phone's battery in a few hours
rather than a few days.  But what if something goes wrong with the VM
subsystem, or the RF subsystem, or the keypad driver?  The device would
crash immediately or at best become almost totally unusable.  These are
much worse scenarios than losing some battery life -- have you added
comparable quantities of debugging to those other parts of the kernel?

In addition, you retain all these debugging facilities in your
production builds, not just in the debug kernels.  Doesn't this seem
excessive?

Alan Stern
