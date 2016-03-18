From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] cpufreq: rockchip: add driver
Date: Fri, 18 Mar 2016 13:56:57 +0100
Message-ID: <1787319.AFAWVqkdk0@diego>
References: <1458303004-26445-1-git-send-email-xf@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:60478 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756836AbcCRM5J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 08:57:09 -0400
In-Reply-To: <1458303004-26445-1-git-send-email-xf@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Feng Xiao <xf@rock-chips.com>
Cc: linux@arm.linux.org.uk, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, wxt@rock-chips.com, zyw@rock-chips.com, jay.xu@rock-chips.com, tim.chen@rock-chips.com, xxx@rock-chips.com, huangtao@rock-chips.com, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>

Hi Feng,

Am Freitag, 18. M=E4rz 2016, 20:10:04 schrieb Feng Xiao:
> This driver will directly use cpufreq-dt driver as backend.
>=20
> As there is not a generic devicetree board file(rockchip.c)
> on ARM64 architecture, so remove platform_device_register_simple
> in rockchip.c and add a new cpufreq driver to support for all
> Rockchip SoCs.
>=20
> Signed-off-by: Feng Xiao <xf@rock-chips.com>

[...]

> diff --git a/drivers/cpufreq/rockchip-cpufreq.c
> b/drivers/cpufreq/rockchip-cpufreq.c new file mode 100644
> index 0000000..ecbadcd
> --- /dev/null
> +++ b/drivers/cpufreq/rockchip-cpufreq.c
> @@ -0,0 +1,36 @@
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
> +static int __init rockchip_cpufreq_driver_init(void)
> +{
> +	struct platform_device *pdev;
> +
> +	pdev =3D platform_device_register_simple("cpufreq-dt", -1, NULL, 0)=
;
> +	return PTR_ERR_OR_ZERO(pdev);

This would create that cpufreq-dt device on all non-Rockchip platforms=20
compiled into the same kernel image as well - we definitly don't want t=
hat.

Also, on both the rk3368 as well as the rk3399, you probably want the c=
luster-
handling of arm-bL-cpufreq-dt.
Contrary to its name it is _not_ limited to switching between clusters,=
 but=20
can also control frequencies of multiple cpu-clusters running at the sa=
me=20
time.


Implementation-wise, I guess doing it similar to the scpi-implementatio=
n might=20
make more sense. Please take a look at drivers/clk/clk-scpi.c that regi=
sters=20
the virtual cpufreq device there.

So we could do something similar, move the cpufreq from mach-rockchip t=
o the=20
clock drivers and register the appropriate cpufreq-driver for each soc.
cpufreq-dt for socs with a single cluster, the bL-thing for socs with m=
ultiple=20
clusters.


Heiko

