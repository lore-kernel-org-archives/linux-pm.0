From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH/RFC 0/6] PSCI: Fix non-PMIC wake-up if SYSTEM_SUSPEND cuts
 power
Date: Tue, 21 Feb 2017 16:45:13 +0000
Message-ID: <445b2f49-5d15-30af-a431-1c4edcd049a4@arm.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <69ab75a1-2e04-19e2-d1ad-12ca1cfc7625@arm.com>
 <CAMuHMdWjseO3XSOH2XCbM411Aj12RpdZZbHkpfFUfej58myz5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdWjseO3XSOH2XCbM411Aj12RpdZZbHkpfFUfej58myz5Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Geert,

On 21/02/17 16:21, Geert Uytterhoeven wrote:
> Hi Sudeep,
> 
> On Tue, Feb 21, 2017 at 11:38 AM, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org> wrote:
>> On 20/02/17 20:33, Geert Uytterhoeven wrote:
>>> This patch series adds support for using non-PMIC wake-up sources on the
>>> Renesas R-Car Gen3 (H3 or M3-W) Salvator-X development boards.
>>>
>>> Nothing in the PSCI specification requires the SoC to remain powered and
>>> to support wake-up sources when suspended using SYSTEM_SUSPEND.
>>> If the firmware implements the PSCI SYSTEM_SUSPEND operation by cutting
>>> power to the SoC, the only possibly wake-up sources are thus the ones
>>> connected to the PMIC.
>>
>> OK, but I don't see any issue with that. That's exactly how it works on
> 
> How do you use other wake-up sources, like wake on LAN, UART or GPIO?
> 

>From wakeup source configuration/management perspective, s2ram and
s2idle are exactly same.

>> ARM Juno platform. The SoC is powered down.
> 
> Good to hear this is not limited to Renesas platforms, so there's a common
> problem to solve.
> 

No, there's no problem to solve. Firmware should enter deepest sleep
state in the system with SYSTEM_SUSPEND from which it can wakeup of course.

>>> To allow other wake-up sources, this patch series documents and adds
>>> support for an "arm,psci-system-suspend-is-power-down" DT property, so
>>
>> NACK, you don't need any such properties.
> 
> If this is true for all PSCI platforms, there's indeed no need for such a
> property, and drivers/firmware/psci.c should default to this case.
> 

Cool.

>>> Linux uses a different suspend method when other wake-up sources (e.g.
>>> wake on LAN, UART or GPIO) are enabled.  Hence the user no longer has to
>>> manually restrict "mem" suspend to "s2idle" or "shallow" states using:
>>
>> Have you explored suspend-to-idle instead ? It looks like thats exactly
>> what you are doing in this patch set. You also get low latency for free
>> as it just enters the deepest idle state on all CPUs instead of
>> hotplugging out all the secondaries.
> 
> Yes, cfr. "s2idle" above.
> The user can specify to use "s2idle" manually:
> 
>     $ echo s2idle > /sys/power/mem_sleep # or "shallow"
> 

This looks like custom file for me.
IIUC, the standard sysfs file for the system PM state is:
	/sys/power/state
1. s2ram:
	$ echo mem > /sys/power/state
2. s2idle
	$ echo freeze > /sys/power/state

> However, how to handle this automatically, e.g. by a distro?

As above

> On most other platforms, userspace can just do e.g.
> 
>     ethtool -s eth0 wol g
> 

That should work.

> to enable wake-on-LAN, and suspend to the deepest supported state using:
> 
>     echo mem > /sys/power/state
> 

This will work only if PSCI SYSTEM_SUPEND is implemented. If the SoC
can't wakeup if it's powered down, then it should not use that state
to implement SYSTEM_SUSPEND in PSCI firmware or just return the
SYSTEM_SUSPEND feature is not implemented in which case "freeze" is the
next available state to enter.

Just botching whatever shallow state you can enter on a particular SoC
into standard "mem" state sounds *horrible* to me.

> On systems where PSCI SYSTEM_SUSPEND powers down the SoC, userspace must
> make sure to configure to use "s2idle" (or "shallow) instead, else the
> configured wake-up sources won't work.

That's perfect. I was worried that user-space is not doing that. So to
summarize, PSCI firmware either:
1. enters a sane and resumable state in SYSTEM_SUSPEND api
or
2. just don't implement SYSTEM_SYSTEM. Use the cpuidle+s2idle framework
   in Linux to enter the deepest idle state.

You literally need no extra work to enter this "freeze" state if the
CPU_SUSPEND in PSCI can enter the deepest idle state you want to enter
in this "s2idle" you are referring so far.
Just start with:

	$ cat /sys/power/state

and you should see "freeze" there, if not that's the first thing to
check provided the platform has cpuidle working.

Hope this helps.

-- 
Regards,
Sudeep
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
