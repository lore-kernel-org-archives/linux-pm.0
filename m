From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: Wakeup-events implementation
Date: Wed, 18 Aug 2010 17:18:58 -0700
Message-ID: <AANLkTi=iUMa468S_UZqvUZ5vjEy_pG7RT6Y7TtWnsYPX@mail.gmail.com>
References: <Pine.LNX.4.44L0.1008181032020.1671-100000@iolanthe.rowland.org>
	<201008182117.19220.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008182117.19220.rjw@sisk.pl>
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

2010/8/18 Rafael J. Wysocki <rjw@sisk.pl>:
> On Wednesday, August 18, 2010, Alan Stern wrote:
>> On Tue, 17 Aug 2010, Arve Hj=F8nnev=E5g wrote:
>>
>> > We don't uncover all bugs during testing before we ship. For instance
>> > the bug could be triggered by a 3db party app, and there is value in
>> > making the system as robust as possible to both driver and user space
>> > bugs.
>>
>> By that argument, all in-kernel wakelocks should always have a timeout.
>>
I don't think that is the only conclusion.

>> What happens if somebody puts down their phone and then puts something
>> on top of it, in such a way that one of the keypad buttons is
>> depressed? =A0If the keypad driver's wakelock doesn't have a timeout then
>> the battery would drain quickly.

This is a real problem that might be worth solving, but just adding a
wakelock timeout does not solve it since the keyboard driver would
either renew the timeout after every scan, or it would leave the
keyboard in a state where you could not use it to wake up the device
anymore.

>>
>> > >> > Wakeup events that don't reach user space should not need user sp=
ace
>> > >> > support to reenter suspend.
>> > >>
>> > >> That's debatable. =A0For example, consider a Wake-On-LAN magic pack=
et.
>> > >> It generally doesn't go anywhere -- it gets dropped once the system=
 is
>> > >> awake.
>> > >
>> > > Yes. =A0I think every event that would wake up a sleeping system sho=
uld result
>> > > in unfreezing user space.
>>
>> In fact they do -- there's almost no way to avoid it. =A0However,
>> unfreezing userspace is different from sending a wakeup event to
>> userspace.
>>
>> The question is whether the kernel should automatically try to
>> re-suspend following a wakeup for which no information was sent to
>> userspace (e.g., WOL). =A0The alternative, of course, is that the kernel
>> does not try to re-suspend until a power-manager program tells it to.
>> To me this seems more flexible and general (the PM program can always
>> start a new suspend, whereas there's no way to prevent an automatic
>> in-kernel re-suspend).
>
> I agree.
>

Having user space initiate every suspend operation is more flexible
out of the box, but you can get the same flexibility with the other
approach by adding an interface to report all wakeup events and failed
suspend attempts. However, I have not seen a use case for this
flexibility other than as a partial workaround for wakeup events that
user space needs to know about but are not reported to user space any
other way (it is only a partial workaround since it still has the same
race condition we are fixing for other wakeup events).

>> > >> Let's say the interrupt handlers responsible for invoking
>> > >> pm_request_resume use non-nesting calls. =A0This may happen several
>> > >> times, depending on the wakeup and interrupt delivery mechanism, but
>> > >> the end result is that the counter is incremented only once. =A0Whe=
n the
>> > >> pm_runtime_resume call ends, pm_relax does a single decrement.
>> > >>
>> > >> Meanwhile, the driver uses nesting calls. =A0It can increment the c=
ounter
>> > >> as much as it wants, and it has to perform an equal number of
>> > >> decrements. =A0The key point is that pm_request_resume never gets c=
alled
>> > >> while the driver has any outstanding pm_stay_awake requests. =A0Hen=
ce the
>> > >> non-nesting calls never got "lost", since the first one is always m=
ade
>> > >> while the counter is 0.
>> > >>
>> >
>> > It sounds as if you are saying that the two drivers don't interfere
>> > because one of them always gets there first. In your example if
>> > another interrupt occurs before the second driver still has released
>> > all its references on the counter, the interrupt will (incorrectly)
>> > not increment the count.
>>
>> That's right -- one of them always gets there first. =A0You're also right
>> to suspect that this is an unusual situation. =A0It arises with USB root
>> hubs because a root hub is the only child of its parent controller
>> device, and the only reason a controller would generate a wakeup
>> request is because the root hub needs to wake up.
>>
>> This means that a root-hub wakeup can be signalled in two different
>> ways:
>>
>> =A0 =A0 =A0 If the controller is in low-power then the controller sends =
its
>> =A0 =A0 =A0 wakeup request. =A0The controller's driver sets the controll=
er
>> =A0 =A0 =A0 back to full power, sees that the root hub has needs attenti=
on,
>> =A0 =A0 =A0 and calls pm_request_resume for the root hub.
>>
>> =A0 =A0 =A0 If the controller isn't in low-power then the root hub simply
>> =A0 =A0 =A0 generates an IRQ. =A0The interrupt handler calls
>> =A0 =A0 =A0 pm_request_resume for the root hub.
>>
>> Depending on how the timing works out, both can occur: The controller
>> gets set to full power and then the IRQ line is signalled before the PM
>> workqueue gets around to resuming the root hub. =A0I have seen this
>> happen while testing my computer.
>>
>> With a little care, I could avoid calling pm_stay_awake twice. =A0The
>> code already sets a bitflag before queuing the resume request, and I
>> could use test_and_set_bit instead. =A0If I did then the non-nesting
>> calls wouldn't be needed at all. =A0And that was the only case I could
>> think of where the two types of calls might need to be mixed.
>
> That means one corner case less to worry about, good. :-)
>
>> > > I actually like the idea of having two levels of calls, ie. pm_stay_=
awake(dev)
>> > > calling something like __pm_stay_awake(handle), where the handle is =
read from
>> > > struct dev_pm_info. =A0And analogously for pm_relax().
>> > >
>> > > Then, the object associated with the handle might be created when th=
e device
>> > > is enabled to wake up and destroyed when it's disabled to do that.
>> > >
>> >
>> > When multiple drivers use the same device, who creates and destroys th=
e handle?
>>
>> The primary driver (i.e., the one bound to the device) would use the
>> device's handle. =A0Other drivers would create and use their own separate
>> wakeup structures.
>>
>> But if all the calls are of the "nesting" sort then there's not really
>> any need for multiple structures, other than to help identify which
>> driver is misbehaving when a problem occurs.
>
> Still, IMO we can do that if it would help to narrow the gap between the
> Android kernel and the mainline.
>

Some android drivers currently need the calls to be not nested so that
they can mix timeouts and pm_relax. With only nesting apis we cannot
get the same functionality.

Other drivers rely on the non nesting property of the existing
wakelock api but do not use timeouts. I expect these drivers can be
converted have the same behavior with a nested api, but there could be
difficult edge cases.

Non-android driver may need a nested api so they can use a handle that
they did not allocate. It is not clear to me if this is really needed.
If it is not needed we can make all the calls non nested and require
that the driver allocates a handle (or more commonly put the handle in
the private data it already allocates). If we do need to keep the
nested behavior, we a way to select which variant to use. We can have
separate calls that nest and require drivers that use the non-nested
variant have their own handle, or we could set a flag when creating a
handle that makes calls on that handle not nest.

>> > Typically a driver puts a wakelock in the state that it already
>> > allocates for each device, so you have a handle for each device/driver
>> > combo that needs to block suspend.
>>
>> You didn't answer my question about which devices have more than one
>> associated wakelock in Android. =A0Those would be the only cases where
>> the device/driver combo matters.
>>

Wakelocks are not associated with devices at all right now, so I don't
have a list for you. However, the input queues need more than one
wakelock per device if they use timeouts. In this case there is only
one driver though, but the driver allocates a separate queue for each
client that opens a device. Our keypad/gpio-keys driver may also end
up using multiple wakelocks. Many phones use different keys types in
the same logical keyboard, so you could end up with one wakelock for
the matrix scan and another one for debouncing keys connected directly
to a gpio. The driver could be changed to share a nested handle, but I
prefer to keep them separate.

>> Also, why does Android's MMC core have its own wakelock instead of
>> using a per-device wakelock?
>>

There is a global work queue.

>> > >> Allocating these wakeup structures for all possible wakeup sources
>> > >> would be a big waste.
>> > >
>> > > Indeed.
>> > >
>> > >> On the other hand, a driver generally doesn't
>> > >> know until a suspend starts whether or not its devices should be
>> > >> enabled for wakeup.
>> >
>> > Why? How is the driver notified on suspend that it needs to be enabled
>> > for wakeup.
>>
>> The driver's (or bus subsystem's) suspend routine calls
>> device_may_wakeup(dev) to see whether it should enable dev's wakeup
>> mechanism. =A0The value returned by device_may_wakeup can change at
>> almost any time, since it is set by userspace.
>>

It would be better to allocate the structure when user space changes
the setting. If you wait until suspend before blocking suspend you may
have passed the event on already.

>> > >> That makes things difficult, especially if you
>> > >> contemplate having multiple structures for each device. =A0Have you
>> > >> really sat down and thought about what wakelocks would be needed on=
 a
>> > >> general system such as a desktop or laptop machine?
>> >
>> > No, I don't know what wakelocks are needed on a general system, but
>> > you need code to turn the wakeup events on and off events anyway, so I
>> > assume allocating a handle for the wakeup event is possible.
>>
>> Yes. =A0However system suspend is generally not a good time to go around
>> allocating new structures; memory tends to be tight then.
>

I mean the code that lets user space turn wakeup events on and off,
not the driver transferring a wakeup source from an interrupt to a
wakeup controller.

> Well, that's what I wanted to do originally in pm_stay_awake(), but you
> convinced me it was avoidable. :-)
>
>> I suppose it might be acceptable to do this during the "prepare" phase of
>> system suspend.
>
> I generally think it would make sense to allocate a structure, call it st=
ruct
> wakeup_source for now, for each device or whatever part of the system tha=
t we
> want to treat as a wakeup source and put all of the statistics in there.
>
> For devices it would be pretty straightforward, the structure is allocate=
d as
> soon as the device is enabled to wakeup and freed when it is disabled. =
=A0In the
> other cases it would have to depend on the usage scenario, I guess.
>
> Rafael
>



-- =

Arve Hj=F8nnev=E5g
