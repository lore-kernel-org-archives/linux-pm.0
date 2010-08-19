From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: Wakeup-events implementation
Date: Thu, 19 Aug 2010 16:12:14 -0700
Message-ID: <AANLkTi=AA+LMjo+M+funMd51JY1AGSW9=Lo-rrYu07Eg@mail.gmail.com>
References: <AANLkTi=iUMa468S_UZqvUZ5vjEy_pG7RT6Y7TtWnsYPX@mail.gmail.com>
	<Pine.LNX.4.44L0.1008191640470.1680-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1008191640470.1680-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

2010/8/19 Alan Stern <stern@rowland.harvard.edu>:
> On Wed, 18 Aug 2010, Arve Hj=F8nnev=E5g wrote:
>
>> >> By that argument, all in-kernel wakelocks should always have a timeou=
t.
>> >>
>> I don't think that is the only conclusion.
>>
>> >> What happens if somebody puts down their phone and then puts something
>> >> on top of it, in such a way that one of the keypad buttons is
>> >> depressed? =A0If the keypad driver's wakelock doesn't have a timeout =
then
>> >> the battery would drain quickly.
>>
>> This is a real problem that might be worth solving, but just adding a
>> wakelock timeout does not solve it since the keyboard driver would
>> either renew the timeout after every scan, or it would leave the
>> keyboard in a state where you could not use it to wake up the device
>> anymore.
>
> Okay. =A0Nevertheless, you maintain debugging info in case a driver bug
> causes a wakelock not to be released. =A0If the wakelocks all had
> timeouts then a bug of that sort wouldn't be able to affect battery
> life very much. =A0So why not add the timeouts?
>

Because we can't. I just described how the keypad driver would break
we just add a timeout to its wakelock. Other drivers, like the usb
gadget driver may need to block suspend for an extended time period.

> Or conversely, if you think the likelihood of such bugs is too low to
> worry about, then why have the debugging info?
>

That statement assumes all the bugs can be fixed by adding timeouts,
which I don't think is true. Also, you don't need to have bugs for the
stats to be useful. The gps could for instance prevent suspend for a
long time because the user ran a gps tracking app.

>> >> The question is whether the kernel should automatically try to
>> >> re-suspend following a wakeup for which no information was sent to
>> >> userspace (e.g., WOL). =A0The alternative, of course, is that the ker=
nel
>> >> does not try to re-suspend until a power-manager program tells it to.
>> >> To me this seems more flexible and general (the PM program can always
>> >> start a new suspend, whereas there's no way to prevent an automatic
>> >> in-kernel re-suspend).
>> >
>> > I agree.
>> >
>>
>> Having user space initiate every suspend operation is more flexible
>> out of the box, but you can get the same flexibility with the other
>> approach by adding an interface to report all wakeup events and failed
>> suspend attempts. However, I have not seen a use case for this
>> flexibility other than as a partial workaround for wakeup events that
>> user space needs to know about but are not reported to user space any
>> other way (it is only a partial workaround since it still has the same
>> race condition we are fixing for other wakeup events).
>
> In any case, this is something that could easily be changed with a
> small Android-specific kernel patch. =A0At the moment it doesn't seem to
> be a major issue.
>

Yes, that seems to be a likely outcome.

>> >> > When multiple drivers use the same device, who creates and destroys=
 the handle?
>> >>
>> >> The primary driver (i.e., the one bound to the device) would use the
>> >> device's handle. =A0Other drivers would create and use their own sepa=
rate
>> >> wakeup structures.
>> >>
>> >> But if all the calls are of the "nesting" sort then there's not really
>> >> any need for multiple structures, other than to help identify which
>> >> driver is misbehaving when a problem occurs.
>> >
>> > Still, IMO we can do that if it would help to narrow the gap between t=
he
>> > Android kernel and the mainline.
>> >
>>
>> Some android drivers currently need the calls to be not nested so that
>> they can mix timeouts and pm_relax. With only nesting apis we cannot
>> get the same functionality.
>>
>> Other drivers rely on the non nesting property of the existing
>> wakelock api but do not use timeouts. I expect these drivers can be
>> converted have the same behavior with a nested api, but there could be
>> difficult edge cases.
>>
>> Non-android driver may need a nested api so they can use a handle that
>> they did not allocate. It is not clear to me if this is really needed.
>> If it is not needed we can make all the calls non nested and require
>> that the driver allocates a handle (or more commonly put the handle in
>> the private data it already allocates). If we do need to keep the
>> nested behavior, we a way to select which variant to use. We can have
>> separate calls that nest and require drivers that use the non-nested
>> variant have their own handle, or we could set a flag when creating a
>> handle that makes calls on that handle not nest.
>
> I agree, there are several possible designs. =A0It's hard to tell which
> will be best without more experience.
>
> How much degradation do you think you would observe if in-kernel
> wakelocks _always_ used timeouts alone and _never_ were cancelled?
>

I don't think that is an option. We have kernel wakelocks that need to
be held while the device is in a specific state.

>> >> You didn't answer my question about which devices have more than one
>> >> associated wakelock in Android. =A0Those would be the only cases where
>> >> the device/driver combo matters.
>> >>
>>
>> Wakelocks are not associated with devices at all right now, so I don't
>> have a list for you. However, the input queues need more than one
>> wakelock per device if they use timeouts. In this case there is only
>> one driver though, but the driver allocates a separate queue for each
>> client that opens a device. Our keypad/gpio-keys driver may also end
>> up using multiple wakelocks. Many phones use different keys types in
>> the same logical keyboard, so you could end up with one wakelock for
>> the matrix scan and another one for debouncing keys connected directly
>> to a gpio. The driver could be changed to share a nested handle, but I
>> prefer to keep them separate.
>
> Okay. =A0In addition, we've already seen that devices for which you
> haven't yet implemented any wakelocks may end up needing more than one.
>
>> >> Also, why does Android's MMC core have its own wakelock instead of
>> >> using a per-device wakelock?
>> >>
>>
>> There is a global work queue.
>
> So you want to be able to cancel the wakelock whenever the queue is
> empty, right? =A0And not have to keep track of whether each MMC device
> has any work items in the queue.
>

I have not reviewed that code, so I don't know the details of how it
works or even if it is correct, but I see that it uses both timeouts
and wake_unlock calls on the same wakelock.

> In theory this is insufficient -- it doesn't handle the case where one
> MMC device is enabled for wakeup and another isn't. =A0I assume you don't
> really care about this (especially since Android phones aren't likely
> to have more than one MMC device capable of generating wakeup events).
>

I'm not sure what you mean by insufficient here. If it not optimal if
you also have work that does not need to prevent suspend, but it
should still work correctly.

>> >> The driver's (or bus subsystem's) suspend routine calls
>> >> device_may_wakeup(dev) to see whether it should enable dev's wakeup
>> >> mechanism. =A0The value returned by device_may_wakeup can change at
>> >> almost any time, since it is set by userspace.
>> >>
>>
>> It would be better to allocate the structure when user space changes
>> the setting. If you wait until suspend before blocking suspend you may
>> have passed the event on already.
>
> That will work for the structure directly associated with the device.
> Additional structures allocated by the drivers have to be handled
> differently, because the drivers aren't notified when the wakeup-enable
> setting is changed.
>

I'm not convinced that is it sufficient to detect that a device is
wakeup-enabled on suspend. However it is not a problem I have tried to
solve since we have only used static wakeup sources.


-- =

Arve Hj=F8nnev=E5g
