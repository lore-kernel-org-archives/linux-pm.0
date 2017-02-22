From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 0/6] PSCI: Fix non-PMIC wake-up if SYSTEM_SUSPEND cuts power
Date: Wed, 22 Feb 2017 14:38:59 +0100
Message-ID: <CAMuHMdXpKrJn9NrkAarvMtytk9gHEFcRoZLCsWBFgriUCeWo=Q@mail.gmail.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <94167d3a-e005-3af0-d290-a1086684d570@arm.com> <3c8b3f2d-8604-f999-4208-a82f171b64f2@arm.com>
 <1975396.x0czmkNPOW@aspire.rjw.lan> <35840771-e16f-d6fe-3a89-1b3f51f4a8f3@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <35840771-e16f-d6fe-3a89-1b3f51f4a8f3@arm.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lina Iyer <lina.iyer@linaro.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Sudeep,

On Wed, Feb 22, 2017 at 12:03 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 22/02/17 01:14, Rafael J. Wysocki wrote:
>> On Tuesday, February 21, 2017 06:45:13 PM Sudeep Holla wrote:
>
> [...]
>
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
>>
>
> True. In this Renasas platform, since the platform doesn't have PSCI
> system suspend, we can only support s2idle and not s2ram. In this case

Not correct: this Renesas platform does have PSCI system suspend.
So s2ram "works" (it suspends the system, which can be resumed by a switch)

> we don't ask platform to enter some system state whereas we suspend all
> the devices(leaving wakeup capable devices active) and ask platform to
> enter deepest idle state on all the CPUs. I still don't understand the
> issue Geert is facing.

PSCI system suspend does not support wake-up sources configured from Linux.
Hence I cannot use PSCI system suspend if any wake-up sources have been
configured from Linux, and I expect to be able to use them for wake-up.

> Geert, so far you have failed to explain what's different from the new
> state you are adding and the existing s2idle.

I did explain, cfr.:
  1. The power consumption figures in the cover letter:
      - shallow:    8.4 W   6.2 W   (secondary CPU cores off)
  2. The description for patch 3/6:
        As secondary CPU cores are taken offline, "shallow" suspend mode saves
        slightly more power than "s2idle", but less than "deep" suspend mode.
        However, unlike "deep" suspend mode, "shallow" suspend mode can be used
        regardless of the presence of support for PSCI_SYSTEM_SUSPEND, which is
        an optional API in PSCI v1.0.

>> As for the device wakeup disable/enable interface, it is for controlling
>> whether or not a given device should be allowed to generate wakeup signals at
>> all.
>>
>> The information on what states a given device can wake up the system from is
>> platform-specific and generally would need to be taken into consideration at
>> the platform level.
>
> Exactly, that's what I am trying to convince Geert ;)

So, how does the communication of wake-up sources happens between PSCI
and Linux?

Perhaps, I didn't make myself clear. Let's summarize:
  1. On Renesas R-Car Gen3 platforms, PSCI SYSTEM_SUSPEND is implemented,
  2. On these platforms, PSCI SYSTEM_SUSPEND powers down the SoC, and supports
     wake-up from PMIC only,
  3. If the user wants to use a different wake-up source, these other
wake-up sources fail
     to wake up the system from PSCI SYSTEM_SUSPEND.,
  4. Patch 3/6 adds a new "shallow" state, as it allows to save more
power (the difference
     may be due to suboptimal cpuidle platform support on R-Car Gen3, though),
  5. Patch 4/6 makes the system use the new "shallow" state iff
       a. the user has configured other wake-up sources, and
       b. DT advertises that PSCI will power down the SoC on SYSTEM_SUSPEND,
     hence other wake-up sources now work as expected.

(If you're so against implementing the "shallow" state, it's a red herring,
 and that patch can be dropped.  Patch 4/6 can be trivially modified, as
 all it does is call cpu_do_idle() instead).

E.g. on non-PSCI platforms with an Ethernet driver that supports
Wake-on-LAN, I can do:

        ethtool -s eth0 wol g
        echo mem > /sys/power/state

and be sure that the system can be woken up by sending a WoL MagicPacket.

On PSCI systems, the above may work, or may not work. And there's no way to
find out (in an automated way) whether it will work or not.

If it doesn't work, the user has to configure his system (manually) to
not use "mem" state.
Since v4.10-rc1, that can be done using e.g.

    echo s2idle > /sys/power/mem_sleep

and my patches make that automatic (for a new "shallow" state instead
of "s2idle", though).

So all of this is a usability issue, and a nightmare for userspace
that wants to treat
different platforms in a generic way (e.g. for distros).

I hope this time it's clear what I want to achieve, and how.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
