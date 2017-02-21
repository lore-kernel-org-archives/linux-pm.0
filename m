From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 0/6] PSCI: Fix non-PMIC wake-up if SYSTEM_SUSPEND cuts power
Date: Tue, 21 Feb 2017 17:21:06 +0100
Message-ID: <CAMuHMdWjseO3XSOH2XCbM411Aj12RpdZZbHkpfFUfej58myz5Q@mail.gmail.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be> <69ab75a1-2e04-19e2-d1ad-12ca1cfc7625@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:34042 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753003AbdBUQVI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Feb 2017 11:21:08 -0500
In-Reply-To: <69ab75a1-2e04-19e2-d1ad-12ca1cfc7625@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lina Iyer <lina.iyer@linaro.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Sudeep,

On Tue, Feb 21, 2017 at 11:38 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 20/02/17 20:33, Geert Uytterhoeven wrote:
>> This patch series adds support for using non-PMIC wake-up sources on the
>> Renesas R-Car Gen3 (H3 or M3-W) Salvator-X development boards.
>>
>> Nothing in the PSCI specification requires the SoC to remain powered and
>> to support wake-up sources when suspended using SYSTEM_SUSPEND.
>> If the firmware implements the PSCI SYSTEM_SUSPEND operation by cutting
>> power to the SoC, the only possibly wake-up sources are thus the ones
>> connected to the PMIC.
>
> OK, but I don't see any issue with that. That's exactly how it works on

How do you use other wake-up sources, like wake on LAN, UART or GPIO?

> ARM Juno platform. The SoC is powered down.

Good to hear this is not limited to Renesas platforms, so there's a common
problem to solve.

>> To allow other wake-up sources, this patch series documents and adds
>> support for an "arm,psci-system-suspend-is-power-down" DT property, so
>
> NACK, you don't need any such properties.

If this is true for all PSCI platforms, there's indeed no need for such a
property, and drivers/firmware/psci.c should default to this case.

>> Linux uses a different suspend method when other wake-up sources (e.g.
>> wake on LAN, UART or GPIO) are enabled.  Hence the user no longer has to
>> manually restrict "mem" suspend to "s2idle" or "shallow" states using:
>
> Have you explored suspend-to-idle instead ? It looks like thats exactly
> what you are doing in this patch set. You also get low latency for free
> as it just enters the deepest idle state on all CPUs instead of
> hotplugging out all the secondaries.

Yes, cfr. "s2idle" above.
The user can specify to use "s2idle" manually:

    $ echo s2idle > /sys/power/mem_sleep # or "shallow"

However, how to handle this automatically, e.g. by a distro?
On most other platforms, userspace can just do e.g.

    ethtool -s eth0 wol g

to enable wake-on-LAN, and suspend to the deepest supported state using:

    echo mem > /sys/power/state

On systems where PSCI SYSTEM_SUSPEND powers down the SoC, userspace must
make sure to configure to use "s2idle" (or "shallow) instead, else the
configured wake-up sources won't work.
I want Linux to handle this automatically.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
