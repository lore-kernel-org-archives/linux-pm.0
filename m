From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Clocks used by another OS/CPU (was: Re: [RFC PATCH] clk: renesas:
 cpg-mssr: Add interface for critical core clocks)
Date: Mon, 3 Jul 2017 09:40:21 +0200
Message-ID: <CAMuHMdVgDNEf8Pe2HsqFpgFiTupVBa-7dvmSR6fJ4eS1LnzRxg@mail.gmail.com>
References: <CAMuHMdW9+CNTTOVO4SRRUxuz3ajLbY2j1uG8b_RpHX52NPwXrQ@mail.gmail.com>
 <CAL_JsqKGrZeR7z80beY_XEjqd5fEQQwPxusJ1FADoALgNE3fEg@mail.gmail.com>
 <20170630202453.eh6vaehkap3as4np@pengutronix.de> <8d86a9aa-1928-6b52-1487-d5fb9dae17f4@gmail.com>
 <20170701181408.yuocymwtj5dgt74d@pengutronix.de> <6098d579-f206-5a23-bbfc-ac13e0448479@gmail.com>
 <20170702092336.uxwl23kyd4koxclj@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170702092336.uxwl23kyd4koxclj@pengutronix.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Dirk Behme <dirk.behme@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>, linux-clk <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

Hi Uwe,

On Sun, Jul 2, 2017 at 11:23 AM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Sun, Jul 02, 2017 at 07:48:41AM +0200, Dirk Behme wrote:
>> > On my machine (Udoo Neo, A9 + M4) the A9 is the primary CPU that is
>> > started by the bootrom. If I want the M4 being the primary device I'd
>> > need support in the bootloader to wait long enough (i.e. until the M4 =
is
>> > up) before letting the A9 jump into Linux. Managable I'd say. This way
>> > would even make sense if the M4 runs a rt critical OS that shouldn't b=
e
>> > forced to wait on the non-rt A9 to enable a clk.
>>
>> Overall, assuming that the issue we are discussing here can be solved qu=
ite
>> easily in hardware (a set of clock registers for each CPU/OS domain,
>> connected cleverly to effectively control each clock, with access protec=
tion
>> for each set of registers) I tend to think that for a SoC supposed to ru=
n
>> different OS on different cores this is a missing hardware feature (bug?=
).
>
> So you want to enable bits for your CAN clock, one in each cpu's domain.
>
> I'd say that is a nice idea that a hardware engineer might be proud to
> pick up but that results in more headache than fun for the software
> colleague.
>
> There are several problems that come immediately to mind:
>
>  - You can switch of a clk because you don't need it on, or because you
>    need it off. I guess you want to have the clock on if at least one
>    cpu wants it on. So you take away the freedom from the other cpu to
>    force the clock off. (Yeah, the currently available clk framework
>    doesn't allow that either.)
>  - What if cpu 0 sets the parent of the can clk to pll2 but cpu 1 wants
>    it set to pll1? How does cpu 1 notice the change?
>  - On off might be relatively easy, what about clk dividers? cpu 0 sets
>    2 which cpu 1 sets 6.
>
> That convinces me that the disadvantages of having two views on the clk
> core have more weight and you really want a single view and share that
> by software.

Renesas ARM SoCs already implement (parts of) that.

There are separate sets of the Module SToP register bits for each set of
CPUs. Only if all sets agree the clock supply to a module will be stopped,
which can be monitored using the status Registers.
So for the CAN modules itself there is no issue, as the clock supply to the
modules will not be stopped as long as the RT CPU keeps it enabled.
There must be more to it (secure mode?), as some R-Car Gen3 module clocks
cannot seem to be disabled by disabling them for all documented CPU sets.

There's also a global bit to prevent modifying any clock register.
This could be used to prevent changing the CAN parent clock (changing
its divider and/or stopping it). However, as this is a global bit, it would
affect the full Linux clock driver.

Again, probably there's more to it when using secure mode...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
