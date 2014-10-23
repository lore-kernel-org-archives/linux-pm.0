From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v8 5/7] qcom: cpuidle: Add cpuidle driver for QCOM cpus
Date: Thu, 23 Oct 2014 13:05:39 +0200
Message-ID: <5448E103.9070505@linaro.org>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org> <1412718106-17049-6-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:43291 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670AbaJWLFn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Oct 2014 07:05:43 -0400
Received: by mail-wg0-f47.google.com with SMTP id x13so823507wgg.6
        for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2014 04:05:42 -0700 (PDT)
In-Reply-To: <1412718106-17049-6-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On 10/07/2014 11:41 PM, Lina Iyer wrote:
> Add cpuidle driver interface to allow cpus to go into C-States. Use t=
he
> cpuidle DT interface, common across ARM architectures, to provide the
> C-State information to the cpuidle framework.
>
> Supported modes at this time are Standby and Standalone Power Collaps=
e.

Why not the retention mode which is in between the standby and the=20
retention ?

> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>   .../bindings/arm/msm/qcom,idle-state.txt           | 81 +++++++++++=
+++++++++++
>   drivers/cpuidle/Kconfig.arm                        |  7 ++
>   drivers/cpuidle/Makefile                           |  1 +
>   drivers/cpuidle/cpuidle-qcom.c                     | 79 +++++++++++=
++++++++++
>   4 files changed, 168 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,i=
dle-state.txt
>   create mode 100644 drivers/cpuidle/cpuidle-qcom.c
>
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,idle-stat=
e.txt b/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
> new file mode 100644
> index 0000000..87f1742
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
> @@ -0,0 +1,81 @@
> +QCOM Idle States for cpuidle driver
> +
> +ARM provides idle-state node to define the cpuidle states, as define=
d in [1].
> +cpuidle-qcom is the cpuidle driver for Qualcomm SoCs and uses these =
idle
> +states. Idle states have different enter/exit latency and residency =
values.
> +The idle states supported by the QCOM SoC are defined as -
> +
> +    * Standby
> +    * Retention
> +    * Standalone Power Collapse (Standalone PC or SPC)
> +    * Power Collapse (PC)
> +
> +Standby: Standby does a little more in addition to architectural clo=
ck gating.
> +When the WFI instruction is executed the ARM core would gate its int=
ernal
> +clocks. In addition to gating the clocks, QCOM cpus use this instruc=
tion as a
> +trigger to execute the SPM state machine.  The SPM state machine wai=
ts for the
> +interrupt to trigger the core back in to active. This triggers the c=
ache
> +heirarchy to enter standby states, when all cpus are idle. An interr=
upt brings

s/heirarchy/hierarchy/

> +the SPM state machine out of its wait, the next step is to ensure th=
at the
> +cache heirarchy is also out of standby, and then the cpu is allowed =
to resume

s/heirarchy/hierarchy/

> +execution.
> +
> +Retention: Retention is a low power state where the core is clock ga=
ted and
> +the memory and the registers associated with the core are retained. =
The
> +voltage may be reduced to the minimum value needed to keep the proce=
ssor
> +registers active. The SPM should be configured to execute the retent=
ion
> +sequence and would wait for interrupt, before restoring the cpu to e=
xecution
> +state. Retention may have a slightly higher latency than Standby.
> +
> +Standalone PC: A cpu can power down and warmboot if there is a suffi=
cient time
> +between the time it enters idle and the next known wake up. SPC mode=
 is used
> +to indicate a core entering a power down state without consulting an=
y other
> +cpu or the system resources. This helps save power only on that core=
=2E  The SPM
> +sequence for this idle state is programmed to power down the supply =
to the
> +core, wait for the interrupt,  restore power to the core, and ensure=
 the

                                 ^^ extra space

> +system state including cache hierarchy is ready before allowing core=
 to
> +resume.  Applying power and resetting the core causes the core to wa=
rmboot

           ^^ extra space

> +back into Elevation Level (EL) which trampolines the control back to=
 the
> +kernel.  Entering a power down state for the cpu, needs to be done b=
y trapping

           ^^ extra space

> +into a EL. Failing to do so, would result in a crash enforced by the=
 warm boot
> +code in the EL for the SoC. On SoCs with write-back L1 cache, the ca=
che has to
> +be flushed in s/w, before powering down the core.
> +
> +Power Collapse: This state is similar to the SPC mode, but distingui=
shes
> +itself in that the cpu acknowledges and permits the SoC to enter dee=
per sleep
> +modes. In a hierarchical power domain SoC, this means L2 and other c=
aches can
> +be flushed, system bus, clocks - lowered, and SoC main XO clock gate=
d and
> +voltages reduced, provided all cpus enter this state.  Since the spa=
n of low

                                                         ^^ extra space

> +power modes possible at this state is vast, the exit latency and the=
 residency
> +of this low power mode would be considered high even though at a cpu=
 level,
> +this essentially is cpu power down.  The SPM in this state also may =
handshake

                                       ^^ extra space

> +with the Resource power manager processor in the SoC to indicate a c=
omplete
> +application processor subsystem shut down.
> +
> +The idle-state for QCOM SoCs are distinguished by the compatible pro=
perty of
> +the idle-states device node.
> +The devicetree representation of the idle state should be -
> +
> +Required properties:
> +
> +- compatible: Must be one of -
> +			"qcom,idle-state-stby",
> +			"qcom,idle-state-ret",
> +			"qcom,idle-state-spc",
> +			"qcom,idle-state-pc",
> +		and "arm,idle-state".
> +
> +Other required and optional properties are specified in [1].
> +
> +Example:
> +
> +	idle-states {
> +		CPU_SPC: spc {
> +			compatible =3D "qcom,idle-state-spc", "arm,idle-state";
> +			entry-latency-us =3D <150>;
> +			exit-latency-us =3D <200>;
> +			min-residency-us =3D <2000>;
> +		};
> +	};
> +
> +[1]. Documentation/devicetree/bindings/arm/idle-states.txt
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.ar=
m
> index 38cff69..6a9ee12 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -62,3 +62,10 @@ config ARM_MVEBU_V7_CPUIDLE
>   	depends on ARCH_MVEBU
>   	help
>   	  Select this to enable cpuidle on Armada 370, 38x and XP processo=
rs.
> +
> +config ARM_QCOM_CPUIDLE
> +	bool "CPU Idle drivers for Qualcomm processors"
> +	depends on QCOM_PM

+ depends on ARCH_QCOM

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
> index 0000000..0a65065
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-qcom.c
> @@ -0,0 +1,79 @@
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
> +#include <linux/cpu_pm.h>
> +#include <linux/cpuidle.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include <soc/qcom/pm.h>
> +#include "dt_idle_states.h"
> +
> +static void (*qcom_idle_enter)(enum pm_sleep_mode);
> +
> +static int qcom_lpm_enter_stby(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index)
> +{
> +	qcom_idle_enter(PM_SLEEP_MODE_STBY);

Could you replace this function by a generic one ?

It would be nice to have qcom_cpu_standby(void) and=20
qcom_cpu_powerdown(void) and let behind the mysterious words 'Single=20
Power Collapse' in the low level code which is qcom specific :)

I guess you had to create a single "qcom_idle_enter" because of a singl=
e=20
pointer in the platform data. I am working on a common structure to be=20
shared across the drivers as a common way to pass the different=20
callbacks without including a soc specific header.

struct cpuidle_ops {
	int (*standby)(void *data);
	int (*retention)(void *data);
	int (*poweroff)(void *data);
};

So maybe you can either:

1. wait I post this structure and provide the driver with this one
2. create a similar structure and I will take care to upgrade when I=20
post the patchset with the common structure.

The issue I see with this common structure is the initialization of the=
=20
qcom_idle_state_match array.

> +	local_irq_enable();

local_irq_enable() is handled by the cpuidle framework.
Please remove all occurrences of this function in the driver otherwise=20
time measurement will include irq time processing and will no longer be=
=20
valid.

> +	return index;
> +}
> +
> +static int qcom_lpm_enter_spc(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index)
> +{
> +	cpu_pm_enter();
> +	qcom_idle_enter(PM_SLEEP_MODE_SPC);

Where is cpu_suspend ?

> +	cpu_pm_exit();
> +	local_irq_enable();
> +
> +	return index;
> +}
> +
> +static struct cpuidle_driver qcom_cpuidle_driver =3D {
> +	.name	=3D "qcom_cpuidle",
> +};
> +
> +static const struct of_device_id qcom_idle_state_match[] =3D {
> +	{ .compatible =3D "qcom,idle-state-stby", .data =3D qcom_lpm_enter_=
stby},
> +	{ .compatible =3D "qcom,idle-state-spc", .data =3D qcom_lpm_enter_s=
pc },
> +	{ },
> +};
> +
> +static int qcom_cpuidle_probe(struct platform_device *pdev)
> +{
> +	struct cpuidle_driver *drv =3D &qcom_cpuidle_driver;
> +	int ret;
> +
> +	qcom_idle_enter =3D pdev->dev.platform_data;
> +	if (!qcom_idle_enter)
> +		return -EFAULT;

It shouldn't fail because if the probe is called then the cpuidle devic=
e=20
was registered with its callback which is hardcoded.

> +	 /* Probe for other states, including standby */
> +	ret =3D dt_init_idle_driver(drv, qcom_idle_state_match, 0);

Are you sure it is not worth to add the simple WFI state ? It may have=20
less latency than the standby mode, no ?

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


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

