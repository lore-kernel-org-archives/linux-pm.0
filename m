From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 0/3] PM / Domain: renesas: Fix active wakeup behavior
Date: Fri, 10 Nov 2017 11:22:30 +0100
Message-ID: <CAMuHMdU84DFZmFACuXLqhFsR-Q+1d3GPG3NFPinLRW8=96BDCA@mail.gmail.com>
References: <1510234022-29442-1-git-send-email-geert+renesas@glider.be> <CAPDyKFrJ67POYoB1PQUjWEWxgzcGuBRUMKSs5NmjoyLOFLuk4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrJ67POYoB1PQUjWEWxgzcGuBRUMKSs5NmjoyLOFLuk4A@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Ulf,

On Fri, Nov 10, 2017 at 10:57 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 9 November 2017 at 14:26, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>> If a device in a Renesas ARM SoC is part of a Clock Domain, and it is
>> used as a wakeup source, it must be kept active during system suspend.
>
> Geert, I think we discussed this a bit already. I wonder if the above
> is a correct statement for all devices in these PM domains, that has
> wakeups?

It is true for all wakeup sources (e.g. Ethernet and serial).

> Don't these SoCs make use of any external logic (out-of-band IRQ) to
> deal with the wakeup IRQs?
>
> For example, how is GPIO irqs dealt with in this regards?

Interrupt controllers (incl. GPIO) may, depending on SoC type:
  - be located in a controllable power area (SH/R-Mobile),
  - may run from a controllable module clock (SH/R-Mobile, R-Car Gen2/Gen3,
    RZ/A1, RZ/G1).

So there are no out-of-band IRQs in the wakeup path, unless on SoCs where
the interrupt controllers are in an always-on power area, AND run from a
fixed clock. I think only R-Car Gen1 falls in that category.
Still, R-Car Gen1 needs active_wakeup for wakeup sources.

See series "[PATCH/RFC 0/3] renesas: irqchip: Use wakeup_path i.s.o.
explicit clock handling", which includes GPIO interrupts.

> If that is the case, you should really avoid using the big hammer
> method of setting the GENPD_FLAG_ACTIVE_WAKEUP.

So I think I do need the big hammer ;-)

>> Currently this is handled in device-specific drivers by explicitly
>> increasing the use count of the module clock when the device is
>> configured as a wakeup source, or if it is part of the wakeup path.
>>
>> However, this is merely a workaround.  The proper way to prevent the
>> device from being stopped is to inform this requirement to the genpd
>> core, using the new GENPD_FLAG_ACTIVE_WAKEUP flag introduced in commit
>> 95a20ef6f7e54c6a ("PM / Domains: Allow genpd users to specify default
>> active wakeup behavior").
>>
>> Hence this series does that for PM Domain drivers used on R-Car, RZ/A1,
>> RZ/G1 SoCs, mimicking what is already done succesfully on SH/R-Mobile
>> SoCs.  This will allow for the workarounds can be removed later.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
