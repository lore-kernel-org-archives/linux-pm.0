From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/4] ARM: shmobile: R-Mobile: Add SYSC restart handler
Date: Thu, 04 Dec 2014 11:08:04 +0100
Message-ID: <3671800.E1ZjeAe67g@wuerfel>
References: <1417616227-6715-1-git-send-email-geert+renesas@glider.be> <1417616227-6715-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1417616227-6715-2-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 03 December 2014 15:17:04 Geert Uytterhoeven wrote:
> Extend the PM domain platform driver for the R-Mobile System
> Controller (SYSC) to register a restart handler, to be used on various
> Renesas ARM SoCs (e.g. R-Mobile A1 (r8a7740) and APE6 (r8a73a4), and
> SH-Mobile AP4 (sh7372) and AG5 (sh73a0)).
> 
> Note that this supports DT-based platforms only.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Is this one of the typical system controllers that contains lots of
random registers? Maybe you could mark it as "syscon" in DT and just
use the existing drivers/power/reset/syscon-reboot.c driver?

> +static void __iomem *sysc_base2;
> +
> +static void rmobile_sysc_restart(enum reboot_mode reboot_mode, const char *cmd)
> +{
> +	pr_debug("%s %u/%s\n", __func__, reboot_mode, cmd);
> +
> +	writel(RESCNT2_PRES, sysc_base2 + RESCNT2);
> +}
> +
> +static int rmobile_sysc_probe(struct platform_device *pdev)
> +{
> +	dev_dbg(&pdev->dev, "%s\n", __func__);
> +
> +	sysc_base2 = of_iomap(pdev->dev.of_node, 1);
> +	if (!sysc_base2)
> +		return -ENODEV;
> +
> +	arm_pm_restart = rmobile_sysc_restart;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id rmobile_sysc_of_match[] = {
> +	{ .compatible = "renesas,sysc-rmobile", },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver rmobile_sysc_driver = {
> +	.probe = rmobile_sysc_probe,
> +	.driver = {
> +		.name = "rmobile_sysc",
> +		.of_match_table = rmobile_sysc_of_match,
> +	},
> +};
> +
> +module_platform_driver(rmobile_sysc_driver);

This clearly looks much better than the previous implementation, so that
is great. If you can decouple it from the rest of this file, either through
syscon or by asserting that sysc_base2 is not going to be needed for
anything else, how about moving the new code to a standalon driver in
drivers/power/reset?

	Arnd
