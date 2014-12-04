From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/4] ARM: shmobile: R-Mobile: Add SYSC restart handler
Date: Thu, 4 Dec 2014 12:47:00 +0100
Message-ID: <CAMuHMdWeFceyn3_TkgsuwakK9UOVUszBFqEv-uRqRC+2a=5XGA@mail.gmail.com>
References: <1417616227-6715-1-git-send-email-geert+renesas@glider.be>
	<1417616227-6715-2-git-send-email-geert+renesas@glider.be>
	<3671800.E1ZjeAe67g@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <3671800.E1ZjeAe67g@wuerfel>
Sender: linux-sh-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Arnd,

On Thu, Dec 4, 2014 at 11:08 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 03 December 2014 15:17:04 Geert Uytterhoeven wrote:
>> Extend the PM domain platform driver for the R-Mobile System
>> Controller (SYSC) to register a restart handler, to be used on various
>> Renesas ARM SoCs (e.g. R-Mobile A1 (r8a7740) and APE6 (r8a73a4), and
>> SH-Mobile AP4 (sh7372) and AG5 (sh73a0)).
>>
>> Note that this supports DT-based platforms only.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Is this one of the typical system controllers that contains lots of
> random registers? Maybe you could mark it as "syscon" in DT and just
> use the existing drivers/power/reset/syscon-reboot.c driver?

The hardware block has two register ranges.
The first one handles boot mode and power management,
the second handles reset control and allows to read the mode strap pins.

The PM domain driver uses the first range, the reset handler uses the second
range.

I tried using syscon and syscon-reboot, but that needs some changes to the
syscon framework, as it currently provides access to the first register
range only. Providing access to the second region requires either:

  1. Extending the regmap to cover all ranges.
     Does regmap support multiple ranges? It seems regmap_range_cfg handles
     only virtual ranges (switchable by writing to a register), not
     always-mapped discontiguous ranges?

  2. Providing multiple regmaps, one for each register range.
     This needs modifications to look up ranges using a phandle and an
     (optional for backwards compatibility) index, and updates to drivers
     and bindings.

Am I missing an option?

>> +static void __iomem *sysc_base2;
>> +
>> +static void rmobile_sysc_restart(enum reboot_mode reboot_mode, const char *cmd)
>> +{
>> +     pr_debug("%s %u/%s\n", __func__, reboot_mode, cmd);
>> +
>> +     writel(RESCNT2_PRES, sysc_base2 + RESCNT2);
>> +}
>> +
>> +static int rmobile_sysc_probe(struct platform_device *pdev)
>> +{
>> +     dev_dbg(&pdev->dev, "%s\n", __func__);
>> +
>> +     sysc_base2 = of_iomap(pdev->dev.of_node, 1);
>> +     if (!sysc_base2)
>> +             return -ENODEV;
>> +
>> +     arm_pm_restart = rmobile_sysc_restart;
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct of_device_id rmobile_sysc_of_match[] = {
>> +     { .compatible = "renesas,sysc-rmobile", },
>> +     { /* sentinel */ }
>> +};
>> +
>> +static struct platform_driver rmobile_sysc_driver = {
>> +     .probe = rmobile_sysc_probe,
>> +     .driver = {
>> +             .name = "rmobile_sysc",
>> +             .of_match_table = rmobile_sysc_of_match,
>> +     },
>> +};
>> +
>> +module_platform_driver(rmobile_sysc_driver);
>
> This clearly looks much better than the previous implementation, so that
> is great. If you can decouple it from the rest of this file, either through
> syscon or by asserting that sysc_base2 is not going to be needed for
> anything else, how about moving the new code to a standalon driver in
> drivers/power/reset?

Yes, sysc_base2 is used for reset control only (I don't think we need to read
the mode strap pins).

So unless there's a simple solution to the regmap problem, I think moving
this driver part to  drivers/power/reset is the most viable option.

Anyway, thanks for the syscon hint! I think it'll be useful for reset on
R-Car Gen2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
