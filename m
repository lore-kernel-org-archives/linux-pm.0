From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v9 2/9] qcom: spm: Add Subsystem Power Manager driver
Date: Fri, 14 Nov 2014 16:56:18 +0100
Message-ID: <54662622.2020307@linaro.org>
References: <1414194024-55547-1-git-send-email-lina.iyer@linaro.org> <1414194024-55547-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:44431 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161046AbaKNP4W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Nov 2014 10:56:22 -0500
Received: by mail-wg0-f47.google.com with SMTP id a1so19758527wgh.20
        for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2014 07:56:21 -0800 (PST)
In-Reply-To: <1414194024-55547-3-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On 10/25/2014 01:40 AM, Lina Iyer wrote:
> SPM is a hardware block that controls the peripheral logic surroundin=
g
> the application cores (cpu/l$). When the core executes WFI instructio=
n,
> the SPM takes over the putting the core in low power state as
> configured. The wake up for the SPM is an interrupt at the GIC, which
> then completes the rest of low power mode sequence and brings the cor=
e
> out of low power mode.
>
> The SPM has a set of control registers that configure the SPMs
> individually based on the type of the core and the runtime conditions=
=2E
> SPM is a finite state machine block to which a sequence is provided a=
nd
> it interprets the bytes and executes them in sequence. Each low power
> mode that the core can enter into is provided to the SPM as a sequenc=
e.
>
> Configure the SPM to set the core (cpu or L2) into its low power mode=
,
> the index of the first command in the sequence is set in the SPM_CTL
> register. When the core executes ARM wfi instruction, it triggers the
> SPM state machine to start executing from that index. The SPM state
> machine waits until the interrupt occurs and starts executing the res=
t
> of the sequence until it hits the end of the sequence. The end of the
> sequence jumps the core out of its low power mode.
>
> Add support for an idle driver to set up the SPM to place the core in
> Standby or Standalone power collapse mode when the core is idle.
>
> Based on work by: Mahesh Sivasubramanian <msivasub@codeaurora.org>,
> Ai Li <ali@codeaurora.org>, Praveen Chidambaram <pchidamb@codeaurora.=
org>
> Original tree available at -
> git://codeaurora.org/quic/la/kernel/msm-3.10.git
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>   .../devicetree/bindings/arm/msm/qcom,saw2.txt      |  31 +-
>   drivers/soc/qcom/Kconfig                           |   8 +
>   drivers/soc/qcom/Makefile                          |   1 +
>   drivers/soc/qcom/spm.c                             | 334 ++++++++++=
+++++++++++
>   include/soc/qcom/pm.h                              |  31 ++
>   5 files changed, 399 insertions(+), 6 deletions(-)
>   create mode 100644 drivers/soc/qcom/spm.c
>   create mode 100644 include/soc/qcom/pm.h
>
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt =
b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
> index 1505fb8..690c3c0 100644
> --- a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
> @@ -2,11 +2,20 @@ SPM AVS Wrapper 2 (SAW2)
>
>   The SAW2 is a wrapper around the Subsystem Power Manager (SPM) and =
the
>   Adaptive Voltage Scaling (AVS) hardware. The SPM is a programmable
> -micro-controller that transitions a piece of hardware (like a proces=
sor or
> +power-controller that transitions a piece of hardware (like a proces=
sor or
>   subsystem) into and out of low power modes via a direct connection =
to
>   the PMIC. It can also be wired up to interact with other processors=
 in the
>   system, notifying them when a low power state is entered or exited.
>
> +Multiple revisions of the SAW hardware are supported using these Dev=
ice Nodes.
> +SAW2 revisions differ in the register offset and configuration data.=
 Also, the
> +same revision of the SAW in different SoCs may have different config=
uration
> +data due the the differences in hardware capabilities. Hence the SoC=
 name, the
> +version of the SAW hardware in that SoC and the distinction between =
cpu (big
> +or Little) or cache, may be needed to uniquely identify the SAW regi=
ster
> +configuration and initialization data. The compatible string is used=
 to
> +indicate this parameter.
> +
>   PROPERTIES
>
>   - compatible:
> @@ -14,10 +23,13 @@ PROPERTIES
>   	Value type: <string>
>   	Definition: shall contain "qcom,saw2". A more specific value shoul=
d be
>   		    one of:
> -			 "qcom,saw2-v1"
> -			 "qcom,saw2-v1.1"
> -			 "qcom,saw2-v2"
> -			 "qcom,saw2-v2.1"
> +			"qcom,saw2-v1"
> +			"qcom,saw2-v1.1"
> +			"qcom,saw2-v2"
> +			"qcom,saw2-v2.1"
> +			"qcom,apq8064-saw2-v1.1-cpu"
> +			"qcom,msm8974-saw2-v2.1-cpu"
> +			"qcom,apq8084-saw2-v2.1-cpu"
>
>   - reg:
>   	Usage: required
> @@ -26,10 +38,17 @@ PROPERTIES
>   		    the register region. An optional second element specifies
>   		    the base address and size of the alias register region.
>
> +- regulator:
> +	Usage: optional
> +	Value type: boolean
> +	Definition: Indicates that this SPM device acts as a regulator devi=
ce
> +			device for the core (CPU or Cache) the SPM is attached
> +			to.
>
>   Example:
>
> -	regulator@2099000 {
> +	power-controller@2099000 {
>   		compatible =3D "qcom,saw2";
>   		reg =3D <0x02099000 0x1000>, <0x02009000 0x1000>;
> +		regulator;
>   	};
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 7dcd554..012fb37 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -11,3 +11,11 @@ config QCOM_GSBI
>
>   config QCOM_SCM
>   	bool
> +
> +config QCOM_PM
> +	bool "Qualcomm Power Management"
> +	depends on ARCH_QCOM
> +	help
> +	  QCOM Platform specific power driver to manage cores and L2 low po=
wer
> +	  modes. It interface with various system drivers to put the cores =
in
> +	  low power modes.
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 70d52ed..20b329f 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -1,3 +1,4 @@
>   obj-$(CONFIG_QCOM_GSBI)	+=3D	qcom_gsbi.o
> +obj-$(CONFIG_QCOM_PM)	+=3D	spm.o
>   CFLAGS_scm.o :=3D$(call as-instr,.arch_extension sec,-DREQUIRES_SEC=
=3D1)
>   obj-$(CONFIG_QCOM_SCM) +=3D scm.o scm-boot.o
> diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
> new file mode 100644
> index 0000000..ee2e3ca
> --- /dev/null
> +++ b/drivers/soc/qcom/spm.c
> @@ -0,0 +1,334 @@
> +/* Copyright (c) 2011-2014, The Linux Foundation. All rights reserve=
d.
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
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/cpuidle.h>
> +#include <linux/cpu_pm.h>
> +
> +#include <asm/proc-fns.h>
> +#include <asm/suspend.h>
> +
> +#include <soc/qcom/pm.h>
> +#include <soc/qcom/pm.h>
> +#include <soc/qcom/scm.h>
> +#include <soc/qcom/scm-boot.h>
> +
> +
> +#define SCM_CMD_TERMINATE_PC	(0x2)
> +#define SCM_FLUSH_FLAG_MASK	(0x3)
> +#define SCM_L2_ON		(0x0)
> +#define SCM_L2_OFF		(0x1)
> +#define MAX_PMIC_DATA 2
> +#define MAX_SEQ_DATA 64
> +
> +#define SPM_CTL_INDEX 0x7f
> +#define SPM_CTL_INDEX_SHIFT 4
> +#define SPM_CTL_EN BIT(0)
> +
> +enum spm_reg {
> +	SPM_REG_CFG,
> +	SPM_REG_SPM_CTL,
> +	SPM_REG_DLY,
> +	SPM_REG_PMIC_DLY,
> +	SPM_REG_PMIC_DATA_0,
> +	SPM_REG_PMIC_DATA_1,
> +	SPM_REG_VCTL,
> +	SPM_REG_SEQ_ENTRY,
> +	SPM_REG_SPM_STS,
> +	SPM_REG_PMIC_STS,
> +	SPM_REG_NR,
> +};
> +
> +struct spm_reg_data {
> +	/* Register position */
> +	const u8 *reg_offset;
> +
> +	/* Register initialization values */
> +	u32 spm_cfg;
> +	u32 spm_dly;
> +	u32 pmic_dly;
> +	u32 pmic_data[MAX_PMIC_DATA];
> +
> +	/* Sequences and start indices */
> +	u8 seq[MAX_SEQ_DATA];
> +	u8 start_index[PM_SLEEP_MODE_NR];
> +
> +};
> +
> +struct spm_driver_data {
> +	void __iomem *reg_base;
> +	const struct spm_reg_data *reg_data;
> +	bool available;
> +};
> +
> +static const u8 spm_reg_offset_v2_1[SPM_REG_NR] =3D {
> +	[SPM_REG_CFG]		=3D 0x08,
> +	[SPM_REG_SPM_CTL]	=3D 0x30,
> +	[SPM_REG_DLY]		=3D 0x34,
> +	[SPM_REG_SEQ_ENTRY]	=3D 0x80,
> +};
> +
> +/* SPM register data for 8974, 8084 */
> +static const struct spm_reg_data spm_reg_8974_8084_cpu  =3D {
> +	.reg_offset =3D spm_reg_offset_v2_1,
> +	.spm_cfg =3D 0x1,
> +	.spm_dly =3D 0x3C102800,
> +	.seq =3D { 0x03, 0x0B, 0x0F, 0x00, 0x20, 0x80, 0x10, 0xE8, 0x5B, 0x=
03,
> +		0x3B, 0xE8, 0x5B, 0x82, 0x10, 0x0B, 0x30, 0x06, 0x26, 0x30,
> +		0x0F },
> +	.start_index[PM_SLEEP_MODE_STBY] =3D 0,
> +	.start_index[PM_SLEEP_MODE_SPC] =3D 3,
> +};
> +
> +static const u8 spm_reg_offset_v1_1[SPM_REG_NR] =3D {
> +	[SPM_REG_CFG]		=3D 0x08,
> +	[SPM_REG_SPM_CTL]	=3D 0x20,
> +	[SPM_REG_PMIC_DLY]	=3D 0x24,
> +	[SPM_REG_PMIC_DATA_0]	=3D 0x28,
> +	[SPM_REG_PMIC_DATA_1]	=3D 0x2C,
> +	[SPM_REG_SEQ_ENTRY]	=3D 0x80,
> +};
> +
> +/* SPM register data for 8064 */
> +static const struct spm_reg_data spm_reg_8064_cpu =3D {
> +	.reg_offset =3D spm_reg_offset_v1_1,
> +	.spm_cfg =3D 0x1F,
> +	.pmic_dly =3D 0x02020004,
> +	.pmic_data[0] =3D 0x0084009C,
> +	.pmic_data[1] =3D 0x00A4001C,
> +	.seq =3D { 0x03, 0x0F, 0x00, 0x24, 0x54, 0x10, 0x09, 0x03, 0x01,
> +		0x10, 0x54, 0x30, 0x0C, 0x24, 0x30, 0x0F },
> +	.start_index[PM_SLEEP_MODE_STBY] =3D 0,
> +	.start_index[PM_SLEEP_MODE_SPC] =3D 2,
> +};
> +
> +static DEFINE_PER_CPU_SHARED_ALIGNED(struct spm_driver_data, cpu_spm=
_drv);
> +
> +static inline void spm_register_write(struct spm_driver_data *drv,
> +					enum spm_reg reg, u32 val)
> +{
> +	if (drv->reg_data->reg_offset[reg])
> +		writel_relaxed(val, drv->reg_base +
> +				drv->reg_data->reg_offset[reg]);
> +}
> +
> +static inline u32 spm_register_read(struct spm_driver_data *drv,
> +					enum spm_reg reg)
> +{
> +	return readl_relaxed(drv->reg_base + drv->reg_data->reg_offset[reg]=
);
> +}
> +
> +/**
> + * spm_set_low_power_mode() - Configure SPM start address for low po=
wer mode
> + * @mode: SPM LPM mode to enter
> + */
> +int qcom_spm_set_low_power_mode(enum pm_sleep_mode mode)
> +{
> +	struct spm_driver_data *drv =3D this_cpu_ptr(&cpu_spm_drv);
> +	u32 start_index;
> +	u32 ctl_val;
> +
> +	if (!drv->available)
> +		return -ENXIO;

really weird how this was initialized.

Are you sure 'drv' is not NULL if it is not available ? (see below)

> +
> +	start_index =3D drv->reg_data->start_index[mode];
> +
> +	ctl_val =3D spm_register_read(drv, SPM_REG_SPM_CTL);
> +	ctl_val &=3D ~(SPM_CTL_INDEX << SPM_CTL_INDEX_SHIFT);
> +	ctl_val |=3D start_index << SPM_CTL_INDEX_SHIFT;
> +	ctl_val |=3D SPM_CTL_EN;
> +	spm_register_write(drv, SPM_REG_SPM_CTL, ctl_val);
> +
> +	/* Ensure we have written the start address */
> +	wmb();
> +
> +	return 0;
> +}
> +
> +static int qcom_pm_collapse(unsigned long int unused)
> +{
> +	int ret;
> +	u32 flag;
> +	int cpu =3D smp_processor_id();
> +
> +	ret =3D scm_set_warm_boot_addr(cpu_resume, cpu);
> +	if (ret) {
> +		pr_err("Failed to set warm boot address for cpu %d\n", cpu);
> +		return ret;
> +	}
> +
> +	flag =3D SCM_L2_ON & SCM_FLUSH_FLAG_MASK;
> +	scm_call_atomic1(SCM_SVC_BOOT, SCM_CMD_TERMINATE_PC, flag);
> +
> +	/**
> +	 *  Returns here only if there was a pending interrupt and we did n=
ot
> +	 *  power down as a result.
> +	 */
> +	return 0;
> +}
> +
> +static int qcom_cpu_standby(void *unused)
> +{
> +	int ret;
> +
> +	ret =3D qcom_spm_set_low_power_mode(PM_SLEEP_MODE_STBY);
> +	if (ret)
> +		return ret;
> +
> +	cpu_do_idle();
> +
> +	return 0;
> +}
> +
> +static int qcom_cpu_spc(void *unused)
> +{	int ret;
> +
> +	ret =3D qcom_spm_set_low_power_mode(PM_SLEEP_MODE_STBY);
> +	if (ret)
> +		return ret;
> +
> +	cpu_pm_enter();
> +	cpu_suspend(0, qcom_pm_collapse);
> +	cpu_pm_exit();
> +
> +	return 0;
> +}
> +
> +static struct spm_driver_data *spm_get_drv(struct platform_device *p=
dev,
> +		int *spm_cpu)
> +{
> +	struct spm_driver_data *drv =3D NULL;
> +	struct device_node *cpu_node, *saw_node;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_node =3D of_cpu_device_node_get(cpu);
> +		if (!cpu_node)
> +			continue;
> +		saw_node =3D of_parse_phandle(cpu_node, "qcom,saw", 0);
> +		if (saw_node) {
> +			if (saw_node =3D=3D pdev->dev.of_node)
> +				drv =3D &per_cpu(cpu_spm_drv, cpu);
> +			of_node_put(saw_node);
> +		}
> +		of_node_put(cpu_node);
> +		if (drv) {
> +			*spm_cpu =3D cpu;
> +			break;
> +		}
> +	}
> +
> +	return drv;
> +}
> +
> +static const struct of_device_id spm_match_table[] =3D {
> +	{ .compatible =3D "qcom,msm8974-saw2-v2.1-cpu",
> +	  .data =3D &spm_reg_8974_8084_cpu },
> +	{ .compatible =3D "qcom,apq8084-saw2-v2.1-cpu",
> +	  .data =3D &spm_reg_8974_8084_cpu },
> +	{ .compatible =3D "qcom,apq8064-saw2-v1.1-cpu",
> +	  .data =3D &spm_reg_8064_cpu },
> +	{ },
> +};
> +
> +static struct qcom_cpu_pm_ops lpm_ops =3D {
> +	.standby =3D qcom_cpu_standby,
> +	.spc =3D qcom_cpu_spc,
> +};
> +
> +struct platform_device qcom_cpuidle_device =3D {
> +	.name              =3D "qcom_cpuidle",
> +	.id                =3D -1,
> +	.dev.platform_data =3D &lpm_ops,
> +};
> +
> +static int spm_dev_probe(struct platform_device *pdev)
> +{
> +	struct spm_driver_data *drv;
> +	struct resource *res;
> +	const struct of_device_id *match_id;
> +	void __iomem *addr;
> +	const u32 *seq_data;
> +	int cpu =3D -EINVAL;
> +	static bool cpuidle_drv_init;
> +
> +	drv =3D spm_get_drv(pdev, &cpu);
> +	if (!drv)
> +		return -EINVAL;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	drv->reg_base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(drv->reg_base))
> +		return PTR_ERR(drv->reg_base);
> +
> +	match_id =3D of_match_node(spm_match_table, pdev->dev.of_node);
> +	if (!match_id)
> +		return -ENODEV;
> +
> +	drv->reg_data =3D match_id->data;
> +	if (!drv->reg_data)
> +		return -EINVAL;
> +
> +	/* Write the SPM sequences, first.. */
> +	addr =3D drv->reg_base + drv->reg_data->reg_offset[SPM_REG_SEQ_ENTR=
Y];
> +	seq_data =3D (const u32 *)drv->reg_data->seq;
> +	__iowrite32_copy(addr, seq_data, ARRAY_SIZE(drv->reg_data->seq)/4);
> +
> +	/* ..and then, the control registers.
> +	 * On some SoC's if the control registers are written first and if =
the
> +	 * CPU was held in reset, the reset signal could trigger the SPM st=
ate
> +	 * machine, before the sequences are completely written.
> +	 */
> +	spm_register_write(drv, SPM_REG_CFG, drv->reg_data->spm_cfg);
> +	spm_register_write(drv, SPM_REG_DLY, drv->reg_data->spm_dly);
> +	spm_register_write(drv, SPM_REG_PMIC_DLY, drv->reg_data->pmic_dly);
> +
> +	spm_register_write(drv, SPM_REG_PMIC_DATA_0,
> +				drv->reg_data->pmic_data[0]);
> +	spm_register_write(drv, SPM_REG_PMIC_DATA_1,
> +				drv->reg_data->pmic_data[1]);
> +
> +	/**
> +	 * Ensure all observers see the above register writes before the
> +	 * cpuidle driver is allowed to use the SPM.
> +	 */
> +	wmb();
> +	drv->available =3D true;

IMO if you have to do that, that means there is something wrong with ho=
w=20
is initialized the driver.

It should be drv =3D=3D NULL =3D> not available

> +
> +	if ((cpu > -1) && !cpuidle_drv_init) {
> +		platform_device_register(&qcom_cpuidle_device);
> +		cpuidle_drv_init =3D true;
> +	}

'cpu' is always > -1.

If the 'spm_get_drv' succeed, cpu is no longer equal to -EINVAL.=20
Otherwise we do not reach this point because we return right after=20
spm_get_drv with an error.

Adding the platform_device_register depending in a static variable is=20
not very nice. Why not add it explicitely in a separate init routine we=
=20
know it will be called one time (eg. at the same place than cpufreq is)=
 ?

> +	return 0;
> +}
> +
> +static struct platform_driver spm_driver =3D {
> +	.probe =3D spm_dev_probe,
> +	.driver =3D {
> +		.name =3D "qcom,spm",
> +		.of_match_table =3D spm_match_table,
> +	},
> +};
> +
> +module_platform_driver(spm_driver);
> diff --git a/include/soc/qcom/pm.h b/include/soc/qcom/pm.h
> new file mode 100644
> index 0000000..d9a56d7
> --- /dev/null
> +++ b/include/soc/qcom/pm.h
> @@ -0,0 +1,31 @@
> +/*
> + * Copyright (c) 2009-2014, The Linux Foundation. All rights reserve=
d.
> + *
> + * This software is licensed under the terms of the GNU General Publ=
ic
> + * License version 2, as published by the Free Software Foundation, =
and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#ifndef __QCOM_PM_H
> +#define __QCOM_PM_H
> +
> +enum pm_sleep_mode {
> +	PM_SLEEP_MODE_STBY,
> +	PM_SLEEP_MODE_RET,
> +	PM_SLEEP_MODE_SPC,
> +	PM_SLEEP_MODE_PC,
> +	PM_SLEEP_MODE_NR,
> +};
> +
> +struct qcom_cpu_pm_ops {
> +	int (*standby)(void *data);
> +	int (*spc)(void *data);
> +};
> +
> +#endif  /* __QCOM_PM_H */
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

