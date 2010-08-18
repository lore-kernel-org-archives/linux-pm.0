From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Wakeup-events implementation
Date: Wed, 18 Aug 2010 11:20:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1008181032020.1671-100000@iolanthe.rowland.org>
References: <AANLkTinNHR0ZkzrtD6xuR5fCrY2FBc7apUUAw1tc58pZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinNHR0ZkzrtD6xuR5fCrY2FBc7apUUAw1tc58pZ@mail.gmail.com>
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

On Tue, 17 Aug 2010, Arve Hj=F8nnev=E5g wrote:

> We don't uncover all bugs during testing before we ship. For instance
> the bug could be triggered by a 3db party app, and there is value in
> making the system as robust as possible to both driver and user space
> bugs.

By that argument, all in-kernel wakelocks should always have a timeout.

What happens if somebody puts down their phone and then puts something =

on top of it, in such a way that one of the keypad buttons is =

depressed?  If the keypad driver's wakelock doesn't have a timeout then =

the battery would drain quickly.

> >> > Wakeup events that don't reach user space should not need user space
> >> > support to reenter suspend.
> >>
> >> That's debatable. =A0For example, consider a Wake-On-LAN magic packet.
> >> It generally doesn't go anywhere -- it gets dropped once the system is
> >> awake.
> >
> > Yes. =A0I think every event that would wake up a sleeping system should=
 result
> > in unfreezing user space.

In fact they do -- there's almost no way to avoid it.  However, =

unfreezing userspace is different from sending a wakeup event to =

userspace.

The question is whether the kernel should automatically try to
re-suspend following a wakeup for which no information was sent to
userspace (e.g., WOL).  The alternative, of course, is that the kernel
does not try to re-suspend until a power-manager program tells it to.  =

To me this seems more flexible and general (the PM program can always =

start a new suspend, whereas there's no way to prevent an automatic =

in-kernel re-suspend).

> >> Let's say the interrupt handlers responsible for invoking
> >> pm_request_resume use non-nesting calls. =A0This may happen several
> >> times, depending on the wakeup and interrupt delivery mechanism, but
> >> the end result is that the counter is incremented only once. =A0When t=
he
> >> pm_runtime_resume call ends, pm_relax does a single decrement.
> >>
> >> Meanwhile, the driver uses nesting calls. =A0It can increment the coun=
ter
> >> as much as it wants, and it has to perform an equal number of
> >> decrements. =A0The key point is that pm_request_resume never gets call=
ed
> >> while the driver has any outstanding pm_stay_awake requests. =A0Hence =
the
> >> non-nesting calls never got "lost", since the first one is always made
> >> while the counter is 0.
> >>
> =

> It sounds as if you are saying that the two drivers don't interfere
> because one of them always gets there first. In your example if
> another interrupt occurs before the second driver still has released
> all its references on the counter, the interrupt will (incorrectly)
> not increment the count.

That's right -- one of them always gets there first.  You're also right
to suspect that this is an unusual situation.  It arises with USB root
hubs because a root hub is the only child of its parent controller
device, and the only reason a controller would generate a wakeup
request is because the root hub needs to wake up.

This means that a root-hub wakeup can be signalled in two different =

ways:

	If the controller is in low-power then the controller sends its
	wakeup request.  The controller's driver sets the controller
	back to full power, sees that the root hub has needs attention,
	and calls pm_request_resume for the root hub.

	If the controller isn't in low-power then the root hub simply
	generates an IRQ.  The interrupt handler calls =

	pm_request_resume for the root hub.

Depending on how the timing works out, both can occur: The controller
gets set to full power and then the IRQ line is signalled before the PM
workqueue gets around to resuming the root hub.  I have seen this
happen while testing my computer.

With a little care, I could avoid calling pm_stay_awake twice.  The =

code already sets a bitflag before queuing the resume request, and I =

could use test_and_set_bit instead.  If I did then the non-nesting =

calls wouldn't be needed at all.  And that was the only case I could
think of where the two types of calls might need to be mixed.

> > I actually like the idea of having two levels of calls, ie. pm_stay_awa=
ke(dev)
> > calling something like __pm_stay_awake(handle), where the handle is rea=
d from
> > struct dev_pm_info. =A0And analogously for pm_relax().
> >
> > Then, the object associated with the handle might be created when the d=
evice
> > is enabled to wake up and destroyed when it's disabled to do that.
> >
> =

> When multiple drivers use the same device, who creates and destroys the h=
andle?

The primary driver (i.e., the one bound to the device) would use the
device's handle.  Other drivers would create and use their own separate
wakeup structures.

But if all the calls are of the "nesting" sort then there's not really
any need for multiple structures, other than to help identify which
driver is misbehaving when a problem occurs.

> Typically a driver puts a wakelock in the state that it already
> allocates for each device, so you have a handle for each device/driver
> combo that needs to block suspend.

You didn't answer my question about which devices have more than one =

associated wakelock in Android.  Those would be the only cases where =

the device/driver combo matters.

Also, why does Android's MMC core have its own wakelock instead of
using a per-device wakelock?

> >> Allocating these wakeup structures for all possible wakeup sources
> >> would be a big waste.
> >
> > Indeed.
> >
> >> On the other hand, a driver generally doesn't
> >> know until a suspend starts whether or not its devices should be
> >> enabled for wakeup.
> =

> Why? How is the driver notified on suspend that it needs to be enabled
> for wakeup.

The driver's (or bus subsystem's) suspend routine calls
device_may_wakeup(dev) to see whether it should enable dev's wakeup
mechanism.  The value returned by device_may_wakeup can change at
almost any time, since it is set by userspace.

> >>=A0That makes things difficult, especially if you
> >> contemplate having multiple structures for each device. =A0Have you
> >> really sat down and thought about what wakelocks would be needed on a
> >> general system such as a desktop or laptop machine?
> =

> No, I don't know what wakelocks are needed on a general system, but
> you need code to turn the wakeup events on and off events anyway, so I
> assume allocating a handle for the wakeup event is possible.

Yes.  However system suspend is generally not a good time to go around =

allocating new structures; memory tends to be tight then.  I suppose =

it might be acceptable to do this during the "prepare" phase of system =

suspend.

Alan Stern
