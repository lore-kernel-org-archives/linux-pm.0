From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFD] Devices that need full power for wakeup
Date: Thu, 25 Jan 2018 17:08:47 +0100
Message-ID: <CAJZ5v0jeShwYjUzvtTYiFO7PaSJwz6SveMPVZvqnVZ59A0cmkw@mail.gmail.com>
References: <CAJZ5v0jf_CVsZOQj4ZzgU59Z9ketb_aNu0UdgMmgXyJwRc37Yg@mail.gmail.com>
 <CAJZ5v0iFGQ5uSvjk8mKUnVNL2=sT97qmHRaY9c5w4q8KHZfe_Q@mail.gmail.com>
 <CAPDyKFo+c_Hd9w-VhTx2KPVKF2k=iJdbomT4Hi_mMLgpWkdetw@mail.gmail.com>
 <1871558.5ybir6VhFs@aspire.rjw.lan> <CAPDyKFonEA6iphhPZWyqVbfFG8VbzK80bk8njuR06y_b-7uwDw@mail.gmail.com>
 <CAJZ5v0h9OniDdLGkSEpU1eKmYKfi49HaG6pBeZYKwtPP9w+LBg@mail.gmail.com>
 <CAPDyKFpy9NQkN60sFwstveQg9T-1HLduGGXNF8+1QeRs8EvJQg@mail.gmail.com> <CAPDyKFradfq8Y2R=NcfJLVJ7_+XgAPUFRv3=t_v-9xwUW6XTiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f181.google.com ([74.125.82.181]:37045 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeAYQIs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jan 2018 11:08:48 -0500
Received: by mail-ot0-f181.google.com with SMTP id a24so7135443otd.4
        for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2018 08:08:48 -0800 (PST)
In-Reply-To: <CAPDyKFradfq8Y2R=NcfJLVJ7_+XgAPUFRv3=t_v-9xwUW6XTiw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Alan Stern <stern@rowland.harvard.edu>

On Wed, Jan 24, 2018 at 12:40 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> [...]
>
>>>
>>> Yes, it can enter the "suspended" metastate, but that metastate may be
>>> mapped to multiple physical states.  Which of them is actually used
>>> may depend on the power requirements of the children.
>>
>> Again, you are right.
>>
>> However, what you are describing is to me a different (but related)
>> and more complex problem. As you say, this is about how to support
>> *multiple* device idle states.
>>
>> My point is, trying to make use of PM_QOS_FLAG_NO_POWER_OFF, would in
>> principle enable support for *one* more device idle state. To me, that
>> doesn't sounds like a future proof solution. Don't we need something
>> more flexible?
>
> [...]
>
>>>> Another observation regarding the PM_QOS_FLAG_NO_POWER_OFF flag, is
>>>> that it's QOS thing, which may also be controlled from userspace via
>>>> sysfs. Using a QOS flag to prevent to turn of in-band power as to be
>>>> able to support wakeups correctly, just doesn't seems right to me. I
>>>> rather consider this as a HW configuration that must be set to support
>>>> a requested wakeup.
>>>
>>> User space may want in-band power to be provided to the device while
>>> suspended too and I'm not sure what's the difference between that and
>>> the wakeup requirement.
>>
>> I am not sure I understand, why user space need to care about what is
>> powered and not powered?
>>
>> User space have wakeups to control and can set QoS latency
>> constraints, isn't that sufficient in this regards?
>
> Moreover, if we consider the runtime PM case, userspace can also force
> a device to remain runtime resumed.
>
> It sounds to me that userspace don't need yet another interface,
> allowing it to control the in-band power for a device. Yeah, it's
> already there for usb ports, but perhaps we can get rid of that!?

Well, what about devices with multiple power states where the deepest
one only is power-off and the in-band power is there in the remaining
states?

In those cases user space may very well still want the device to be
suspended when not in use, but not in the deepest (power-off) state.

>>> The point here, among other things, is that it doesn't really matter
>>> *why* the device needs to be provided with in-band power while
>>> suspended.  Potentially, there may be multiple valid reasons for that
>>> and wakeup is only one of them, so why does it need to be special?
>>
>> Sure, it doesn't needs to be special as long as it can cope with all
>> different scenarios.
>
> I have started to think a little bit more about how to support the
> "multiple device idle state" thingy and I have started to prepare and
> RFC. In fact it seems like quite limited amount of code, at least
> initially.
>
> In regards to that, it sure seems like it would be possible to find a
> common way (both for system suspend and runtime suspend) to cope with
> the out-band vs in-band wakeup problem.
>
> In principle what I am thinking around that, is that we need way to
> disable/enable the deepest supported idle state for a device, as that
> seems to match turning off the in-band power for the device.

That sounds reasonable.

We do some of that for PCI devices and in ACPI PM already.

>>
>>>
>>>> Going back to what I think is needed. I think we need a per device PM
>>>> flag that the driver can set, to instruct upper layers about how it
>>>> has configured the wakeup (in-band or out-band). That flag needs to be
>>>> propagated to parents as well. Moreover, I am questioning whether such
>>>> flag may be useful for runtime PM, maybe it could.
>>>
>>> Upper layers need not be informed about wakeup in general, like genpd
>>> which only understands (a) whether or not to cut off in-band power and
>>> (b) whether or not to invoke the "stop" callback.  It doesn't need to
>>> care about why those two things may or may not be done.
>>
>> That's true.
>>
>> Still I am a bit worried about not doing the propagation, because we
>> then need to walk the hierarchy of children instead of just checking a
>> per device flag that has been propagated already.
>
> Alright, even if I am still a bit concerned about this, let's start
> simple and leave the parent driver to check the children.

Cool. :-)

>>>
>>> My first conclusion from the above is that the runtime PM case and the
>>> system-wide PM case are really the same from the wakeup setup
>>> perspective and I don't see general reasons for them to be handled
>>> differently.
>>>
>>> The way to communicate the requirements related to that to upper
>>> layers, parent drivers etc may be via PM QoS flags, but I'm not
>>> insisting on that.  It has just occurred to me that it is one possible
>>> way to do it and there was some work done in that direction.
>>
>> Okay, I see.
>
> Unless you have some additional thoughts, I plan to continue to cook
> the RFC for supporting multiple device idle states. When posted, we
> can continue the discussion around that instead.
>
> Do it sounds reasonable to you?

Yes, it does, looking forward to seeing the patches. :-)

[Sorry for the delayed responses, I've been in a totally different
time zone lately.]

Thanks,
Rafael
