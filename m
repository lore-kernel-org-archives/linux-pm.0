From: Rob Herring <robh+dt@kernel.org>
Subject: Re: Clocks used by another OS/CPU (was: Re: [RFC PATCH] clk: renesas:
 cpg-mssr: Add interface for critical core clocks)
Date: Fri, 30 Jun 2017 10:58:26 -0500
Message-ID: <CAL_JsqKGrZeR7z80beY_XEjqd5fEQQwPxusJ1FADoALgNE3fEg@mail.gmail.com>
References: <CAMuHMdW9+CNTTOVO4SRRUxuz3ajLbY2j1uG8b_RpHX52NPwXrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdW9+CNTTOVO4SRRUxuz3ajLbY2j1uG8b_RpHX52NPwXrQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@baylibre.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 29, 2017 at 4:27 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Dirk,
>
> CC clock, ARM, DT, PM people
>
> TL;DR: Clocks may be in use by another CPU not running Linux, while Linux
> disables them as being unused.
>
> On Mon, Jun 26, 2017 at 1:30 PM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
>> With commit 72f5df2c2bbb6 ("clk: renesas: cpg-mssr: Migrate to
>> CLK_IS_CRITICAL") we are able to handle critical module clocks.
>> Introduce the same logic for critical core clocks.
>>
>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>> ---
>> Commit
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/clk/renesas?id=72f5df2c2bbb66d4a555cb51eb9f412abf1af77f
>>
>> is quite nice to avoid *module* clocks being disabled. Unfortunately,
>> there are *core* clocks, too. E.g. using an other OS on the Cortex R7
>> core of the r8a7795, the 'canfd' is a quite popular core clock which
>> shouldn't be disabled by Linux.
>>
>> Therefore, this patch is a proposal to use the same 'mark clocks as
>> critical' logic implemented for the module clocks for the core
>> clocks, too.
>>
>> Opinions?
>
> On r8a7795, there are several Cortex A cores running Linux, and a Cortex R7
> core which may run another OS.
> This is an interesting issue, and relevant to other SoCs, too.
>
> In this particular case, the "canfd" clock is a core clock used as an
> auxiliary clock for the CAN0, CAN1, and CANFD interfaces.  This can lead
> to three scenarios:
>   1. Linux controls all CAN interfaces
>      => no issue,
>   2. The OS on the RT CPU controls all CAN interfaces
>      => issue, Linux disables the clock
>   3. Mix of 1 and 2
>      => More issues.
> Of course this is not limited to clocks, but also to e.g. PM domains.
>
> How can this be handled?
> I believe just marking the "canfd" clock critical is not the right solution,
> as about any clock could be used by the RT CPU.
>
> Still, Linux needs to be made aware that devices (clocks and PM domains) are
> controlled by another CPU/OS.
>
> Should this be described in DT? It feels like software policy to me.

No, it shouldn't. It is Linux policy to disable all unused clocks, so
Linux gets to deal with the consequences.

Rob
