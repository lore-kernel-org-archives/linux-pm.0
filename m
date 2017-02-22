From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 4/6] drivers: firmware: psci: Fix non-PMIC wake-up if
 SYSTEM_SUSPEND cuts power
Date: Wed, 22 Feb 2017 15:05:44 +0100
Message-ID: <CAMuHMdW8JAYrgvWxi8c_ZLtsUWBYFGZ=V7pu2p+cO=NdwLas2w@mail.gmail.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-5-git-send-email-geert+renesas@glider.be> <20170221174844.GE8605@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170221174844.GE8605@leverpostej>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lina Iyer <lina.iyer@linaro.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Mark,

On Tue, Feb 21, 2017 at 6:48 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Feb 20, 2017 at 09:33:27PM +0100, Geert Uytterhoeven wrote:
>> @@ -440,12 +442,14 @@ static int psci_system_suspend_valid(suspend_state_t state)
>>  static int psci_system_suspend_enter(suspend_state_t state)
>>  {
>>       switch (state) {
>> +     case PM_SUSPEND_MEM:
>> +             if (!psci_system_suspend_is_power_down ||
>> +                 !wakeup_source_available())
>> +                     return cpu_suspend(0, psci_system_suspend);
>> +             /* fall through */
>
> I don't believe that this is the correct place to handle this.
>
> The wakeup_source_available() check *might* be ok, though even with that
> I'd rather we rejected the request rather than trying to fall back to a
> PSCI_CPU_SUSPEND. Otherwise we have a potential silent power regression.

If we reject the request here, I think the PM core has to be modified to
try again using a shallower state. Note that it would be better to reject
the state in the .valid() callback instead of in .enter().

You also have to consider this is dynamic not static.
I.e. the availability of other wake-up sources may change at runtime (cfr.
the "wakeup" files in sysfs). Currently pm_sleep_states[] (which controls
which states are available) is initialized from suspend_set_ops(), and not
changed later.

Perhaps pm_sleep_states[] should be updated every time the wakeup_sources
list is changed?

> I can imagine that there are cases where the wakeup source is completely
> external and invisible to Linux (e.g. a power button that has no
> programming interface, and isn't desscribed at all). In that case, even
> the wakeup_source_available() check might be too much. :/

You mean the wakeup source that actually wakes up the system from PSCI
SYSTEM_SUSPEND? On Renesas boards, that's a switch wired to the PMIC,
and currently not described in DT.  Describing it in DT could indeed interfere
with wakeup_source_available() :-(

> What we could/should do is expose to userspace which suspend cases a
> device can wake up the system from and/or whether a wakeup source is
> suitable configured for a state currently. That way userspace can
> determine whether it is gauranteed to be woken.

Right.  And that information should come from DT?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
