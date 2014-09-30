From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v7 1/7] qcom: spm: Add Subsystem Power Manager driver
Date: Tue, 30 Sep 2014 10:27:48 -0600
Message-ID: <20140930162748.GD528@ilina-mac.local>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
 <1411779495-39724-2-git-send-email-lina.iyer@linaro.org>
 <5429E91A.8070901@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5429E91A.8070901@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 29 2014 at 17:19 -0600, Stephen Boyd wrote:
>On 09/26/14 17:58, Lina Iyer wrote:

>  	Definition: shall contain "qcom,saw2". A more specific value should be
>>  		    one of:
>> -			 "qcom,saw2-v1"
>> -			 "qcom,saw2-v1.1"
>> -			 "qcom,saw2-v2"
>> -			 "qcom,saw2-v2.1"
>> +			 "qcom,apq8064-saw2-v1.1-cpu"
>> +			 "qcom,msm8974-saw2-v2.1-cpu"
>> +			 "qcom,apq8084-saw2-v2.1-cpu"
>
>It's probably not good to remove the old compatibles. Just add more to
>the list. Please Cc dt reviewers on dt bindings.
>
You are right, I should not have removed them.
>>
>>  - reg:
>>  	Usage: required
>> @@ -26,10 +25,9 @@ PROPERTIES
>>  		    the register region. An optional second element specifies
>>  		    the base address and size of the alias register region.
>>
>> -
>>  Example:
>>
>> -	regulator@2099000 {
>> +	saw@2099000 {
>
>saw is not a standard thing. Hence the usage of regulator here. I agree
>when it doesn't directly control a regulator then it should be called
>something else, power-controller perhaps? I don't really see a need to
>change this example though.
>
I am okay with the name power controller.

>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> +config QCOM_PM
>> +	bool "Qualcomm Power Management"
>> +	depends on PM && ARCH_QCOM
>
>Drop the PM dependency. There isn't any right? Honestly we don't want
>this type of option at all. We want an option for each driver introduced.
>
OK.

We want? Why? Thats just many config items that we have to configure to
build the kernel. If you know of a reason, please let me know.

[...]
> +
>> +/* SPM register data for 8974, 8084 */
>> +static const struct spm_reg_data spm_reg_8974_8084_cpu  = {
>> +	.reg[SPM_REG_CFG]		= {0x08, 0x1},
>> +	.reg[SPM_REG_SPM_STS]		= {0x0C, 0x0},
>> +	.reg[SPM_REG_PMIC_STS]		= {0x14, 0x0},
>> +	.reg[SPM_REG_VCTL]		= {0x1C, 0x0},
>> +	.reg[SPM_REG_SPM_CTL]		= {0x30, 0x1},
>> +	.reg[SPM_REG_DLY]		= {0x34, 0x3C102800},
>> +	.reg[SPM_REG_PMIC_DATA_0]	= {0x40, 0x0},
>> +	.reg[SPM_REG_PMIC_DATA_1]	= {0x44, 0x0},
>> +	.reg[SPM_REG_PMIC_DATA_2]	= {0x48, 0x0},
>> +	.reg[SPM_REG_SEQ_ENTRY_0]	= {0x80, 0x000F0B03},
>> +	.reg[SPM_REG_SEQ_ENTRY_1]	= {0x84, 0xE8108020},
>> +	.reg[SPM_REG_SEQ_ENTRY_2]	= {0x88, 0xE83B035B},
>> +	.reg[SPM_REG_SEQ_ENTRY_3]	= {0x8C, 0x300B1082},
>> +	.reg[SPM_REG_SEQ_ENTRY_4]	= {0x90, 0x0F302606},
>
>Is this endian agnostic? 
I dont think I considered that.

>We don't need this initial value table. The
>only thing that really is different is delay and seq entries. 
I need the PMIC_DATA for supporting 8064. And the voltage control and
the status registers for verifying the changes. I looked at the common
functionality with SoC that I plan to support and used them here.

>The seq
>entries can be a byte array that gets written to the device in an endian
>agnostic fashion and the delay can be a different struct member.
Endianness is something I may need to think about. So for that purpose,
I may need to fashion this into sequences. I just removed a bunch of
code that did that. Made the driver a lot easy on the eyes.

>The
>register map can be per version of the spm (i.e. not per-soc) and that
>can be pointed to by the SoC data.
>
I thought about it, its just unnecessary bunch of data structures. This
is clearly a name, value pair and is much more readable.


>I really don't like setting the SPM_CTL register's enable bit to 1 with
>this table either. That should be done explicitly because it isn't
>"configuration" like the delays or the sequences are. It's a bit that
>will have some effect. It probably even needs to be cleared if we're
>reprogramming the SPM sequence in a scenario like kexec where the bit
>may already be set.
>
Fair enough.

>> +	.reg[SPM_REG_SEQ_ENTRY_5]	= {0x94, 0x0},
>> +	.reg[SPM_REG_SEQ_ENTRY_6]	= {0x98, 0x0},
>> +	.reg[SPM_REG_SEQ_ENTRY_7]	= {0x9C, 0x0},
>> +
>> +	.start_addr[SPM_MODE_CLOCK_GATING]	= 0,
>> +	.start_addr[SPM_MODE_POWER_COLLAPSE]	= 3,
>> +};
>> +
>> +static DEFINE_PER_CPU_SHARED_ALIGNED(struct spm_driver_data, cpu_spm_drv);
>> +
>> +/**
>> + * spm_set_low_power_mode() - Configure SPM start address for low power mode
>> + * @mode: SPM LPM mode to enter
>> + */
>> +int qcom_spm_set_low_power_mode(enum spm_mode mode)
>> +{
>> +	struct spm_driver_data *drv = &__get_cpu_var(cpu_spm_drv);
>> +	u32 start_addr = 0;
>
>Unnecessary assignment.
>
Done.
>> +	u32 ctl_val;
>> +
>> +	if (!drv || !drv->reg_data)
>> +		return -ENXIO;
>
>Does this ever happen? Please remove.
>
Possible, if the idle driver makes a call, before the SPM is ready.
>> +
>> +	start_addr = drv->reg_data->start_addr[mode];
>> +
>> +	/* Update bits 10:4 in the SPM CTL register */
>
>This comment provides nothing that isn't evident from the code. Remove.
>
okay

> +	for_each_possible_cpu(cpu) {
>> +		cpu_node = of_get_cpu_node(cpu, NULL);
>> +		if (!cpu_node)
>> +			continue;
>> +		saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);
>> +		if (!saw_node)
>> +			continue;
>> +		if (saw_node == pdev->dev.of_node) {
>> +			drv = &per_cpu(cpu_spm_drv, cpu);
>> +			break;
>> +		}
>
>Missing a couple of_node_put()s.
>
Argh. I saw them after I sent the patches. Thanks for pointing it out.

> +
>> +static struct platform_driver spm_driver = {
>> +	.probe = spm_dev_probe,
>> +	.driver = {
>> +		.name = "spm",
>
>qcom-spm?
>
ok

>> +static int __init spm_driver_init(void)
>> +{
>> +	return platform_driver_register(&spm_driver);
>> +}
>> +device_initcall(spm_driver_init);
>
>Why can't we support modules?
>
It just happens later than we would like.

>> diff --git a/include/soc/qcom/spm.h b/include/soc/qcom/spm.h
>> new file mode 100644
>> index 0000000..997abfc
>> --- /dev/null
>> +++ b/include/soc/qcom/spm.h

> +#endif  /* __QCOM_SPM_H */
>
>It would be nice to not have this file.
>
Why?

Thanks for your time Stephen.

Lina
