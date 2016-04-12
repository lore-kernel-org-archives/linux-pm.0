From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 1/7] PM / devfreq: event: Add new Exynos NoC probe driver
Date: Tue, 12 Apr 2016 10:07:18 +0200
Message-ID: <570CACB6.40405@samsung.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
 <1460091646-28701-2-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1460091646-28701-2-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/08/2016 07:00 AM, Chanwoo Choi wrote:
> This patch adds NoC (Network on Chip) Probe driver which provides
> the primitive values to get the performance data. The packets that the Network
> on Chip (NoC) probes detects are transported over the network infrastructure.
> Exynos542x bus has multiple NoC probes to provide bandwidth information about
> behavior of the SoC that you can use while analyzing system performance.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  .../bindings/devfreq/event/exynos-nocp.txt         |  86 +++++++
>  drivers/devfreq/event/Kconfig                      |   8 +
>  drivers/devfreq/event/Makefile                     |   2 +
>  drivers/devfreq/event/exynos-nocp.c                | 247 +++++++++++++++++++++
>  drivers/devfreq/event/exynos-nocp.h                |  78 +++++++
>  5 files changed, 421 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/event/exynos-nocp.txt
>  create mode 100644 drivers/devfreq/event/exynos-nocp.c
>  create mode 100644 drivers/devfreq/event/exynos-nocp.h
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/event/exynos-nocp.txt b/Documentation/devicetree/bindings/devfreq/event/exynos-nocp.txt
> new file mode 100644
> index 000000000000..03b74fed034c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/event/exynos-nocp.txt
> @@ -0,0 +1,86 @@
> +
> +* Samsung Exynos NoC (Network on Chip) Probe device
> +
> +The Samsung Exynos542x SoC has NoC (Network on Chip) Probe for NoC bus.
> +NoC provides the primitive values to get the performance data. The packets
> +that the Network on Chip (NoC) probes detects are transported over
> +the network infrastructure to observer units. You can configure probes to
> +capture packets with header or data on the data request response network,
> +or as traffic debug or statistic collectors. Exynos542x bus has multiple
> +NoC probes to provide bandwidth information about behavior of the SoC
> +that you can use while analyzing system performance.
> +
> +Required properties:
> +- compatible: Should be "samsung,exynos5420-nocp"
> +- reg: physical base address of each NoC Probe and length of memory mapped region.
> +
> +Optional properties:
> +- clock-names : the name of clock used by the NoC Probe, "nocp"
> +- clocks : phandles for clock specified in "clock-names" property
> +
> +Example1 : NoC Probe nodes in exynos5420.dtsi are listed below.
> +
> +	nocp_mem0_0: nocp_mem0_0@10CA1000 {
> +		compatible = "samsung,exynos5420-nocp";
> +		reg = <0x10CA1000 0x200>;
> +		status = "disabled";
> +	};
> +
> +	nocp_mem0_1: nocp_mem0_1@10CA1400 {
> +		compatible = "samsung,exynos5420-nocp";
> +		reg = <0x10CA1400 0x200>;
> +		status = "disabled";
> +	};
> +
> +	nocp_mem0_2: nocp_mem0_2@10CA1800 {
> +		compatible = "samsung,exynos5420-nocp";
> +		reg = <0x10CA1800 0x200>;
> +		status = "disabled";
> +	};
> +
> +	nocp_mem0_3: nocp_mem0_0@10CA1C00 {
> +		compatible = "samsung,exynos5420-nocp";
> +		reg = <0x10CA1C00 0x200>;
> +		status = "disabled";
> +	};
> +
> +	nocp_g3d_0: nocp_g3d_0@11A51000 {
> +		compatible = "samsung,exynos5420-nocp";
> +		reg = <0x11A51000 0x200>;
> +		status = "disabled";
> +	};
> +
> +	nocp_g3d_1: nocp_g3d_1@11A51400 {
> +		compatible = "samsung,exynos5420-nocp";
> +		reg = <0x11A51400 0x200>;
> +		status = "disabled";
> +	};
> +
> +
> +Example2 : Events of each NoC Probe node in exynos5422-odroidxu3-common.dtsi
> +	are listed below.
> +
> +
> +	&nocp_mem0_0 {
> +		status = "okay";
> +	};
> +
> +	&nocp_mem0_1 {
> +		status = "okay";
> +	};
> +
> +	&nocp_mem0_2 {
> +		status = "okay";
> +	};
> +
> +	&nocp_mem0_3 {
> +		status = "okay";
> +	};
> +
> +	&nocp_g3d_0 {
> +		status = "okay";
> +	};
> +
> +	&nocp_g3d_1 {
> +		status = "okay";
> +	};

I think this split in documentation between DTSI and DTS is not needed
for example. Just add one example without the status and it should be
sufficient to get the idea.

> diff --git a/drivers/devfreq/event/Kconfig b/drivers/devfreq/event/Kconfig
> index a11720affc31..1e8b4f469f38 100644
> --- a/drivers/devfreq/event/Kconfig
> +++ b/drivers/devfreq/event/Kconfig
> @@ -13,6 +13,14 @@ menuconfig PM_DEVFREQ_EVENT
>  
>  if PM_DEVFREQ_EVENT
>  
> +config DEVFREQ_EVENT_EXYNOS_NOCP
> +	bool "EXYNOS NoC (Network On Chip) Probe DEVFREQ event Driver"
> +	depends on ARCH_EXYNOS
> +	select PM_OPP
> +	help
> +	  This add the devfreq-event driver for Exynos SoC. It provides NoC
> +	  (Network on Chip) Probe counters to measure the bandwidth of AXI bus.
> +
>  config DEVFREQ_EVENT_EXYNOS_PPMU
>  	bool "EXYNOS PPMU (Platform Performance Monitoring Unit) DEVFREQ event Driver"
>  	depends on ARCH_EXYNOS
> diff --git a/drivers/devfreq/event/Makefile b/drivers/devfreq/event/Makefile
> index be146ead79cf..3d6afd352253 100644
> --- a/drivers/devfreq/event/Makefile
> +++ b/drivers/devfreq/event/Makefile
> @@ -1,2 +1,4 @@
>  # Exynos DEVFREQ Event Drivers
> +
> +obj-$(CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP) += exynos-nocp.o
>  obj-$(CONFIG_DEVFREQ_EVENT_EXYNOS_PPMU) += exynos-ppmu.o
> diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
> new file mode 100644
> index 000000000000..b9468a6143f6
> --- /dev/null
> +++ b/drivers/devfreq/event/exynos-nocp.c
> @@ -0,0 +1,247 @@
> +/*
> + * exynos-nocp.c - EXYNOS NoC (Network On Chip) Probe support
> + *
> + * Copyright (c) 2016 Samsung Electronics Co., Ltd.
> + * Author : Chanwoo Choi <cw00.choi@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/devfreq-event.h>
> +#include <linux/kernel.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include "exynos-nocp.h"
> +
> +struct exynos_nocp {
> +	struct devfreq_event_dev *edev;
> +	struct devfreq_event_desc desc;
> +
> +	struct device *dev;
> +
> +	struct regmap *regmap;
> +	struct clk *clk;
> +};
> +
> +/*
> + * The devfreq-event ops structure for nocp probe.
> + */
> +static int exynos_nocp_set_event(struct devfreq_event_dev *edev)
> +{
> +	struct exynos_nocp *nocp = devfreq_event_get_drvdata(edev);
> +
> +	/* Disable NoC probe */
> +	regmap_update_bits(nocp->regmap, NOCP_MAIN_CTL,
> +				NOCP_MAIN_CTL_STATEN_MASK, 0);
> +
> +	/* Set a statistics dump period to 0 */
> +	regmap_write(nocp->regmap, NOCP_STAT_PERIOD, 0x0);
> +
> +	/* Set the IntEvent fields of *_SRC */
> +	regmap_update_bits(nocp->regmap, NOCP_COUNTERS_0_SRC,
> +				NOCP_CNT_SRC_INTEVENT_MASK,
> +				NOCP_CNT_SRC_INTEVENT_BYTE_MASK);
> +
> +	regmap_update_bits(nocp->regmap, NOCP_COUNTERS_1_SRC,
> +				NOCP_CNT_SRC_INTEVENT_MASK,
> +				NOCP_CNT_SRC_INTEVENT_CHAIN_MASK);
> +
> +	regmap_update_bits(nocp->regmap, NOCP_COUNTERS_2_SRC,
> +				NOCP_CNT_SRC_INTEVENT_MASK,
> +				NOCP_CNT_SRC_INTEVENT_CYCLE_MASK);
> +
> +	regmap_update_bits(nocp->regmap, NOCP_COUNTERS_3_SRC,
> +				NOCP_CNT_SRC_INTEVENT_MASK,
> +				NOCP_CNT_SRC_INTEVENT_CHAIN_MASK);
> +
> +
> +	/* Set an alarm with a max/min value of 0 to generate StatALARM */
> +	regmap_write(nocp->regmap, NOCP_STAT_ALARM_MIN, 0x0);
> +	regmap_write(nocp->regmap, NOCP_STAT_ALARM_MAX, 0x0);
> +
> +	/* Set AlarmMode */
> +	regmap_update_bits(nocp->regmap, NOCP_COUNTERS_0_ALARM_MODE,
> +				NOCP_CNT_ALARM_MODE_MASK,
> +				NOCP_CNT_ALARM_MODE_MIN_MAX_MASK);
> +	regmap_update_bits(nocp->regmap, NOCP_COUNTERS_1_ALARM_MODE,
> +				NOCP_CNT_ALARM_MODE_MASK,
> +				NOCP_CNT_ALARM_MODE_MIN_MAX_MASK);
> +	regmap_update_bits(nocp->regmap, NOCP_COUNTERS_2_ALARM_MODE,
> +				NOCP_CNT_ALARM_MODE_MASK,
> +				NOCP_CNT_ALARM_MODE_MIN_MAX_MASK);
> +	regmap_update_bits(nocp->regmap, NOCP_COUNTERS_3_ALARM_MODE,
> +				NOCP_CNT_ALARM_MODE_MASK,
> +				NOCP_CNT_ALARM_MODE_MIN_MAX_MASK);
> +
> +	/* Enable the measurements by setting AlarmEn and StatEn */
> +	regmap_update_bits(nocp->regmap, NOCP_MAIN_CTL,
> +			NOCP_MAIN_CTL_STATEN_MASK | NOCP_MAIN_CTL_ALARMEN_MASK,
> +			NOCP_MAIN_CTL_STATEN_MASK | NOCP_MAIN_CTL_ALARMEN_MASK);
> +
> +	/* Set GlobalEN */
> +	regmap_update_bits(nocp->regmap, NOCP_CFG_CTL,
> +				NOCP_CFG_CTL_GLOBALEN_MASK,
> +				NOCP_CFG_CTL_GLOBALEN_MASK);
> +
> +	/* Enable NoC probe */
> +	regmap_update_bits(nocp->regmap, NOCP_MAIN_CTL,
> +				NOCP_MAIN_CTL_STATEN_MASK,
> +				NOCP_MAIN_CTL_STATEN_MASK);

In all these regmap_update_bits() calls you are ignoring the return
value. This does not look right.

> +
> +	return 0;
> +}
> +
> +static int exynos_nocp_get_event(struct devfreq_event_dev *edev,
> +				struct devfreq_event_data *edata)
> +{
> +	struct exynos_nocp *nocp = devfreq_event_get_drvdata(edev);
> +	unsigned int counter[4];
> +
> +	/* Read cycle count */
> +	regmap_read(nocp->regmap, NOCP_COUNTERS_0_VAL, &counter[0]);
> +	regmap_read(nocp->regmap, NOCP_COUNTERS_1_VAL, &counter[1]);
> +	regmap_read(nocp->regmap, NOCP_COUNTERS_2_VAL, &counter[2]);
> +	regmap_read(nocp->regmap, NOCP_COUNTERS_3_VAL, &counter[3]);

Ditto. If read fails, the data in counter should not be trusted (not
initialized) so the devfreq_event_get_event() should not use it. The
simplest would be to return error on each failure.

> +
> +	edata->load_count = ((counter[1] << 16) | counter[0]);
> +	edata->total_count = ((counter[3] << 16) | counter[2]);
> +
> +	dev_dbg(&edev->dev, "%s (event: %ld/%ld)\n", edev->desc->name,
> +					edata->load_count, edata->total_count);
> +
> +	return 0;
> +}
> +
> +static const struct devfreq_event_ops exynos_nocp_ops = {
> +	.set_event = exynos_nocp_set_event,
> +	.get_event = exynos_nocp_get_event,
> +};
> +
> +static const struct of_device_id exynos_nocp_id_match[] = {
> +	{ .compatible = "samsung,exynos5420-nocp", },
> +	{ /* sentinel */ },
> +};
> +
> +static struct regmap_config exynos_nocp_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = NOCP_COUNTERS_3_VAL,
> +};
> +
> +static int exynos_nocp_parse_dt(struct platform_device *pdev,
> +				struct exynos_nocp *nocp)
> +{
> +	struct device *dev = nocp->dev;
> +	struct device_node *np = dev->of_node;
> +	struct resource *res;
> +	void __iomem *base;
> +	int ret = 0;
> +
> +	if (!np) {
> +		dev_err(dev, "failed to find devicetree node\n");
> +		return -EINVAL;
> +	}
> +
> +	nocp->clk = devm_clk_get(dev, "nocp");
> +	if (IS_ERR(nocp->clk))
> +		nocp->clk = NULL;
> +
> +	/* Maps the memory mapped IO to control nocp register */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (IS_ERR(res))
> +		return PTR_ERR(res);
> +
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +	exynos_nocp_regmap_config.max_register = resource_size(res) - 4;
> +
> +	nocp->regmap = devm_regmap_init_mmio(dev, base,
> +					&exynos_nocp_regmap_config);
> +	if (IS_ERR(nocp->regmap)) {
> +		dev_err(dev, "failed to initialize regmap\n");
> +		ret = PTR_ERR(nocp->regmap);
> +		goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	devm_iounmap(dev, base);

Why you need this? This is obtained by devm-like() interface so it
should be released by the core.
	
> +
> +	return ret;
> +}
> +
> +static int exynos_nocp_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct exynos_nocp *nocp;
> +	int ret;
> +
> +	nocp = devm_kzalloc(&pdev->dev, sizeof(*nocp), GFP_KERNEL);
> +	if (!nocp)
> +		return -ENOMEM;
> +
> +	nocp->dev = &pdev->dev;
> +
> +	/* Parse dt data to get resource */
> +	ret = exynos_nocp_parse_dt(pdev, nocp);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"failed to parse devicetree for resource\n");
> +		return ret;
> +	}
> +
> +	/* Add devfreq-event device to measure the bandwidth of NoC */
> +	nocp->desc.ops = &exynos_nocp_ops;
> +	nocp->desc.driver_data = nocp;
> +	nocp->desc.name = np->name;
> +	nocp->edev = devm_devfreq_event_add_edev(&pdev->dev, &nocp->desc);
> +	if (IS_ERR(nocp->edev)) {
> +		ret = PTR_ERR(nocp->edev);
> +		dev_err(&pdev->dev,
> +			"failed to add devfreq-event device\n");
> +		goto err;

This looks not needed and does not improve readability to me. Just
'return ret' always. At this point (before this if() statement) 'ret'
equals to 0. Then you could remove the 'err' label and always 'return ret'.

Best regards,
Krzysztof
