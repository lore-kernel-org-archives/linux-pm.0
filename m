From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 0/6] PSCI: Fix non-PMIC wake-up if SYSTEM_SUSPEND cuts power
Date: Tue, 21 Feb 2017 18:34:23 +0100
Message-ID: <CAMuHMdUS96tPJRqNxG6sJjvC0LN-FjCeKOm7Zg2V_qMeQ_1QSQ@mail.gmail.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <69ab75a1-2e04-19e2-d1ad-12ca1cfc7625@arm.com> <CAMuHMdWjseO3XSOH2XCbM411Aj12RpdZZbHkpfFUfej58myz5Q@mail.gmail.com>
 <445b2f49-5d15-30af-a431-1c4edcd049a4@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34521 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753515AbdBURe0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Feb 2017 12:34:26 -0500
In-Reply-To: <445b2f49-5d15-30af-a431-1c4edcd049a4@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lina Iyer <lina.iyer@linaro.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Sudeep,

On Tue, Feb 21, 2017 at 5:45 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 21/02/17 16:21, Geert Uytterhoeven wrote:
>> On Tue, Feb 21, 2017 at 11:38 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>> On 20/02/17 20:33, Geert Uytterhoeven wrote:
>>>> This patch series adds support for using non-PMIC wake-up sources on the
>>>> Renesas R-Car Gen3 (H3 or M3-W) Salvator-X development boards.
>>>>
>>>> Nothing in the PSCI specification requires the SoC to remain powered and
>>>> to support wake-up sources when suspended using SYSTEM_SUSPEND.
>>>> If the firmware implements the PSCI SYSTEM_SUSPEND operation by cutting
>>>> power to the SoC, the only possibly wake-up sources are thus the ones
>>>> connected to the PMIC.
>>>
>>> OK, but I don't see any issue with that. That's exactly how it works on
>>
>> How do you use other wake-up sources, like wake on LAN, UART or GPIO?
>
> From wakeup source configuration/management perspective, s2ram and
> s2idle are exactly same.

>From the point of view of Linux, that's indeed the case. Linux knows about e.g.
interrupt controllers to keep awake if they're needed for one of the configured
wake-up sources.

PSCI does not know about the wake-up sources configured under Linux.

>>> ARM Juno platform. The SoC is powered down.
>>
>> Good to hear this is not limited to Renesas platforms, so there's a common
>> problem to solve.
>
> No, there's no problem to solve. Firmware should enter deepest sleep
> state in the system with SYSTEM_SUSPEND from which it can wakeup of course.

While SYSTEM_SUSPEND can wake up (e.g. from PMIC), it may not support all
wake-up sources configured from Linux. There's no API to communicate that
information (from Linux to PSCI), or to communicate that limitation (from
PSCI to Linux).

>>>> To allow other wake-up sources, this patch series documents and adds
>>>> support for an "arm,psci-system-suspend-is-power-down" DT property, so
>>>
>>> NACK, you don't need any such properties.
>>
>> If this is true for all PSCI platforms, there's indeed no need for such a
>> property, and drivers/firmware/psci.c should default to this case.
>
> Cool.
>
>>>> Linux uses a different suspend method when other wake-up sources (e.g.
>>>> wake on LAN, UART or GPIO) are enabled.  Hence the user no longer has to
>>>> manually restrict "mem" suspend to "s2idle" or "shallow" states using:
>>>
>>> Have you explored suspend-to-idle instead ? It looks like thats exactly
>>> what you are doing in this patch set. You also get low latency for free
>>> as it just enters the deepest idle state on all CPUs instead of
>>> hotplugging out all the secondaries.
>>
>> Yes, cfr. "s2idle" above.
>> The user can specify to use "s2idle" manually:
>>
>>     $ echo s2idle > /sys/power/mem_sleep # or "shallow"
>
> This looks like custom file for me.

/sys/power/mem_sleep was added in v4.10-rc1, to choose which state to use
for s2ram, cfr. Documentation/power/states.txt.

> IIUC, the standard sysfs file for the system PM state is:
>         /sys/power/state
> 1. s2ram:
>         $ echo mem > /sys/power/state

As of v4.10-rc1, this will use either "s2idle", "shallow", or "deep" mode,
depending on availability and configuration through mem_sleep.
("deep" maps to PSCI SYSTEM_SUSPEND).

> 2. s2idle
>         $ echo freeze > /sys/power/state

Correct.

>> However, how to handle this automatically, e.g. by a distro?
>
> As above

I meant the "mem" one, which should not pick "deep" mode if it cannot wake-up
from that state using the configured wake-up sources.

>> On most other platforms, userspace can just do e.g.
>>
>>     ethtool -s eth0 wol g
>
> That should work.
>
>> to enable wake-on-LAN, and suspend to the deepest supported state using:
>>
>>     echo mem > /sys/power/state
>
> This will work only if PSCI SYSTEM_SUPEND is implemented. If the SoC
> can't wakeup if it's powered down, then it should not use that state
> to implement SYSTEM_SUSPEND in PSCI firmware or just return the
> SYSTEM_SUSPEND feature is not implemented in which case "freeze" is the
> next available state to enter.

The SoC can wake-up. It's just not guaranteed that it can wake-up using
the wakeup-source configured from Linux. Which wakeup-sources are available
depends on the actual PSCI implementation.  It's not specified by the PSCI
specification.

> Just botching whatever shallow state you can enter on a particular SoC
> into standard "mem" state sounds *horrible* to me.

That's more or less what /sys/power/mem_sleep does, though.

>> On systems where PSCI SYSTEM_SUSPEND powers down the SoC, userspace must
>> make sure to configure to use "s2idle" (or "shallow) instead, else the
>> configured wake-up sources won't work.
>
> That's perfect. I was worried that user-space is not doing that. So to
> summarize, PSCI firmware either:
> 1. enters a sane and resumable state in SYSTEM_SUSPEND api

In this case, it may resume using the PMIC only.
And there's no way for userspace (or even the kernel) to find out!
Hence my solution to:
  - add a DT property to indicate that PSCI will power down the SoC,
  - use "shallow" suspend if any Linux wakeup-sources have been configured
    and the property above is present.

> or
> 2. just don't implement SYSTEM_SYSTEM. Use the cpuidle+s2idle framework
>    in Linux to enter the deepest idle state.

In that case, it indeeds falls back to cpuidle/s2idle, which works fine.

> You literally need no extra work to enter this "freeze" state if the
> CPU_SUSPEND in PSCI can enter the deepest idle state you want to enter
> in this "s2idle" you are referring so far.
> Just start with:
>
>         $ cat /sys/power/state
>
> and you should see "freeze" there, if not that's the first thing to
> check provided the platform has cpuidle working.

"freeze" is always available.
"deep" is available if PSCI supports SYSTEM_SUSPEND.
My third patch adds "shallow", but it can be dropped (patch 4 can fall
through to cpu_do_idle() when needed, regardless of the existence of shallow).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
