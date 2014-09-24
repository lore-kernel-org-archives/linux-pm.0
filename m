From: Josh Cartwright <joshc@codeaurora.org>
Subject: Re: [PATCH v6 1/5] qcom: spm: Add Subsystem Power Manager driver
Date: Wed, 24 Sep 2014 12:43:41 -0500
Message-ID: <20140924174341.GH868@joshc.qualcomm.com>
References: <1411516281-58328-1-git-send-email-lina.iyer@linaro.org>
 <1411516281-58328-2-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1411516281-58328-2-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: galak@codeaurora.org, sboyd@codeaurora.org, daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@linaro.org, msivasub@codeaurora.org, lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hey Lina-

A few comments inline:

On Tue, Sep 23, 2014 at 05:51:17PM -0600, Lina Iyer wrote:
> +++ b/drivers/soc/qcom/spm.c
[..]
> +
> +static u32 reg_offsets_saw2_v2_1[MSM_SPM_REG_NR] = {

const?

> +	[MSM_SPM_REG_SAW2_SECURE]		= 0x00,
> +	[MSM_SPM_REG_SAW2_ID]			= 0x04,
> +	[MSM_SPM_REG_SAW2_CFG]			= 0x08,
> +	[MSM_SPM_REG_SAW2_SPM_STS]		= 0x0C,
> +	[MSM_SPM_REG_SAW2_AVS_STS]		= 0x10,
> +	[MSM_SPM_REG_SAW2_PMIC_STS]		= 0x14,
> +	[MSM_SPM_REG_SAW2_RST]			= 0x18,
> +	[MSM_SPM_REG_SAW2_VCTL]			= 0x1C,
> +	[MSM_SPM_REG_SAW2_AVS_CTL]		= 0x20,
> +	[MSM_SPM_REG_SAW2_AVS_LIMIT]		= 0x24,
> +	[MSM_SPM_REG_SAW2_AVS_DLY]		= 0x28,
> +	[MSM_SPM_REG_SAW2_AVS_HYSTERESIS]	= 0x2C,
> +	[MSM_SPM_REG_SAW2_SPM_CTL]		= 0x30,
> +	[MSM_SPM_REG_SAW2_SPM_DLY]		= 0x34,
> +	[MSM_SPM_REG_SAW2_PMIC_DATA_0]		= 0x40,
> +	[MSM_SPM_REG_SAW2_PMIC_DATA_1]		= 0x44,
> +	[MSM_SPM_REG_SAW2_PMIC_DATA_2]		= 0x48,
> +	[MSM_SPM_REG_SAW2_PMIC_DATA_3]		= 0x4C,
> +	[MSM_SPM_REG_SAW2_PMIC_DATA_4]		= 0x50,
> +	[MSM_SPM_REG_SAW2_PMIC_DATA_5]		= 0x54,
> +	[MSM_SPM_REG_SAW2_PMIC_DATA_6]		= 0x58,
> +	[MSM_SPM_REG_SAW2_PMIC_DATA_7]		= 0x5C,
> +	[MSM_SPM_REG_SAW2_SEQ_ENTRY]		= 0x80,
> +	[MSM_SPM_REG_SAW2_VERSION]		= 0xFD0,
> +};
> +
> +struct spm_of {
> +	char *key;

const char *key?

> +	u32 id;
> +};
> +
> +struct msm_spm_mode {
> +	u32 mode;
> +	u32 start_addr;
> +};
> +
> +struct msm_spm_driver_data {
> +	void __iomem *reg_base_addr;
> +	u32 *reg_offsets;
> +	struct msm_spm_mode *modes;
> +	u32 num_modes;

Why u32?

Actually, the maximum modes is fixed, and really all you need to keep
around is the start_addr per-mode (which is only 5 bits), and an
additional bit indicating whether that mode is valid. I'd recommend
folding msm_spm_mode into msm_spm_driver_data completely.  Something
like this, maybe:

	struct msm_spm_driver_data {
		void __iomem *reg_base_addr;
		const u32 *reg_offsets;
		struct {
			u8 is_valid;
			u8 start_addr;
		} modes[MSM_SPM_MODE_NR];
	};

> +};
> +
> +struct msm_spm_device {
> +	bool initialized;
> +	struct msm_spm_driver_data drv;
> +};
> +
> +static DEFINE_PER_CPU_SHARED_ALIGNED(struct msm_spm_device, msm_cpu_spm_device);

Why have both msm_spm_device and msm_spm_driver_data?

Would it be easier if you instead used 'struct msm_spm_device *', and
used NULL to indicate it has not been initialized?

> +static const struct of_device_id msm_spm_match_table[] __initconst;

Just move the table above probe.

> +
> +static int msm_spm_drv_set_low_power_mode(struct msm_spm_driver_data *drv,
> +						u32 mode)
> +{
> +	int i;
> +	u32 start_addr = 0;
> +	u32 ctl_val;
> +
> +	for (i = 0; i < drv->num_modes; i++) {
> +		if (drv->modes[i].mode == mode) {
> +			start_addr = drv->modes[i].start_addr;
> +			break;
> +		}
> +	}
> +
> +	if (i == drv->num_modes)
> +		return -EINVAL;
> +
> +	/* Update bits 10:4 in the SPM CTL register */
> +	ctl_val = readl_relaxed(drv->reg_base_addr +
> +			drv->reg_offsets[MSM_SPM_REG_SAW2_SPM_CTL]);
> +	start_addr &= 0x7F;
> +	start_addr <<= 4;
> +	ctl_val &= 0xFFFFF80F;
> +	ctl_val |= start_addr;
> +	writel_relaxed(ctl_val, drv->reg_base_addr +
> +			drv->reg_offsets[MSM_SPM_REG_SAW2_SPM_CTL]);
> +	/* Ensure we have written the start address */
> +	wmb();
> +
> +	return 0;
> +}
> +
> +static int msm_spm_drv_set_spm_enable(struct msm_spm_driver_data *drv,
> +					bool enable)
> +{
> +	u32 value = enable ? 0x01 : 0x00;
> +	u32 ctl_val;
> +
> +	ctl_val = readl_relaxed(drv->reg_base_addr +
> +			drv->reg_offsets[MSM_SPM_REG_SAW2_SPM_CTL]);
> +
> +	/* Update SPM_CTL to enable/disable the SPM */
> +	if ((ctl_val & SPM_CTL_ENABLE) != value) {
> +		/* Clear the existing value and update */
> +		ctl_val &= ~0x1;
> +		ctl_val |= value;
> +		writel_relaxed(ctl_val, drv->reg_base_addr +
> +			drv->reg_offsets[MSM_SPM_REG_SAW2_SPM_CTL]);
> +
> +		/* Ensure we have enabled/disabled before returning */
> +		wmb();
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * msm_spm_set_low_power_mode() - Configure SPM start address for low power mode
> + * @mode: SPM LPM mode to enter
> + */
> +int msm_spm_set_low_power_mode(u32 mode)
> +{
> +	struct msm_spm_device *dev = &__get_cpu_var(msm_cpu_spm_device);
> +	int ret = -EINVAL;
> +
> +	if (!dev->initialized)
> +		return -ENXIO;
> +
> +	if (mode == MSM_SPM_MODE_DISABLED)
> +		ret = msm_spm_drv_set_spm_enable(&dev->drv, false);

I would suggest not modeling "DISABLED" as a "mode", as it's not a state
like the others.  Instead, perhaps you could expect users to call
msm_spm_drv_set_spm_enable() directly.

> +	else if (!msm_spm_drv_set_spm_enable(&dev->drv, true))
> +		ret = msm_spm_drv_set_low_power_mode(&dev->drv, mode);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(msm_spm_set_low_power_mode);

Is this actually to be used by modules?

[..]
> +static int msm_spm_seq_init(struct msm_spm_device *spm_dev,
> +			struct platform_device *pdev)
> +{
> +	int i;
> +	u8 *cmd;

const u8 *cmd; will save you the cast below.

> +	void *addr;
> +	u32 val;
> +	u32 count = 0;
> +	int offset = 0;
> +	struct msm_spm_mode modes[MSM_SPM_MODE_NR];
> +	u32 sequences[NUM_SEQ_ENTRY/4] = {0};
> +	struct msm_spm_driver_data *drv = &spm_dev->drv;
> +
> +	/* SPM sleep sequences */
> +	struct spm_of mode_of_data[] = {

static const?

> +		{"qcom,saw2-spm-cmd-wfi", MSM_SPM_MODE_CLOCK_GATING},
> +		{"qcom,saw2-spm-cmd-spc", MSM_SPM_MODE_POWER_COLLAPSE},
> +	};
> +
> +	/**
> +	 * Compose the u32 array based on the individual bytes of the SPM
> +	 * sequence for each low power mode that we read from the DT.
> +	 * The sequences are appended if there is space available in the
> +	 * u32 after the end of the previous sequence.
> +	 */
> +
> +	for (i = 0; i < ARRAY_SIZE(mode_of_data); i++) {
> +		cmd = (u8 *)of_get_property(pdev->dev.of_node,
> +						mode_of_data[i].key, &val);
> +		if (!cmd)
> +			continue;
> +		/* The last in the sequence should be 0x0F */
> +		if (cmd[val - 1] != 0x0F)
> +			continue;
> +		modes[count].mode = mode_of_data[i].id;
> +		modes[count].start_addr = offset;
> +		append_seq_data(&sequences[0], cmd, &offset);
> +		count++;
> +	}
> +
> +	/* Write the idle state sequences to SPM */
> +	drv->modes = devm_kcalloc(&pdev->dev, count,
> +					sizeof(modes[0]), GFP_KERNEL);
> +	if (!drv->modes)
> +		return -ENOMEM;
> +
> +	drv->num_modes = count;
> +	memcpy(drv->modes, modes, sizeof(modes[0]) * count);
> +
> +	/* Flush the integer array */
> +	addr = drv->reg_base_addr +
> +			drv->reg_offsets[MSM_SPM_REG_SAW2_SEQ_ENTRY];
> +	for (i = 0; i < ARRAY_SIZE(sequences); i++, addr += 4)
> +		writel_relaxed(sequences[i], addr);
> +
> +	/* Ensure we flush the writes */
> +	wmb();
> +
> +	return 0;
> +}
> +
> +static struct msm_spm_device *msm_spm_get_device(struct platform_device *pdev)
> +{
> +	struct msm_spm_device *dev = NULL;
> +	struct device_node *cpu_node;
> +	u32 cpu;
> +
> +	cpu_node = of_parse_phandle(pdev->dev.of_node, "qcom,cpu", 0);
> +	if (cpu_node) {
> +		for_each_possible_cpu(cpu) {
> +			if (of_get_cpu_node(cpu, NULL) == cpu_node)
> +				dev = &per_cpu(msm_cpu_spm_device, cpu);
> +		}
> +	}
> +
> +	return dev;
> +}
> +
> +static int msm_spm_dev_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	int i;
> +	u32 val;
> +	struct msm_spm_device *spm_dev;
> +	struct resource *res;
> +	const struct of_device_id *match_id;
> +
> +	/* SPM Configuration registers */
> +	struct spm_of spm_of_data[] = {

static const?

> +		{"qcom,saw2-clk-div", MSM_SPM_REG_SAW2_CFG},
> +		{"qcom,saw2-enable", MSM_SPM_REG_SAW2_SPM_CTL},
> +		{"qcom,saw2-delays", MSM_SPM_REG_SAW2_SPM_DLY},
> +	};
> +
> +	 /* Get the right SPM device */
> +	spm_dev = msm_spm_get_device(pdev);
> +	if (IS_ERR_OR_NULL(spm_dev))

Should this just be a simple NULL check?

> +		return -EINVAL;
> +
> +	/* Get the SPM start address */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		ret = -EINVAL;
> +		goto fail;
> +	}
> +	spm_dev->drv.reg_base_addr = devm_ioremap(&pdev->dev, res->start,
> +					resource_size(res));

devm_ioremap_resource()?

> +	if (!spm_dev->drv.reg_base_addr) {
> +		ret = -ENOMEM;
> +		goto fail;
> +	}
> +
> +	match_id = of_match_node(msm_spm_match_table, pdev->dev.of_node);
> +	if (!match_id)
> +		return -ENODEV;
> +
> +	/* Use the register offsets for the SPM version in use */
> +	spm_dev->drv.reg_offsets = (u32 *)match_id->data;
> +	if (!spm_dev->drv.reg_offsets)
> +		return -EFAULT;
> +
> +	/* Read the SPM idle state sequences */
> +	ret = msm_spm_seq_init(spm_dev, pdev);
> +	if (ret)
> +		return ret;
> +
> +	/* Read the SPM register values */
> +	for (i = 0; i < ARRAY_SIZE(spm_of_data); i++) {
> +		ret = of_property_read_u32(pdev->dev.of_node,
> +					spm_of_data[i].key, &val);
> +		if (ret)
> +			continue;
> +		writel_relaxed(val, spm_dev->drv.reg_base_addr +
> +				spm_dev->drv.reg_offsets[spm_of_data[i].id]);
> +	}
> +
> +	/* Flush all writes */

This isn't very descriptive.  Perhaps:

/*
 * Ensure all observers see the above register writes before the
 * updating of spm_dev->initialized
 */

> +	wmb();
> +
> +	spm_dev->initialized = true;
> +	return ret;
> +fail:
> +	dev_err(&pdev->dev, "SPM device probe failed: %d\n", ret);
> +	return ret;
> +}
> +
> +static const struct of_device_id msm_spm_match_table[] __initconst = {
> +	{.compatible = "qcom,spm-v2.1", .data = reg_offsets_saw2_v2_1},
> +	{ },
> +};
> +
> +
> +static struct platform_driver msm_spm_device_driver = {
> +	.probe = msm_spm_dev_probe,
> +	.driver = {
> +		.name = "spm",
> +		.owner = THIS_MODULE,

This assignment is not necessary.

> +		.of_match_table = msm_spm_match_table,
> +	},
> +};
> +
> +static int __init msm_spm_device_init(void)
> +{
> +	return platform_driver_register(&msm_spm_device_driver);
> +}
> +device_initcall(msm_spm_device_init);
> diff --git a/include/soc/qcom/spm.h b/include/soc/qcom/spm.h
> new file mode 100644
> index 0000000..29686ef
> --- /dev/null
> +++ b/include/soc/qcom/spm.h
> @@ -0,0 +1,38 @@
> +/* Copyright (c) 2010-2014, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __QCOM_SPM_H
> +#define __QCOM_SPM_H
> +
> +enum {
> +	MSM_SPM_MODE_DISABLED,
> +	MSM_SPM_MODE_CLOCK_GATING,
> +	MSM_SPM_MODE_RETENTION,
> +	MSM_SPM_MODE_GDHS,
> +	MSM_SPM_MODE_POWER_COLLAPSE,
> +	MSM_SPM_MODE_NR
> +};

Is there a particular reason you aren't naming this enumeration, and
using it's type in msm_spm_set_low_power_mode()?

> +
> +struct msm_spm_device;

Why this forward declaration?

> +
> +#if defined(CONFIG_QCOM_PM)
> +
> +int msm_spm_set_low_power_mode(u32 mode);
> +
> +#else
> +
> +static inline int msm_spm_set_low_power_mode(u32 mode)
> +{ return -ENOSYS; }
> +
> +#endif  /* CONFIG_QCOM_PM */
> +
> +#endif  /* __QCOM_SPM_H */
> -- 
> 1.9.1
> 

Thanks,
  Josh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
