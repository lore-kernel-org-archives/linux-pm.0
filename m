From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH/RFC 0/6] PSCI: Fix non-PMIC wake-up if SYSTEM_SUSPEND cuts
 power
Date: Wed, 22 Feb 2017 14:32:10 +0000
Message-ID: <f649d707-8b0a-5ca9-b021-93ae8cf66b33@arm.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <94167d3a-e005-3af0-d290-a1086684d570@arm.com>
 <3c8b3f2d-8604-f999-4208-a82f171b64f2@arm.com>
 <1975396.x0czmkNPOW@aspire.rjw.lan>
 <35840771-e16f-d6fe-3a89-1b3f51f4a8f3@arm.com>
 <CAMuHMdXpKrJn9NrkAarvMtytk9gHEFcRoZLCsWBFgriUCeWo=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdXpKrJn9NrkAarvMtytk9gHEFcRoZLCsWBFgriUCeWo=Q@mail.gmail.com>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



On 22/02/17 13:38, Geert Uytterhoeven wrote:
> Hi Sudeep,
> 
> On Wed, Feb 22, 2017 at 12:03 PM, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org> wrote:
>> On 22/02/17 01:14, Rafael J. Wysocki wrote:
>>> On Tuesday, February 21, 2017 06:45:13 PM Sudeep Holla wrote:
>>
>> [...]
>>
>>>> I take this back, you have everything you need in place, nothing needs
>>>> to be done. I just checked again. If I don't register PSCI suspend_ops,
>>>> I still get mem in /sys/power/state with s2idle in /sys/power/mem_sleep
>>>> which is exactly what we need. Again we don't support standby/shallow
>>>> state on ARM64/PSCI.
>>>
>>> Except for one thing which may or may not be a concern here.
>>>
>>> Suspend to idle should only go into states in which all of the available wakeup
>>> devices work.  If there are devices that cannot wake you up from a given state,
>>> this isn't "idle" any more, is it?
>>>
>>
>> True. In this Renasas platform, since the platform doesn't have PSCI
>> system suspend, we can only support s2idle and not s2ram. In this case
> 
> Not correct: this Renesas platform does have PSCI system suspend.
> So s2ram "works" (it suspends the system, which can be resumed by a switch)
> 

Ah OK. Sorry for misunderstanding the platform support.

>> we don't ask platform to enter some system state whereas we suspend all
>> the devices(leaving wakeup capable devices active) and ask platform to
>> enter deepest idle state on all the CPUs. I still don't understand the
>> issue Geert is facing.
> 
> PSCI system suspend does not support wake-up sources configured from Linux.
> Hence I cannot use PSCI system suspend if any wake-up sources have been
> configured from Linux, and I expect to be able to use them for wake-up.
> 

OK, I thought I had told this before. What do you mean by PSCI system
suspend can't wakeup from the configured wakeup source. You just said
above that you can wake up from the switch.

Just enabling the wakeup sources in Linux doesn't mean you can enter
system suspend anytime. You must enter only the state from which you can
resume. And in your case if you can't wakeup from WLAN or wakeup source
you have configured then simply don't enter system suspend.

>> Geert, so far you have failed to explain what's different from the new
>> state you are adding and the existing s2idle.
> 
> I did explain, cfr.:
>   1. The power consumption figures in the cover letter:
>       - shallow:    8.4 W   6.2 W   (secondary CPU cores off)

That's because your CPU_SUSPEND implementation is incomplete. You can
enter the same state as secondary CPU core off even with idle. It's just
that we can save by not entering and exiting the CPU hotplug state
machine. So this "shallow" state can be achieved if your CPU_SUSPEND
implements that state.

>   2. The description for patch 3/6:
>         As secondary CPU cores are taken offline, "shallow" suspend mode saves
>         slightly more power than "s2idle", but less than "deep" suspend mode.
>         However, unlike "deep" suspend mode, "shallow" suspend mode can be used
>         regardless of the presence of support for PSCI_SYSTEM_SUSPEND, which is
>         an optional API in PSCI v1.0.
> 

Yes I understood that, you need to add an extra idle states to get that
shallow state. We have discussed this in past to depth. On ARM64/PSCI,
we will that support "shallow" system suspend mode which can't be
defined generically. Also we can support this shallow state with s2idle.

Your system probably not supporting all the CPU idle states. E.g.: it
may just support CPU ON/OFF/RET and not cluster ON/OFF/RET. Please add
that state to CPU_SUSPEND implementation in the firmware.

>>> As for the device wakeup disable/enable interface, it is for controlling
>>> whether or not a given device should be allowed to generate wakeup signals at
>>> all.
>>>
>>> The information on what states a given device can wake up the system from is
>>> platform-specific and generally would need to be taken into consideration at
>>> the platform level.
>>
>> Exactly, that's what I am trying to convince Geert ;)
> 
> So, how does the communication of wake-up sources happens between PSCI
> and Linux?
> 
> Perhaps, I didn't make myself clear. Let's summarize:
>   1. On Renesas R-Car Gen3 platforms, PSCI SYSTEM_SUSPEND is implemented,

OK got that.

>   2. On these platforms, PSCI SYSTEM_SUSPEND powers down the SoC, and supports
>      wake-up from PMIC only,

OK

>   3. If the user wants to use a different wake-up source, these other
> wake-up sources fail to wake up the system from PSCI SYSTEM_SUSPEND.

In that case don't enter PSCI SYSTEM_SUSPEND

>   4. Patch 3/6 adds a new "shallow" state, as it allows to save more
> power (the difference may be due to suboptimal cpuidle platform support on R-Car Gen3, though),

Why can't you do that in s2idle mode. Please give me the difference
between your shallow state and s2idle state, not just power numbers
but the actual state of CPUs and the devices in the system.

>   5. Patch 4/6 makes the system use the new "shallow" state iff
>        a. the user has configured other wake-up sources, and
>        b. DT advertises that PSCI will power down the SoC on SYSTEM_SUSPEND,
>      hence other wake-up sources now work as expected.
> 

Linux can just leave the wakeup interrupts enabled in the interrupt
controller and the PSCI implementation can understand that. That's what
we mean when we say platform must deal with that. It should not enter
the state blindly if it can't wake up with those sources. It's not
always necessary to communicate such details via dedicated PSCI APIs.
It's impossible and not scalable in a system with 100s of interrupt
sources. Platform can deal with that in better and simple ways than APIs
to exchange such information.

> (If you're so against implementing the "shallow" state, it's a red herring,
>  and that patch can be dropped.  Patch 4/6 can be trivially modified, as
>  all it does is call cpu_do_idle() instead).
> 

And again that's exactly what s2idle implementation. So NACK for each
patch in this series.

> E.g. on non-PSCI platforms with an Ethernet driver that supports
> Wake-on-LAN, I can do:
> 
>         ethtool -s eth0 wol g
>         echo mem > /sys/power/state
> 
> and be sure that the system can be woken up by sending a WoL MagicPacket.
> 

Still possible with s2idle if CPU_SUSPEND is correctly implemented by
the platform.

> On PSCI systems, the above may work, or may not work. And there's no way to
> find out (in an automated way) whether it will work or not.
> 
> If it doesn't work, the user has to configure his system (manually) to
> not use "mem" state.
> Since v4.10-rc1, that can be done using e.g.
> 
>     echo s2idle > /sys/power/mem_sleep
> 
> and my patches make that automatic (for a new "shallow" state instead
> of "s2idle", though).

How is that ? If "deep" is available as in your case too, why will
shallow become default. IIUC the user still have to write "shallow"
to mem_sleep.

Again to re-iterate, we will not support the not so well defined
"shallow" sleep state unless it's proved that the same can't be done
with cpuidle.

> 
> So all of this is a usability issue, and a nightmare for userspace
> that wants to treat different platforms in a generic way (e.g. for distros).
> 

Yes exactly and that's one reason why "shallow" is useless as it's not
well defined or should I say ill-defined.

> I hope this time it's clear what I want to achieve, and how.
> 

Yes, go and fix the CPU_SUSPEND to implement all the idle states correctly.

Does this platform use generic arm64 DT cpuidle driver ? I don't see so
from the DT.

-- 
Regards,
Sudeep
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
