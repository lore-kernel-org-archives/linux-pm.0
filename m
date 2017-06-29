From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Clocks used by another OS/CPU
Date: Thu, 29 Jun 2017 14:45:39 +0200
Message-ID: <CAMuHMdXedexq_jGq+y3Hbmph1_1N_LjT7dhYJ=rC0Q2oK_Xjug@mail.gmail.com>
References: <CAMuHMdW9+CNTTOVO4SRRUxuz3ajLbY2j1uG8b_RpHX52NPwXrQ@mail.gmail.com>
 <CAMuHMdWRadUCZUycUW3dKJhS__aRRVbV1tXo0umUQ7KHOYQMoQ@mail.gmail.com> <50911172-8fa1-8341-0ed0-d40f00d9392c@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <50911172-8fa1-8341-0ed0-d40f00d9392c@de.bosch.com>
Sender: linux-clk-owner@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@baylibre.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Dirk,

On Thu, Jun 29, 2017 at 2:07 PM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
> On 29.06.2017 13:56, Geert Uytterhoeven wrote:
>> On Thu, Jun 29, 2017 at 11:27 AM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>>> CC clock, ARM, DT, PM people
>>>
>>> TL;DR: Clocks may be in use by another CPU not running Linux, while Linux
>>> disables them as being unused.
>>
>>> Of course this is not limited to clocks, but also to e.g. PM domains.
>>
>> BTW, how do you prevent Linux from powering down the CR7 PM domain,
>> which contains the Cortex R7?
>
> The idea is
>
> --- a/drivers/soc/renesas/r8a7795-sysc.c
> +++ b/drivers/soc/renesas/r8a7795-sysc.c
> @@ -38,7 +38,8 @@ static const struct rcar_sysc_area r8a7795_areas[]
> __initconst = {
>         { "ca53-cpu3",  0x200, 3, R8A7795_PD_CA53_CPU3, R8A7795_PD_CA53_SCU,
>           PD_CPU_NOCR },
>         { "a3vp",       0x340, 0, R8A7795_PD_A3VP,      R8A7795_PD_ALWAYS_ON
> },
> -       { "cr7",        0x240, 0, R8A7795_PD_CR7,       R8A7795_PD_ALWAYS_ON
> },
> +       { "cr7",        0x240, 0, R8A7795_PD_CR7,
> R8A7795_PD_ALWAYS_ON,
> +         PD_CPU_NOCR },
>         { "a3vc",       0x380, 0, R8A7795_PD_A3VC,      R8A7795_PD_ALWAYS_ON
> },
>         { "a2vc0",      0x3c0, 0, R8A7795_PD_A2VC0,     R8A7795_PD_A3VC },
>         { "a2vc1",      0x3c0, 1, R8A7795_PD_A2VC1,     R8A7795_PD_A3VC },
>
>
> Not finally tested, though.

Pretending the CR7 PM Domain can only be controlled through WFI/APMU only should
work.
But IMHO it is a hack, just like your solution for the CANFD clock.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
