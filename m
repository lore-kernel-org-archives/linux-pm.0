From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v8 1/7] qcom: spm: Add Subsystem Power Manager driver
Date: Wed, 08 Oct 2014 18:12:03 -0700
Message-ID: <5435E0E3.3060906@codeaurora.org>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org> <1412718106-17049-2-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1412718106-17049-2-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/07/2014 02:41 PM, Lina Iyer wrote:
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
> index 1505fb8..a18e8fc 100644
> --- a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
> @@ -2,11 +2,20 @@ SPM AVS Wrapper 2 (SAW2)
>   
>   The SAW2 is a wrapper around the Subsystem Power Manager (SPM) and the
>   Adaptive Voltage Scaling (AVS) hardware. The SPM is a programmable
> -micro-controller that transitions a piece of hardware (like a processor or
> +power-controller that transitions a piece of hardware (like a processor or
>   subsystem) into and out of low power modes via a direct connection to
>   the PMIC. It can also be wired up to interact with other processors in the
>   system, notifying them when a low power state is entered or exited.
>   
> +Multiple revisions of the SAW hardware is supported using these Device Nodes.

s/is/are/

> +SAW2 revisions differ in the register offset and configuration data. Also,
> +same revision of the SAW in different SoCs may have different configuration

the same

> +data due the the differences in hardware capabilities. Hence the SoC name, the
> +version of the SAW hardware in that SoC and the distinction between cpu (big
> +or Little) or cache, may be needed to uniquely identify the SAW register
> +configuration and initialization data. The compatible string is used to
> +indicate this parameter.
> +
>   PROPERTIES
>   
>   - compatible:
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 70d52ed..20b329f 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -1,3 +1,4 @@
>   obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
> +obj-$(CONFIG_QCOM_PM)	+=	spm.o
>   CFLAGS_scm.o :=$(call as-instr,.arch_extension sec,-DREQUIRES_SEC=1)
>   obj-$(CONFIG_QCOM_SCM) += scm.o scm-boot.o
> diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
> new file mode 100644
> index 0000000..c1dd04b
> --- /dev/null
> +++ b/drivers/soc/qcom/spm.c
> @@ -0,0 +1,223 @@
> +/* Copyright (c) 2011-2014, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
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
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +
> +#include <soc/qcom/pm.h>
> +
> +#define MAX_PMIC_DATA 3
> +#define MAX_SEQ_DATA 64
> +
> +enum {
> +	SPM_REG_CFG,
> +	SPM_REG_SPM_CTL,
> +	SPM_REG_DLY,
> +	SPM_REG_PMIC_DLY,
> +	SPM_REG_PMIC_DATA_0,
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
> +	void __iomem *reg_base_addr;

It's not really an address, more like a reg_base or just base.

> +	const struct spm_reg_data *reg_data;
> +};
> +
> +static const u8 spm_reg_offset_v2_1[SPM_REG_NR] = {
> +	[SPM_REG_CFG]		= 0x08,
> +	[SPM_REG_SPM_CTL]	= 0x30,
> +	[SPM_REG_DLY]		= 0x34,
> +	[SPM_REG_SEQ_ENTRY]	= 0x80,
> +};
> +
> +/* SPM register data for 8974, 8084 */
> +static const struct spm_reg_data spm_reg_8974_8084_cpu  = {
> +	.reg_offset = spm_reg_offset_v2_1,
> +	.spm_cfg = 0x1,
> +	.spm_dly = 0x3C102800,
> +	.seq = { 0x03, 0x0B, 0x0F, 0x00, 0x20, 0x80, 0x10, 0xE8, 0x5B, 0x03,
> +		0x3B, 0xE8, 0x5B, 0x82, 0x10, 0x0B, 0x30, 0x06, 0x26, 0x30,
> +		0x0F },
> +	.start_index[PM_SLEEP_MODE_STBY] = 0,
> +	.start_index[PM_SLEEP_MODE_SPC] = 3,
> +};
> +
> +static DEFINE_PER_CPU_SHARED_ALIGNED(struct spm_driver_data, cpu_spm_drv);
> +
> +/**
> + * spm_set_low_power_mode() - Configure SPM start address for low power mode
> + * @mode: SPM LPM mode to enter
> + */
> +int qcom_spm_set_low_power_mode(enum pm_sleep_mode mode)
> +{
> +	struct spm_driver_data *drv = &__get_cpu_var(cpu_spm_drv);

this_cpu_ptr()

> +	u32 start_index;
> +	u32 ctl_val;
> +
> +	if (!drv->reg_base_addr)
> +		return -ENXIO;
> +
> +	start_index = drv->reg_data->start_index[mode];
> +
> +	ctl_val = readl_relaxed(drv->reg_base_addr +
> +				drv->reg_data->reg_offset[SPM_REG_SPM_CTL]);
> +	start_index &= 0x7F;

Why are we statically defining numbers larger than 0x7f? Drop this?

> +	start_index <<= 4;
> +	ctl_val &= 0xFFFFF80F;

Make a #define for this register field (or two)?

#define SPM_CTL_INDEX 0x7f
#define SPM_CTL_INDEX_SHIFT 4
#define SPM_CTL_EN BIT(0)

ctl_val &= ~(SPM_CTL_INDEX << SPM_CTL_INDEX_SHIFT);
ctl_val |= start_index << SPM_CTL_INDEX_SHIFT;
ctl_val |= SPM_CTL_EN;

> +	ctl_val |= start_index;
> +	ctl_val |= 0x1; /* Enable the SPM CTL register */
> +	writel_relaxed(ctl_val, drv->reg_base_addr +
> +				drv->reg_data->reg_offset[SPM_REG_SPM_CTL]);

Can we please have spm_read/write functions that take the drv, register 
mapping enum, and optional value?

> +	/* Ensure we have written the start address */
> +	wmb();
> +
> +	return 0;
> +}
> +
> +static struct spm_driver_data *spm_get_drv(struct platform_device *pdev)
> +{
> +	struct spm_driver_data *drv = NULL;
> +	struct device_node *cpu_node, *saw_node;
> +	u32 cpu;

int instead of u32

> +
> +	for_each_possible_cpu(cpu) {
> +		if (drv)
> +			break;

This looks weird. Why not put this at the end of the loop?

> +		cpu_node = of_get_cpu_node(cpu, NULL);
> +		if (!cpu_node)
> +			continue;
> +		saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);
> +		if (saw_node) {
> +			if (saw_node == pdev->dev.of_node)
> +				drv = &per_cpu(cpu_spm_drv, cpu);

How does this work with the logical cpu map? cpu0 in hardware may be 
cpu1 in software for example.

> +			of_node_put(saw_node);
> +		}
> +		of_node_put(cpu_node);
> +	}
> +
> +	return drv;
> +}
> +
> +static const struct of_device_id spm_match_table[] = {
> +	{ .compatible = "qcom,msm8974-saw2-v2.1-cpu",
> +	  .data = &spm_reg_8974_8084_cpu },
> +	{ .compatible = "qcom,apq8084-saw2-v2.1-cpu",
> +	  .data = &spm_reg_8974_8084_cpu },
> +	{ },
> +};
> +
> +static int spm_dev_probe(struct platform_device *pdev)
> +{
> +	struct spm_driver_data *drv;
> +	struct resource *res;
> +	const struct of_device_id *match_id;
> +	void __iomem *addr, *reg_base;
> +	int i;
> +	const u32 *seq_regs;
> +
> +	 /* Get the right SPM device */
> +	drv = spm_get_drv(pdev);
> +	if (!drv)
> +		return -EINVAL;
> +
> +	/* Get the SPM start address */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	reg_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(reg_base))
> +		return PTR_ERR(reg_base);
> +
> +	match_id = of_match_node(spm_match_table, pdev->dev.of_node);
> +	if (!match_id)
> +		return -ENODEV;
> +
> +	/* Get the SPM register data for this instance */

The above three comments seem so obvious. Why do we need them?

> +	drv->reg_data = match_id->data;
> +	if (!drv->reg_data)
> +		return -EINVAL;
> +
> +	/* Write the SPM sequences */
> +	addr = reg_base + drv->reg_data->reg_offset[SPM_REG_SEQ_ENTRY];
> +	seq_regs = (const u32 *)drv->reg_data->seq;
> +	for (i = 0; i < ARRAY_SIZE(drv->reg_data->seq)/4; i++)
> +		writel_relaxed(seq_regs[i], 4 * i + addr);

Just use __iowrite32_copy()? Please run sparse, seq_regs is not an 
__iomem pointer.

> +
> +	/**
> +	 *  Write the SPM registers.
> +	 *  An offset of 0, indicates that the SPM version does not support
> +	 *  this register, otherwise it should be supported.
> +	 */
> +	writel_relaxed(drv->reg_data->spm_cfg,
> +			reg_base + drv->reg_data->reg_offset[SPM_REG_CFG]);
> +
> +	if (drv->reg_data->reg_offset[SPM_REG_DLY])

Is this ever false? I thought we always had these registers to configure.

> +		writel_relaxed(drv->reg_data->spm_dly, reg_base +
> +				drv->reg_data->reg_offset[SPM_REG_DLY]);
> +
> +	if (drv->reg_data->reg_offset[SPM_REG_PMIC_DLY])

Same comment.

> +		writel_relaxed(drv->reg_data->pmic_dly, reg_base +
> +				drv->reg_data->reg_offset[SPM_REG_PMIC_DLY]);
> +
> +	/* Write the PMIC data */
> +	if (drv->reg_data->reg_offset[SPM_REG_PMIC_DATA_0])
> +		for (i = 0; i < MAX_PMIC_DATA; i++)
> +			writel_relaxed(drv->reg_data->pmic_data[i], reg_base +
> +				drv->reg_data->reg_offset[SPM_REG_PMIC_DATA_0] +
> +				4 * i);

This looks unused. I'm not sure we even want to do it though? Would it 
be better if we wrote these registers in the SMP boot code with whatever 
value we're using to boot secondary CPUs? That way we don't have a 
dependency between the SMP code and this code to know to use the same 
values. We should also think about moving that SMP boot code into this 
file so that such dependencies are implicit.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
