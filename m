From: Raju P L S S S N <rplsssn@codeaurora.org>
Subject: Re: [PATCH RFC v1 4/8] drivers: qcom: cpu_pd: add cpu power domain
 support using genpd
Date: Fri, 12 Oct 2018 23:31:44 +0530
Message-ID: <e56b6fd6-dc48-9eb0-83b2-4621b2e14f44@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-5-git-send-email-rplsssn@codeaurora.org>
 <20181012143350.GG3401@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012143350.GG3401@e107155-lin>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org
List-Id: linux-pm@vger.kernel.org



On 10/12/2018 8:03 PM, Sudeep Holla wrote:
> On Thu, Oct 11, 2018 at 02:50:51AM +0530, Raju P.L.S.S.S.N wrote:
>> RPMH based targets require that the sleep and wake state request votes
>> be sent during system low power mode entry. The votes help reduce the
>> power consumption when the AP is not using them. The votes sent by the
>> clients are cached in RPMH controller and needs to be flushed when the
>> last cpu enters low power mode. So add cpu power domain using Linux
>> generic power domain infrastructure to perform necessary tasks as part
>> of domain power down.
>>
>> Suggested-by: Lina Iyer <ilina@codeaurora.org>
>> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
>> ---
>>   drivers/soc/qcom/Kconfig  |   9 ++++
>>   drivers/soc/qcom/Makefile |   1 +
>>   drivers/soc/qcom/cpu_pd.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 114 insertions(+)
>>   create mode 100644 drivers/soc/qcom/cpu_pd.c
>>
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index ba79b60..91e8b3b 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -95,6 +95,7 @@ config QCOM_RMTFS_MEM
>>   config QCOM_RPMH
>>   	bool "Qualcomm RPM-Hardened (RPMH) Communication"
>>   	depends on ARCH_QCOM && ARM64 && OF || COMPILE_TEST
>> +	select QCOM_CPU_PD
>>   	help
>>   	  Support for communication with the hardened-RPM blocks in
>>   	  Qualcomm Technologies Inc (QTI) SoCs. RPMH communication uses an
>> @@ -102,6 +103,14 @@ config QCOM_RPMH
>>   	  of hardware components aggregate requests for these resources and
>>   	  help apply the aggregated state on the resource.
>>
>> +config QCOM_CPU_PD
>> +    bool "Qualcomm cpu power domain driver"
>> +    depends on QCOM_RPMH && PM_GENERIC_DOMAINS || COMPILE_TEST
>> +    help
>> +	  Support for QCOM platform cpu power management to perform tasks
>> +	  necessary while application processor votes for deeper modes so that
>> +	  the firmware can enter SoC level low power modes to save power.
>> +
>>   config QCOM_SMEM
>>   	tristate "Qualcomm Shared Memory Manager (SMEM)"
>>   	depends on ARCH_QCOM
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index f25b54c..57a1b0e 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -12,6 +12,7 @@ obj-$(CONFIG_QCOM_RMTFS_MEM)	+= rmtfs_mem.o
>>   obj-$(CONFIG_QCOM_RPMH)		+= qcom_rpmh.o
>>   qcom_rpmh-y			+= rpmh-rsc.o
>>   qcom_rpmh-y			+= rpmh.o
>> +obj-$(CONFIG_QCOM_CPU_PD) += cpu_pd.o
>>   obj-$(CONFIG_QCOM_SMD_RPM)	+= smd-rpm.o
>>   obj-$(CONFIG_QCOM_SMEM) +=	smem.o
>>   obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
>> diff --git a/drivers/soc/qcom/cpu_pd.c b/drivers/soc/qcom/cpu_pd.c
>> new file mode 100644
>> index 0000000..565c510
>> --- /dev/null
>> +++ b/drivers/soc/qcom/cpu_pd.c
>> @@ -0,0 +1,104 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/of_platform.h>
>> +#include <linux/pm_domain.h>
>> +#include <linux/slab.h>
>> +
>> +#include <soc/qcom/rpmh.h>
>> +
>> +static struct device *cpu_pd_dev;
>> +
> 
> This doesn't scale if you have 2 instances.

There would be one instance of this driver for this platform.
This platform has single cluster & single power domain which includes 
all the cpus. Even if there are more than one cluster (lets say, later 
on) the top level grouping of all the clusters will be considered as a 
domain. In this case, if hierarchical topological representation is 
needed, the driver probe needs to be modified. The naming might have led 
to the confusion. Should I change it to something like top_level_pd_dev 
? Another way is to define the compatible flag as SoC specific like 
"qcom,cpu-pm-domain-sdm845" but then there will be multiple SoCs based 
on single cluster. For each of them, compatible flag needs to be added.




> 
>> +static int cpu_pd_power_off(struct generic_pm_domain *domain)
>> +{
>> +	if (rpmh_ctrlr_idle(cpu_pd_dev)) {
> 
> How is this expected to compile ? I couldn't find any instance of this.
> 
>> +		/* Flush the sleep/wake sets */
>> +		rpmh_flush(cpu_pd_dev);
> 
> So it's just flushing the pending requests on the controller. The function
> implementation carries a note that it's assumed to be called only from
> system PM and we may call it in cpu idle path here. Is that fine ?
> If so, may be the comment needs to be dropped.

Sure. we will change the comment.
When RPMh driver was being developed, it named the top level power 
domain which includes all the cpus as system PM.


> 
> Also, where exactly this voting for CPU is happening in this path ?
> 

This SoC uses PC mode and we are not voting for CPU's idle state here.. 
We are just doing power domain activities that are needed when all the 
cpus are down.



>> +	} else {
>> +		pr_debug("rpmh controller is busy\n");
>> +		return -EBUSY;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int cpu_pm_domain_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = dev->of_node;
>> +	struct generic_pm_domain *cpu_pd;
>> +	int ret = -EINVAL, cpu;
>> +
>> +	if (!np) {
>> +		dev_err(dev, "device tree node not found\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (!of_find_property(np, "#power-domain-cells", NULL)) {
>> +		pr_err("power-domain-cells not found\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	cpu_pd_dev = &pdev->dev;
>> +	if (IS_ERR_OR_NULL(cpu_pd_dev))
> 
> Isn't this too late to check ? You would have crashed on dev->of_node.
> So sounds pretty useless

Agree. I will change this.


> 
>> +		return PTR_ERR(cpu_pd_dev);
>> +
>> +	cpu_pd = devm_kzalloc(dev, sizeof(*cpu_pd), GFP_KERNEL);
>> +	if (!cpu_pd)
>> +		return -ENOMEM;
>> +
>> +	cpu_pd->name = kasprintf(GFP_KERNEL, "%s", np->name);
>> +	if (!cpu_pd->name)
>> +		goto free_cpu_pd;
>> +	cpu_pd->name = kbasename(cpu_pd->name);
>> +	cpu_pd->power_off = cpu_pd_power_off;
> 
> If some kind of voting is done in off, why is there nothing to take care
> of that in pd_power_on  if it's per EL(linux/hyp/secure).
Both sleep state votes (which would be applied while powering down)and 
wake state votes (which would be applied while powering on) are applied 
in hardware. Software is expected to write both these types of votes to 
RPM while powering down only. As hardware takes care of applying the 
votes, no need for any pd_power_on operations.


Thanks a lot for your time & review Sudeep. Happy weekend.

- Raju.



> 
> --
> Regards,
> Sudeep
> 
