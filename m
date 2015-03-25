From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 1/5] clk: shmobile: mstp: Never disable INTC-SYS
Date: Wed, 25 Mar 2015 22:19:41 +0100
Message-ID: <CAMuHMdWY7orzt0ONTzmyG8nSagCM1r1HK=zQHzfttfr6cK7eqA@mail.gmail.com>
References: <1426706164-28309-1-git-send-email-geert+renesas@glider.be>
	<1426706164-28309-2-git-send-email-geert+renesas@glider.be>
	<20150324232508.7930.89483@quantum>
	<CAMuHMdVRhaZY_y2=1+9sZ-kteiguYGeS62Ka-V1WYnNCq_rgQA@mail.gmail.com>
	<55127E2A.1040300@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <55127E2A.1040300@arm.com>
Sender: linux-sh-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Michael Turquette <mturquette@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi Marc,

On Wed, Mar 25, 2015 at 10:21 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 25/03/15 04:17, Geert Uytterhoeven wrote:
>> On Wed, Mar 25, 2015 at 12:25 AM, Michael Turquette
>> <mturquette@linaro.org> wrote:
>>> Quoting Geert Uytterhoeven (2015-03-18 12:16:00)
>>>> INTC-SYS is the module clock for the GIC.  Accessing the GIC while it is
>>>> disabled causes:
>>>>
>>>>     Unhandled fault: asynchronous external abort (0x1211) at 0x00000000
>>>>
>>>> Currently, the GIC driver cannot enable its module clock for several
>>>> reasons:
>>>>   - It does not use a platform device, so Runtime PM is not an option,
>>>>   - gic_of_init() runs before any clocks are registered, so it cannot
>>>>     explicitly enable the clock,
>>>>   - gic_of_init() cannot return -EPROBE_DEFER, as IRQCHIP_DECLARE()
>>>>     doesn't support deferred probing.
>>>>
>>>> Hence we have to keep on relying on the boot loader for enabling the
>>>> module clock.
>>>>
>>>> To prevent the module clock from being disabled when the CCF core thinks
>>>> it is unused, and thus causing a system lock-up, add a quirk to the MSTP
>>>> clock driver to make sure the module clock is never disabled.
>>>>
>>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>> ---
>>>>  drivers/clk/shmobile/clk-mstp.c | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
>>>> index 2d2fe773ac8168f9..742af84735a07450 100644
>>>> --- a/drivers/clk/shmobile/clk-mstp.c
>>>> +++ b/drivers/clk/shmobile/clk-mstp.c
>>>> @@ -62,6 +62,12 @@ static int cpg_mstp_clock_endisable(struct clk_hw *hw, bool enable)
>>>>         unsigned int i;
>>>>         u32 value;
>>>>
>>>> +       /* INTC-SYS is the module clock of the GIC, and must not be disabled */
>>>> +       if (!enable && !strcmp(__clk_get_name(hw->clk), "intc-sys")) {
>>>> +               pr_debug("MSTP %pC skipping disable\n", hw->clk);
>>>> +               return 0;
>>>> +       }
>>>
>>> Hello Geert,
>>>
>>> This is a bit ugly for three reasons:
>>>
>>> 1) we hit this code for every MSTP clock {en,dis}able call
>>> 2) __clk_get_name is kind of gross
>>
>> Sure, this is ugly. That's why this was an RFC.
>> I was mainly trying to trigger a reply from the GIC maintainers ;-)
>
> Given that I'm the only GIC-related person on the cc list, I suppose
> this is puts me on the spot.

> adverse to it. My only gripe is with the undocumented clock property in
> the binding, and that leads to two questions:
> This doesn't touch the GIC code at all, so I don't feel completely

The reason no GIC code is touched (for now), is that it's non-trivial to
fix the GIC driver to handle this.

> adverse to it. My only gripe is with the undocumented clock property in
> the binding, and that leads to two questions:
> - the GIC architecture doesn't mention a clock at all, so that's a
> Renesas special. Do we want to have a vendor-specific property for this?
> Or does it belong elsewhere?

Apart from being implemented using synchronous logic and thus using a
clock signal internally, the GIC and its driver don't care about this clock.

When an existing IP module that doesn't care about clocks becomes reused
on a new SoC, and it now ends up being part of a "PM Domain" (e.g. a Power
Domain or Clock Domain, or both), this "PM Domain" is a feature of the
platform, not of the IP module itself (cfr. "(Existing) Device Driver" in [1];
GIC falls in the same category as the Thermal Module example).
Hence I don't think it's necessary to mention this in the ARM GIC binding.

> - alternatively, do we want the core GIC code to deal with this? In
> which case, how do we express the policy?

The proper way to handle this automatically is to add Runtime PM support
to the driver. However, this requires using a platform device.

I would like to add the clock and GIC dependency on the clock in the DTS now,
for reasons of DTS stability. But that means I need a temporary workaround
to avoid the clock from being disabled, until the GIC driver handles this.

I don't expect a fix for the GIC code to just show up magically. I just wanted
you to be aware of the problem. GIC is not the only problematic module here,
there are others, cfr. the last slide of [2].

Thanks!

References:
Presentations at ELC2015:
  [1] "Last one out, turn off the lights", by Geert Uytterhoeven
(http://events.linuxfoundation.org/sites/events/files/slides/Last_One_Out_Turn_Off_The_Lights_Handouts.pdf)
  [2] "Introduction to Kernel Power Managemen", by Kevin Hilman (still
to appear at http://events.linuxfoundation.org/events/embedded-linux-conference/program/slides)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
