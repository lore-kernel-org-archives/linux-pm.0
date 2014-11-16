From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v9 6/9] qcom: cpuidle: Add cpuidle driver for QCOM cpus
Date: Sun, 16 Nov 2014 22:20:26 +0100
Message-ID: <5469151A.20205@linaro.org>
References: <1414194024-55547-1-git-send-email-lina.iyer@linaro.org> <1414194024-55547-7-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:48684 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbaKPVUb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 16 Nov 2014 16:20:31 -0500
Received: by mail-wg0-f42.google.com with SMTP id z12so5228063wgg.15
        for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2014 13:20:29 -0800 (PST)
In-Reply-To: <1414194024-55547-7-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On 10/25/2014 01:40 AM, Lina Iyer wrote:
> Add cpuidle driver interface to allow cpus to go into C-States. Use t=
he
> cpuidle DT interface, common across ARM architectures, to provide the
> C-State information to the cpuidle framework.
>
> Supported modes at this time are Standby and Standalone Power Collaps=
e.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

A few comments below, otherwise it looks good to me.


> ---

[ ... ]

> +[1]. Documentation/devicetree/bindings/arm/idle-states.txt
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.ar=
m
> index 8c16ab2..13c7c1f 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -63,3 +63,10 @@ config ARM_MVEBU_V7_CPUIDLE
>   	depends on ARCH_MVEBU
>   	help
>   	  Select this to enable cpuidle on Armada 370, 38x and XP processo=
rs.
> +
> +config ARM_QCOM_CPUIDLE
> +	bool "CPU Idle drivers for Qualcomm processors"
> +	depends on QCOM_PM

Could you stick to the ARCH dependency as the other drivers ?

> +	select DT_IDLE_STATES
> +	help
> +	  Select this to enable cpuidle for QCOM processors
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 4d177b9..6c222d5 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+=3D cpuidle-zynq.o
>   obj-$(CONFIG_ARM_U8500_CPUIDLE)         +=3D cpuidle-ux500.o
>   obj-$(CONFIG_ARM_AT91_CPUIDLE)          +=3D cpuidle-at91.o
>   obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        +=3D cpuidle-exynos.o
> +obj-$(CONFIG_ARM_QCOM_CPUIDLE)		+=3D cpuidle-qcom.o
>
>   ###################################################################=
############
>   # MIPS drivers
> diff --git a/drivers/cpuidle/cpuidle-qcom.c b/drivers/cpuidle/cpuidle=
-qcom.c
> new file mode 100644
> index 0000000..1c1dcbc
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-qcom.c
> @@ -0,0 +1,72 @@
> +/*
> + * Copyright (c) 2014, Linaro Limited.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 an=
d
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/cpuidle.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include <soc/qcom/pm.h>
> +#include "dt_idle_states.h"
> +
> +static struct qcom_cpu_pm_ops *lpm_ops;
> +
> +static int qcom_cpu_stby(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index)
> +{
> +	lpm_ops->standby(NULL);

No check ?

> +	return index;
> +}
> +
> +static int qcom_cpu_spc(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index)
> +{
> +	lpm_ops->spc(NULL);

No check ?

> +	return index;
> +}
> +
> +static struct cpuidle_driver qcom_cpuidle_driver =3D {
> +	.name	=3D "qcom_cpuidle",
> +};
> +
> +static const struct of_device_id qcom_idle_state_match[] =3D {
> +	{ .compatible =3D "qcom,idle-state-stby", .data =3D qcom_cpu_stby},
> +	{ .compatible =3D "qcom,idle-state-spc", .data =3D qcom_cpu_spc },
> +	{ },
> +};
> +
> +static int qcom_cpuidle_probe(struct platform_device *pdev)
> +{
> +	struct cpuidle_driver *drv =3D &qcom_cpuidle_driver;
> +	int ret;
> +
> +	lpm_ops =3D pdev->dev.platform_data;
> +
> +	/* Probe for other states, including standby */
> +	ret =3D dt_init_idle_driver(drv, qcom_idle_state_match, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	return cpuidle_register(drv, NULL);
> +}
> +
> +static struct platform_driver qcom_cpuidle_plat_driver =3D {
> +	.probe	=3D qcom_cpuidle_probe,
> +	.driver =3D {
> +		.name =3D "qcom_cpuidle",
> +	},
> +};
> +
> +module_platform_driver(qcom_cpuidle_plat_driver);
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

