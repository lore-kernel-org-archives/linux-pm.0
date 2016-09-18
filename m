From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH V5 2/6] thermal: bcm2835: add thermal driver for bcm2835
 soc
Date: Sun, 18 Sep 2016 13:31:14 +0200 (CEST)
Message-ID: <1999564031.209213.6508fbdb-00c5-486b-a34e-3d60ae68fe88.open-xchange@email.1und1.de>
References: <1473759262-27031-1-git-send-email-kernel@martin.sperl.org>
 <1473759262-27031-3-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:49580 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932485AbcIRLcL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Sep 2016 07:32:11 -0400
In-Reply-To: <1473759262-27031-3-git-send-email-kernel@martin.sperl.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kernel@martin.sperl.org, Zhang Rui <rui.zhang@intel.com>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Stephen Warren <swarren@wwwdotorg.org>, devicetree@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Pawel Moll <pawel.moll@arm.com>, linux-arm-kernel@lists.infradead.org, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, linux-pm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-rpi-kernel@lists.infradead.org

Hi Martin,

> kernel@martin.sperl.org hat am 13. September 2016 um 11:34 geschrieben:
> 
> 
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> Add basic thermal driver for bcm2835 SOC.
> 
> This driver currently relies on the firmware setting up the
> tsense HW block and does not set it up itself.
> 
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> 
> ChangeLog:
>  V1 -> V2: added specific settings depending on compatiblity
> 	   added trip point based on register
> 	   setting up ctrl-register if HW is not enabled by firmware
> 	     as per recommendation of Eric (untested)
> 	   check that clock frequency is in range
> 	     (1.9 - 5MHz - as per comment in clk-bcm2835.c)
>  V2 -> V4: moved back to thermal (not using bcm sub-directory)
>        	   set polling interval to 1second (was 0ms, so interrupt driven)
> ---
>  drivers/thermal/Kconfig           |   5 +
>  drivers/thermal/Makefile          |   1 +
>  drivers/thermal/bcm2835_thermal.c | 327
> ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 333 insertions(+)
>  create mode 100644 drivers/thermal/bcm2835_thermal.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 2d702ca..5e3e4e4 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -399,4 +399,9 @@ config GENERIC_ADC_THERMAL
>  	  to this driver. This driver reports the temperature by reading ADC
>  	  channel and converts it to temperature based on lookup table.
>  
> +config BCM2835_THERMAL
> +       tristate "Thermal sensors on bcm2835 SoC"

i'm not sure if "depends on ARCH_BCM2835 || COMPILE_TEST" is necessary here,
but the following is:

depends on OF
depends on HAS_IOMEM

> +       help
> +         Support for thermal sensors on Broadcom bcm2835 SoCs.
> +
>  endif
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 10b07c1..c26343e 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -51,3 +51,4 @@ obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra/
>  obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
>  obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
>  obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
> +obj-$(CONFIG_BCM2835_THERMAL)	+= bcm2835_thermal.o
> ...
> +
> +static int bcm2835_thermal_get_temp(struct thermal_zone_device *tz,
> +				    int *temp)
> +{
> +	struct bcm2835_thermal_data *data = tz->devdata;
> +	u32 val = readl(data->regs + BCM2835_TS_TSENSSTAT);
> +
> +	if (!(val & BCM2835_TS_TSENSSTAT_VALID))
> +		return -EIO;
> +
> +	/* mask the relevant bits */

I think this is obvious and could be removed.

> +	val &= BCM2835_TS_TSENSSTAT_DATA_MASK;
> +
> +	*temp = bcm2835_thermal_adc2temp(data->info, val);
> +
> +	return 0;
> +}
> +
> ...
> +static const struct of_device_id bcm2835_thermal_of_match_table[];
> +static int bcm2835_thermal_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *match;
> +	struct thermal_zone_device *tz;
> +	struct bcm2835_thermal_data *data;
> +	struct resource *res;
> +	int err;
> +	u32 val;
> +	unsigned long rate;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	match = of_match_device(bcm2835_thermal_of_match_table,
> +				&pdev->dev);
> +	if (!match)
> +		return -EINVAL;
> +	data->info = match->data;
> +
> +	/* get registers */

ditto

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(data->regs)) {
> +		err = PTR_ERR(data->regs);
> +		dev_err(&pdev->dev, "Could not get registers: %d\n", err);
> +		return err;
> +	}
> +
> +	/* get clock */

ditto

> +	data->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(data->clk)) {
> +		err = PTR_ERR(data->clk);
> +		if (err != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Could not get clk: %d\n", err);
> +		return err;
> +	}
> +
> +	/* set up registers if not already done by the fw */
> +	val = readl(data->regs + BCM2835_TS_TSENSCTL);
> +	if (!(val & BCM2835_TS_TSENSCTL_RSTB)) {
> +		/* the basic required flags */
> +		val = (BCM2835_TS_TSENSCTL_CTRL_DEFAULT <<
> +		       BCM2835_TS_TSENSCTL_CTRL_SHIFT) |
> +		      BCM2835_TS_TSENSCTL_REGULEN;

The comment above isn't helpful. Could you please write down the intension
behind this bit operation?

> +
> +		/* reset delay */

What is the unit of the delay (seconds, 1/10 seconds)?

> +		val |= (BCM2835_TS_TSENSCTL_RSTDELAY_DEFAULT <<

Instead of hiding the value behind a define, please use the number directly and
remove this define.

> +			BCM2835_TS_TSENSCTL_RSTDELAY_SHIFT);
> +
> +		/*  trip_adc value from info */
> +		val |= bcm2835_thermal_temp2adc(data->info,
> +						data->info->trip_temp) <<
> +			BCM2835_TS_TSENSCTL_THOLD_SHIFT;
> +
> +		/* write the value back to the register as 2 steps */
> +		writel(val, data->regs + BCM2835_TS_TSENSCTL);
> +		val |= BCM2835_TS_TSENSCTL_RSTB;
> +		writel(val, data->regs + BCM2835_TS_TSENSCTL);
> +	}
> +
> +	/* enable clock and check rate */
> +	clk_prepare_enable(data->clk);

This could fail. So please check the result and move this call before the
register set up.

> +	rate = clk_get_rate(data->clk);
> +	if ((rate < 1920000) || (rate > 5000000)) {
> +		dev_warn(&pdev->dev,
> +			 "Clock %pCn is running at %pCr Hz, which is outside the recommended range
> of 1.9 to 5.0 MHz\n",
> +			 data->clk, data->clk);

Instead of printing the clock name twice your intension would be to print the
actual clock rate?

Btw the message is very long. Could you please shorten it and make the lower
limit more precise 1.92 MHz?

> +	}
> +
> +	/* register thermal zone with 1 trip point an 1s polling */
> +	tz = thermal_zone_device_register("bcm2835_thermal",
> +					  1, 0, data,
> +					  &bcm2835_thermal_ops,
> +					  NULL,
> +					  0, 1000);
> +	if (IS_ERR(tz)) {
> +		clk_disable_unprepare(data->clk);
> +		err = PTR_ERR(tz);
> +		dev_err(&pdev->dev,
> +			"Failed to register the thermal device: %d\n",
> +			err);
> +		return err;
> +	}
> +
> +	platform_set_drvdata(pdev, tz);
> +
> +	bcm2835_thermal_debugfs(pdev);
> +
> +	return 0;
> +}
> +
> +static int bcm2835_thermal_remove(struct platform_device *pdev)
> +{
> +	struct thermal_zone_device *tz = platform_get_drvdata(pdev);
> +	struct bcm2835_thermal_data *data = tz->devdata;
> +
> +	debugfs_remove_recursive(data->debugfsdir);
> +	thermal_zone_device_unregister(tz);

clk_disable_unprepare(data->clk)

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id bcm2835_thermal_of_match_table[] = {
> +	{
> +		.compatible = "brcm,bcm2835-thermal",
> +		.data = &(struct bcm2835_thermal_info) {
> +			.offset = 407000,
> +			.slope = -538,
> +			.trip_temp = 80000

Since the operating temperature of the bcm2835 is only available in the
Foundation FAQ. I would suggest to add the recommenend operating temperature
range ( -40 C to +85 C ) here as a comment.

Thanks
Stefan
