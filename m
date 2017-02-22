From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH/RFC 0/6] PSCI: Fix non-PMIC wake-up if SYSTEM_SUSPEND cuts power
Date: Wed, 22 Feb 2017 15:50:39 +0100
Message-ID: <CAJZ5v0iheYM-qj8=bO3NZhoM5=8+TikYhm23EZV72HxNxUXDsg@mail.gmail.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <94167d3a-e005-3af0-d290-a1086684d570@arm.com> <3c8b3f2d-8604-f999-4208-a82f171b64f2@arm.com>
 <1975396.x0czmkNPOW@aspire.rjw.lan> <35840771-e16f-d6fe-3a89-1b3f51f4a8f3@arm.com>
 <CAMuHMdXpKrJn9NrkAarvMtytk9gHEFcRoZLCsWBFgriUCeWo=Q@mail.gmail.com> <f649d707-8b0a-5ca9-b021-93ae8cf66b33@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f649d707-8b0a-5ca9-b021-93ae8cf66b33-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 22, 2017 at 3:32 PM, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org> wrote:
>
>
> On 22/02/17 13:38, Geert Uytterhoeven wrote:
>> Hi Sudeep,
>>
>> On Wed, Feb 22, 2017 at 12:03 PM, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org> wrote:
>>> On 22/02/17 01:14, Rafael J. Wysocki wrote:
>>>> On Tuesday, February 21, 2017 06:45:13 PM Sudeep Holla wrote:
>>>
>>> [...]
>>>
>>>>> I take this back, you have everything you need in place, nothing needs
>>>>> to be done. I just checked again. If I don't register PSCI suspend_ops,
>>>>> I still get mem in /sys/power/state with s2idle in /sys/power/mem_sleep
>>>>> which is exactly what we need. Again we don't support standby/shallow
>>>>> state on ARM64/PSCI.
>>>>
>>>> Except for one thing which may or may not be a concern here.
>>>>
>>>> Suspend to idle should only go into states in which all of the available wakeup
>>>> devices work.  If there are devices that cannot wake you up from a given state,
>>>> this isn't "idle" any more, is it?
>>>>
>>>
>>> True. In this Renasas platform, since the platform doesn't have PSCI
>>> system suspend, we can only support s2idle and not s2ram. In this case
>>
>> Not correct: this Renesas platform does have PSCI system suspend.
>> So s2ram "works" (it suspends the system, which can be resumed by a switch)
>>
>
> Ah OK. Sorry for misunderstanding the platform support.
>
>>> we don't ask platform to enter some system state whereas we suspend all
>>> the devices(leaving wakeup capable devices active) and ask platform to
>>> enter deepest idle state on all the CPUs. I still don't understand the
>>> issue Geert is facing.
>>
>> PSCI system suspend does not support wake-up sources configured from Linux.
>> Hence I cannot use PSCI system suspend if any wake-up sources have been
>> configured from Linux, and I expect to be able to use them for wake-up.
>>
>
> OK, I thought I had told this before. What do you mean by PSCI system
> suspend can't wakeup from the configured wakeup source. You just said
> above that you can wake up from the switch.
>
> Just enabling the wakeup sources in Linux doesn't mean you can enter
> system suspend anytime. You must enter only the state from which you can
> resume. And in your case if you can't wakeup from WLAN or wakeup source
> you have configured then simply don't enter system suspend.

Well, not quite.

The sysfs wakeup setting for devices only means whether or not to
enable the generation of wakeup signals for them while suspending.  It
allows to *prevent* devices from waking up the system, but it doesn't
guarantee that they will actually wake up if enabled.

Now, the platform doesn't decide on the sleep state it will go to on
the basis of what devices have been enabled to wake up the system.
The states ("shallow", "deep") have to be defined upfront, including
what devices can wake up from the "shallow" and what devices can wake
up from the "deep" states (these lists need not be the same).  [As I
said before, the assumption is that all of them will be able to wake
up the system from suspend-to-idle.]

So, if user space triggers a transition to the "shallow" state, say,
it will be possible to wake up the system from it by devices that (a)
can wake it up from the "shallow" state as defined for the given
platform and (b) have been enabled to wake up the system via sysfs.

Conversely, if you have a system power state such that only a subset
of devices can wake up from it, it needs to be defined as either
"shallow" or "deep" and the list of possible wakeup sources is part of
that definition.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
