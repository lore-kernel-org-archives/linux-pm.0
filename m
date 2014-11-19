From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v9 2/9] qcom: spm: Add Subsystem Power Manager driver
Date: Wed, 19 Nov 2014 10:43:39 -0700
Message-ID: <20141119174339.GA891@linaro.org>
References: <1414194024-55547-1-git-send-email-lina.iyer@linaro.org>
 <1414194024-55547-3-git-send-email-lina.iyer@linaro.org>
 <54662622.2020307@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54662622.2020307@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 14 2014 at 08:56 -0700, Daniel Lezcano wrote:
>On 10/25/2014 01:40 AM, Lina Iyer wrote:

>>+/**
>>+ * spm_set_low_power_mode() - Configure SPM start address for low power mode
>>+ * @mode: SPM LPM mode to enter
>>+ */
>>+int qcom_spm_set_low_power_mode(enum pm_sleep_mode mode)
>>+{
>>+	struct spm_driver_data *drv = this_cpu_ptr(&cpu_spm_drv);
>>+	u32 start_index;
>>+	u32 ctl_val;
>>+
>>+	if (!drv->available)
>>+		return -ENXIO;
>
>really weird how this was initialized.
>
>Are you sure 'drv' is not NULL if it is not available ? (see below)
>
'drv' has some data that I need to decode the register address. Hence
cant have that NULL. Therefore, the available flag.

...

>+static int spm_dev_probe(struct platform_device *pdev)
>>+{
>>+	struct spm_driver_data *drv;
>>+	struct resource *res;
>>+	const struct of_device_id *match_id;
>>+	void __iomem *addr;
>>+	const u32 *seq_data;
>>+	int cpu = -EINVAL;
>>+	static bool cpuidle_drv_init;
>>+
>>+	drv = spm_get_drv(pdev, &cpu);
>>+	if (!drv)
>>+		return -EINVAL;
>>+
>>+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>+	drv->reg_base = devm_ioremap_resource(&pdev->dev, res);
>>+	if (IS_ERR(drv->reg_base))
>>+		return PTR_ERR(drv->reg_base);
>>+
>>+	match_id = of_match_node(spm_match_table, pdev->dev.of_node);
>>+	if (!match_id)
>>+		return -ENODEV;
>>+
>>+	drv->reg_data = match_id->data;
>>+	if (!drv->reg_data)
>>+		return -EINVAL;
>>+
>>+	/* Write the SPM sequences, first.. */
>>+	addr = drv->reg_base + drv->reg_data->reg_offset[SPM_REG_SEQ_ENTRY];
>>+	seq_data = (const u32 *)drv->reg_data->seq;
>>+	__iowrite32_copy(addr, seq_data, ARRAY_SIZE(drv->reg_data->seq)/4);
>>+
>>+	/* ..and then, the control registers.
>>+	 * On some SoC's if the control registers are written first and if the
>>+	 * CPU was held in reset, the reset signal could trigger the SPM state
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
>>+	/**
>>+	 * Ensure all observers see the above register writes before the
>>+	 * cpuidle driver is allowed to use the SPM.
>>+	 */
>>+	wmb();
>>+	drv->available = true;
>
>IMO if you have to do that, that means there is something wrong with 
>how is initialized the driver.
>
>It should be drv == NULL => not available
>
drv has the register base that I dont want to pass seprately.

>>+
>>+	if ((cpu > -1) && !cpuidle_drv_init) {
>>+		platform_device_register(&qcom_cpuidle_device);
>>+		cpuidle_drv_init = true;
>>+	}
>
>'cpu' is always > -1.
>
OK. I was hoping to use -1 for not a cpu (i.e, L2) SPM. For now, I will
change.


>If the 'spm_get_drv' succeed, cpu is no longer equal to -EINVAL. 
>Otherwise we do not reach this point because we return right after 
>spm_get_drv with an error.
>
>Adding the platform_device_register depending in a static variable is 
>not very nice. Why not add it explicitely in a separate init routine 
>we know it will be called one time (eg. at the same place than cpufreq 
>is) ?
>
We want to register the cpuidle device only if any of the SPM devices
have been probed.

Ideally, Stephen and I would like to register cpuidle device separately
for each CPU SPM, when it is probed, so we would invoke cpuidle driver
and thereby the low power modes only for those cpus. However, the
complexity to do that, AFAICS, is very complex. I would need to change
quite a bit of the framework and in the cpuidle driver, I may have to
stray from the recommended format.

Here I set up cpuidle device, when I know atleast 1 cpu is ready to
allow low power modes.

Do you have any better ideas?

Thanks,
Lina
