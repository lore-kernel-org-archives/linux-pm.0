From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH] PM / Runtime: Allow to inactivate devices during
 system suspend
Date: Mon, 18 Nov 2013 14:27:00 +0100
Message-ID: <CAPDyKFrushEwW7x_VguPjOnP8BuSO=+tD=DxS9J0JQVfYTgOYA@mail.gmail.com>
References: <CAPDyKFrQfwOQsOCB1QFo4GWeX303AEWnanE61svy9UUJpNBUiw@mail.gmail.com>
	<Pine.LNX.4.44L0.1311151006280.1527-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1311151006280.1527-100000@iolanthe.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PCI <linux-pci@vger.kernel.org>, linux-usb@vger.kernel.org, Kevin Hilman <khilman@linaro.org>
List-Id: linux-pm@vger.kernel.org

> In any case, although Bj=F8rn made a good point about latency, the ma=
in
> reason for having the sysfs interface was to cope with buggy devices.
> Linux started using runtime PM before Windows did.  At that time, man=
y
> devices did not support runtime suspend very well -- they didn't have
> to since Windows didn't use it.  Plenty of devices simply couldn't
> handle it.  Too many for a blacklist.
>
> So we pushed the decision about whether to enable runtime PM out to
> userspace.  There was no other choice; too many people were having to=
o
> many problems when runtime PM was automatically on.
>
>> What would make sense to me, is to move the runtime PM sysfs to
>> debugfs, because it is a good feature to make use of during
>> development and debugging.
>
> But since it is primarily needed for device control by the user, it
> belongs in sysfs.
>

Got it! Thanks for giving me the history to better understand why the
sysfs exists.

<snip>

>> >> So as a way forward, I am thinking of a similar approach as you
>> >> suggested with the "generic" suspend_late. But instead add a new
>> >> runtime PM API, which intent is to let drivers to specify for PM =
core,
>> >> if it should care to prevent the runtime suspend from happen duri=
ng
>> >> system system - or not. Could that work?
>> >
>> > I don't see what good it would do.  Instead of adding a new flag, =
why
>> > not just let drivers point their .suspend_late methods to the new
>> > generic function?  That would accomplish almost the same thing wit=
hout
>> > changing the API.
>>
>> Two minor functions will be added to the API, no big deal I think.
>> More importantly these will actually make life easier for some drive=
rs
>> since they don't need to set up any additional PM callbacks.
>>
>> Using the generic suspend_late approach would for sure work, but it
>> will spread to buses and power domains as well, which is not the cas=
e
>> when adding when adding a new API.
>
> I don't understand what you mean by "spread to".  That makes it sound
> like an infectious disease rather than a subroutine.  :-)
>
> Also, I don't see how adding one line for an extra callback pointer i=
s
> any harder than adding one line to call pm_runtime_no_prevent_suspend=
=2E
>

I favour the pm_runtime_no_prevent_suspend API approach, since it
would mean a change in behaviour of the PM core. I also think that in
some cases it could make runtime PM better understandable, for those
who are deploying it.

Another advantage of "pm_runtime_no_prevent_suspend" is that driver's
can still easily prevent runtime suspend, during system suspend, by an
extra call to "pm_runtime_get*". Typically this could be used when the
device is configured for wakeup. In this case the generic suspend_late
approach would not work, since the driver would need to implement it's
own .suspend_late callback to handle this.

Kind regards
Ulf Hansson

>> > (Actually, it would be superior.  The generic suspend_late approac=
h
>> > will work even if the user writes "on" to /sys/.../power/control,
>> > whereas your approach won't work.)
>>
>> We have different view here. :-)
>>
>> Whether I like it or not, the sysfs interface exist and then I think
>> the kernel must act accordingly. We shouldn=92t override it. I mean =
if
>> userspace has decided to keep a device active, there is probably a
>> reason.
>>
>>
>> Thanks a lot Alan for being patient with me and continuing the discu=
ssion!
>
> My pleasure.
>
> Alan Stern
>
