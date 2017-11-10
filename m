From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/3] PM / Domain: renesas: Fix active wakeup behavior
Date: Fri, 10 Nov 2017 13:49:46 +0100
Message-ID: <CAPDyKFrstmMQ=R49EKXQ3fs=_pwhmJkaX8K0dY4u9OZVxY3Z4w@mail.gmail.com>
References: <1510234022-29442-1-git-send-email-geert+renesas@glider.be>
 <CAPDyKFrJ67POYoB1PQUjWEWxgzcGuBRUMKSs5NmjoyLOFLuk4A@mail.gmail.com> <CAMuHMdU84DFZmFACuXLqhFsR-Q+1d3GPG3NFPinLRW8=96BDCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:47716 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751142AbdKJMtr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Nov 2017 07:49:47 -0500
Received: by mail-io0-f182.google.com with SMTP id h70so13444094ioi.4
        for <linux-pm@vger.kernel.org>; Fri, 10 Nov 2017 04:49:47 -0800 (PST)
In-Reply-To: <CAMuHMdU84DFZmFACuXLqhFsR-Q+1d3GPG3NFPinLRW8=96BDCA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 10 November 2017 at 11:22, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf,
>
> On Fri, Nov 10, 2017 at 10:57 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 9 November 2017 at 14:26, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>>> If a device in a Renesas ARM SoC is part of a Clock Domain, and it is
>>> used as a wakeup source, it must be kept active during system suspend.
>>
>> Geert, I think we discussed this a bit already. I wonder if the above
>> is a correct statement for all devices in these PM domains, that has
>> wakeups?
>
> It is true for all wakeup sources (e.g. Ethernet and serial).
>
>> Don't these SoCs make use of any external logic (out-of-band IRQ) to
>> deal with the wakeup IRQs?
>>
>> For example, how is GPIO irqs dealt with in this regards?
>
> Interrupt controllers (incl. GPIO) may, depending on SoC type:
>   - be located in a controllable power area (SH/R-Mobile),
>   - may run from a controllable module clock (SH/R-Mobile, R-Car Gen2/Gen3,
>     RZ/A1, RZ/G1).
>
> So there are no out-of-band IRQs in the wakeup path, unless on SoCs where
> the interrupt controllers are in an always-on power area, AND run from a
> fixed clock. I think only R-Car Gen1 falls in that category.
> Still, R-Car Gen1 needs active_wakeup for wakeup sources.

Perhaps out-of-band IRQ is a too vague term. :-) Anyway, let me
elaborate a bit more.

Apologize for being so persistent, but I really want to get to bottom with this.

According to the statement above, it seems like IRQs (including GPIOs)
is controllable from a separate "power area" (or module clock). In
many ARM SoCs that "power area" is a separate piece of external logic,
sometimes it may even consist a small co-processor. I guess you
already know that, but wanted to point it out for clarity.

For that reason, some serial drivers re-routs its serial rx pin to a
GPIO IRQ to deal with wakeup, instead of keeping the serial device
always powered. This enables the GPIO IRQ to be managed by the
external logic, thus allowing the serial device and the PM domain it
is attached to, to be powered off. Especially during system suspend,
that may avoid wasting lots of power.

Another example, where I think a more fine grained method is preferred
over using GENPD_FLAG_ACTIVE_WAKEUP, is when an SD card controller has
an card detect pin hooked up to a GPIO. Thus the device_may_wakeup()
would return true for the SD card controller's struct device, but that
does not mean that the device needs to stay powered during system
suspend.

>
> See series "[PATCH/RFC 0/3] renesas: irqchip: Use wakeup_path i.s.o.
> explicit clock handling", which includes GPIO interrupts.
>
>> If that is the case, you should really avoid using the big hammer
>> method of setting the GENPD_FLAG_ACTIVE_WAKEUP.
>
> So I think I do need the big hammer ;-)

>From a hypothetical point of view, if you were to use the more fine
grained method I proposed [1] (or something very similar), how many
drivers would you need to change, to be able to remove the current
workaround?

[...]

Kind regards
Uffe

[1]
https://www.spinics.net/lists/linux-renesas-soc/msg19911.html
