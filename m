From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFD] Devices that need full power for wakeup
Date: Sat, 13 Jan 2018 03:42:14 +0100
Message-ID: <1871558.5ybir6VhFs@aspire.rjw.lan>
References: <CAJZ5v0jf_CVsZOQj4ZzgU59Z9ketb_aNu0UdgMmgXyJwRc37Yg@mail.gmail.com> <CAJZ5v0iFGQ5uSvjk8mKUnVNL2=sT97qmHRaY9c5w4q8KHZfe_Q@mail.gmail.com> <CAPDyKFo+c_Hd9w-VhTx2KPVKF2k=iJdbomT4Hi_mMLgpWkdetw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:41770 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965368AbeAMCna (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jan 2018 21:43:30 -0500
In-Reply-To: <CAPDyKFo+c_Hd9w-VhTx2KPVKF2k=iJdbomT4Hi_mMLgpWkdetw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Alan Stern <stern@rowland.harvard.edu>

On Friday, January 12, 2018 12:59:04 PM CET Ulf Hansson wrote:
> [...]
> 
> >>>> Therefore, device_may_wakeup() may returns true, if userspace wants to
> >>>> wakeup the system from sleep when there is an SD card inserted.
> >>>> Although, that doesn't mean we have to keep the logic for the SD
> >>>> controller device being powered during system suspend, since it would
> >>>> waste power.
> >>>
> >>> The SD controller need not be provided with power, but of course the
> >>> GPIO card detect pin won't work without power I suppose.  It
> >>> essentially is like a button attached to the device with its own power
> >>> and signal wiring.
> >>
> >> Correct.
> >>
> >>>
> >>> Well, for devices like Ethernet or WiFi or even input (say mice and
> >>> keyboards, touch panels and so on) power has to be provided to the
> >>> device itself for detection of activity while suspended.
> >>
> >> Actually no.
> >
> > Why "no"?
> >
> > The example below doesn't contradict what I said at all.
> 
> The "no" meant, that the above statement isn't applicable as generic
> statement. I meant there are cases when it isn't true, apologize if
> that was unclear.
> 
> >
> >> I realize that SD card detect GPIO was not the best example to
> >> describe the real problem, even if it's related though.
> >>
> >> Let me take another example from an embedded battery driven platform:
> >>
> >> Assume user space has enabled the wakeup setting for the serial
> >> console device. In a similar system as described earlier, the serial
> >> console driver may be able to re-route the serial RX pin to a GPIO
> >> wake IRQ at system suspend.
> >
> > OK
> >
> > That's equivalent to switching over to an out-of-band wakeup power
> > source AFAICS.  There is no substantial practical difference between
> > that and being able to use a special separate power source for wakeup
> > for the whole device.
> 
> From a wakup point of view, yes.
> 
> However, in case of the power source you refer to, this isn't
> something the driver controls by itself, but rather the upper layers,
> right!?

That may or may not be the case.

I guess your point is that the middle layer may control both the in-band and
out-of-band power sources and it needs to be told which one to use.

I'm not sure that this really is a problem, because the out-of-band wakeup
power source has to be represented somehow for the driver to be able to use it.
In your example, the driver can only reroute the pin to the GPIO if it knows
that the GPIO is there and then configure it for wakeup.  Then, the IRQ
chip driver responsible for it needs to figure out how to ensure sufficient
power for it to work while suspended (that's the Geert's use case or at least
part of it).

> So, in principle for the cases you refer to, upper layers only need to
> know that the device has wakeup enabled, in principle, as to be able
> to take the correct decision during system suspend. Right?

That depends on what the upper layer itself can do.

If there are facilities for dealing with wakeup in the upper layer, it should
be sufficient for it to know that the device can and is allowed to wake up the
system.  Then, it will just apply those facilities to the device.

OTOH, if the upper layer has no such facilities, the driver needs to give it
hints regarding what needs to be done in terms of what the upper layer *can*
do.

> While in those case I refer to, the driver explicitly needs to be
> involved, dealing with the re-routing of the GPIO - *if* it can, as to
> enable system wakeups. In these circumstances, upper layers have no
> clue of what goes on. This is the big difference in my opinion.

There is a difference if the driver needs to be involved in setting up the
device for wakeup (both system-wide and in runtime PM), but in that case the
driver knows (a) what wakeup IRQ it is going to use and (b) whether or not
in-band power may be turned off for it.  There are ways to indicate both of
these things to the other code layers today.

What else is needed, specifically?

> >
> >> This means that serial console device may
> >> be completely powered off during system suspend. However, whether
> >> powering off the serial device (and its attached PM domain) can be
> >> done, is currently only known by the driver, as upper-layers (PM
> >> domain) don't know if the RX pin is re-routed to a GPIO wake IRQ or
> >> not.
> >
> > Well, then what does prevent you from defaulting to "turn off in-band
> > power on suspend" (which is the current state of affairs) and then
> > using PM_QOS_FLAG_NO_POWER_OFF for indicating the "no power off"
> > condition in case you've not rerouted the pin?
> >
> 
> Using the PM_QOS_FLAG_NO_POWER_OFF doesn't work, because of the
> following reasons.
> 
> If genpd would default to power off the "in-band-power" at system
> suspend, devices not supporting remote wakeups (keeping devices
> runtime resumed), needs to start announcing that genpd needs to keep
> the in-band-power on at system suspend. In other words, they need to
> set the PM_QOS_FLAG_NO_POWER_OFF flag.
> 
> However, that wouldn't be sufficient, as the PM_QOS_FLAG_NO_POWER_OFF
> flag isn't propagated to parents devices and other wakeup path
> resources.

It only needs to be propagated to parents if the parents actively
route wakeup signals from the children or provide them with power.
In the genpd case the latter is not relevant at least.

> > And I still don't see why this isn't relevant to runtime PM too, at
> > least in principle.
> 
> Regarding runtime PM; I don't see any issues,

I wonder why.

How exactly do you tell the middle layer to avoid turning the in-band power
off for devices that are suspended if they need in-band power to signal
remote wakeup?

Your example with the pin rerouting is perfectly relevant for runtime PM too,
in particular, as the driver may very well want to reroute the pin for remote
wakeup and turn the in-band power off for the device then during runtime
suspend just like it does for system-wide suspend.

> but perhaps you have some cases for the ACPI PM domain in mind?
> 
> Anyway, for genpd and drivers that manages devices attached to it: If
> the driver and the device can't be configured for remote wakeup (at
> runtime suspend), runtime suspend must be prevented by the driver.

Why?  I don't see any technical reason for that whatever.

The "must" part seems to be totally artificial here.

> That's the generic behavior drivers must support, no matter if their
> devices are attached to genpd or not, right!?

Nope.

> The point is, for remote wakeups, genpd and its users don't need the
> PM_QOS_FLAG_NO_POWER_OFF flag, or anything else.

Yes, they do or at least they may, which is why it is already supported in
there.

I'll respond to the rest of this later, sorry for being time-constrained.

Thanks,
Rafael
