From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH/RFC 0/6] PSCI: Fix non-PMIC wake-up if SYSTEM_SUSPEND cuts power
Date: Wed, 22 Feb 2017 15:31:31 +0100
Message-ID: <CAJZ5v0gh=t+yMhZcSc7tXbVdNhGynwomCkRYpMD0eC_RpyY4sw@mail.gmail.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <94167d3a-e005-3af0-d290-a1086684d570@arm.com> <3c8b3f2d-8604-f999-4208-a82f171b64f2@arm.com>
 <1975396.x0czmkNPOW@aspire.rjw.lan> <CAMuHMdUWMN1ZyRn=eL6MQZeZHOf5zOC=njdnuL9-9CDS2h8CMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdUWMN1ZyRn=eL6MQZeZHOf5zOC=njdnuL9-9CDS2h8CMQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 22, 2017 at 2:14 PM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> Hi Rafael,
>
> On Wed, Feb 22, 2017 at 2:14 AM, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
>> On Tuesday, February 21, 2017 06:45:13 PM Sudeep Holla wrote:
>>> On 21/02/17 18:27, Sudeep Holla wrote:
>>> > On 21/02/17 17:51, Sudeep Holla wrote:
>>> >> On 21/02/17 17:34, Geert Uytterhoeven wrote:
>>> >>> That's more or less what /sys/power/mem_sleep does, though.
>>> >>
>>> >> OK, I will go through that in detail.
>>> >
>>> > OK, I went through the patch and the main intention is was added.
>>> > So I will begin by summarizing my understanding:
>>> >
>>> > A new suspend interface(/sys/power/mem_sleep) is added to allow the
>>> > "mem" string in /sys/power/state to represent multiple things that can
>>> > be selected.
>>> >
>>> > Before:
>>> > A. echo freeze > /sys/power/state ---> Enters s2idle
>>> > B. echo mem > /sys/power/state ---> Enters s2r(a.k.a now deep mem sleep)
>>> >
>>> > After:
>>> > 1. echo freeze > /sys/power/state ---> Enters s2idle still same
>>> > 2. echo s2idle > /sys/power/mem_sleep
>>> >    echo mem > /sys/power/state ---> Also enter s2idle
>>> > 3. echo deep > /sys/power/mem_sleep
>>> >    echo mem > /sys/power/state ---> Also enter s2r(same as [B] above)
>>> >
>>> > Please note I have carefully dropped standby/shallow as we will not
>>> > support that state on ARM64 platforms(refer previous discussions for the
>>> > same)
>>> >
>>> > Now IIUC, you need 2 above. So, since this new interface allow mem to
>>> > mean "s2idle", we need to fix the core to register default suspend_ops
>>> > to achieve what you need.
>>>
>>> I take this back, you have everything you need in place, nothing needs
>>> to be done. I just checked again. If I don't register PSCI suspend_ops,
>>> I still get mem in /sys/power/state with s2idle in /sys/power/mem_sleep
>>> which is exactly what we need. Again we don't support standby/shallow
>>> state on ARM64/PSCI.
>>
>> Except for one thing which may or may not be a concern here.
>>
>> Suspend to idle should only go into states in which all of the available wakeup
>> devices work.  If there are devices that cannot wake you up from a given state,
>> this isn't "idle" any more, is it?
>
> Indeed. And I have no problem with handling wake-up sources from Linux,
> as Linux knows how to handle them.
>
>> As for the device wakeup disable/enable interface, it is for controlling
>> whether or not a given device should be allowed to generate wakeup signals at
>> all.
>
> OK. So it's not guaranteed that it will actually work...

No, it is not.

Enabling generation of wakeup signals at a device doesn't guarantee
that the interrupt (or GPIO etc) controller will be functional when
those signals reach it, for example.

There actually is no way to guarantee that in general.  In the ACPI
land, for example, devices may be able to wake up the system from S3,
but not from S4 or S5, and you can't say "I want that device to wake
up the system from S4", because that may be physically impossible to
achieve.

>> The information on what states a given device can wake up the system from is
>> platform-specific and generally would need to be taken into consideration at
>> the platform level.
>
> So that's PSCI on arm64?
> But the PSCI specification doesn't handle that.

In theory, that should be some code that knows how the platform is
configured and can set up things to work as expected.

That's why we have all of the platform hooks, syscore operations etc
(of course, all of that is not needed for suspend to idle, because it
is entered via the idle path and wakeup signals for wakeup devices
should be handled then).

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
