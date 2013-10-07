From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: sirf : Add cpuidle for SiRFprimaII and SiRFatlasVI
Date: Mon, 07 Oct 2013 10:23:39 +0200
Message-ID: <52526F8B.6030905@linaro.org>
References: <1381033577-19818-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:46235 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300Ab3JGIXj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Oct 2013 04:23:39 -0400
Received: by mail-we0-f174.google.com with SMTP id u56so3271309wes.33
        for <linux-pm@vger.kernel.org>; Mon, 07 Oct 2013 01:23:38 -0700 (PDT)
In-Reply-To: <1381033577-19818-1-git-send-email-Baohua.Song@csr.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>, rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, workgroup.linux@csr.com, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>


Hi Barry,

On 10/06/2013 06:26 AM, Barry Song wrote:
> From: Rongjun Ying <Rongjun.Ying@csr.com>
>
> This patch adds support cpuidle for CSR SiRFprimaII and SiRFatlasVI u=
nicore
> ARM Cortex-A9 SoCs.

A new driver deserves a better description.

> Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---

Is there a technical reference manual accessible somewhere ?

>   - this patch depens on  Rongjun Ying's "[PATCH] cpufreq: sirf: Add =
cpufreq
>   for SiRFprimaII and SiRFatlasVI" at:
>   http://marc.info/?l=3Dlinux-pm&m=3D138103042106089&w=3D2
>
>   arch/arm/configs/prima2_defconfig |   2 +
>   drivers/cpuidle/Kconfig.arm       |   6 ++
>   drivers/cpuidle/Makefile          |   1 +
>   drivers/cpuidle/cpuidle-sirf.c    | 131 +++++++++++++++++++++++++++=
+++++++++++
>   4 files changed, 140 insertions(+)
>   create mode 100644 drivers/cpuidle/cpuidle-sirf.c
>
> diff --git a/arch/arm/configs/prima2_defconfig b/arch/arm/configs/pri=
ma2_defconfig
> index 513d75e..bc0bf1f 100644
> --- a/arch/arm/configs/prima2_defconfig
> +++ b/arch/arm/configs/prima2_defconfig
> @@ -18,6 +18,8 @@ CONFIG_PREEMPT=3Dy
>   CONFIG_AEABI=3Dy
>   CONFIG_KEXEC=3Dy
>   CONFIG_CPU_FREQ=3Dy
> +CONFIG_CPU_IDLE=3Dy
> +CONFIG_ARM_SIRF_CPUIDLE=3Dy
>   CONFIG_BINFMT_MISC=3Dy
>   CONFIG_PM_RUNTIME=3Dy
>   CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.ar=
m
> index 8e36603..c1f5fbf 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -15,6 +15,12 @@ config ARM_KIRKWOOD_CPUIDLE
>   	help
>   	  This adds the CPU Idle driver for Marvell Kirkwood SoCs.
>
> +config ARM_SIRF_CPUIDLE
> +	bool "CPU Idle Driver for CSR SiRFprimaII and CSRatlasVI SoCs"
> +	depends on ARCH_SIRF
> +	help
> +	  This adds the CPU Idle driver for CSR SiRF SoCs.
> +
>   config ARM_ZYNQ_CPUIDLE
>   	bool "CPU Idle Driver for Xilinx Zynq processors"
>   	depends on ARCH_ZYNQ
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index cea5ef5..f8cce16 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) +=3D couple=
d.o
>   # ARM SoC drivers
>   obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)	+=3D cpuidle-calxeda.o
>   obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+=3D cpuidle-kirkwood.o
> +obj-$(CONFIG_ARM_SIRF_CPUIDLE)		+=3D cpuidle-sirf.o
>   obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+=3D cpuidle-zynq.o
>   obj-$(CONFIG_ARM_U8500_CPUIDLE)         +=3D cpuidle-ux500.o
>   obj-$(CONFIG_CPU_IDLE_BIG_LITTLE)	+=3D cpuidle-big_little.o
> diff --git a/drivers/cpuidle/cpuidle-sirf.c b/drivers/cpuidle/cpuidle=
-sirf.c
> new file mode 100644
> index 0000000..fc1f71e
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-sirf.c
> @@ -0,0 +1,131 @@
> +/*
> + * CPU idle drivers for CSR SiRFprimaII
> + *
> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc gro=
up company.
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/cpuidle.h>
> +#include <linux/io.h>
> +#include <linux/time.h>
> +#include <asm/proc-fns.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <asm/cpuidle.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/cpu.h>
> +#include <linux/opp.h>
> +
> +#define SIRFSOC_MAX_VOLTAGE	1200000
> +
> +/*
> + * now we have only 2 C state WFI
> + * 1. ARM WFI
> + * 2. WFI + switch to 26Mhz clock source + lower volatge
> + */
> +
> +static struct {
> +	struct clk		*cpu_clk;
> +	struct clk		*osc_clk;
> +	struct regulator	*vcore_regulator;
> +	struct device		*cpu_dev;
> +} sirf_cpuidle;
> +
> +static int sirf_enter_idle(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv,
> +				int index)
> +{
> +	struct clk *parent_clk;
> +	unsigned long volt_old =3D 0, volt_new, freq;
> +	struct opp *opp;
> +
> +	local_irq_disable();

Don't use local_irq_disable in the driver it is done by the caller.

> +	parent_clk =3D clk_get_parent(sirf_cpuidle.cpu_clk);
> +	clk_set_parent(sirf_cpuidle.cpu_clk, sirf_cpuidle.osc_clk);
> +
> +	if (sirf_cpuidle.vcore_regulator) {
> +		volt_old =3D regulator_get_voltage(sirf_cpuidle.vcore_regulator);
> +
> +		freq =3D clk_get_rate(sirf_cpuidle.osc_clk);
> +		rcu_read_lock();

Using rcu in the idle path is not allowed.

> +		opp =3D opp_find_freq_ceil(sirf_cpuidle.cpu_dev, &freq);
> +		if (IS_ERR(opp)) {
> +			rcu_read_unlock();
> +			return -EINVAL;
> +		}
> +
> +		volt_new =3D opp_get_voltage(opp);
> +		rcu_read_unlock();
> +
> +		regulator_set_voltage(sirf_cpuidle.vcore_regulator, volt_new,
> +				SIRFSOC_MAX_VOLTAGE);
> +	}
> +	/* Wait for interrupt state */
> +	cpu_do_idle();
> +
> +	if (sirf_cpuidle.vcore_regulator)
> +		regulator_set_voltage(sirf_cpuidle.vcore_regulator, volt_old,
> +				SIRFSOC_MAX_VOLTAGE);
> +
> +	clk_set_parent(sirf_cpuidle.cpu_clk, parent_clk);
> +	/* Todo: other C states */

It sounds very weird you have this freq/volt/opp code here.

If you hit idle, the cpufreq driver didn't put the cpu in the state you=
=20
are trying to bring here ?

There isn't a power management unit on this board ?

> +	local_irq_enable();

Done by the caller.

> +	return index;
> +}
> +
> +static struct cpuidle_driver sirf_cpuidle_driver =3D {
> +	.name =3D "sirf_cpuidle",
> +	.states =3D {
> +		ARM_CPUIDLE_WFI_STATE,
> +		{
> +			.name =3D "WFI-LP",
> +			.desc =3D "WFI low power",
> +			.flags =3D CPUIDLE_FLAG_TIME_VALID,
> +			.exit_latency =3D 10,
> +			.target_residency =3D 10000,
> +			.enter =3D sirf_enter_idle,
> +		},
> +	},
> +	.state_count =3D 2,
> +};
> +
> +/* Initialize CPU idle by registering the idle states */
> +static int sirfsoc_init_cpuidle(void)
> +{
> +	int ret =3D 0;
> +
> +	sirf_cpuidle.cpu_clk =3D clk_get_sys("cpu", NULL);
> +	if (IS_ERR(sirf_cpuidle.cpu_clk))
> +		return PTR_ERR(sirf_cpuidle.cpu_clk);
> +
> +	sirf_cpuidle.osc_clk =3D clk_get_sys("osc", NULL);
> +	if (IS_ERR(sirf_cpuidle.osc_clk)) {
> +		ret =3D PTR_ERR(sirf_cpuidle.osc_clk);
> +		goto out_put_osc_clk;
> +	}
> +
> +	sirf_cpuidle.vcore_regulator =3D regulator_get(NULL, "vcore");
> +	if (IS_ERR(sirf_cpuidle.vcore_regulator))
> +		sirf_cpuidle.vcore_regulator =3D NULL;
> +
> +	sirf_cpuidle.cpu_dev =3D get_cpu_device(0);
> +	if (IS_ERR(sirf_cpuidle.cpu_dev)) {
> +		ret =3D PTR_ERR(sirf_cpuidle.cpu_dev);
> +		goto out_put_clk;
> +	}
> +
> +	ret =3D cpuidle_register(&sirf_cpuidle_driver, NULL);
> +	if (!ret)
> +		return ret;
> +
> +out_put_clk:
> +	clk_put(sirf_cpuidle.cpu_clk);
> +out_put_osc_clk:
> +	clk_put(sirf_cpuidle.osc_clk);
> +	return ret;
> +}
> +late_initcall(sirfsoc_init_cpuidle);

Please convert it to platform_driver as the other drivers are moving to=
=20
(cf. cpuidle-kirkwood, cpuidle-ux500).

Thanks
   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

