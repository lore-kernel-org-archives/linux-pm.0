From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFD] Devices that need full power for wakeup
Date: Mon, 22 Jan 2018 09:00:27 +0100
Message-ID: <CAJZ5v0h9OniDdLGkSEpU1eKmYKfi49HaG6pBeZYKwtPP9w+LBg@mail.gmail.com>
References: <CAJZ5v0jf_CVsZOQj4ZzgU59Z9ketb_aNu0UdgMmgXyJwRc37Yg@mail.gmail.com>
 <CAJZ5v0iFGQ5uSvjk8mKUnVNL2=sT97qmHRaY9c5w4q8KHZfe_Q@mail.gmail.com>
 <CAPDyKFo+c_Hd9w-VhTx2KPVKF2k=iJdbomT4Hi_mMLgpWkdetw@mail.gmail.com>
 <1871558.5ybir6VhFs@aspire.rjw.lan> <CAPDyKFonEA6iphhPZWyqVbfFG8VbzK80bk8njuR06y_b-7uwDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f176.google.com ([74.125.82.176]:38338 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbeAVIA3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jan 2018 03:00:29 -0500
Received: by mail-ot0-f176.google.com with SMTP id v5so6710832oth.5
        for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2018 00:00:29 -0800 (PST)
In-Reply-To: <CAPDyKFonEA6iphhPZWyqVbfFG8VbzK80bk8njuR06y_b-7uwDw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Alan Stern <stern@rowland.harvard.edu>

On Mon, Jan 15, 2018 at 10:11 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 13 January 2018 at 03:42, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Friday, January 12, 2018 12:59:04 PM CET Ulf Hansson wrote:

[cut]

>>
>>> >
>>> >> This means that serial console device may
>>> >> be completely powered off during system suspend. However, whether
>>> >> powering off the serial device (and its attached PM domain) can be
>>> >> done, is currently only known by the driver, as upper-layers (PM
>>> >> domain) don't know if the RX pin is re-routed to a GPIO wake IRQ or
>>> >> not.
>>> >
>>> > Well, then what does prevent you from defaulting to "turn off in-band
>>> > power on suspend" (which is the current state of affairs) and then
>>> > using PM_QOS_FLAG_NO_POWER_OFF for indicating the "no power off"
>>> > condition in case you've not rerouted the pin?
>>> >
>>>
>>> Using the PM_QOS_FLAG_NO_POWER_OFF doesn't work, because of the
>>> following reasons.
>>>
>>> If genpd would default to power off the "in-band-power" at system
>>> suspend, devices not supporting remote wakeups (keeping devices
>>> runtime resumed), needs to start announcing that genpd needs to keep
>>> the in-band-power on at system suspend. In other words, they need to
>>> set the PM_QOS_FLAG_NO_POWER_OFF flag.
>>>
>>> However, that wouldn't be sufficient, as the PM_QOS_FLAG_NO_POWER_OFF
>>> flag isn't propagated to parents devices and other wakeup path
>>> resources.
>>
>> It only needs to be propagated to parents if the parents actively
>> route wakeup signals from the children or provide them with power.
>
> That is correct, but how would the children driver know when to
> propagate the PM_QOS_FLAG_NO_POWER_OFF flag from the child device to
> the parent device?
>
> Or maybe that is not what you are suggesting?

No, it isn't.

I see no valid reasons for propagating PM_QOS_FLAG_NO_POWER_OFF.  The
only case in which it could be potentially useful is when the parent
is explicitly providing the children with power, but in that case it
is the responsibility of the parent's driver to take the PM QoS flags
of the children into account and avoid turning off power at the parent
if need be.

OTOH, I see valid reasons for PM_QOS_FLAG_NO_POWER_OFF to not be
propagated (like when the parent does not provide the children with
power directly in which case there is no reason to avoid turning off
power at the parent when any of the children have that flag set).

>> In the genpd case the latter is not relevant at least.
>
> Why not?
>
> Especially we may have cases when the child device isn't attached to
> genpd, while the parent device may be.

That only matters if the parent provides power to the child directly
in which case, again, the parent's driver should (a) know that and (b)
take care of the child's PM QoS requirements as appropriate.

>>
>>> > And I still don't see why this isn't relevant to runtime PM too, at
>>> > least in principle.
>>>
>>> Regarding runtime PM; I don't see any issues,
>>
>> I wonder why.
>>
>> How exactly do you tell the middle layer to avoid turning the in-band power
>> off for devices that are suspended if they need in-band power to signal
>> remote wakeup?
>
> The driver simply don't allow its device to become runtime suspended.

Well, this is a strategy of dealing with the requirement, but it may
be sort of wasteful in some cases, like when you could disable clocks
for the suspended device while avoiding to remove in-band power from
it at the same time.

It arguably isn't the only strategy that can be used.

>>
>> Your example with the pin rerouting is perfectly relevant for runtime PM too,
>> in particular, as the driver may very well want to reroute the pin for remote
>> wakeup and turn the in-band power off for the device then during runtime
>> suspend just like it does for system-wide suspend.
>
> Correct! In such case the driver allows its device to become runtime suspended.

So instead of preventing runtime suspend from happening at all in the
other case the driver could indicate the requirement to supply in-band
power to the device via PM QoS and still allow runtime suspend to
work.

If that strategy is used, the runtime suspend and system-wide suspend
cases are not distinct any more from the driver's perspective.

>>
>>> but perhaps you have some cases for the ACPI PM domain in mind?
>>>
>>> Anyway, for genpd and drivers that manages devices attached to it: If
>>> the driver and the device can't be configured for remote wakeup (at
>>> runtime suspend), runtime suspend must be prevented by the driver.
>>
>> Why?  I don't see any technical reason for that whatever.
>>
>> The "must" part seems to be totally artificial here.
>>
>>> That's the generic behavior drivers must support, no matter if their
>>> devices are attached to genpd or not, right!?
>>
>> Nope.
>
> OK, this explains some of our disagreement. :-)
>
> Artificial or not, I find it quite unlikely that this would work for
> the general case. The reason is because of how runtime PM totally
> respects for the device hierarchy.
>
> For example, if a child driver allows it child device to enter runtime
> suspend, while it still requires the in-band power to be provided to
> its device - then how would the parent driver know how to behave in
> this regards?

Either the parent directly supplies in-band power to its children or
it doesn't.  In the former case the parent's driver needs to know that
this is the case and deal with it.  In the latter case it doesn't need
to care.

> Especially in cases when the parent device provides power to the
> child, then, when the parent device's child count drops to zero, the
> parent device may also enter runtime suspend.

Yes, it can enter the "suspended" metastate, but that metastate may be
mapped to multiple physical states.  Which of them is actually used
may depend on the power requirements of the children.

> In other words, what happens to the child when the parent stops providing power to it,
> under these circumstances?
>
> I think the general assumption for these cases, is that it wouldn't
> play well, which is why the child device is prevented to enter runtime
> suspend, in case it needs in-band power as to deliver remote-wakeups.

That is how it may be implemented, but it doesn't have to be done this way.

Again, please don't confuse a requirement with a strategy to meet it.

>>> The point is, for remote wakeups, genpd and its users don't need the
>>> PM_QOS_FLAG_NO_POWER_OFF flag, or anything else.
>>
>> Yes, they do or at least they may, which is why it is already supported in
>> there.
>
> I did a quick investigation. The PM_QOS_FLAG_NO_POWER_OFF flag, added
> in 2012, only have two drivers that use it today. These are:
>
> 1) drivers/pci/pci-acpi.c.
> I assume this isn't a driver for devices that can be attached to genpd.
>
> 2) drivers/usb/core/port.c
> This registers an internal struct device for the usb port, which it
> deploys runtime PM support for and sets the PM_QOS_FLAG_NO_POWER_OFF
> flag to. The internal created device can't be attached to genpd,
> however it gets the usb hub device assigned to its parent, which is an
> interesting part, as the PM_QOS_FLAG_NO_POWER_OFF doesn't become
> propagated to it.
>
> This made me realize that the code in genpd dealing with the
> PM_QOS_FLAG_NO_POWER_OFF flag, is unused, unless I am missing another
> use case, of course.

That's probably the case.

It was added in anticipation of future use in drivers.

> Another observation regarding the PM_QOS_FLAG_NO_POWER_OFF flag, is
> that it's QOS thing, which may also be controlled from userspace via
> sysfs. Using a QOS flag to prevent to turn of in-band power as to be
> able to support wakeups correctly, just doesn't seems right to me. I
> rather consider this as a HW configuration that must be set to support
> a requested wakeup.

User space may want in-band power to be provided to the device while
suspended too and I'm not sure what's the difference between that and
the wakeup requirement.

The point here, among other things, is that it doesn't really matter
*why* the device needs to be provided with in-band power while
suspended.  Potentially, there may be multiple valid reasons for that
and wakeup is only one of them, so why does it need to be special?

> Going back to what I think is needed. I think we need a per device PM
> flag that the driver can set, to instruct upper layers about how it
> has configured the wakeup (in-band or out-band). That flag needs to be
> propagated to parents as well. Moreover, I am questioning whether such
> flag may be useful for runtime PM, maybe it could.

Upper layers need not be informed about wakeup in general, like genpd
which only understands (a) whether or not to cut off in-band power and
(b) whether or not to invoke the "stop" callback.  It doesn't need to
care about why those two things may or may not be done.

My first conclusion from the above is that the runtime PM case and the
system-wide PM case are really the same from the wakeup setup
perspective and I don't see general reasons for them to be handled
differently.

The way to communicate the requirements related to that to upper
layers, parent drivers etc may be via PM QoS flags, but I'm not
insisting on that.  It has just occurred to me that it is one possible
way to do it and there was some work done in that direction.

Thanks,
Rafael
