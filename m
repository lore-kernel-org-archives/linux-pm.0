From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v13 03/10] qcom: spm: Add Subsystem Power Manager driver
Date: Thu, 27 Nov 2014 15:01:37 +0000
Message-ID: <20141127150137.GA7889@red-moon>
References: <1417065854-37745-1-git-send-email-lina.iyer@linaro.org>
 <1417065854-37745-4-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:40779 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbaK0PBx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Nov 2014 10:01:53 -0500
Content-Disposition: inline
In-Reply-To: <1417065854-37745-4-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "khilman@linaro.org" <khilman@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "msivasub@codeaurora.org" <msivasub@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thu, Nov 27, 2014 at 05:24:07AM +0000, Lina Iyer wrote:

[...]

> +static int spm_set_low_power_mode(enum pm_sleep_mode mode)
> +{
> +       struct spm_driver_data *drv = per_cpu(cpu_spm_drv,
> +                                               smp_processor_id());
> +       u32 start_index;
> +       u32 ctl_val;
> +
> +       if (!drv)
> +               return -ENXIO;
> +
> +       start_index = drv->reg_data->start_index[mode];
> +
> +       ctl_val = spm_register_read(drv, SPM_REG_SPM_CTL);
> +       ctl_val &= ~(SPM_CTL_INDEX << SPM_CTL_INDEX_SHIFT);
> +       ctl_val |= start_index << SPM_CTL_INDEX_SHIFT;
> +       ctl_val |= SPM_CTL_EN;
> +       spm_register_write(drv, SPM_REG_SPM_CTL, ctl_val);
> +
> +       /* Ensure we have written the start address */
> +       wmb();

Can you explain please what this wmb is meant to achieve ? If it is there
to make sure the write made it to the SPM that's not a proper way
to achieve it, the barrier ensures ordering, not write completion.

> +
> +       return 0;
> +}
> +
> +static int qcom_pm_collapse(unsigned long int unused)
> +{
> +       int ret;
> +       u32 flag;
> +       int cpu = smp_processor_id();
> +
> +       ret = scm_set_warm_boot_addr(cpu_resume, cpu);
> +       if (ret)
> +               return ret;
> +
> +       flag = SCM_L2_ON & SCM_FLUSH_FLAG_MASK;
> +       scm_call_atomic1(SCM_SVC_BOOT, SCM_CMD_TERMINATE_PC, flag);
> +
> +       /*
> +        * Returns here only if there was a pending interrupt and we did not
> +        * power down as a result.
> +        */
> +       return 0;

I know the return value is changed by the cpu_suspend implementation to
signal error when not returning from cpu_resume, but you should not
return 0 anyway.

> +}
> +
> +static int qcom_cpu_standby(void *unused)
> +{
> +       int ret;
> +
> +       ret = spm_set_low_power_mode(PM_SLEEP_MODE_STBY);
> +       if (ret)
> +               return ret;
> +
> +       cpu_do_idle();
> +
> +       return 0;
> +}
> +
> +static int qcom_cpu_spc(void *unused)
> +{      int ret;
> +
> +       ret = spm_set_low_power_mode(PM_SLEEP_MODE_STBY);
> +       if (ret)
> +               return ret;
> +
> +       cpu_pm_enter();
> +       cpu_suspend(0, qcom_pm_collapse);

You must stash the return value and propagate it.

> +       cpu_pm_exit();
> +
> +       return 0;
> +}
> +
> +static struct spm_driver_data *spm_get_drv(struct platform_device *pdev,
> +               int *spm_cpu)
> +{
> +       struct spm_driver_data *drv = NULL;
> +       struct device_node *cpu_node, *saw_node;
> +       int cpu;
> +       bool found = false;
> +
> +       for_each_possible_cpu(cpu) {
> +               cpu_node = of_cpu_device_node_get(cpu);
> +               if (!cpu_node)
> +                       continue;
> +               saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);

+               if (saw_node) {
+                       if (saw_node == pdev->dev.of_node)
+                               found = true;
+                       of_node_put(saw_node);
+               }

can be:
		found = (saw_node == pdev->dev.of_node);
		of_node_put(saw_node);

Thanks,
Lorenzo

> +               of_node_put(cpu_node);
> +               if (found)
> +                       break;
> +       }
> +
> +       if (found) {
> +               drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
> +               if (drv)
> +                       *spm_cpu = cpu;
> +       }
> +
> +       return drv;
> +}
> +
> +static const struct of_device_id spm_match_table[] = {
> +       { .compatible = "qcom,msm8974-saw2-v2.1-cpu",
> +         .data = &spm_reg_8974_8084_cpu },
> +       { .compatible = "qcom,apq8084-saw2-v2.1-cpu",
> +         .data = &spm_reg_8974_8084_cpu },
> +       { .compatible = "qcom,apq8064-saw2-v1.1-cpu",
> +         .data = &spm_reg_8064_cpu },
> +       { },
> +};
> +
> +static const struct qcom_cpu_pm_ops lpm_ops = {
> +       .standby = qcom_cpu_standby,
> +       .spc = qcom_cpu_spc,
> +};
> +
> +static int spm_dev_probe(struct platform_device *pdev)
> +{
> +       struct spm_driver_data *drv;
> +       struct resource *res;
> +       const struct of_device_id *match_id;
> +       void __iomem *addr;
> +       int cpu = -EINVAL;
> +       static bool cpuidle_drv_init;
> +       const struct platform_device_info qcom_cpuidle_info = {
> +               .name   = "qcom_cpuidle",
> +               .id     = -1,
> +               .data = &lpm_ops,
> +               .size_data = sizeof(lpm_ops),
> +       };
> +
> +       drv = spm_get_drv(pdev, &cpu);
> +       if (!drv || cpu < 0)
> +               return -EINVAL;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       drv->reg_base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(drv->reg_base))
> +               return PTR_ERR(drv->reg_base);
> +
> +       match_id = of_match_node(spm_match_table, pdev->dev.of_node);
> +       if (!match_id)
> +               return -ENODEV;
> +
> +       drv->reg_data = match_id->data;
> +
> +       /* Write the SPM sequences first.. */
> +       addr = drv->reg_base + drv->reg_data->reg_offset[SPM_REG_SEQ_ENTRY];
> +       __iowrite32_copy(addr, drv->reg_data->seq,
> +                       ARRAY_SIZE(drv->reg_data->seq) / 4);
> +
> +       /*
> +        * ..and then the control registers.
> +        * On some SoC's if the control registers are written first and if the
> +        * CPU was held in reset, the reset signal could trigger the SPM state
> +        * machine, before the sequences are completely written.
> +        */
> +       spm_register_write(drv, SPM_REG_CFG, drv->reg_data->spm_cfg);
> +       spm_register_write(drv, SPM_REG_DLY, drv->reg_data->spm_dly);
> +       spm_register_write(drv, SPM_REG_PMIC_DLY, drv->reg_data->pmic_dly);
> +
> +       spm_register_write(drv, SPM_REG_PMIC_DATA_0,
> +                               drv->reg_data->pmic_data[0]);
> +       spm_register_write(drv, SPM_REG_PMIC_DATA_1,
> +                               drv->reg_data->pmic_data[1]);
> +
> +       /*
> +        * Ensure all observers see the above register writes before the
> +        * cpuidle driver is allowed to use the SPM.
> +        */
> +       wmb();
> +       per_cpu(cpu_spm_drv, cpu) = drv;
> +
> +       if (!cpuidle_drv_init) {
> +               platform_device_register_full(&qcom_cpuidle_info);
> +               cpuidle_drv_init = true;
> +       }
> +
> +       return 0;
> +}
> +
> +static struct platform_driver spm_driver = {
> +       .probe = spm_dev_probe,
> +       .driver = {
> +               .name = "saw",
> +               .of_match_table = spm_match_table,
> +       },
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
> + * Copyright (c) 2009-2014, The Linux Foundation. All rights reserved.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
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
> +       PM_SLEEP_MODE_STBY,
> +       PM_SLEEP_MODE_RET,
> +       PM_SLEEP_MODE_SPC,
> +       PM_SLEEP_MODE_PC,
> +       PM_SLEEP_MODE_NR,
> +};
> +
> +struct qcom_cpu_pm_ops {
> +       int (*standby)(void *data);
> +       int (*spc)(void *data);
> +};
> +
> +#endif  /* __QCOM_PM_H */
> --
> 2.1.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
