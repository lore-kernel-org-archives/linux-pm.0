From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 13/14] clk: shmobile: mstp: Consider "zb_clk" suitable
 for power management
Date: Mon, 22 Jun 2015 22:17:03 +0200
Message-ID: <CAMuHMdWYJNWZ+NW4se_H2Ks9nyza9BZJp3RUZ=PDwiqyO+Azdg@mail.gmail.com>
References: <1432839219-475-1-git-send-email-geert+renesas@glider.be>
	<1432839219-475-14-git-send-email-geert+renesas@glider.be>
	<20150622200549.9112.2411@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150622200549.9112.2411@quantum>
Sender: linux-sh-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-clk@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Mike,

On Mon, Jun 22, 2015 at 10:05 PM, Michael Turquette
<mturquette@linaro.org> wrote:

Still sending email from Linaro, which will cause me to receive an autoreply?

> Quoting Geert Uytterhoeven (2015-05-28 11:53:38)
>> Currently the CPG Clock Domain code looks for MSTP clocks to power
>> manage a device.
>>
>> Unfortunately, on R-Mobile APE6 (r8a73a4) and SH-Mobile AG5 (sh73a0),
>> the Bus State Controller (BSC) is not power-managed by an MSTP clock,
>> but by a plain CPG clock (zb_clk).  Add a special case to handle this,
>> so the clock is properly managed, and devices connected to the BSC work
>> as expected.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> v2:
>>   - New.
>> ---
>>  drivers/clk/shmobile/clk-mstp.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
>> index 619f3eccefd4884f..19e2b11953383587 100644
>> --- a/drivers/clk/shmobile/clk-mstp.c
>> +++ b/drivers/clk/shmobile/clk-mstp.c
>> @@ -258,6 +258,10 @@ int cpg_mstp_attach_dev(struct generic_pm_domain *domain, struct device *dev)
>>                                             "renesas,cpg-mstp-clocks"))
>>                         goto found;
>>
>> +               /* BSC on r8a73a4/sh73a0 uses zb_clk instead of an mstp clock*/
>> +               if (!strcmp(clkspec.np->name, "zb_clk"))
>> +                       goto found;
>
> Hello Geert,
>
> Is the driver the right place to handle this corner case? What do you
> think about linking zb_clk up to the bsc devicetree node for
> r8a73a4/sh73a0?

It already is linked:

        bsc: bus@fec10000 {
                compatible = "renesas,bsc-r8a73a4", "renesas,bsc",
                    "simple-pm-bus";
                #address-cells = <1>;
                #size-cells = <1>;
               ranges = <0 0 0 0x20000000>;
               reg = <0 0xfec10000 0 0x400>;
                clocks = <&zb_clk>;
               power-domains = <&pd_c4>;
        };

        https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/r8a73a4.dtsi#n446

But without this hack in clk-mstp, the clock domain controller doesn't know
it can use this clock for power management like an ordinary mstp clock.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
