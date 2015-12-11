From: Stefan Wahren <info-saaNCTdWVBT7BZbvpMY5sg@public.gmane.org>
Subject: Re: [PATCH v2 3/5] ARM: bcm2835: add rpi power domain driver
Date: Fri, 11 Dec 2015 19:13:30 +0100
Message-ID: <566B124A.4010401@lategoodbye.de>
References: <1449251148-19344-1-git-send-email-eric@anholt.net>
 <1449251148-19344-4-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449251148-19344-4-git-send-email-eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Eric,

Am 04.12.2015 um 18:45 schrieb Eric Anholt:
> From: Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> This patch adds support for several power domains on Raspberry Pi,
> including USB (so it can be enabled even if the bootloader didn't do
> it), and graphics.
>
> This patch is the combined work of Eric Anholt (who wrote USB support
> inside of the Raspberry Pi firmware driver, and wrote the non-USB
> domain support) and Alexander Aring (who separated the original USB
> work out from the firmware driver).
>
> Signed-off-by: Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
> ---
>
> v2: Add support for power domains other than USB, using the new
>      firmware interface, reword commit message (changes by Eric)
>
>   arch/arm/mach-bcm/Kconfig                   |  10 ++
>   arch/arm/mach-bcm/Makefile                  |   1 +
>   arch/arm/mach-bcm/raspberrypi-power.c       | 269 ++++++++++++++++++++++++++++
>   include/dt-bindings/arm/raspberrypi-power.h |  41 +++++
>   4 files changed, 321 insertions(+)
>   create mode 100644 arch/arm/mach-bcm/raspberrypi-power.c
>   create mode 100644 include/dt-bindings/arm/raspberrypi-power.h
>
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 8c53c55..0f23bad 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -134,6 +134,16 @@ config ARCH_BCM2835
>   	  This enables support for the Broadcom BCM2835 SoC. This SoC is
>   	  used in the Raspberry Pi and Roku 2 devices.
>
> +config RASPBERRYPI_POWER
> +	bool "Raspberry Pi power domain driver"
> +	depends on ARCH_BCM2835 || COMPILE_TEST
> +	depends on RASPBERRYPI_FIRMWARE
> +	select PM_GENERIC_DOMAINS if PM
> +	select PM_GENERIC_DOMAINS_OF if PM
> +	help
> +	  This enables support for the RPi power domains which can be enabled
> +	  or disabled via the RPi firmware.
> +
>   config ARCH_BCM_63XX
>   	bool "Broadcom BCM63xx DSL SoC" if ARCH_MULTI_V7
>   	depends on MMU
> diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
> index 892261f..fec2d6b 100644
> --- a/arch/arm/mach-bcm/Makefile
> +++ b/arch/arm/mach-bcm/Makefile
> @@ -36,6 +36,7 @@ endif
>
>   # BCM2835
>   obj-$(CONFIG_ARCH_BCM2835)	+= board_bcm2835.o
> +obj-$(CONFIG_RASPBERRYPI_POWER)	+= raspberrypi-power.o
>
>   # BCM5301X
>   obj-$(CONFIG_ARCH_BCM_5301X)	+= bcm_5301x.o
> diff --git a/arch/arm/mach-bcm/raspberrypi-power.c b/arch/arm/mach-bcm/raspberrypi-power.c
> new file mode 100644
> index 0000000..3444301
> --- /dev/null
> +++ b/arch/arm/mach-bcm/raspberrypi-power.c
> @@ -0,0 +1,269 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Authors:
> + * (C) 2015 Pengutronix, Alexander Aring <aar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> + * Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>

shouldn't be the copyright before license?

> + */
> + [...]
> +
> +static int rpi_power_probe(struct platform_device *pdev)
> +{
> +	struct device_node *fw_np;
> +	struct device *dev = &pdev->dev;
> +	struct rpi_power_domains *rpi_domains;
> +	int ret, i;
> +
> +	rpi_domains = devm_kzalloc(dev, sizeof(*rpi_domains), GFP_KERNEL);
> +	if (!rpi_domains)
> +		return -ENOMEM;
> +
> +	rpi_domains->xlate.domains =
> +		devm_kzalloc(dev, sizeof(*rpi_domains->xlate.domains) *
> +			     RPI_POWER_DOMAIN_COUNT, GFP_KERNEL);
> +	if (!rpi_domains->xlate.domains)
> +		return -ENOMEM;
> +
> +	rpi_domains->xlate.num_domains = RPI_POWER_DOMAIN_COUNT;
> +
> +	fw_np = of_parse_phandle(pdev->dev.of_node, "firmware", 0);
> +	if (!fw_np) {
> +		dev_err(&pdev->dev, "no firmware node\n");
> +		return -ENODEV;
> +	}
> +
> +	rpi_domains->fw = rpi_firmware_get(fw_np);
> +	of_node_put(fw_np);
> +	if (!rpi_domains->fw)
> +		return -EPROBE_DEFER;
> +
> +	rpi_domains->has_new_interface =
> +		rpi_has_new_domain_support(rpi_domains);
> +
> +	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_I2C0, "I2C0");
> +	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_I2C1, "I2C1");
> +	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_I2C2, "I2C2");
> +	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_VIDEO_SCALER,
> +			      "VIDEO_SCALER");
> +	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_VPU1, "VPU1");
> +	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_HDMI, "HDMI");
> +
> +	/*
> +	 * Use the old firmware interface for USB power, so that we
> +	 * can turn it on even if the firmware hasn't been updated.
> +	 */
> +	rpi_init_old_power_domain(rpi_domains, RPI_POWER_DOMAIN_USB,
> +				  RPI_OLD_POWER_DOMAIN_USB, "USB");
> +
> +	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_VEC, "VEC");
> +	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_JPEG, "JPEG");
> +	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_H264, "H264");
> +	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_V3D, "V3D");

After this line i would expect the following:

rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_ISP, "ISP");

> +	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_UNICAM0, "UNICAM0");
> +	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_UNICAM1, "UNICAM1");
> +	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_CCP2RX, "CCP2RX");
> +	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_CSI2, "CSI2");
> +	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_CPI, "CPI");
> +	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_DSI0, "DSI0");
> +	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_DSI1, "DSI1");
> +	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_TRANSPOSER,
> +			      "TRANPOSER");

s/TRANPOSER/TRANSPOSER ?

> +	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_CCP2TX, "CCP2TX");
> +	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_CDP, "CDP");
> +	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_ARM, "ARM");
> +
> +	ret = of_genpd_add_provider_onecell(dev->of_node, &rpi_domains->xlate);
> +	if (ret < 0)
> +		goto exit_pm;
> +
> +	platform_set_drvdata(pdev, rpi_domains);
> +
> +	return 0;
> +
> +exit_pm:
> +	for (i = 0; i < rpi_domains->xlate.num_domains; i++)
> +		pm_genpd_exit(rpi_domains->xlate.domains[i]);
> +
> +	return ret;
> +}
> +

Best regards
Stefan

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
