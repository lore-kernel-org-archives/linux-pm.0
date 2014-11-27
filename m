From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v12 07/10] qcom: cpuidle: Add cpuidle driver for QCOM
 cpus
Date: Thu, 27 Nov 2014 09:55:12 +0100
Message-ID: <5476E6F0.1080408@linaro.org>
References: <1417047195-18978-1-git-send-email-lina.iyer@linaro.org> <1417047195-18978-8-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1417047195-18978-8-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11/27/2014 01:13 AM, Lina Iyer wrote:
> Add cpuidle driver interface to allow cpus to go into idle states. Us=
e
> the cpuidle DT interface, common across ARM architectures, to provide
> the idle state information to the cpuidle framework.
>
> Supported modes at this time are Standby and Standalone Power Collaps=
e.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>   .../bindings/arm/msm/qcom,idle-state.txt           | 81 +++++++++++=
+++++++++++
>   drivers/cpuidle/Kconfig.arm                        |  7 ++
>   drivers/cpuidle/Makefile                           |  1 +
>   drivers/cpuidle/cpuidle-qcom.c                     | 78 +++++++++++=
++++++++++
>   4 files changed, 167 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,i=
dle-state.txt
>   create mode 100644 drivers/cpuidle/cpuidle-qcom.c
>
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,idle-stat=
e.txt b/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
> new file mode 100644
> index 0000000..ae1b07f
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
> +trigger to execute the SPM state machine. The SPM state machine wait=
s for the
> +interrupt to trigger the core back in to active. This triggers the c=
ache
> +hierarchy to enter standby states, when all cpus are idle. An interr=
upt brings
> +the SPM state machine out of its wait, the next step is to ensure th=
at the
> +cache hierarchy is also out of standby, and then the cpu is allowed =
to resume
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
> +core, wait for the interrupt, restore power to the core, and ensure =
the
> +system state including cache hierarchy is ready before allowing core=
 to
> +resume. Applying power and resetting the core causes the core to war=
mboot
> +back into Elevation Level (EL) which trampolines the control back to=
 the
> +kernel. Entering a power down state for the cpu, needs to be done by=
 trapping
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
> +power modes possible at this state is vast, the exit latency and the=
 residency
> +of this low power mode would be considered high even though at a cpu=
 level,
> +this essentially is cpu power down. The SPM in this state also may h=
andshake
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
> index 8c16ab2..e98993c 100644
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
> +	depends on ARCH_QCOM
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
> index 0000000..5e54d9d
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-qcom.c
> @@ -0,0 +1,78 @@
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
> +	if (!lpm_ops->standby(NULL))
> +		return -1;
> +
> +	return index;
> +}
> +
> +static int qcom_cpu_spc(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index)
> +{
> +	if (!lpm_ops->spc(NULL))
> +		return -1;
> +
> +	return index;
> +}


Really ? the lpm_ops return NULL on error ?

ret =3D lpm_ops->spc(NULL);
if (ret)
	return ret;





--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
