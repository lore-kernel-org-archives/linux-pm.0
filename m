From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 0/6] PSCI: Fix non-PMIC wake-up if SYSTEM_SUSPEND cuts power
Date: Thu, 23 Feb 2017 16:26:33 +0100
Message-ID: <CAMuHMdVTEbqEocYwu=KW_uXpykYkVwUgSJBnLvQp_Epn8Pjp1g@mail.gmail.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <94167d3a-e005-3af0-d290-a1086684d570@arm.com> <3c8b3f2d-8604-f999-4208-a82f171b64f2@arm.com>
 <1975396.x0czmkNPOW@aspire.rjw.lan> <35840771-e16f-d6fe-3a89-1b3f51f4a8f3@arm.com>
 <CAMuHMdXpKrJn9NrkAarvMtytk9gHEFcRoZLCsWBFgriUCeWo=Q@mail.gmail.com> <f649d707-8b0a-5ca9-b021-93ae8cf66b33@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f649d707-8b0a-5ca9-b021-93ae8cf66b33@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lina Iyer <lina.iyer@linaro.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Sudeep,

On Wed, Feb 22, 2017 at 3:32 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 22/02/17 13:38, Geert Uytterhoeven wrote:
>> On Wed, Feb 22, 2017 at 12:03 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>> On 22/02/17 01:14, Rafael J. Wysocki wrote:
>>>> On Tuesday, February 21, 2017 06:45:13 PM Sudeep Holla wrote:
>>> Geert, so far you have failed to explain what's different from the new
>>> state you are adding and the existing s2idle.
>>
>> I did explain, cfr.:
>>   1. The power consumption figures in the cover letter:
>>       - shallow:    8.4 W   6.2 W   (secondary CPU cores off)
>
> That's because your CPU_SUSPEND implementation is incomplete. You can
> enter the same state as secondary CPU core off even with idle. It's just
> that we can save by not entering and exiting the CPU hotplug state
> machine. So this "shallow" state can be achieved if your CPU_SUSPEND
> implements that state.

Does that include power areas?

>>   2. The description for patch 3/6:
>>         As secondary CPU cores are taken offline, "shallow" suspend mode saves
>>         slightly more power than "s2idle", but less than "deep" suspend mode.
>>         However, unlike "deep" suspend mode, "shallow" suspend mode can be used
>>         regardless of the presence of support for PSCI_SYSTEM_SUSPEND, which is
>>         an optional API in PSCI v1.0.
>
> Yes I understood that, you need to add an extra idle states to get that
> shallow state. We have discussed this in past to depth. On ARM64/PSCI,
> we will that support "shallow" system suspend mode which can't be
> defined generically. Also we can support this shallow state with s2idle.
>
> Your system probably not supporting all the CPU idle states. E.g.: it
> may just support CPU ON/OFF/RET and not cluster ON/OFF/RET. Please add
> that state to CPU_SUSPEND implementation in the firmware.

I can find CPU_ON and CPU_OFF in the PSCI specification, but not
CPU_RET?

How is the cluster ON/OFF/RET called exactly? I can't find any CLUSTER_*
calls in the PSCI specification.

>From a quick glance in the PSCI sources, there's some support for powering
down clusters.

>> Perhaps, I didn't make myself clear. Let's summarize:
>>   1. On Renesas R-Car Gen3 platforms, PSCI SYSTEM_SUSPEND is implemented,
>
> OK got that.
>
>>   2. On these platforms, PSCI SYSTEM_SUSPEND powers down the SoC, and supports
>>      wake-up from PMIC only,
>
> OK
>
>>   3. If the user wants to use a different wake-up source, these other
>> wake-up sources fail to wake up the system from PSCI SYSTEM_SUSPEND.
>
> In that case don't enter PSCI SYSTEM_SUSPEND

Or prevent the system from doing that...

>>   4. Patch 3/6 adds a new "shallow" state, as it allows to save more
>> power (the difference may be due to suboptimal cpuidle platform support on R-Car Gen3, though),
>
> Why can't you do that in s2idle mode. Please give me the difference
> between your shallow state and s2idle state, not just power numbers
> but the actual state of CPUs and the devices in the system.

>From the Linux side, there's not much difference, except that the secondary
CPU cores are disabled.  As that is handled by PSCI, the difference may be
in the PSCI implementation.  I will have to check that...

On these SoCs, the individual CPU cores and the SCU/L2 are in separate
(nested) power areas.  Perhaps these power areas are turned off when
disabling the CPU cores, but not when suspending them.

>> E.g. on non-PSCI platforms with an Ethernet driver that supports
>> Wake-on-LAN, I can do:
>>
>>         ethtool -s eth0 wol g
>>         echo mem > /sys/power/state
>>
>> and be sure that the system can be woken up by sending a WoL MagicPacket.
>
> Still possible with s2idle if CPU_SUSPEND is correctly implemented by
> the platform.

Sure. But not automatic, as it needs fiddling with mem_sleep.

>> On PSCI systems, the above may work, or may not work. And there's no way to
>> find out (in an automated way) whether it will work or not.
>>
>> If it doesn't work, the user has to configure his system (manually) to
>> not use "mem" state.
>> Since v4.10-rc1, that can be done using e.g.
>>
>>     echo s2idle > /sys/power/mem_sleep
>>
>> and my patches make that automatic (for a new "shallow" state instead
>> of "s2idle", though).
>
> How is that ? If "deep" is available as in your case too, why will
> shallow become default. IIUC the user still have to write "shallow"
> to mem_sleep.

After patch 4, if needed (DT property + extra wake-up sources configured),
psci_system_suspend_enter() will call cpu_do_idle() instead of
psci_system_suspend(). No need to fiddle with mem_sleep manually.

> Does this platform use generic arm64 DT cpuidle driver ? I don't see so
> from the DT.

I think that task isn't complete yet.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
