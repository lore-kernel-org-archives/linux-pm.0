From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v9 2/9] qcom: spm: Add Subsystem Power Manager driver
Date: Tue, 18 Nov 2014 09:56:14 -0700
Message-ID: <20141118165614.GB770@linaro.org>
References: <1414194024-55547-1-git-send-email-lina.iyer@linaro.org>
 <1414194024-55547-3-git-send-email-lina.iyer@linaro.org>
 <20141114224620.GD11808@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141114224620.GD11808@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 14 2014 at 15:46 -0700, Stephen Boyd wrote:
>On 10/24, Lina Iyer wrote:
>> diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
>> new file mode 100644
>> index 0000000..ee2e3ca
>> --- /dev/null
>> +++ b/drivers/soc/qcom/spm.c
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/delay.h>
>
>Is this used?
>
OK. Will check and remove.
>> +#include <linux/init.h>
>> +#include <linux/io.h>
>> +#include <linux/slab.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_device.h>
>> +#include <linux/err.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/cpuidle.h>
>> +#include <linux/cpu_pm.h>
>> +
>> +#include <asm/proc-fns.h>
>> +#include <asm/suspend.h>
>> +
>> +#include <soc/qcom/pm.h>
>> +#include <soc/qcom/pm.h>
>> +#include <soc/qcom/scm.h>
>> +#include <soc/qcom/scm-boot.h>
>> +
>> +
>> +#define SCM_CMD_TERMINATE_PC	(0x2)
>> +#define SCM_FLUSH_FLAG_MASK	(0x3)
>> +#define SCM_L2_ON		(0x0)
>> +#define SCM_L2_OFF		(0x1)
>> +#define MAX_PMIC_DATA 2
>> +#define MAX_SEQ_DATA 64
>> +
>> +#define SPM_CTL_INDEX 0x7f
>> +#define SPM_CTL_INDEX_SHIFT 4
>> +#define SPM_CTL_EN BIT(0)
>
>Nitpick, why aren't these also tabbed out?
>
Ok
>> +
>> +/**
>> + * spm_set_low_power_mode() - Configure SPM start address for low power mode
>> + * @mode: SPM LPM mode to enter
>> + */
>> +int qcom_spm_set_low_power_mode(enum pm_sleep_mode mode)
>
>static?
>
Yeah, seem to have noticed and fixed.

>> +{
>> +	struct spm_driver_data *drv = this_cpu_ptr(&cpu_spm_drv);
>> +	u32 start_index;
>> +	u32 ctl_val;
>> +
>> +	if (!drv->available)
>> +		return -ENXIO;
>
>It would be nice if we didn't need this by only registering the
>cpuidle device for this CPU once we've initialized the SPM
>hardware.
>
I did explore it. It strays our cpuidle code away from the standard code
that we are trying to go towards with idle-states framework.

>> +
>> +	start_index = drv->reg_data->start_index[mode];
>> +
>> +	ctl_val = spm_register_read(drv, SPM_REG_SPM_CTL);
>> +	ctl_val &= ~(SPM_CTL_INDEX << SPM_CTL_INDEX_SHIFT);
>> +	ctl_val |= start_index << SPM_CTL_INDEX_SHIFT;
>> +	ctl_val |= SPM_CTL_EN;
>> +	spm_register_write(drv, SPM_REG_SPM_CTL, ctl_val);
>> +
>> +	/* Ensure we have written the start address */
>> +	wmb();
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_pm_collapse(unsigned long int unused)
>> +{
>> +	int ret;
>> +	u32 flag;
>> +	int cpu = smp_processor_id();
>> +
>> +	ret = scm_set_warm_boot_addr(cpu_resume, cpu);
>> +	if (ret) {
>> +		pr_err("Failed to set warm boot address for cpu %d\n", cpu);
>
>Do we want this print? Won't it start spamming the log if we go
>idle and we can't set the flag? Maybe we should just be silent
>and return an error.
>
OK. removed.
I can remove it..

>> +		return ret;
>> +	}
>> +
>> +	flag = SCM_L2_ON & SCM_FLUSH_FLAG_MASK;
>> +	scm_call_atomic1(SCM_SVC_BOOT, SCM_CMD_TERMINATE_PC, flag);
>> +
>> +	/**
>> +	 *  Returns here only if there was a pending interrupt and we did not
>> +	 *  power down as a result.
>> +	 */
>> +	return 0;
>> +}
>[...]
>> +
>> +static struct qcom_cpu_pm_ops lpm_ops = {
>
>const?
>
Ok
>> +	.standby = qcom_cpu_standby,
>> +	.spc = qcom_cpu_spc,
>> +};
>> +
>> +struct platform_device qcom_cpuidle_device = {
>> +	.name              = "qcom_cpuidle",
>> +	.id                = -1,
>> +	.dev.platform_data = &lpm_ops,
>> +};
>
>This can be created dynamically instead of living statically.
>
Done.
>> +
>> +static int spm_dev_probe(struct platform_device *pdev)
>> +{
>[...]
>> +
>> +	match_id = of_match_node(spm_match_table, pdev->dev.of_node);
>> +	if (!match_id)
>> +		return -ENODEV;
>> +
>> +	drv->reg_data = match_id->data;
>> +	if (!drv->reg_data)
>> +		return -EINVAL;
>
>This check seems useless. We control the .data field right above
>this function so there better be some reg_data.
>
Removed.
>> +
>> +	/* Write the SPM sequences, first.. */
>> +	addr = drv->reg_base + drv->reg_data->reg_offset[SPM_REG_SEQ_ENTRY];
>> +	seq_data = (const u32 *)drv->reg_data->seq;
>
>Why do we need a cast?
>
Compiler warns otherwise.

>> +	__iowrite32_copy(addr, seq_data, ARRAY_SIZE(drv->reg_data->seq)/4);
>
>nitpick: space around that / please.
>
>> +
>> +	/* ..and then, the control registers.
>> +	 * On some SoC's if the control registers are written first and if the
>> +	 * CPU was held in reset, the reset signal could trigger the SPM state
>> +	 * machine, before the sequences are completely written.
>> +	 */
>> +	spm_register_write(drv, SPM_REG_CFG, drv->reg_data->spm_cfg);
>> +	spm_register_write(drv, SPM_REG_DLY, drv->reg_data->spm_dly);
>> +	spm_register_write(drv, SPM_REG_PMIC_DLY, drv->reg_data->pmic_dly);
>> +
>> +	spm_register_write(drv, SPM_REG_PMIC_DATA_0,
>> +				drv->reg_data->pmic_data[0]);
>> +	spm_register_write(drv, SPM_REG_PMIC_DATA_1,
>> +				drv->reg_data->pmic_data[1]);
>> +
>> +	/**
>> +	 * Ensure all observers see the above register writes before the
>> +	 * cpuidle driver is allowed to use the SPM.
>> +	 */
>> +	wmb();
>> +	drv->available = true;
>> +
>> +	if ((cpu > -1) && !cpuidle_drv_init) {
>
>Nitpick: () are unnecessary.
>
OK

>> +		platform_device_register(&qcom_cpuidle_device);
>> +		cpuidle_drv_init = true;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver spm_driver = {
>> +	.probe = spm_dev_probe,
>> +	.driver = {
>> +		.name = "qcom,spm",
>
>This is an odd driver name with the "qcom," part. Maybe call it "spm" or "saw"?
>
Sure.

>> +		.of_match_table = spm_match_table,
>> +	},
>> +};
>> +
>> +module_platform_driver(spm_driver);
>
>MODULE_LICENSE()?
>MODULE_ALIAS()?
>
MODULE_DESCRIPTION() would work?

Thanks Stephen for your time.

Lina
