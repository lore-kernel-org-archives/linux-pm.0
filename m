From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v13 03/10] qcom: spm: Add Subsystem Power Manager driver
Date: Mon, 1 Dec 2014 11:50:23 -0700
Message-ID: <20141201185023.GB499@linaro.org>
References: <1417065854-37745-1-git-send-email-lina.iyer@linaro.org>
 <1417065854-37745-4-git-send-email-lina.iyer@linaro.org>
 <5476E653.4040007@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:61409 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbaLASu0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 13:50:26 -0500
Received: by mail-pd0-f182.google.com with SMTP id r10so11480896pdi.27
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2014 10:50:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5476E653.4040007@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On Thu, Nov 27 2014 at 01:52 -0700, Daniel Lezcano wrote:
>On 11/27/2014 06:24 AM, Lina Iyer wrote:

>+	static bool cpuidle_drv_init;
>
>        ^^^^^^^^^
>
>As already said in a previous comment, please find a way to remove tha=
t.
>
I will look into it. Stephen and I wanted the cpuidle driver to be
probed only after any of the SPMs are ready. And possibly, only for tha=
t
cpu, for which the SPM has been probed.

To achieve the SPM -> CPUIDLE Device relation, I havent found a good wa=
y
to do that. Without using CPUIDLE_MULTIPLE_DRIVERS, initializing each
cpuidle device, separate from the cpuidle driver, requires that I updat=
e=20
the cpuidle_driver->cpumask after probing each SPM device, to allow for
only one driver and cpuidle devices only for the probed cpus. Using the
cpuidle_register_driver(), resets the drv->refcnt in
__cpuidle_driver_init.

I may need something like this in the else clause of CPUIDLE_MULTIPLE_D=
RIVERS -

static inline struct cpuidle_driver *__cpuidle_get_cpu_driver(int cpu)
{
        struct cpuidle_driver *drv =3D cpuidle_curr_driver;

        if (drv && !cpumask_test_cpu(cpu, drv->cpumask))
                 drv =3D NULL;

        return drv;
}

void cpuidle_update_cpumask(struct cpumask *mask) {
        struct cpuidle_driver *drv;

        spin_lock(&cpuidle_driver_lock);
        drv =3D cpuidle_get_driver();
	if (drv)
		drv->cpumask =3D mask ?: cpu_possible_mask;
        spin_unlock(&cpuidle_driver_lock);
}

With that, I could register cpuidle driver the first time when the mask=
 changes
from empty and consequent updates would just update the cpumask. (I am =
not
sure, if I missed anything in this change). It just seemed far too inva=
sive at
this time, in lieu of the static bool.

>>+	const struct platform_device_info qcom_cpuidle_info =3D {
>>+		.name	=3D "qcom_cpuidle",
>>+		.id	=3D -1,
>>+		.data =3D &lpm_ops,
>>+		.size_data =3D sizeof(lpm_ops),
>>+	};
>>+
>>+	drv =3D spm_get_drv(pdev, &cpu);
>>+	if (!drv || cpu < 0)
>>+		return -EINVAL;
>
>As already said in a previous comment, it is not possible to have "cpu=
=20
>< 0" with "drv !=3D NULL", so except I am missing something the test=20
>should be:
>
>	if (!drv)
>		return -EINVAL;
>
Sorry, done.

>There is something wrong with the init sequence. Don't you find weird=20
>you have to backward search for the cpu belonging to the pdev each=20
>time the probe function is called ?
>
>
Well, it was that or the SPM device node pointing to the CPU that it
references. It seems more common to have an iterator than the doubly
linked device nodes. I dont have a strong preference either way, just
chose the way that made device nodes easier.

>>+
>>+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>+	drv->reg_base =3D devm_ioremap_resource(&pdev->dev, res);
>>+	if (IS_ERR(drv->reg_base))
>>+		return PTR_ERR(drv->reg_base);
>>+
>>+	match_id =3D of_match_node(spm_match_table, pdev->dev.of_node);
>>+	if (!match_id)
>>+		return -ENODEV;
>>+
>>+	drv->reg_data =3D match_id->data;
>>+
>>+	/* Write the SPM sequences first.. */
>>+	addr =3D drv->reg_base + drv->reg_data->reg_offset[SPM_REG_SEQ_ENTR=
Y];
>>+	__iowrite32_copy(addr, drv->reg_data->seq,
>>+			ARRAY_SIZE(drv->reg_data->seq) / 4);
>>+
>>+	/*
>>+	 * ..and then the control registers.
>>+	 * On some SoC's if the control registers are written first and if =
the
>>+	 * CPU was held in reset, the reset signal could trigger the SPM st=
ate
>>+	 * machine, before the sequences are completely written.
>>+	 */
>>+	spm_register_write(drv, SPM_REG_CFG, drv->reg_data->spm_cfg);
>>+	spm_register_write(drv, SPM_REG_DLY, drv->reg_data->spm_dly);
>>+	spm_register_write(drv, SPM_REG_PMIC_DLY, drv->reg_data->pmic_dly);
>>+
>>+	spm_register_write(drv, SPM_REG_PMIC_DATA_0,
>>+				drv->reg_data->pmic_data[0]);
>>+	spm_register_write(drv, SPM_REG_PMIC_DATA_1,
>>+				drv->reg_data->pmic_data[1]);
>>+
>>+	/*
>>+	 * Ensure all observers see the above register writes before the
>>+	 * cpuidle driver is allowed to use the SPM.
>>+	 */
>>+	wmb();
>>+	per_cpu(cpu_spm_drv, cpu) =3D drv;
>>+
>>+	if (!cpuidle_drv_init) {
>>+		platform_device_register_full(&qcom_cpuidle_info);
>>+		cpuidle_drv_init =3D true;
>>+	}
>>+
>>+	return 0;
>>+}
>>+
>>+static struct platform_driver spm_driver =3D {
>>+	.probe =3D spm_dev_probe,
>>+	.driver =3D {
>>+		.name =3D "saw",
>>+		.of_match_table =3D spm_match_table,
>>+	},
>>+};
>>+
>>+module_platform_driver(spm_driver);
>>+
>>+MODULE_LICENSE("GPL v2");
>>+MODULE_DESCRIPTION("SAW power controller driver");
>>+MODULE_ALIAS("platform:saw");
>>diff --git a/include/soc/qcom/pm.h b/include/soc/qcom/pm.h
>>new file mode 100644
>>index 0000000..d9a56d7
>>--- /dev/null
>>+++ b/include/soc/qcom/pm.h
>>@@ -0,0 +1,31 @@
>>+/*
>>+ * Copyright (c) 2009-2014, The Linux Foundation. All rights reserve=
d.
>>+ *
>>+ * This software is licensed under the terms of the GNU General Publ=
ic
>>+ * License version 2, as published by the Free Software Foundation, =
and
>>+ * may be copied, distributed, and modified under those terms.
>>+ *
>>+ * This program is distributed in the hope that it will be useful,
>>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>+ * GNU General Public License for more details.
>>+ *
>>+ */
>>+
>>+#ifndef __QCOM_PM_H
>>+#define __QCOM_PM_H
>>+
>>+enum pm_sleep_mode {
>>+	PM_SLEEP_MODE_STBY,
>>+	PM_SLEEP_MODE_RET,
>>+	PM_SLEEP_MODE_SPC,
>>+	PM_SLEEP_MODE_PC,
>>+	PM_SLEEP_MODE_NR,
>>+};
>>+
>>+struct qcom_cpu_pm_ops {
>>+	int (*standby)(void *data);
>>+	int (*spc)(void *data);
>>+};
>>+
>>+#endif  /* __QCOM_PM_H */
>>
>
>
>--=20
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs
>
>Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
><http://twitter.com/#!/linaroorg> Twitter |
><http://www.linaro.org/linaro-blog/> Blog
>
