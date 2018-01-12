From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFD] Devices that need full power for wakeup
Date: Fri, 12 Jan 2018 01:21:50 +0100
Message-ID: <CAJZ5v0iFGQ5uSvjk8mKUnVNL2=sT97qmHRaY9c5w4q8KHZfe_Q@mail.gmail.com>
References: <CAJZ5v0jf_CVsZOQj4ZzgU59Z9ketb_aNu0UdgMmgXyJwRc37Yg@mail.gmail.com>
 <CAPDyKFqZ+ja5bu+G7ynTowq1CFQ2_k2zdA7qGbj3VagdB0yT4Q@mail.gmail.com>
 <CAJZ5v0hw_z5qGiGFGtJHLMfduEsH5c9y8q7ZFNCZdjwppP=GbA@mail.gmail.com>
 <CAPDyKFpwVevhg7F==GdxDwDhbuTy5hPn6zMbq4WpqkBiDKbM+g@mail.gmail.com>
 <CAJZ5v0hpOe6cQbuLEaYx8=JVrD79276J8VO0YNveWoNc5TU0tg@mail.gmail.com> <CAPDyKFo_MpVGy7jNh-mgwxCQq5+zTj4qt1t8LMY7LfdF419xdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f174.google.com ([74.125.82.174]:43629 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754168AbeALAVw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jan 2018 19:21:52 -0500
Received: by mail-ot0-f174.google.com with SMTP id t28so3723388oti.10
        for <linux-pm@vger.kernel.org>; Thu, 11 Jan 2018 16:21:51 -0800 (PST)
In-Reply-To: <CAPDyKFo_MpVGy7jNh-mgwxCQq5+zTj4qt1t8LMY7LfdF419xdw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Alan Stern <stern@rowland.harvard.edu>

On Thu, Jan 11, 2018 at 3:45 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> [...]
>
>>>>
>>>>> However, there are a few related issues around system wakeups in
>>>>> genpd, during system suspend.
>>>>>
>>>>> 1)
>>>>> If the driver for the device, configures system wakeup as an
>>>>> "out-band-wakeup", the device and its PM domain, don't need to stay
>>>>> powered on during system suspend from the driver perspective.
>>>>
>>>> That depends.
>>>>
>>>> The wakeup signal has to be generated or asserted by something,
>>>> presumably the device itself.
>>>
>>> The cases I looking at don't require the device to be powered - at
>>> least from the driver's perspective.
>>>
>>> A classic example is a SD card detect pin, which is being routed to a
>>> GPIO pin. In these case, that GPIO pin has no logic whatsoever,
>>> coupled with the device for SD controller. Still, it needs to be
>>> manged by the same device driver.
>>
>> So technically it is a different device, but since it is functionally
>> related to the one originally handled by the driver in question, the
>> driver is expected to handle this wakeup thing too.
>>
>> Fair enough, but certainly that is not a common setup for other subsystems.
>>
>> [BTW, since the wakeup thing is a separate device technically, I would
>> try to model it as a separate device object in the kernel with its own
>> wakeup settings.  That would save you some complications you're trying
>> to deal with IMO.]
>>
>> Also I'm sort of wondering why the problem is specific to system-wide
>> suspend.  It looks like if the card slot was empty, it would make
>> perfect sense to put the "master" device into runtime suspend with no
>> remote wakeup and then only resume it if the GPIO thing signaled card
>> insertion.  And this looks like the same problem in disguise.
>>
>> Moreover, that is quite a departure from the direction of my original
>> message in this thread.
>>
>>> Therefore, device_may_wakeup() may returns true, if userspace wants to
>>> wakeup the system from sleep when there is an SD card inserted.
>>> Although, that doesn't mean we have to keep the logic for the SD
>>> controller device being powered during system suspend, since it would
>>> waste power.
>>
>> The SD controller need not be provided with power, but of course the
>> GPIO card detect pin won't work without power I suppose.  It
>> essentially is like a button attached to the device with its own power
>> and signal wiring.
>
> Correct.
>
>>
>> Well, for devices like Ethernet or WiFi or even input (say mice and
>> keyboards, touch panels and so on) power has to be provided to the
>> device itself for detection of activity while suspended.
>
> Actually no.

Why "no"?

The example below doesn't contradict what I said at all.

> I realize that SD card detect GPIO was not the best example to
> describe the real problem, even if it's related though.
>
> Let me take another example from an embedded battery driven platform:
>
> Assume user space has enabled the wakeup setting for the serial
> console device. In a similar system as described earlier, the serial
> console driver may be able to re-route the serial RX pin to a GPIO
> wake IRQ at system suspend.

OK

That's equivalent to switching over to an out-of-band wakeup power
source AFAICS.  There is no substantial practical difference between
that and being able to use a special separate power source for wakeup
for the whole device.

> This means that serial console device may
> be completely powered off during system suspend. However, whether
> powering off the serial device (and its attached PM domain) can be
> done, is currently only known by the driver, as upper-layers (PM
> domain) don't know if the RX pin is re-routed to a GPIO wake IRQ or
> not.

Well, then what does prevent you from defaulting to "turn off in-band
power on suspend" (which is the current state of affairs) and then
using PM_QOS_FLAG_NO_POWER_OFF for indicating the "no power off"
condition in case you've not rerouted the pin?

And I still don't see why this isn't relevant to runtime PM too, at
least in principle.

>>
>> You seem to be considering a very special case which may have been
>> arranged entirely differently, so the usefulness of it as a general
>> example is quite limited in my view.
>>
>> Yes, this case should be taken into account too somehow, but how to do
>> that is a good question and I'm not sure how relevant it is to the
>> general handling of wakeup to be honest.
>
> Again, the SD card detect GPIO was just one case.
>
> There are several more, which are similar to the above described,
> serial console wakeup case.

So far I still don't see a need for new infrastructure beyond the
"passive wakeup devices" case.

[cut]

>>
>>>>
>>>> A wakeup signal usually means that something interesting happened
>>>> outside and that thing needs to be detected in the first place, most
>>>> likely by the device.
>>>>
>>>>> A very common scenario when this is the case, is when a wakeup signal is
>>>>> routed via GPIO IRQ.
>>
>> Routing via a GPIO IRQ doesn't mean that it always works like the card
>> detect pin given in the example.  Usually, some input from the device
>> is necessary to activate the IRQ pin.
>
> Well, not in those cases I am referring to.
>
> The input and wakeup is completely driven via the (re-)routed GPIO pin.

So I should have said "often" instead of "usually" maybe (and that
depends a good deal on what is usual for whom).

The pin rerouting example is just a special case of switching over to
an out-of-band wakeup power source (as I said above), which in some
cases (eg. PCI/ACPI) can be done automatically and transparently with
respect to the driver and in some cases is done by the driver itself.
In the latter case it only is a matter of letting the other layers of
code know whether or not they can turn off the in-band power source
for the device and they really don't need to know that this is related
to wakeup in any way.

Again, genpd (for example) has a very "specific" understanding of
"wakeup".  From its perspective "wakeup" means "do not turn in-band
power off", but that is completely arbitrary and arguably it would be
sufficient to tell it directly "do not turn in-band power off" without
even saying that this is related to wakeup at all.

And in the genpd case in particular it doesn't even need to be
propagated do parents, because the hierarchy of domains should reflect
the power dependencies already anyway.

Thanks,
Rafael
