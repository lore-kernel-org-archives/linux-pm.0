From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFD] Devices that need full power for wakeup
Date: Thu, 11 Jan 2018 01:08:06 +0100
Message-ID: <CAJZ5v0hpOe6cQbuLEaYx8=JVrD79276J8VO0YNveWoNc5TU0tg@mail.gmail.com>
References: <CAJZ5v0jf_CVsZOQj4ZzgU59Z9ketb_aNu0UdgMmgXyJwRc37Yg@mail.gmail.com>
 <CAPDyKFqZ+ja5bu+G7ynTowq1CFQ2_k2zdA7qGbj3VagdB0yT4Q@mail.gmail.com>
 <CAJZ5v0hw_z5qGiGFGtJHLMfduEsH5c9y8q7ZFNCZdjwppP=GbA@mail.gmail.com> <CAPDyKFpwVevhg7F==GdxDwDhbuTy5hPn6zMbq4WpqkBiDKbM+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33467 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbeAKAII (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jan 2018 19:08:08 -0500
Received: by mail-oi0-f46.google.com with SMTP id y141so555884oia.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Jan 2018 16:08:07 -0800 (PST)
In-Reply-To: <CAPDyKFpwVevhg7F==GdxDwDhbuTy5hPn6zMbq4WpqkBiDKbM+g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Alan Stern <stern@rowland.harvard.edu>

On Wed, Jan 10, 2018 at 11:21 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 10 January 2018 at 02:22, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Mon, Jan 8, 2018 at 5:33 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> On 8 January 2018 at 12:51, Rafael J. Wysocki <rafael@kernel.org> wrote:

[cut]

>>
>>> This is also what Geert convinced to be the best, from earlier discussions.
>>
>> I'm not sure about that.  Geert seems to need power to stay on,
>> nothing more, and that regardless of genpd_is_active_wakeup() AFAICS.
>
> That was the initial problem, which is taken care of by using the
> ->dev.power.wakeup_path flag and the new helper,
> device_set_wakeup_path().
>
> This in combination of enabling genpd to deal with wakeups, as that is
> currently not the default setting, which is done via setting the
> GENPD_FLAG_ACTIVE_WAKEUP configuration flag.

But that really isn't about wakeup, but rather about whether or not
power can be cut off things, right?

> The next part of the problems Geert pointed out was exactly those I am
> describing here. Please have a look at his reply at:
> https://www.mail-archive.com/linux-renesas-soc@vger.kernel.org/msg21157.html

OK

>>
>>> However, there are a few related issues around system wakeups in
>>> genpd, during system suspend.
>>>
>>> 1)
>>> If the driver for the device, configures system wakeup as an
>>> "out-band-wakeup", the device and its PM domain, don't need to stay
>>> powered on during system suspend from the driver perspective.
>>
>> That depends.
>>
>> The wakeup signal has to be generated or asserted by something,
>> presumably the device itself.
>
> The cases I looking at don't require the device to be powered - at
> least from the driver's perspective.
>
> A classic example is a SD card detect pin, which is being routed to a
> GPIO pin. In these case, that GPIO pin has no logic whatsoever,
> coupled with the device for SD controller. Still, it needs to be
> manged by the same device driver.

So technically it is a different device, but since it is functionally
related to the one originally handled by the driver in question, the
driver is expected to handle this wakeup thing too.

Fair enough, but certainly that is not a common setup for other subsystems.

[BTW, since the wakeup thing is a separate device technically, I would
try to model it as a separate device object in the kernel with its own
wakeup settings.  That would save you some complications you're trying
to deal with IMO.]

Also I'm sort of wondering why the problem is specific to system-wide
suspend.  It looks like if the card slot was empty, it would make
perfect sense to put the "master" device into runtime suspend with no
remote wakeup and then only resume it if the GPIO thing signaled card
insertion.  And this looks like the same problem in disguise.

Moreover, that is quite a departure from the direction of my original
message in this thread.

> Therefore, device_may_wakeup() may returns true, if userspace wants to
> wakeup the system from sleep when there is an SD card inserted.
> Although, that doesn't mean we have to keep the logic for the SD
> controller device being powered during system suspend, since it would
> waste power.

The SD controller need not be provided with power, but of course the
GPIO card detect pin won't work without power I suppose.  It
essentially is like a button attached to the device with its own power
and signal wiring.

Well, for devices like Ethernet or WiFi or even input (say mice and
keyboards, touch panels and so on) power has to be provided to the
device itself for detection of activity while suspended.

You seem to be considering a very special case which may have been
arranged entirely differently, so the usefulness of it as a general
example is quite limited in my view.

Yes, this case should be taken into account too somehow, but how to do
that is a good question and I'm not sure how relevant it is to the
general handling of wakeup to be honest.

>> Out-of-band usually only means that the signal is routed in a special
>> way different from the usual device's interrupt routing and not that
>> the device is not involved in wakeup signaling at all.
>
> Okay, so it's a matter of terminology. I had that feeling, as I have
> seen "out-of-band" being used in different context, not always meaning
> the same thing.

That's fair enough.

More generally, there are two aspects of wakeup: wakeup power and
wakeup signaling.  Wakeup power is what the device needs to be able to
detect activity while suspended and trigger a wakeup signal.  Wakeup
signaling is all about how the wakeup signal is generated (or
asserted), routed and handled.

Wakeup power may be provided in-band or out-of-band (eg. from a
special wakeup power source) and wakeup signaling may be in-band (eg.
via the IRQ normally used by the device when it is not suspended) or
sideband (out-of-band; when there is a special setup for wakeup
signals).  All combinations are generally possible, but in-band wakeup
signaling usually implies in-band wakeup power (although not
necessarily the other way around).

Note that in your example you effectively have two devices, the SD
controller with no wakeup capability of its own and the card detect
pin which can signal wakeup (in-band) and requires in-band (from its
perspective) wakeup power.  Also note that the card detect pin doesn't
take any input from the SD controller, so treating it as part of the
SD controller's wakeup signaling is technically questionable.

>>
>> A wakeup signal usually means that something interesting happened
>> outside and that thing needs to be detected in the first place, most
>> likely by the device.
>>
>>> A very common scenario when this is the case, is when a wakeup signal is
>>> routed via GPIO IRQ.

Routing via a GPIO IRQ doesn't mean that it always works like the card
detect pin given in the example.  Usually, some input from the device
is necessary to activate the IRQ pin.

>>> In these cases, genpd still leaves the device powered on, as well as
>>> its PM domain, thus wasting power during system suspend.
>>
>> Which probably is the right thing to do.
>
> No, it isn't, simply because it would waste power.

It would cause the system to draw more power than necessary.

[Power is the rate of the flow of energy and so it cannot be wasted.
Energy can be wasted, but only in the sense in which fresh water can
be wasted.]

Yes, it would, but that may not be because the domain handling is wrong.

> Especially for those SoCs, which may have an external HW logic
> (perhaps via co-processor) that can be informed from the irqchip
> driver, to deal with wakeup GPIO IRQs during system sleep.
>
> In these cases, keeping the device and PM domain powered would
> potentially waste a lot of power, which is critical case for battery
> driven platforms.

In the absence of any numbers it is hard to say what "a lot" means. :-)

Moreover, your argumentation goes like this:

"I have a case in which two different devices are handled as one by a
single driver.   They are functionally related, so they are
represented as a single entity.  Unfortunately, when remote wakeup
comes into play, that one entity is not handled adequately, because I
have no way to specify that part of it may be turned off completely,
while the other part has to stay on power for wakeup to work."

Fair enough, but the representation used here may be the source of the problem.

>>
>>> 2)
>>> The are cases when device_may_wakeup() returns true for a device, but
>>> because there are no consumers registered for the system wakeup IRQ,
>>> it doesn't make sense for the driver to configure system wakeup for
>>> the device during system suspend. An example of this, exists in the
>>> mmc subsystem, when an SDIO controller driver, during system suspend,
>>> realizes that there are no SDIO functional driver (a WiFi driver for
>>> example) that wants system wakeup signals (SDIO IRQs) to be delivered.
>>
>> This isn't genpd-specific, but general.
>
> I fully agree. I just wanted to give genpd as an example.
>
>>
>> device_may_wakeup() currently means that the device can and is allowed
>> (by user space) to signal wakeup, but if the device is just a man in
>> the middle and merely passes wakeup signals from its children or
>> consumers, it is not necessary to configure it for wakeup when none of
>> them are allowed to wake up the system.
>>
>> So far we have just enabled wakeup unconditionally for such "passive"
>> devices, although that indeed generally isn't particularly
>> energy-efficient, but it is simple and it allowed us to avoid quite
>> some headaches.
>
> I am not suggesting to change existing behavior, to for example, for
> ACPI PM domain.
>
> However, I am looking for how we can find a way for drivers to provide
> additional information to the upper layers about its wakeup
> configuration, since device_may_wakeup() don't give the full story.
> Then, what upper layers decide to do with this information, have to be
> decided on case by case.
>
> Perhaps ACPI PM domain could benefit from this information, but if
> not, there should be no harm.

I'm inclined to agree that the handling of "passive wakeup" devices
(that merely propagate wakeup signals from their "consumers") could be
improved (probably by something along the lines of wakeup_path, but
that also needs to work for runtime PM), so that they aren't
configured for wakeup unnecessarily (which may lead to excessive
energy usage).  Everybody might benefit from that, but for this
purpose it has to be consistent across the core, middle layers and
drivers.

The handling of devices that need in-band wakeup power (but not
in-band wakeup signaling) may be arranged with the help of
PM_QOS_FLAG_NO_POWER_OFF.  At least I haven't seen any arguments to
the contrary so far.

The handling of the cases like in your example seems to be possible to
arrange without any extra changes beyond the above.  At least I don't
see why it can't be done at this point.

>>
>>> Again, the problem boils done to that the middle-layer/PM domain, only
>>> can check the ->dev.power.wakeup_path flag to know if the device needs
>>> to stay power on during system suspend, while in fact in both case 1)
>>> and case 2), the device could have been powered off.
>>>
>>> I think, to cope with these scenarios, we need a way for drivers to
>>> inform the middle-layer/PM domain, that the driver is fine with
>>> powering off the device and its PM domain during system suspend. Of
>>> course, then its up to the middle-layer/PM domain to act on this.
>>
>> I'm not sure why you want it this way and why it makes sense even.
>
> Because it's only the driver that has this information.

If you mean something like "I use an unusual representation of things,
so please bear with me", then I may agree, but then I may not be quite
willing to make any changes in support of that.

> Somehow it needs to passed along, so upper layers can decide what to do with it.
>
>>
>> The handling of "passive" devices requires two things: an indication
>> that the device is "passive" and the tracking of its "consumers".
>> wakeup_path only is a poor man's substitute for the latter.
>
> We don't have to use the wakeup_path flag for this, we can have a
> separate flag/status bits for this.
>
> The thing I was talking about above, was that currently the PM domain
> only have the information in the ->dev.power.wakeup_path flag to act
> on (and the device_may_wakeup()) but it's not sufficient to take the
> best decision.

It may not be sufficient, yes.

That's why I sent the original message in this thread in the first place.

I asked specifically about devices needing in-band wakeup power and
you just started to talk about other things.

I guess we just need to make a list of issues to address, have a look
at the related code in detail and then try to design something
properly.

Thanks,
Rafael
