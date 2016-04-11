From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 03/11] soc: renesas: rcar-sysc: Add DT support for SYSC
 PM domains
Date: Mon, 11 Apr 2016 11:39:29 +0200
Message-ID: <CAMuHMdUOePyrBi2ofVMYKmoUYcGmg23f086VVQsA4eY6uDs-wg@mail.gmail.com>
References: <1460031628-13336-1-git-send-email-geert+renesas@glider.be>
	<1460031628-13336-4-git-send-email-geert+renesas@glider.be>
	<1651059.9FCnPbykeI@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f194.google.com ([209.85.213.194]:33430 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbcDKJja (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2016 05:39:30 -0400
In-Reply-To: <1651059.9FCnPbykeI@avalon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi Laurent,

Thanks for your comments!

On Sat, Apr 9, 2016 at 9:50 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thursday 07 Apr 2016 14:20:20 Geert Uytterhoeven wrote:
>> Populate the SYSC PM domains from DT, based on the presence of a device
>> node for the System Controller. The actual power area hiearchy, and
>> features of specific areas are obtained from tables in the C code.
>>
>> The SYSCIER and SYSCIMR register values are derived from the power areas
>> present, which will help to get rid of the hardcoded values in R-Car H1
>> and R-Car Gen2 platform code later.
>>
>> Initialization is done in two phases:
>>   1. SYSC initialization and setup of power areas containing CPUs or
>>      SCUs is done from an early_initcall(), to make sure these PM
>>      Domains are initialized before secondary CPU bringup,
>>   2. Setup of the always-on power area (which is basically an alias for
>>      the CPG/MSSR or CPG/MSTP Clock Domain), and of I/O power areas is
>>      done from builtin_platform_driver_probe(), when the Clock Domain is
>>      available.

>> --- a/drivers/soc/renesas/rcar-sysc.c
>> +++ b/drivers/soc/renesas/rcar-sysc.c

>> +/*
>> + * Initialization phase 1, including setup of CPU and SCU domains
>> + */
>> +static int __init rcar_sysc_early(void)
>> +{
>> +     const struct rcar_sysc_info *info;
>> +     const struct of_device_id *match;
>> +     struct rcar_pm_domains *domains;
>> +     struct device_node *np;
>> +     u32 syscier, syscimr;
>> +     void __iomem *base;
>> +     unsigned int i;
>> +     int error;
>> +
>> +     np = of_find_matching_node_and_match(NULL, rcar_sysc_matches, &match);
>> +     if (!np)
>> +             return -ENODEV;
>> +
>> +     info = match->data;
>> +
>> +     base = of_iomap(np, 0);
>> +     if (!base) {
>> +             pr_warn("%s: Cannot map regs\n", np->full_name);
>> +             error = -ENOMEM;
>> +             goto out_put;
>> +     }
>> +
>> +     rcar_sysc_base = base;
>> +
>> +     domains = kzalloc(sizeof(*domains), GFP_KERNEL);
>> +     if (!domains) {
>> +             error = -ENOMEM;
>> +             goto out_put;
>
> You might want to iounmap() when cleaning up.

That's a bit tricky. The R-Car H1 and H2 platform code may still call
rcar_sysc_power_*() if initialization fails here, which relies on
rcar_sysc_base pointing to the mapped registers.
So until that code is cleaned up (I have local patches), I would like to keep
it this way.

>> +     /*
>> +      * Mask all interrupt sources to prevent the CPU from receiving them.
>> +      * Make sure not to clear reserved bits that were set before.
>> +      */
>> +     syscimr = ioread32(base + SYSCIMR);
>> +     syscimr |= syscier;
>> +     pr_debug("%s: syscimr = 0x%08x\n", np->full_name, syscimr);
>> +     iowrite32(syscimr, base + SYSCIMR);
>
> Should you mask the interrupt sources before enabling them in SYSCIER ?

It doesn't matter much, as they're disabled at the GIC level anyway.
Note that the current platform code doesn't mask them at all.

I'll change the order, though.

>> +/*
>> + * Initialization phase 2, including setup of always-on and I/O domains
>> + */
>> +static int __init rcar_sysc_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +
>> +     if (!rcar_sysc_onecell_data)
>> +             return -ENODEV;
>> +
>> +     rcar_sysc_onecell_data->domains[RCAR_PD_ALWAYS_ON] =
>> +             pd_to_genpd(dev->pm_domain);
>
> This part, or rather the power-domains = <&cpg_clocks>; property in the SYSC
> DT node, bothers me. I don't think the DT property really describes the
> hardware. I like your " clk: renesas: cpg-mssr: Export
> cpg_mssr_{at,de}tach_dev()" approach better.

I had two issues with the other approach:
  1. It required keeping a static pointer to the cpg_mssr_clk_domain structure,
  2. The SYSC driver had to call the CPG/MSSR driver directly.

The second issue made it complicated to support the SYSC "always-on" PM Domain
on R-Car H1 and Gen2, as these SoCs (currently) don't use the CPG/MSSR driver,
but the CPG/MSTP driver, so the SYSC driver has to differentiate to call into
the right Clock Domain driver. Migrating these SoCs over to CPG/MSSR and
preserving backwards compatibility is even more complicated.

Hence the need to express the relationship in DT.

Would you be more comfortable using a custom property instead of the
"power-domains" property to link SYSC to CPG in DT?
E.g.:

    renesas,cpg = <&cpg_clocks>;

The "Connected module" subsection of the "System Controller (SYSC)" section of
the User's Manual does list the "Clock Pulse Generator (CPG)" as a connected
module, so that would describe the hardware.

Then I can call of_genpd_get_from_provider() to get a pointer to the Clock
Domain, and call its .attach/detach() methods directly from
rcar_sysc_{at,de}tach_dev(), without walking the parent PM Domains.

>> --- /dev/null
>> +++ b/drivers/soc/renesas/rcar-sysc.h

>> +/*
>> + * Power Domain flags
>> + */
>> +#define PD_CPU               BIT(0)  /* Area contains main CPU core */
>> +#define PD_SCU               BIT(1)  /* Area contains SCU and L2 cache */
>> +#define PD_NO_CR     BIT(2)  /* Area lacks PWR{ON,OFF}CR registers */
>> +
>> +#define PD_BUSY              BIT(3)  /* Busy, for internal use only */
>> +
>> +#define PD_CPU_CR    PD_CPU            /* CPU area has CR (R-Car H1) */
>> +#define PD_CPU_NOCR  PD_CPU | PD_NO_CR /* CPU area lacks CR (R-Car Gen2/3)
>
> I'd enclose PD_CPU | PD_NO_CR in parentheses.

I choose not to do so, as it would make the comment no longer fit on the line.
As the define is used in tables only, the risk of incorrect operator precedence
is very low.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
