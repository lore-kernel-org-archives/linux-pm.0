From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 1/5] clk: shmobile: mstp: Never disable INTC-SYS
Date: Wed, 25 Mar 2015 05:17:36 +0100
Message-ID: <CAMuHMdVRhaZY_y2=1+9sZ-kteiguYGeS62Ka-V1WYnNCq_rgQA@mail.gmail.com>
References: <1426706164-28309-1-git-send-email-geert+renesas@glider.be>
	<1426706164-28309-2-git-send-email-geert+renesas@glider.be>
	<20150324232508.7930.89483@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150324232508.7930.89483@quantum>
Sender: linux-sh-owner@vger.kernel.org
To: Michael Turquette <mturquette@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Mike,

On Wed, Mar 25, 2015 at 12:25 AM, Michael Turquette
<mturquette@linaro.org> wrote:
> Quoting Geert Uytterhoeven (2015-03-18 12:16:00)
>> INTC-SYS is the module clock for the GIC.  Accessing the GIC while it is
>> disabled causes:
>>
>>     Unhandled fault: asynchronous external abort (0x1211) at 0x00000000
>>
>> Currently, the GIC driver cannot enable its module clock for several
>> reasons:
>>   - It does not use a platform device, so Runtime PM is not an option,
>>   - gic_of_init() runs before any clocks are registered, so it cannot
>>     explicitly enable the clock,
>>   - gic_of_init() cannot return -EPROBE_DEFER, as IRQCHIP_DECLARE()
>>     doesn't support deferred probing.
>>
>> Hence we have to keep on relying on the boot loader for enabling the
>> module clock.
>>
>> To prevent the module clock from being disabled when the CCF core thinks
>> it is unused, and thus causing a system lock-up, add a quirk to the MSTP
>> clock driver to make sure the module clock is never disabled.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  drivers/clk/shmobile/clk-mstp.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
>> index 2d2fe773ac8168f9..742af84735a07450 100644
>> --- a/drivers/clk/shmobile/clk-mstp.c
>> +++ b/drivers/clk/shmobile/clk-mstp.c
>> @@ -62,6 +62,12 @@ static int cpg_mstp_clock_endisable(struct clk_hw *hw, bool enable)
>>         unsigned int i;
>>         u32 value;
>>
>> +       /* INTC-SYS is the module clock of the GIC, and must not be disabled */
>> +       if (!enable && !strcmp(__clk_get_name(hw->clk), "intc-sys")) {
>> +               pr_debug("MSTP %pC skipping disable\n", hw->clk);
>> +               return 0;
>> +       }
>
> Hello Geert,
>
> This is a bit ugly for three reasons:
>
> 1) we hit this code for every MSTP clock {en,dis}able call
> 2) __clk_get_name is kind of gross

Sure, this is ugly. That's why this was an RFC.
I was mainly trying to trigger a reply from the GIC maintainers ;-)

> 3) the enable_count will not be correct. It will be zero but the clock
> will actually be enabled

That's indeed something I didn't take into account. Will change to just enabling
the clock from the clock driver.

> Have you considered Lee's series to express these always-on clocks in
> DT? See,
>
> https://lkml.org/lkml/2015/2/24/495

That solution doesn't apply here, as we do have a correct description
of the hardware
in DT (after the other patches in the series, like e.g. (courtesy for
Lee) http://permalink.gmane.org/gmane.linux.power-management.general/58123).

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
