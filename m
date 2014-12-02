From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v14 03/10] qcom: spm: Add Subsystem Power Manager driver
Date: Tue, 2 Dec 2014 16:05:44 -0700
Message-ID: <20141202230544.GG499@linaro.org>
References: <1417541958-56907-1-git-send-email-lina.iyer@linaro.org>
 <1417541958-56907-4-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1417541958-56907-4-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 02 2014 at 10:40 -0700, Lina Iyer wrote:
+
[...]
>+static int spm_dev_probe(struct platform_device *pdev)
>+{
>+	struct spm_driver_data *drv;
>+	struct resource *res;
>+	const struct of_device_id *match_id;
>+	void __iomem *addr;
>+	int cpu;
>+	struct cpuidle_device *dev;
>+
>+	drv = spm_get_drv(pdev, &cpu);
>+	if (!drv)
>+		return -EINVAL;
>+
>+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>+	drv->reg_base = devm_ioremap_resource(&pdev->dev, res);
>+	if (IS_ERR(drv->reg_base))
>+		return PTR_ERR(drv->reg_base);
>+
>+	match_id = of_match_node(spm_match_table, pdev->dev.of_node);
>+	if (!match_id)
>+		return -ENODEV;
>+
>+	drv->reg_data = match_id->data;
>+
>+	/* Write the SPM sequences first.. */
>+	addr = drv->reg_base + drv->reg_data->reg_offset[SPM_REG_SEQ_ENTRY];
>+	__iowrite32_copy(addr, drv->reg_data->seq,
>+			ARRAY_SIZE(drv->reg_data->seq) / 4);
>+
>+	/*
>+	 * ..and then the control registers.
>+	 * On some SoC if the control registers are written first and if the
>+	 * CPU was held in reset, the reset signal could trigger the SPM state
>+	 * machine, before the sequences are completely written.
>+	 */
>+	spm_register_write(drv, SPM_REG_CFG, drv->reg_data->spm_cfg);
>+	spm_register_write(drv, SPM_REG_DLY, drv->reg_data->spm_dly);
>+	spm_register_write(drv, SPM_REG_PMIC_DLY, drv->reg_data->pmic_dly);
>+	spm_register_write(drv, SPM_REG_PMIC_DATA_0,
>+				drv->reg_data->pmic_data[0]);
>+	spm_register_write(drv, SPM_REG_PMIC_DATA_1,
>+				drv->reg_data->pmic_data[1]);
>+
>+	per_cpu(cpu_spm_drv, cpu) = drv;
>+
>+	/* Register the cpuidle device for the cpu, we are ready for cpuidle */
>+	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
>+	if (!dev)
>+		return -ENOMEM;
>+
>+	dev->cpu = cpu;
>+	return cpuidle_register_device(dev);
>+}
>+
>+static struct qcom_cpu_pm_ops lpm_ops = {
>+	.standby = qcom_cpu_standby,
>+	.spc = qcom_cpu_spc,
>+};
>+
>+static struct platform_device qcom_cpuidle_drv = {
>+	.name	= "qcom_cpuidle",
>+	.id	= -1,
>+	.dev.platform_data = &lpm_ops,
>+};
>+
>+static struct platform_driver spm_driver = {
>+	.probe = spm_dev_probe,
>+	.driver = {
>+		.name = "saw",
>+		.of_match_table = spm_match_table,
>+	},
>+};
>+
>+static int __init qcom_spm_init(void)
>+{
>+	int ret;
>+
>+	/*
>+	 * cpuidle driver need to registered before the cpuidle device
>+	 * for any cpu. Register the device for the the cpuidle driver.
>+	 */
>+	ret = platform_device_register(&qcom_cpuidle_drv);
>+	if (ret)
>+		return ret;
Stephen pointed out that we would have the platform device lying around
on a non-QCOM device when using multi_v7_defconfig.

So instead of doing this here, we could do this in the probe..

 if (!cpuidle_get_driver()) {
         int ret = platform_device_register(&qcom_cpuidle_drv);
         if (ret)
                 return ret;
 }

Would that be okay?

The successful probe indicates that we are on a QCOM SoC, and we have not
registered a cpuidle_driver before this.

Thanks,
Lina

>+
>+	return platform_driver_register(&spm_driver);
>+}
>+module_init(qcom_spm_init);
>+
>+MODULE_LICENSE("GPL v2");
>+MODULE_DESCRIPTION("SAW power controller driver");
>+MODULE_ALIAS("platform:saw");
>diff --git a/include/soc/qcom/pm.h b/include/soc/qcom/pm.h
>new file mode 100644
>index 0000000..d9a56d7
>--- /dev/null
>+++ b/include/soc/qcom/pm.h
>@@ -0,0 +1,31 @@
>+/*
>+ * Copyright (c) 2009-2014, The Linux Foundation. All rights reserved.
>+ *
>+ * This software is licensed under the terms of the GNU General Public
>+ * License version 2, as published by the Free Software Foundation, and
>+ * may be copied, distributed, and modified under those terms.
>+ *
>+ * This program is distributed in the hope that it will be useful,
>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>+ * GNU General Public License for more details.
>+ *
>+ */
>+
>+#ifndef __QCOM_PM_H
>+#define __QCOM_PM_H
>+
>+enum pm_sleep_mode {
>+	PM_SLEEP_MODE_STBY,
>+	PM_SLEEP_MODE_RET,
>+	PM_SLEEP_MODE_SPC,
>+	PM_SLEEP_MODE_PC,
>+	PM_SLEEP_MODE_NR,
>+};
>+
>+struct qcom_cpu_pm_ops {
>+	int (*standby)(void *data);
>+	int (*spc)(void *data);
>+};
>+
>+#endif  /* __QCOM_PM_H */
>-- 
>2.1.0
>
