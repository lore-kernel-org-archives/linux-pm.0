From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFD] Devices that need full power for wakeup
Date: Mon, 15 Jan 2018 10:11:26 +0100
Message-ID: <CAPDyKFonEA6iphhPZWyqVbfFG8VbzK80bk8njuR06y_b-7uwDw@mail.gmail.com>
References: <CAJZ5v0jf_CVsZOQj4ZzgU59Z9ketb_aNu0UdgMmgXyJwRc37Yg@mail.gmail.com>
 <CAJZ5v0iFGQ5uSvjk8mKUnVNL2=sT97qmHRaY9c5w4q8KHZfe_Q@mail.gmail.com>
 <CAPDyKFo+c_Hd9w-VhTx2KPVKF2k=iJdbomT4Hi_mMLgpWkdetw@mail.gmail.com> <1871558.5ybir6VhFs@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:40006 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932689AbeAOJL3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jan 2018 04:11:29 -0500
Received: by mail-io0-f180.google.com with SMTP id t22so175756ioa.7
        for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2018 01:11:28 -0800 (PST)
In-Reply-To: <1871558.5ybir6VhFs@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Alan Stern <stern@rowland.harvard.edu>

On 13 January 2018 at 03:42, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, January 12, 2018 12:59:04 PM CET Ulf Hansson wrote:
>> [...]
>>
>> >>>> Therefore, device_may_wakeup() may returns true, if userspace wants to
>> >>>> wakeup the system from sleep when there is an SD card inserted.
>> >>>> Although, that doesn't mean we have to keep the logic for the SD
>> >>>> controller device being powered during system suspend, since it would
>> >>>> waste power.
>> >>>
>> >>> The SD controller need not be provided with power, but of course the
>> >>> GPIO card detect pin won't work without power I suppose.  It
>> >>> essentially is like a button attached to the device with its own power
>> >>> and signal wiring.
>> >>
>> >> Correct.
>> >>
>> >>>
>> >>> Well, for devices like Ethernet or WiFi or even input (say mice and
>> >>> keyboards, touch panels and so on) power has to be provided to the
>> >>> device itself for detection of activity while suspended.
>> >>
>> >> Actually no.
>> >
>> > Why "no"?
>> >
>> > The example below doesn't contradict what I said at all.
>>
>> The "no" meant, that the above statement isn't applicable as generic
>> statement. I meant there are cases when it isn't true, apologize if
>> that was unclear.
>>
>> >
>> >> I realize that SD card detect GPIO was not the best example to
>> >> describe the real problem, even if it's related though.
>> >>
>> >> Let me take another example from an embedded battery driven platform:
>> >>
>> >> Assume user space has enabled the wakeup setting for the serial
>> >> console device. In a similar system as described earlier, the serial
>> >> console driver may be able to re-route the serial RX pin to a GPIO
>> >> wake IRQ at system suspend.
>> >
>> > OK
>> >
>> > That's equivalent to switching over to an out-of-band wakeup power
>> > source AFAICS.  There is no substantial practical difference between
>> > that and being able to use a special separate power source for wakeup
>> > for the whole device.
>>
>> From a wakup point of view, yes.
>>
>> However, in case of the power source you refer to, this isn't
>> something the driver controls by itself, but rather the upper layers,
>> right!?
>
> That may or may not be the case.
>
> I guess your point is that the middle layer may control both the in-band and
> out-of-band power sources and it needs to be told which one to use.
>
> I'm not sure that this really is a problem, because the out-of-band wakeup
> power source has to be represented somehow for the driver to be able to use it.
> In your example, the driver can only reroute the pin to the GPIO if it knows
> that the GPIO is there and then configure it for wakeup.  Then, the IRQ
> chip driver responsible for it needs to figure out how to ensure sufficient
> power for it to work while suspended (that's the Geert's use case or at least
> part of it).
>
>> So, in principle for the cases you refer to, upper layers only need to
>> know that the device has wakeup enabled, in principle, as to be able
>> to take the correct decision during system suspend. Right?
>
> That depends on what the upper layer itself can do.
>
> If there are facilities for dealing with wakeup in the upper layer, it should
> be sufficient for it to know that the device can and is allowed to wake up the
> system.  Then, it will just apply those facilities to the device.
>
> OTOH, if the upper layer has no such facilities, the driver needs to give it
> hints regarding what needs to be done in terms of what the upper layer *can*
> do.
>
>> While in those case I refer to, the driver explicitly needs to be
>> involved, dealing with the re-routing of the GPIO - *if* it can, as to
>> enable system wakeups. In these circumstances, upper layers have no
>> clue of what goes on. This is the big difference in my opinion.
>
> There is a difference if the driver needs to be involved in setting up the
> device for wakeup (both system-wide and in runtime PM), but in that case the
> driver knows (a) what wakeup IRQ it is going to use and (b) whether or not
> in-band power may be turned off for it.  There are ways to indicate both of
> these things to the other code layers today.
>
> What else is needed, specifically?

See at the end of my reply.

>
>> >
>> >> This means that serial console device may
>> >> be completely powered off during system suspend. However, whether
>> >> powering off the serial device (and its attached PM domain) can be
>> >> done, is currently only known by the driver, as upper-layers (PM
>> >> domain) don't know if the RX pin is re-routed to a GPIO wake IRQ or
>> >> not.
>> >
>> > Well, then what does prevent you from defaulting to "turn off in-band
>> > power on suspend" (which is the current state of affairs) and then
>> > using PM_QOS_FLAG_NO_POWER_OFF for indicating the "no power off"
>> > condition in case you've not rerouted the pin?
>> >
>>
>> Using the PM_QOS_FLAG_NO_POWER_OFF doesn't work, because of the
>> following reasons.
>>
>> If genpd would default to power off the "in-band-power" at system
>> suspend, devices not supporting remote wakeups (keeping devices
>> runtime resumed), needs to start announcing that genpd needs to keep
>> the in-band-power on at system suspend. In other words, they need to
>> set the PM_QOS_FLAG_NO_POWER_OFF flag.
>>
>> However, that wouldn't be sufficient, as the PM_QOS_FLAG_NO_POWER_OFF
>> flag isn't propagated to parents devices and other wakeup path
>> resources.
>
> It only needs to be propagated to parents if the parents actively
> route wakeup signals from the children or provide them with power.

That is correct, but how would the children driver know when to
propagate the PM_QOS_FLAG_NO_POWER_OFF flag from the child device to
the parent device?

Or maybe that is not what you are suggesting?

> In the genpd case the latter is not relevant at least.

Why not?

Especially we may have cases when the child device isn't attached to
genpd, while the parent device may be.

>
>> > And I still don't see why this isn't relevant to runtime PM too, at
>> > least in principle.
>>
>> Regarding runtime PM; I don't see any issues,
>
> I wonder why.
>
> How exactly do you tell the middle layer to avoid turning the in-band power
> off for devices that are suspended if they need in-band power to signal
> remote wakeup?

The driver simply don't allow its device to become runtime suspended.

>
> Your example with the pin rerouting is perfectly relevant for runtime PM too,
> in particular, as the driver may very well want to reroute the pin for remote
> wakeup and turn the in-band power off for the device then during runtime
> suspend just like it does for system-wide suspend.

Correct! In such case the driver allows its device to become runtime suspended.

>
>> but perhaps you have some cases for the ACPI PM domain in mind?
>>
>> Anyway, for genpd and drivers that manages devices attached to it: If
>> the driver and the device can't be configured for remote wakeup (at
>> runtime suspend), runtime suspend must be prevented by the driver.
>
> Why?  I don't see any technical reason for that whatever.
>
> The "must" part seems to be totally artificial here.
>
>> That's the generic behavior drivers must support, no matter if their
>> devices are attached to genpd or not, right!?
>
> Nope.

OK, this explains some of our disagreement. :-)

Artificial or not, I find it quite unlikely that this would work for
the general case. The reason is because of how runtime PM totally
respects for the device hierarchy.

For example, if a child driver allows it child device to enter runtime
suspend, while it still requires the in-band power to be provided to
its device - then how would the parent driver know how to behave in
this regards?

Especially in cases when the parent device provides power to the
child, then, when the parent device's child count drops to zero, the
parent device may also enter runtime suspend. In other words, what
happens to the child when the parent stops providing power to it,
under these circumstances?

I think the general assumption for these cases, is that it wouldn't
play well, which is why the child device is prevented to enter runtime
suspend, in case it needs in-band power as to deliver remote-wakeups.

>
>> The point is, for remote wakeups, genpd and its users don't need the
>> PM_QOS_FLAG_NO_POWER_OFF flag, or anything else.
>
> Yes, they do or at least they may, which is why it is already supported in
> there.

I did a quick investigation. The PM_QOS_FLAG_NO_POWER_OFF flag, added
in 2012, only have two drivers that use it today. These are:

1) drivers/pci/pci-acpi.c.
I assume this isn't a driver for devices that can be attached to genpd.

2) drivers/usb/core/port.c
This registers an internal struct device for the usb port, which it
deploys runtime PM support for and sets the PM_QOS_FLAG_NO_POWER_OFF
flag to. The internal created device can't be attached to genpd,
however it gets the usb hub device assigned to its parent, which is an
interesting part, as the PM_QOS_FLAG_NO_POWER_OFF doesn't become
propagated to it.

This made me realize that the code in genpd dealing with the
PM_QOS_FLAG_NO_POWER_OFF flag, is unused, unless I am missing another
use case, of course.

Another observation regarding the PM_QOS_FLAG_NO_POWER_OFF flag, is
that it's QOS thing, which may also be controlled from userspace via
sysfs. Using a QOS flag to prevent to turn of in-band power as to be
able to support wakeups correctly, just doesn't seems right to me. I
rather consider this as a HW configuration that must be set to support
a requested wakeup.

Going back to what I think is needed. I think we need a per device PM
flag that the driver can set, to instruct upper layers about how it
has configured the wakeup (in-band or out-band). That flag needs to be
propagated to parents as well. Moreover, I am questioning whether such
flag may be useful for runtime PM, maybe it could.

>
> I'll respond to the rest of this later, sorry for being time-constrained.

No worries, there is no rush!

Kind regards
Uffe
