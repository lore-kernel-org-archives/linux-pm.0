From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Wakeup-events implementation
Date: Thu, 19 Aug 2010 17:09:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1008191640470.1680-100000@iolanthe.rowland.org>
References: <AANLkTi=iUMa468S_UZqvUZ5vjEy_pG7RT6Y7TtWnsYPX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=iUMa468S_UZqvUZ5vjEy_pG7RT6Y7TtWnsYPX@mail.gmail.com>
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

On Wed, 18 Aug 2010, Arve Hj=F8nnev=E5g wrote:

> >> By that argument, all in-kernel wakelocks should always have a timeout.
> >>
> I don't think that is the only conclusion.
> =

> >> What happens if somebody puts down their phone and then puts something
> >> on top of it, in such a way that one of the keypad buttons is
> >> depressed? =A0If the keypad driver's wakelock doesn't have a timeout t=
hen
> >> the battery would drain quickly.
> =

> This is a real problem that might be worth solving, but just adding a
> wakelock timeout does not solve it since the keyboard driver would
> either renew the timeout after every scan, or it would leave the
> keyboard in a state where you could not use it to wake up the device
> anymore.

Okay.  Nevertheless, you maintain debugging info in case a driver bug
causes a wakelock not to be released.  If the wakelocks all had
timeouts then a bug of that sort wouldn't be able to affect battery
life very much.  So why not add the timeouts?

Or conversely, if you think the likelihood of such bugs is too low to =

worry about, then why have the debugging info?

> >> The question is whether the kernel should automatically try to
> >> re-suspend following a wakeup for which no information was sent to
> >> userspace (e.g., WOL). =A0The alternative, of course, is that the kern=
el
> >> does not try to re-suspend until a power-manager program tells it to.
> >> To me this seems more flexible and general (the PM program can always
> >> start a new suspend, whereas there's no way to prevent an automatic
> >> in-kernel re-suspend).
> >
> > I agree.
> >
> =

> Having user space initiate every suspend operation is more flexible
> out of the box, but you can get the same flexibility with the other
> approach by adding an interface to report all wakeup events and failed
> suspend attempts. However, I have not seen a use case for this
> flexibility other than as a partial workaround for wakeup events that
> user space needs to know about but are not reported to user space any
> other way (it is only a partial workaround since it still has the same
> race condition we are fixing for other wakeup events).

In any case, this is something that could easily be changed with a
small Android-specific kernel patch.  At the moment it doesn't seem to =

be a major issue.

> >> > When multiple drivers use the same device, who creates and destroys =
the handle?
> >>
> >> The primary driver (i.e., the one bound to the device) would use the
> >> device's handle. =A0Other drivers would create and use their own separ=
ate
> >> wakeup structures.
> >>
> >> But if all the calls are of the "nesting" sort then there's not really
> >> any need for multiple structures, other than to help identify which
> >> driver is misbehaving when a problem occurs.
> >
> > Still, IMO we can do that if it would help to narrow the gap between the
> > Android kernel and the mainline.
> >
> =

> Some android drivers currently need the calls to be not nested so that
> they can mix timeouts and pm_relax. With only nesting apis we cannot
> get the same functionality.
> =

> Other drivers rely on the non nesting property of the existing
> wakelock api but do not use timeouts. I expect these drivers can be
> converted have the same behavior with a nested api, but there could be
> difficult edge cases.
> =

> Non-android driver may need a nested api so they can use a handle that
> they did not allocate. It is not clear to me if this is really needed.
> If it is not needed we can make all the calls non nested and require
> that the driver allocates a handle (or more commonly put the handle in
> the private data it already allocates). If we do need to keep the
> nested behavior, we a way to select which variant to use. We can have
> separate calls that nest and require drivers that use the non-nested
> variant have their own handle, or we could set a flag when creating a
> handle that makes calls on that handle not nest.

I agree, there are several possible designs.  It's hard to tell which =

will be best without more experience.

How much degradation do you think you would observe if in-kernel
wakelocks _always_ used timeouts alone and _never_ were cancelled?

> >> You didn't answer my question about which devices have more than one
> >> associated wakelock in Android. =A0Those would be the only cases where
> >> the device/driver combo matters.
> >>
> =

> Wakelocks are not associated with devices at all right now, so I don't
> have a list for you. However, the input queues need more than one
> wakelock per device if they use timeouts. In this case there is only
> one driver though, but the driver allocates a separate queue for each
> client that opens a device. Our keypad/gpio-keys driver may also end
> up using multiple wakelocks. Many phones use different keys types in
> the same logical keyboard, so you could end up with one wakelock for
> the matrix scan and another one for debouncing keys connected directly
> to a gpio. The driver could be changed to share a nested handle, but I
> prefer to keep them separate.

Okay.  In addition, we've already seen that devices for which you
haven't yet implemented any wakelocks may end up needing more than one.

> >> Also, why does Android's MMC core have its own wakelock instead of
> >> using a per-device wakelock?
> >>
> =

> There is a global work queue.

So you want to be able to cancel the wakelock whenever the queue is
empty, right?  And not have to keep track of whether each MMC device
has any work items in the queue.

In theory this is insufficient -- it doesn't handle the case where one =

MMC device is enabled for wakeup and another isn't.  I assume you don't =

really care about this (especially since Android phones aren't likely =

to have more than one MMC device capable of generating wakeup events).

> >> The driver's (or bus subsystem's) suspend routine calls
> >> device_may_wakeup(dev) to see whether it should enable dev's wakeup
> >> mechanism. =A0The value returned by device_may_wakeup can change at
> >> almost any time, since it is set by userspace.
> >>
> =

> It would be better to allocate the structure when user space changes
> the setting. If you wait until suspend before blocking suspend you may
> have passed the event on already.

That will work for the structure directly associated with the device.  =

Additional structures allocated by the drivers have to be handled
differently, because the drivers aren't notified when the wakeup-enable
setting is changed.

Alan Stern
