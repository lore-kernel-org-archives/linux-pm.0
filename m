From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v6 1/5] qcom: spm: Add Subsystem Power Manager driver
Date: Wed, 24 Sep 2014 12:47:50 -0600
Message-ID: <20140924184750.GA1004@ilina-mac.local>
References: <1411516281-58328-1-git-send-email-lina.iyer@linaro.org>
 <1411516281-58328-2-git-send-email-lina.iyer@linaro.org>
 <1F7E5951-7704-4ADE-A1D1-2E380FF2540A@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:64849 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbaIXSr6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Sep 2014 14:47:58 -0400
Received: by mail-pa0-f49.google.com with SMTP id lf10so9134942pab.8
        for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2014 11:47:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1F7E5951-7704-4ADE-A1D1-2E380FF2540A@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: sboyd@codeaurora.org, daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@linaro.org, msivasub@codeaurora.org, lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org

On Wed, Sep 24 2014 at 12:07 -0600, Kumar Gala wrote:
>
>On Sep 23, 2014, at 6:51 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>
>> Based on work by many authors, available at codeaurora.org
>>
>> SPM is a hardware block that controls the peripheral logic surroundi=
ng
>> the application cores (cpu/l$). When the core executes WFI instructi=
on,
>> the SPM takes over the putting the core in low power state as
>> configured. The wake up for the SPM is an interrupt at the GIC, whic=
h
>> then completes the rest of low power mode sequence and brings the co=
re
>> out of low power mode.
>>
>> The SPM has a set of control registers that configure the SPMs
>> individually based on the type of the core and the runtime condition=
s.
>> SPM is a finite state machine block to which a sequence is provided =
and
>> it interprets the bytes  and executes them in sequence. Each low pow=
er
>> mode that the core can enter into is provided to the SPM as a sequen=
ce.
>>
>> Configure the SPM to set the core (cpu or L2) into its low power mod=
e,
>> the index of the first command in the sequence is set in the SPM_CTL
>> register. When the core executes ARM wfi instruction, it triggers th=
e
>> SPM state machine to start executing from that index. The SPM state
>> machine waits until the interrupt occurs and starts executing the re=
st
>> of the sequence until it hits the end of the sequence. The end of th=
e
>> sequence jumps the core out of its low power mode.
>>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> [lina: simplify the driver for initial submission, clean up and upda=
te
>> commit text]
>> ---
>> Documentation/devicetree/bindings/arm/msm/spm.txt |  43 +++
>> drivers/soc/qcom/Kconfig                          |   8 +
>> drivers/soc/qcom/Makefile                         |   1 +
>> drivers/soc/qcom/spm.c                            | 388 ++++++++++++=
++++++++++
>> include/soc/qcom/spm.h                            |  38 +++
>> 5 files changed, 478 insertions(+)
>> create mode 100644 Documentation/devicetree/bindings/arm/msm/spm.txt
>> create mode 100644 drivers/soc/qcom/spm.c
>> create mode 100644 include/soc/qcom/spm.h
>
>General comment, lets use qcom instead of msm for various things.
>
>[snip]
>
OK, Done. I renamed all msm_ functions to qcom_ functions as well.

>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index 7dcd554..cd249c4 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -11,3 +11,11 @@ config QCOM_GSBI
>>
>> config QCOM_SCM
>> 	bool
>> +
>> +config QCOM_PM
>> +	bool "Qualcomm Power Management"
>> +	depends on PM && ARCH_QCOM
>> +	help
>> +	  QCOM Platform specific power driver to manage cores and L2 low p=
ower
>> +	  modes. It interface with various system drivers to put the cores=
 in
>> +	  low power modes.
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index 70d52ed..20b329f 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -1,3 +1,4 @@
>> obj-$(CONFIG_QCOM_GSBI)	+=3D	qcom_gsbi.o
>> +obj-$(CONFIG_QCOM_PM)	+=3D	spm.o
>> CFLAGS_scm.o :=3D$(call as-instr,.arch_extension sec,-DREQUIRES_SEC=3D=
1)
>> obj-$(CONFIG_QCOM_SCM) +=3D scm.o scm-boot.o
>> diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
>> new file mode 100644
>> index 0000000..1fa6a96
>> --- /dev/null
>> +++ b/drivers/soc/qcom/spm.c
>> @@ -0,0 +1,388 @@
>> +/* Copyright (c) 2011-2014, The Linux Foundation. All rights reserv=
ed.
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
nd
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/delay.h>
>> +#include <linux/init.h>
>> +#include <linux/io.h>
>> +#include <linux/slab.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/err.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include <soc/qcom/spm.h>
>> +
>> +#define NUM_SEQ_ENTRY 32
>> +#define SPM_CTL_ENABLE BIT(0)
>> +
>> +enum {
>> +	MSM_SPM_REG_SAW2_CFG,
>> +	MSM_SPM_REG_SAW2_AVS_CTL,
>> +	MSM_SPM_REG_SAW2_AVS_HYSTERESIS,
>> +	MSM_SPM_REG_SAW2_SPM_CTL,
>> +	MSM_SPM_REG_SAW2_PMIC_DLY,
>> +	MSM_SPM_REG_SAW2_AVS_LIMIT,
>> +	MSM_SPM_REG_SAW2_AVS_DLY,
>> +	MSM_SPM_REG_SAW2_SPM_DLY,
>> +	MSM_SPM_REG_SAW2_PMIC_DATA_0,
>> +	MSM_SPM_REG_SAW2_PMIC_DATA_1,
>> +	MSM_SPM_REG_SAW2_PMIC_DATA_2,
>> +	MSM_SPM_REG_SAW2_PMIC_DATA_3,
>> +	MSM_SPM_REG_SAW2_PMIC_DATA_4,
>> +	MSM_SPM_REG_SAW2_PMIC_DATA_5,
>> +	MSM_SPM_REG_SAW2_PMIC_DATA_6,
>> +	MSM_SPM_REG_SAW2_PMIC_DATA_7,
>> +	MSM_SPM_REG_SAW2_RST,
>> +
>> +	MSM_SPM_REG_NR_INITIALIZE =3D MSM_SPM_REG_SAW2_RST,
>> +
>> +	MSM_SPM_REG_SAW2_ID,
>> +	MSM_SPM_REG_SAW2_SECURE,
>> +	MSM_SPM_REG_SAW2_STS0,
>> +	MSM_SPM_REG_SAW2_STS1,
>> +	MSM_SPM_REG_SAW2_STS2,
>> +	MSM_SPM_REG_SAW2_VCTL,
>> +	MSM_SPM_REG_SAW2_SEQ_ENTRY,
>> +	MSM_SPM_REG_SAW2_SPM_STS,
>> +	MSM_SPM_REG_SAW2_AVS_STS,
>> +	MSM_SPM_REG_SAW2_PMIC_STS,
>> +	MSM_SPM_REG_SAW2_VERSION,
>> +
>> +	MSM_SPM_REG_NR,
>> +};
>> +
>> +static u32 reg_offsets_saw2_v2_1[MSM_SPM_REG_NR] =3D {
>
>Why an array, can=E2=80=99t this just be an enum?
>
An array makes it easier to have multiple SPM versions. The value of th=
e
enums are not very malleable as the driver scales to support multiple
SPM revisions.

>> +	[MSM_SPM_REG_SAW2_SECURE]		=3D 0x00,
>> +	[MSM_SPM_REG_SAW2_ID]			=3D 0x04,
>> +	[MSM_SPM_REG_SAW2_CFG]			=3D 0x08,
>> +	[MSM_SPM_REG_SAW2_SPM_STS]		=3D 0x0C,
>> +	[MSM_SPM_REG_SAW2_AVS_STS]		=3D 0x10,
>> +	[MSM_SPM_REG_SAW2_PMIC_STS]		=3D 0x14,
>> +	[MSM_SPM_REG_SAW2_RST]			=3D 0x18,
>> +	[MSM_SPM_REG_SAW2_VCTL]			=3D 0x1C,
>> +	[MSM_SPM_REG_SAW2_AVS_CTL]		=3D 0x20,
>> +	[MSM_SPM_REG_SAW2_AVS_LIMIT]		=3D 0x24,
>> +	[MSM_SPM_REG_SAW2_AVS_DLY]		=3D 0x28,
>> +	[MSM_SPM_REG_SAW2_AVS_HYSTERESIS]	=3D 0x2C,
>> +	[MSM_SPM_REG_SAW2_SPM_CTL]		=3D 0x30,
>> +	[MSM_SPM_REG_SAW2_SPM_DLY]		=3D 0x34,
>> +	[MSM_SPM_REG_SAW2_PMIC_DATA_0]		=3D 0x40,
>> +	[MSM_SPM_REG_SAW2_PMIC_DATA_1]		=3D 0x44,
>> +	[MSM_SPM_REG_SAW2_PMIC_DATA_2]		=3D 0x48,
>> +	[MSM_SPM_REG_SAW2_PMIC_DATA_3]		=3D 0x4C,
>> +	[MSM_SPM_REG_SAW2_PMIC_DATA_4]		=3D 0x50,
>> +	[MSM_SPM_REG_SAW2_PMIC_DATA_5]		=3D 0x54,
>> +	[MSM_SPM_REG_SAW2_PMIC_DATA_6]		=3D 0x58,
>> +	[MSM_SPM_REG_SAW2_PMIC_DATA_7]		=3D 0x5C,
>> +	[MSM_SPM_REG_SAW2_SEQ_ENTRY]		=3D 0x80,
>> +	[MSM_SPM_REG_SAW2_VERSION]		=3D 0xFD0,
>> +};
>> +
>> +struct spm_of {
>> +	char *key;
>> +	u32 id;
>> +};
>> +
>> +struct msm_spm_mode {
>> +	u32 mode;
>> +	u32 start_addr;
>> +};
>> +
>> +struct msm_spm_driver_data {
>> +	void __iomem *reg_base_addr;
>> +	u32 *reg_offsets;
>> +	struct msm_spm_mode *modes;
>> +	u32 num_modes;
>> +};
>> +
>> +struct msm_spm_device {
>> +	bool initialized;
>> +	struct msm_spm_driver_data drv;
>> +};
>> +
>> +static DEFINE_PER_CPU_SHARED_ALIGNED(struct msm_spm_device, msm_cpu=
_spm_device);
>> +
>> +static const struct of_device_id msm_spm_match_table[] __initconst;
>> +
>> +static int msm_spm_drv_set_low_power_mode(struct msm_spm_driver_dat=
a *drv,
>> +						u32 mode)
>> +{
>
>Can we just fold this into msm_spm_set_low_power_mode

OK.

>>
>> +	int i;
>> +	u32 start_addr =3D 0;
>> +	u32 ctl_val;
>> +
>> +	for (i =3D 0; i < drv->num_modes; i++) {
>> +		if (drv->modes[i].mode =3D=3D mode) {
>> +			start_addr =3D drv->modes[i].start_addr;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (i =3D=3D drv->num_modes)
>> +		return -EINVAL;
>> +
>> +	/* Update bits 10:4 in the SPM CTL register */
>> +	ctl_val =3D readl_relaxed(drv->reg_base_addr +
>> +			drv->reg_offsets[MSM_SPM_REG_SAW2_SPM_CTL]);
>> +	start_addr &=3D 0x7F;
>> +	start_addr <<=3D 4;
>> +	ctl_val &=3D 0xFFFFF80F;
>> +	ctl_val |=3D start_addr;
>> +	writel_relaxed(ctl_val, drv->reg_base_addr +
>> +			drv->reg_offsets[MSM_SPM_REG_SAW2_SPM_CTL]);
>> +	/* Ensure we have written the start address */
>> +	wmb();
>> +
>> +	return 0;
>> +}
>> +
>> +static int msm_spm_drv_set_spm_enable(struct msm_spm_driver_data *d=
rv,
>> +					bool enable)
>> +{
>> +	u32 value =3D enable ? 0x01 : 0x00;
>> +	u32 ctl_val;
>> +
>> +	ctl_val =3D readl_relaxed(drv->reg_base_addr +
>> +			drv->reg_offsets[MSM_SPM_REG_SAW2_SPM_CTL]);
>> +
>> +	/* Update SPM_CTL to enable/disable the SPM */
>> +	if ((ctl_val & SPM_CTL_ENABLE) !=3D value) {
>> +		/* Clear the existing value and update */
>> +		ctl_val &=3D ~0x1;
>> +		ctl_val |=3D value;
>> +		writel_relaxed(ctl_val, drv->reg_base_addr +
>> +			drv->reg_offsets[MSM_SPM_REG_SAW2_SPM_CTL]);
>> +
>> +		/* Ensure we have enabled/disabled before returning */
>> +		wmb();
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * msm_spm_set_low_power_mode() - Configure SPM start address for l=
ow power mode
>> + * @mode: SPM LPM mode to enter
>> + */
>> +int msm_spm_set_low_power_mode(u32 mode)
>> +{
>> +	struct msm_spm_device *dev =3D &__get_cpu_var(msm_cpu_spm_device);
>> +	int ret =3D -EINVAL;
>> +
>> +	if (!dev->initialized)
>> +		return -ENXIO;
>> +
>> +	if (mode =3D=3D MSM_SPM_MODE_DISABLED)
>> +		ret =3D msm_spm_drv_set_spm_enable(&dev->drv, false);
>> +	else if (!msm_spm_drv_set_spm_enable(&dev->drv, true))
>> +		ret =3D msm_spm_drv_set_low_power_mode(&dev->drv, mode);
>> +
>
>This could become:
>
>	if (mode =3D=3D MSM_SPM_MODE_DISABLED)
>		return msm_spm_drv_set_spm_enable(&dev->drv, false);
>
>	if (msm_spm_drv_set_spm_enable(&dev->drv, true))
>		return ret;
>
>	code from msm_spm_drv_set_low_power_mode
>
Sure

>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(msm_spm_set_low_power_mode);
>> +
>> +static void append_seq_data(u32 *reg_seq_entry, u8 *cmd, u32 *offse=
t)
>> +{
>> +	u32 cmd_w;
>> +	u32 offset_w =3D *offset / 4;
>> +	u8 last_cmd;
>> +
>> +	while (1) {
>> +		int i;
>> +
>> +		cmd_w =3D 0;
>> +		last_cmd =3D 0;
>> +		cmd_w =3D reg_seq_entry[offset_w];
>> +
>> +		for (i =3D (*offset % 4); i < 4; i++) {
>> +			last_cmd =3D *(cmd++);
>> +			cmd_w |=3D  last_cmd << (i * 8);
>> +			(*offset)++;
>> +			if (last_cmd =3D=3D 0x0f)
>> +				break;
>> +		}
>> +
>> +		reg_seq_entry[offset_w++] =3D cmd_w;
>> +		if (last_cmd =3D=3D 0x0f)
>> +			break;
>> +	}
>> +}
>> +
>> +static int msm_spm_seq_init(struct msm_spm_device *spm_dev,
>> +			struct platform_device *pdev)
>> +{
>> +	int i;
>> +	u8 *cmd;
>> +	void *addr;
>> +	u32 val;
>> +	u32 count =3D 0;
>> +	int offset =3D 0;
>> +	struct msm_spm_mode modes[MSM_SPM_MODE_NR];
>> +	u32 sequences[NUM_SEQ_ENTRY/4] =3D {0};
>> +	struct msm_spm_driver_data *drv =3D &spm_dev->drv;
>> +
>> +	/* SPM sleep sequences */
>> +	struct spm_of mode_of_data[] =3D {
>> +		{"qcom,saw2-spm-cmd-wfi", MSM_SPM_MODE_CLOCK_GATING},
>> +		{"qcom,saw2-spm-cmd-spc", MSM_SPM_MODE_POWER_COLLAPSE},
>> +	};
>> +
>> +	/**
>> +	 * Compose the u32 array based on the individual bytes of the SPM
>> +	 * sequence for each low power mode that we read from the DT.
>> +	 * The sequences are appended if there is space available in the
>> +	 * u32 after the end of the previous sequence.
>> +	 */
>> +
>> +	for (i =3D 0; i < ARRAY_SIZE(mode_of_data); i++) {
>> +		cmd =3D (u8 *)of_get_property(pdev->dev.of_node,
>> +						mode_of_data[i].key, &val);
>> +		if (!cmd)
>> +			continue;
>> +		/* The last in the sequence should be 0x0F */
>> +		if (cmd[val - 1] !=3D 0x0F)
>> +			continue;
>> +		modes[count].mode =3D mode_of_data[i].id;
>> +		modes[count].start_addr =3D offset;
>> +		append_seq_data(&sequences[0], cmd, &offset);
>> +		count++;
>> +	}
>> +
>> +	/* Write the idle state sequences to SPM */
>> +	drv->modes =3D devm_kcalloc(&pdev->dev, count,
>> +					sizeof(modes[0]), GFP_KERNEL);
>> +	if (!drv->modes)
>> +		return -ENOMEM;
>> +
>> +	drv->num_modes =3D count;
>> +	memcpy(drv->modes, modes, sizeof(modes[0]) * count);
>> +
>> +	/* Flush the integer array */
>> +	addr =3D drv->reg_base_addr +
>> +			drv->reg_offsets[MSM_SPM_REG_SAW2_SEQ_ENTRY];
>> +	for (i =3D 0; i < ARRAY_SIZE(sequences); i++, addr +=3D 4)
>> +		writel_relaxed(sequences[i], addr);
>> +
>> +	/* Ensure we flush the writes */
>> +	wmb();
>> +
>> +	return 0;
>> +}
>> +
>> +static struct msm_spm_device *msm_spm_get_device(struct platform_de=
vice *pdev)
>> +{
>> +	struct msm_spm_device *dev =3D NULL;
>> +	struct device_node *cpu_node;
>> +	u32 cpu;
>> +
>> +	cpu_node =3D of_parse_phandle(pdev->dev.of_node, "qcom,cpu", 0);
>> +	if (cpu_node) {
>> +		for_each_possible_cpu(cpu) {
>> +			if (of_get_cpu_node(cpu, NULL) =3D=3D cpu_node)
>> +				dev =3D &per_cpu(msm_cpu_spm_device, cpu);
>> +		}
>> +	}
>> +
>> +	return dev;
>> +}
>> +
>> +static int msm_spm_dev_probe(struct platform_device *pdev)
>> +{
>> +	int ret;
>> +	int i;
>> +	u32 val;
>> +	struct msm_spm_device *spm_dev;
>> +	struct resource *res;
>> +	const struct of_device_id *match_id;
>> +
>> +	/* SPM Configuration registers */
>> +	struct spm_of spm_of_data[] =3D {
>> +		{"qcom,saw2-clk-div", MSM_SPM_REG_SAW2_CFG},
>> +		{"qcom,saw2-enable", MSM_SPM_REG_SAW2_SPM_CTL},
>> +		{"qcom,saw2-delays", MSM_SPM_REG_SAW2_SPM_DLY},
>> +	};
>
>Remove this array and do explicit of parsing and register setting, so =
only explicitly set what we should.
>
too many of_get_property() calls then Would it be okay if I use a
function to read the property and write to the SPM and call that
repeatedly based on key/enum passed?
I found this array method to be easy to scale.

Just for my curiosity, what is the drawback of this approach?

>> +
>> +	 /* Get the right SPM device */
>> +	spm_dev =3D msm_spm_get_device(pdev);
>> +	if (IS_ERR_OR_NULL(spm_dev))
>> +		return -EINVAL;
>> +
>> +	/* Get the SPM start address */
>> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		ret =3D -EINVAL;
>> +		goto fail;
>> +	}
>> +	spm_dev->drv.reg_base_addr =3D devm_ioremap(&pdev->dev, res->start=
,
>> +					resource_size(res));
>> +	if (!spm_dev->drv.reg_base_addr) {
>> +		ret =3D -ENOMEM;
>> +		goto fail;
>> +	}
>
>Can we move to using devm_ioremap_resource() to reduce the platform_ge=
t_resource/devm_ioremap combo
>
Okay, will fix.

>> +
>> +	match_id =3D of_match_node(msm_spm_match_table, pdev->dev.of_node)=
;
>> +	if (!match_id)
>> +		return -ENODEV;
>> +
>> +	/* Use the register offsets for the SPM version in use */
>> +	spm_dev->drv.reg_offsets =3D (u32 *)match_id->data;
>> +	if (!spm_dev->drv.reg_offsets)
>> +		return -EFAULT;
>> +
>> +	/* Read the SPM idle state sequences */
>> +	ret =3D msm_spm_seq_init(spm_dev, pdev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Read the SPM register values */
>> +	for (i =3D 0; i < ARRAY_SIZE(spm_of_data); i++) {
>> +		ret =3D of_property_read_u32(pdev->dev.of_node,
>> +					spm_of_data[i].key, &val);
>> +		if (ret)
>> +			continue;
>> +		writel_relaxed(val, spm_dev->drv.reg_base_addr +
>> +				spm_dev->drv.reg_offsets[spm_of_data[i].id]);
>> +	}
>
>Change this to explicit parsing of each of prop and add proper read/mo=
dify/writes so we only change the things in the registers we should be =
touching
>
Well these registers are complete writes, so i am thinking, i could
create a function and call that function with different arguments, No?

>> +
>> +	/* Flush all writes */
>> +	wmb();
>> +
>> +	spm_dev->initialized =3D true;
>> +	return ret;
>> +fail:
>> +	dev_err(&pdev->dev, "SPM device probe failed: %d\n", ret);
>> +	return ret;
>> +}
>> +
>> +static const struct of_device_id msm_spm_match_table[] __initconst =
=3D {
>> +	{.compatible =3D "qcom,spm-v2.1", .data =3D reg_offsets_saw2_v2_1}=
,
>> +	{ },
>> +};
>> +
>> +
>> +static struct platform_driver msm_spm_device_driver =3D {
>> +	.probe =3D msm_spm_dev_probe,
>> +	.driver =3D {
>> +		.name =3D "spm",
>> +		.owner =3D THIS_MODULE,
>> +		.of_match_table =3D msm_spm_match_table,
>> +	},
>> +};
>> +
>> +static int __init msm_spm_device_init(void)
>> +{
>> +	return platform_driver_register(&msm_spm_device_driver);
>> +}
>> +device_initcall(msm_spm_device_init);
>> diff --git a/include/soc/qcom/spm.h b/include/soc/qcom/spm.h
>> new file mode 100644
>> index 0000000..29686ef
>> --- /dev/null
>> +++ b/include/soc/qcom/spm.h
>> @@ -0,0 +1,38 @@
>> +/* Copyright (c) 2010-2014, The Linux Foundation. All rights reserv=
ed.
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
nd
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#ifndef __QCOM_SPM_H
>> +#define __QCOM_SPM_H
>> +
>> +enum {
>> +	MSM_SPM_MODE_DISABLED,
>> +	MSM_SPM_MODE_CLOCK_GATING,
>> +	MSM_SPM_MODE_RETENTION,
>> +	MSM_SPM_MODE_GDHS,
>> +	MSM_SPM_MODE_POWER_COLLAPSE,
>> +	MSM_SPM_MODE_NR
>> +};
>
>Why don=E2=80=99t we make this a named enum, than msm_spm_set_low_powe=
r_mode can take that enum
>>
Sure.
>> +
>> +struct msm_spm_device;
>> +
Need to remove this.

>> +#if defined(CONFIG_QCOM_PM)
>> +
>> +int msm_spm_set_low_power_mode(u32 mode);
>
>So this could become
>
>int qcom_spm_set_low_power_mode(enum qcom_spm_mode mode)
>
Agreed.

>> +
>> +#else
>> +
>> +static inline int msm_spm_set_low_power_mode(u32 mode)
>> +{ return -ENOSYS; }
>> +
>> +#endif  /* CONFIG_QCOM_PM */
>> +
>> +#endif  /* __QCOM_SPM_H */
>> --
>> 1.9.1
>>
>
>--=20
>Employee of Qualcomm Innovation Center, Inc.
>Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hos=
ted by The Linux Foundation
>
