From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v9 6/9] qcom: cpuidle: Add cpuidle driver for QCOM cpus
Date: Mon, 17 Nov 2014 15:15:42 -0700
Message-ID: <20141117221542.GH45276@linaro.org>
References: <1414194024-55547-1-git-send-email-lina.iyer@linaro.org>
 <1414194024-55547-7-git-send-email-lina.iyer@linaro.org>
 <20141117173950.GA24304@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141117173950.GA24304@e102568-lin.cambridge.arm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "khilman@linaro.org" <khilman@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "msivasub@codeaurora.org" <msivasub@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 17 2014 at 10:39 -0700, Lorenzo Pieralisi wrote:
>On Sat, Oct 25, 2014 at 12:40:21AM +0100, Lina Iyer wrote:
>> Add cpuidle driver interface to allow cpus to go into C-States. Use the
>> cpuidle DT interface, common across ARM architectures, to provide the
>> C-State information to the cpuidle framework.
>
>"idle states", this is not ACPI.
>
Okay.
>> Supported modes at this time are Standby and Standalone Power Collapse.
>>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
[...]

> +static struct qcom_cpu_pm_ops *lpm_ops;
>> +
>> +static int qcom_cpu_stby(struct cpuidle_device *dev,
>> +				struct cpuidle_driver *drv, int index)
>> +{
>> +	lpm_ops->standby(NULL);
>> +
>> +	return index;
>> +}
>> +
>> +static int qcom_cpu_spc(struct cpuidle_device *dev,
>> +				struct cpuidle_driver *drv, int index)
>> +{
>> +	lpm_ops->spc(NULL);
>> +
>> +	return index;
>> +}
>> +
>
>I can't have a look at this and avoid thinking that this should look
>something like:
>
>static qcom_cpu_idle(...., int index)
>{
>	lpm_ops[index].enter_idle(...);
>	return index;
>}
>
>Before jumping to conclusions, see below.
>
>> +static struct cpuidle_driver qcom_cpuidle_driver = {
>> +	.name	= "qcom_cpuidle",
>> +};
>> +
>> +static const struct of_device_id qcom_idle_state_match[] = {
>> +	{ .compatible = "qcom,idle-state-stby", .data = qcom_cpu_stby},
>> +	{ .compatible = "qcom,idle-state-spc", .data = qcom_cpu_spc },
>> +	{ },
>> +};
>> +
>> +static int qcom_cpuidle_probe(struct platform_device *pdev)
>> +{
>> +	struct cpuidle_driver *drv = &qcom_cpuidle_driver;
>> +	int ret;
>> +
>> +	lpm_ops = pdev->dev.platform_data;
>> +
>> +	/* Probe for other states, including standby */
>> +	ret = dt_init_idle_driver(drv, qcom_idle_state_match, 0);
>
>This driver will be DT only. If an idle state is parsed correctly,
>it is initialized, otherwise it is skipped. Now, if we added glue
>code in arch arm (as arm64 does) that allows us to link an idle state
>index with the functions above (a DT idle state contains all information
>required to initialize its enter function, more so now that we are adding
>power domains to the picture), what would be the issue in defining a
>common API that just passes the index to the arch back-end ? No pointers
>to pass, no platform drivers required and still no arch/soc code in
>drivers/cpuidle.
>
>I am obviously talking about DT CPUidle drivers only.
>
>If the idle state is parsed correctly and the backend initializer (let's
>call it arm_cpu_init_idle(cpu)) is successful (which means that DT idle
>states contain valid information and the enter functions could be
>initialized from DT properly) I do not see what's the problem, give it
>some thought.
>

>Anyway, I will put together an RFC to start the discussion when patch is
>merged and patch the relevant code as an example, you can go ahead with
>current code, I am reviewing it.
>
OK. I understand your idea. Like it.

>Lorenzo
>
