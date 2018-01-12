From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFD] Devices that need full power for wakeup
Date: Fri, 12 Jan 2018 12:59:04 +0100
Message-ID: <CAPDyKFo+c_Hd9w-VhTx2KPVKF2k=iJdbomT4Hi_mMLgpWkdetw@mail.gmail.com>
References: <CAJZ5v0jf_CVsZOQj4ZzgU59Z9ketb_aNu0UdgMmgXyJwRc37Yg@mail.gmail.com>
 <CAPDyKFqZ+ja5bu+G7ynTowq1CFQ2_k2zdA7qGbj3VagdB0yT4Q@mail.gmail.com>
 <CAJZ5v0hw_z5qGiGFGtJHLMfduEsH5c9y8q7ZFNCZdjwppP=GbA@mail.gmail.com>
 <CAPDyKFpwVevhg7F==GdxDwDhbuTy5hPn6zMbq4WpqkBiDKbM+g@mail.gmail.com>
 <CAJZ5v0hpOe6cQbuLEaYx8=JVrD79276J8VO0YNveWoNc5TU0tg@mail.gmail.com>
 <CAPDyKFo_MpVGy7jNh-mgwxCQq5+zTj4qt1t8LMY7LfdF419xdw@mail.gmail.com> <CAJZ5v0iFGQ5uSvjk8mKUnVNL2=sT97qmHRaY9c5w4q8KHZfe_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:42387 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933122AbeALL7G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jan 2018 06:59:06 -0500
Received: by mail-io0-f170.google.com with SMTP id 25so5580898ioj.9
        for <linux-pm@vger.kernel.org>; Fri, 12 Jan 2018 03:59:06 -0800 (PST)
In-Reply-To: <CAJZ5v0iFGQ5uSvjk8mKUnVNL2=sT97qmHRaY9c5w4q8KHZfe_Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Alan Stern <stern@rowland.harvard.edu>

[...]

>>>> Therefore, device_may_wakeup() may returns true, if userspace wants to
>>>> wakeup the system from sleep when there is an SD card inserted.
>>>> Although, that doesn't mean we have to keep the logic for the SD
>>>> controller device being powered during system suspend, since it would
>>>> waste power.
>>>
>>> The SD controller need not be provided with power, but of course the
>>> GPIO card detect pin won't work without power I suppose.  It
>>> essentially is like a button attached to the device with its own power
>>> and signal wiring.
>>
>> Correct.
>>
>>>
>>> Well, for devices like Ethernet or WiFi or even input (say mice and
>>> keyboards, touch panels and so on) power has to be provided to the
>>> device itself for detection of activity while suspended.
>>
>> Actually no.
>
> Why "no"?
>
> The example below doesn't contradict what I said at all.

The "no" meant, that the above statement isn't applicable as generic
statement. I meant there are cases when it isn't true, apologize if
that was unclear.

>
>> I realize that SD card detect GPIO was not the best example to
>> describe the real problem, even if it's related though.
>>
>> Let me take another example from an embedded battery driven platform:
>>
>> Assume user space has enabled the wakeup setting for the serial
>> console device. In a similar system as described earlier, the serial
>> console driver may be able to re-route the serial RX pin to a GPIO
>> wake IRQ at system suspend.
>
> OK
>
> That's equivalent to switching over to an out-of-band wakeup power
> source AFAICS.  There is no substantial practical difference between
> that and being able to use a special separate power source for wakeup
> for the whole device.

>From a wakup point of view, yes.

However, in case of the power source you refer to, this isn't
something the driver controls by itself, but rather the upper layers,
right!?

So, in principle for the cases you refer to, upper layers only need to
know that the device has wakeup enabled, in principle, as to be able
to take the correct decision during system suspend. Right?

While in those case I refer to, the driver explicitly needs to be
involved, dealing with the re-routing of the GPIO - *if* it can, as to
enable system wakeups. In these circumstances, upper layers have no
clue of what goes on. This is the big difference in my opinion.

>
>> This means that serial console device may
>> be completely powered off during system suspend. However, whether
>> powering off the serial device (and its attached PM domain) can be
>> done, is currently only known by the driver, as upper-layers (PM
>> domain) don't know if the RX pin is re-routed to a GPIO wake IRQ or
>> not.
>
> Well, then what does prevent you from defaulting to "turn off in-band
> power on suspend" (which is the current state of affairs) and then
> using PM_QOS_FLAG_NO_POWER_OFF for indicating the "no power off"
> condition in case you've not rerouted the pin?
>

Using the PM_QOS_FLAG_NO_POWER_OFF doesn't work, because of the
following reasons.

If genpd would default to power off the "in-band-power" at system
suspend, devices not supporting remote wakeups (keeping devices
runtime resumed), needs to start announcing that genpd needs to keep
the in-band-power on at system suspend. In other words, they need to
set the PM_QOS_FLAG_NO_POWER_OFF flag.

However, that wouldn't be sufficient, as the PM_QOS_FLAG_NO_POWER_OFF
flag isn't propagated to parents devices and other wakeup path
resources.

> And I still don't see why this isn't relevant to runtime PM too, at
> least in principle.

Regarding runtime PM; I don't see any issues, but perhaps you have
some cases for the ACPI PM domain in mind?

Anyway, for genpd and drivers that manages devices attached to it: If
the driver and the device can't be configured for remote wakeup (at
runtime suspend), runtime suspend must be prevented by the driver.
That's the generic behavior drivers must support, no matter if their
devices are attached to genpd or not, right!?

The point is, for remote wakeups, genpd and its users don't need the
PM_QOS_FLAG_NO_POWER_OFF flag, or anything else.

>
>>>
>>> You seem to be considering a very special case which may have been
>>> arranged entirely differently, so the usefulness of it as a general
>>> example is quite limited in my view.
>>>
>>> Yes, this case should be taken into account too somehow, but how to do
>>> that is a good question and I'm not sure how relevant it is to the
>>> general handling of wakeup to be honest.
>>
>> Again, the SD card detect GPIO was just one case.
>>
>> There are several more, which are similar to the above described,
>> serial console wakeup case.
>
> So far I still don't see a need for new infrastructure beyond the
> "passive wakeup devices" case.
>
> [cut]
>
>>>
>>>>>
>>>>> A wakeup signal usually means that something interesting happened
>>>>> outside and that thing needs to be detected in the first place, most
>>>>> likely by the device.
>>>>>
>>>>>> A very common scenario when this is the case, is when a wakeup signal is
>>>>>> routed via GPIO IRQ.
>>>
>>> Routing via a GPIO IRQ doesn't mean that it always works like the card
>>> detect pin given in the example.  Usually, some input from the device
>>> is necessary to activate the IRQ pin.
>>
>> Well, not in those cases I am referring to.
>>
>> The input and wakeup is completely driven via the (re-)routed GPIO pin.
>
> So I should have said "often" instead of "usually" maybe (and that
> depends a good deal on what is usual for whom).
>
> The pin rerouting example is just a special case of switching over to
> an out-of-band wakeup power source (as I said above), which in some
> cases (eg. PCI/ACPI) can be done automatically and transparently with
> respect to the driver and in some cases is done by the driver itself.
> In the latter case it only is a matter of letting the other layers of
> code know whether or not they can turn off the in-band power source
> for the device and they really don't need to know that this is related
> to wakeup in any way.

You have the principles correctly described here, so if we would start
from scratch, this is probably how we should have done it.

>
> Again, genpd (for example) has a very "specific" understanding of
> "wakeup".  From its perspective "wakeup" means "do not turn in-band
> power off", but that is completely arbitrary and arguably it would be
> sufficient to tell it directly "do not turn in-band power off" without
> even saying that this is related to wakeup at all.

Sorry, but there is more to it than this.

In regards to remote wakeup, the above is true, but not in regards to
system wakeups, as then we have two different types of scenarios to
consider.

1) A driver have configured its device for system wakeup and requires
its device+genpd to stay powered on, as to be able to have wakeup
signals delivered. These devices don't support remote wakeups.
2) A driver have configured its device for system wakeup, but allows
the in-band power for its device+genpd to be powered off, because the
driver managed to configure the system wakeup as out-band (GPIO IRQ).

>
> And in the genpd case in particular it doesn't even need to be
> propagated do parents, because the hierarchy of domains should reflect
> the power dependencies already anyway.

This we must not limit the solution to, as it depends on the device/PM
topology of the particular SoC.

I am sure I we already have cases where this is needed, but to me it
doesn't really matter. The complexity in regards to PM topology is
increasing, so I am sure it would be a mistake to accept that kind of
limitation.

Kind regards
Uffe
