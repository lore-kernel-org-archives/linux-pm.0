From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v1] cpufreq: rockchip: add driver
Date: Tue, 22 Mar 2016 17:07:36 +0100
Message-ID: <1758347.rheI35MbRd@diego>
References: <1458303004-26445-1-git-send-email-xf@rock-chips.com> <1458647848-48999-1-git-send-email-xf@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:53485 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365AbcCVQHt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Mar 2016 12:07:49 -0400
In-Reply-To: <1458647848-48999-1-git-send-email-xf@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Feng Xiao <xf@rock-chips.com>
Cc: linux@arm.linux.org.uk, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, wxt@rock-chips.com, zyw@rock-chips.com, jay.xu@rock-chips.com, tim.chen@rock-chips.com, xxx@rock-chips.com, huangtao@rock-chips.com

Hi,

Am Dienstag, 22. M=E4rz 2016, 19:57:28 schrieb Feng Xiao:
> This driver will directly use cpufreq-dt driver as backend.
>=20
> As there is not a generic devicetree board file(rockchip.c)
> on ARM64 architecture, so remove platform_device_register_simple
> in rockchip.c and add a new cpufreq driver to support Rockchip
> SoCs.
>=20
> Signed-off-by: Feng Xiao <xf@rock-chips.com>

some hints regarding the soc-selection below, otherwise this looks nice=
=2E

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

[includes an Ack for the mach-rockchip change ;-) ]

[...]

> diff --git a/drivers/cpufreq/rockchip-cpufreq.c
> b/drivers/cpufreq/rockchip-cpufreq.c new file mode 100644
> index 0000000..65c1de9
> --- /dev/null
> +++ b/drivers/cpufreq/rockchip-cpufreq.c
> @@ -0,0 +1,55 @@
> +/*
> + * Rockchip Platforms CPUFreq Support
> + *
> + * Copyright (C) 2016 Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * Feng Xiao <xf@rock-chips.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warran=
ty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +static const char * const rockchip_compat[] =3D {
> +	"rockchip,rk2928",

+	"rockchip,rk3036",

> +	"rockchip,rk3066a",
> +	"rockchip,rk3066b",
> +	"rockchip,rk3188",

+	"rockchip,rk3228",

> +	"rockchip,rk3288",
> +	"rockchip,rk3366",
> +	"rockchip,rk3368",
> +	"rockchip,rk3399",
> +};
> +
> +static int __init rockchip_cpufreq_driver_init(void)
> +{
> +	struct platform_device *pdev;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(rockchip_compat); i++) {
> +		if (of_machine_is_compatible(rockchip_compat[i])) {
> +			pdev =3D platform_device_register_simple("cpufreq-dt",
> +							       -1, NULL, 0);
> +			return PTR_ERR_OR_ZERO(pdev);
> +		}
> +	}
> +
> +	return -ENODEV;
> +}
> +module_init(rockchip_cpufreq_driver_init);
> +
> +MODULE_AUTHOR("Feng Xiao <xf@rock-chips.com>");
> +MODULE_DESCRIPTION("Rockchip cpufreq driver");
> +MODULE_LICENSE("GPL v2");

