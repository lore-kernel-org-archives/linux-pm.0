From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFD] Devices that need full power for wakeup
Date: Wed, 10 Jan 2018 11:21:46 +0100
Message-ID: <CAPDyKFpwVevhg7F==GdxDwDhbuTy5hPn6zMbq4WpqkBiDKbM+g@mail.gmail.com>
References: <CAJZ5v0jf_CVsZOQj4ZzgU59Z9ketb_aNu0UdgMmgXyJwRc37Yg@mail.gmail.com>
 <CAPDyKFqZ+ja5bu+G7ynTowq1CFQ2_k2zdA7qGbj3VagdB0yT4Q@mail.gmail.com> <CAJZ5v0hw_z5qGiGFGtJHLMfduEsH5c9y8q7ZFNCZdjwppP=GbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:40278 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755082AbeAJKVs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jan 2018 05:21:48 -0500
Received: by mail-it0-f48.google.com with SMTP id f190so15578581ita.5
        for <linux-pm@vger.kernel.org>; Wed, 10 Jan 2018 02:21:48 -0800 (PST)
In-Reply-To: <CAJZ5v0hw_z5qGiGFGtJHLMfduEsH5c9y8q7ZFNCZdjwppP=GbA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Alan Stern <stern@rowland.harvard.edu>

On 10 January 2018 at 02:22, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Mon, Jan 8, 2018 at 5:33 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 8 January 2018 at 12:51, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> Hi,
>>>
>>> First, let me characterize the problem the way I understand it and if
>>> my understanding of it is not correct, let me know why.
>>>
>>> There are devices that can only signal wakeup if they are provided
>>> with full "in-band" power (in contrast with devices that can signal
>>> wakeup with the help of a special "wakeup" power source, possibly of
>>> smaller capacity).  Suspending them via runtime PM is problematic
>>> because of the general assumption that wakeup should always be enabled
>>> for all runtime-suspended wakeup-capable devices which leads to sort
>>> of a Catch 22 situation in this particular case.
>>>
>>> Some drivers work around that by only allowing the device to be
>>> suspended if they know that it is not expected by user space to signal
>>> wakeup and they use the runtime PM usage counter to prevent the device
>>> from being suspended otherwise.  That works for runtime PM, but if the
>>> system goes to a sleep state, the runtime PM usage counter is not
>>> taken into account and the handling of the device may not be adequate
>>> and there is a question how to address that.
>>
>> As far as I understand, I would describe the problem a bit
>> differently. Let me elaborate on that.
>>
>> Genpd treats a device with the ->dev.power.wakeup_path flag set, as it
>> need to stay powered on during system suspend, thus also its PM
>> domain. There is nothing new around this, which make me think that we
>> should continue to treat that as being the default behavior.
>
> It actually does more than just preventing device (and domain) power
> from being turned off, as it causes the entire genpd_finish_suspend()
> to be skipped effectively in the genpd_is_active_wakeup() case.
>
> Nothing wrong with that in principle, but let's be precise.

Actually this code in genpd isn't entirely correct, even if it doesn't
cause any problems for now.

I know you have pointed to this behavior in genpd before, so I am
going to send a patch to make sure the code in genpd gets correct and
consistent.

>
>> This is also what Geert convinced to be the best, from earlier discussions.
>
> I'm not sure about that.  Geert seems to need power to stay on,
> nothing more, and that regardless of genpd_is_active_wakeup() AFAICS.

That was the initial problem, which is taken care of by using the
->dev.power.wakeup_path flag and the new helper,
device_set_wakeup_path().

This in combination of enabling genpd to deal with wakeups, as that is
currently not the default setting, which is done via setting the
GENPD_FLAG_ACTIVE_WAKEUP configuration flag.

The next part of the problems Geert pointed out was exactly those I am
describing here. Please have a look at his reply at:
https://www.mail-archive.com/linux-renesas-soc@vger.kernel.org/msg21157.html

>
>> However, there are a few related issues around system wakeups in
>> genpd, during system suspend.
>>
>> 1)
>> If the driver for the device, configures system wakeup as an
>> "out-band-wakeup", the device and its PM domain, don't need to stay
>> powered on during system suspend from the driver perspective.
>
> That depends.
>
> The wakeup signal has to be generated or asserted by something,
> presumably the device itself.

The cases I looking at don't require the device to be powered - at
least from the driver's perspective.

A classic example is a SD card detect pin, which is being routed to a
GPIO pin. In these case, that GPIO pin has no logic whatsoever,
coupled with the device for SD controller. Still, it needs to be
manged by the same device driver.

Therefore, device_may_wakeup() may returns true, if userspace wants to
wakeup the system from sleep when there is an SD card inserted.
Although, that doesn't mean we have to keep the logic for the SD
controller device being powered during system suspend, since it would
waste power.

>
> Out-of-band usually only means that the signal is routed in a special
> way different from the usual device's interrupt routing and not that
> the device is not involved in wakeup signaling at all.

Okay, so it's a matter of terminology. I had that feeling, as I have
seen "out-of-band" being used in different context, not always meaning
the same thing.

>
> A wakeup signal usually means that something interesting happened
> outside and that thing needs to be detected in the first place, most
> likely by the device.
>
>> A very common scenario when this is the case, is when a wakeup signal is
>> routed via GPIO IRQ.
>>
>> In these cases, genpd still leaves the device powered on, as well as
>> its PM domain, thus wasting power during system suspend.
>
> Which probably is the right thing to do.

No, it isn't, simply because it would waste power.

Especially for those SoCs, which may have an external HW logic
(perhaps via co-processor) that can be informed from the irqchip
driver, to deal with wakeup GPIO IRQs during system sleep.

In these cases, keeping the device and PM domain powered would
potentially waste a lot of power, which is critical case for battery
driven platforms.

>
>> 2)
>> The are cases when device_may_wakeup() returns true for a device, but
>> because there are no consumers registered for the system wakeup IRQ,
>> it doesn't make sense for the driver to configure system wakeup for
>> the device during system suspend. An example of this, exists in the
>> mmc subsystem, when an SDIO controller driver, during system suspend,
>> realizes that there are no SDIO functional driver (a WiFi driver for
>> example) that wants system wakeup signals (SDIO IRQs) to be delivered.
>
> This isn't genpd-specific, but general.

I fully agree. I just wanted to give genpd as an example.

>
> device_may_wakeup() currently means that the device can and is allowed
> (by user space) to signal wakeup, but if the device is just a man in
> the middle and merely passes wakeup signals from its children or
> consumers, it is not necessary to configure it for wakeup when none of
> them are allowed to wake up the system.
>
> So far we have just enabled wakeup unconditionally for such "passive"
> devices, although that indeed generally isn't particularly
> energy-efficient, but it is simple and it allowed us to avoid quite
> some headaches.

I am not suggesting to change existing behavior, to for example, for
ACPI PM domain.

However, I am looking for how we can find a way for drivers to provide
additional information to the upper layers about its wakeup
configuration, since device_may_wakeup() don't give the full story.
Then, what upper layers decide to do with this information, have to be
decided on case by case.

Perhaps ACPI PM domain could benefit from this information, but if
not, there should be no harm.

>
>> Again, the problem boils done to that the middle-layer/PM domain, only
>> can check the ->dev.power.wakeup_path flag to know if the device needs
>> to stay power on during system suspend, while in fact in both case 1)
>> and case 2), the device could have been powered off.
>>
>> I think, to cope with these scenarios, we need a way for drivers to
>> inform the middle-layer/PM domain, that the driver is fine with
>> powering off the device and its PM domain during system suspend. Of
>> course, then its up to the middle-layer/PM domain to act on this.
>
> I'm not sure why you want it this way and why it makes sense even.

Because it's only the driver that has this information. Somehow it
needs to passed along, so upper layers can decide what to do with it.

>
> The handling of "passive" devices requires two things: an indication
> that the device is "passive" and the tracking of its "consumers".
> wakeup_path only is a poor man's substitute for the latter.

We don't have to use the wakeup_path flag for this, we can have a
separate flag/status bits for this.

The thing I was talking about above, was that currently the PM domain
only have the information in the ->dev.power.wakeup_path flag to act
on (and the device_may_wakeup()) but it's not sufficient to take the
best decision.

>
>>>
>>> Assuming that the above description of the problem is accurate, here's
>>> how I see it.
>>>
>>> All depends on whether or not a device requiring full power for
>>> signaling wakeup is allowed to wake up the system from sleeps states.
>>> If it is not allowed to do that, it should be fully suspended during
>>> system transitions to sleep states regardless of its previous runtime
>>> PM status and (in the majority of cases) it may just be left in
>>> suspend if already suspended.
>>>
>>> The problematic case is when the device is allowed to wake up the
>>> system from sleep states, because it has to be provided with full
>>> power while the system is in a sleep state for the wakeup to work.
>>> Clearly, checking the runtime PM usage counter alone is not sufficient
>>> for that, because the wakeup counter may be nonzero for reasons other
>>> than wakeup and the driver may not be able to arrange things properly
>>> by itself during system-wide transitions, for example in the cases
>>> when the device belongs to a power domain managed by a separate code
>>> layer (like genpd).  This leads to the conclusion that it is necessary
>>> to provide an additional mechanism allowing all of the layers of code
>>> involved in the handling of the device to check what to do with it (or
>>> with the power domain it belongs to etc) during system-wide
>>> transitions to sleep state.
>>>
>>> In principle, that mechanism might be a new driver flag saying that
>>> power should not be removed from the device if device_may_wakeup()
>>> returns "true" for it.  However, there already is a similar thing in
>>> the kernel which already is taken into account by genpd_power_off()
>>> and which is the PM_QOS_FLAG_NO_POWER_OFF PM QoS flag.
>>>
>>> The existence of it means that drivers can use it for runtime PM in
>>> the first place instead of preventing devices from being suspended if
>>> they need to signal wakeup.  In principle, a driver may just set this
>>> flag and then suspend the device normally whenever that makes sense
>>> (of course, taking the flag into account if set) which may lead to
>>> reduced power draw if (say) device cloks may be gated without
>>> disturbing its wakeup capability.  Moreover, PM QoS requests may be
>>> added and removed at any time, so the driver may just set the flag or
>>> clear it whenever the device's wakeup settings change.
>>>
>>> And if this flag is taken into account by genpd_sync_power_off() too,
>>> using it may just be sufficient to address the concern at hand.
>>>
>>> Thoughts?
>>
>> As I tried to describe above, I think we rather need an "opt-out
>> method", rather than opt-in. In other words, a flag telling that the
>> device can be powered off, from the driver's perspective.
>>
>> I also think such flag needs to be propagated to parent devices,
>> similar to what we do for the wakeup_path flag.
>>
>> If this makes some sense, I can share some patches which I already in my pipe!?
>
> I'd rather like to agree on general rules to start with.

Yeah, let's continue here for while, then we can move on to code.

Kind regards
Uffe
