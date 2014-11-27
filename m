From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v13 03/10] qcom: spm: Add Subsystem Power Manager driver
Date: Thu, 27 Nov 2014 09:52:35 +0100
Message-ID: <5476E653.4040007@linaro.org>
References: <1417065854-37745-1-git-send-email-lina.iyer@linaro.org> <1417065854-37745-4-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:48120 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751AbaK0Iwj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Nov 2014 03:52:39 -0500
Received: by mail-wg0-f52.google.com with SMTP id a1so5829770wgh.25
        for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2014 00:52:38 -0800 (PST)
In-Reply-To: <1417065854-37745-4-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On 11/27/2014 06:24 AM, Lina Iyer wrote:
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
> Reviewed-by: Kevin Hilman <khilman@linaro.org>

[ ... ]

> +static struct spm_driver_data *spm_get_drv(struct platform_device *p=
dev,
> +		int *spm_cpu)
> +{
> +	struct spm_driver_data *drv =3D NULL;
> +	struct device_node *cpu_node, *saw_node;
> +	int cpu;
> +	bool found =3D false;
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_node =3D of_cpu_device_node_get(cpu);
> +		if (!cpu_node)
> +			continue;
> +		saw_node =3D of_parse_phandle(cpu_node, "qcom,saw", 0);
> +		if (saw_node) {
> +			if (saw_node =3D=3D pdev->dev.of_node)
> +				found =3D true;
> +			of_node_put(saw_node);
> +		}
> +		of_node_put(cpu_node);
> +		if (found)
> +			break;
> +	}
> +
> +	if (found) {
> +		drv =3D devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
> +		if (drv)
> +			*spm_cpu =3D cpu;
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
> +static const struct qcom_cpu_pm_ops lpm_ops =3D {
> +	.standby =3D qcom_cpu_standby,
> +	.spc =3D qcom_cpu_spc,
> +};
> +
> +static int spm_dev_probe(struct platform_device *pdev)
> +{
> +	struct spm_driver_data *drv;
> +	struct resource *res;
> +	const struct of_device_id *match_id;
> +	void __iomem *addr;
> +	int cpu =3D -EINVAL;
> +	static bool cpuidle_drv_init;

         ^^^^^^^^^

As already said in a previous comment, please find a way to remove that=
=2E

> +	const struct platform_device_info qcom_cpuidle_info =3D {
> +		.name	=3D "qcom_cpuidle",
> +		.id	=3D -1,
> +		.data =3D &lpm_ops,
> +		.size_data =3D sizeof(lpm_ops),
> +	};
> +
> +	drv =3D spm_get_drv(pdev, &cpu);
> +	if (!drv || cpu < 0)
> +		return -EINVAL;

As already said in a previous comment, it is not possible to have "cpu =
<=20
0" with "drv !=3D NULL", so except I am missing something the test shou=
ld be:

	if (!drv)
		return -EINVAL;

There is something wrong with the init sequence. Don't you find weird=20
you have to backward search for the cpu belonging to the pdev each time=
=20
the probe function is called ?


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
> +
> +	/* Write the SPM sequences first.. */
> +	addr =3D drv->reg_base + drv->reg_data->reg_offset[SPM_REG_SEQ_ENTR=
Y];
> +	__iowrite32_copy(addr, drv->reg_data->seq,
> +			ARRAY_SIZE(drv->reg_data->seq) / 4);
> +
> +	/*
> +	 * ..and then the control registers.
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
> +	/*
> +	 * Ensure all observers see the above register writes before the
> +	 * cpuidle driver is allowed to use the SPM.
> +	 */
> +	wmb();
> +	per_cpu(cpu_spm_drv, cpu) =3D drv;
> +
> +	if (!cpuidle_drv_init) {
> +		platform_device_register_full(&qcom_cpuidle_info);
> +		cpuidle_drv_init =3D true;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver spm_driver =3D {
> +	.probe =3D spm_dev_probe,
> +	.driver =3D {
> +		.name =3D "saw",
> +		.of_match_table =3D spm_match_table,
> +	},
> +};
> +
> +module_platform_driver(spm_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("SAW power controller driver");
> +MODULE_ALIAS("platform:saw");
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

