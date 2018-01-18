From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH] cpufreq: AMD: Ignore the check for ProcFeedback in ST/CZ
Date: Thu, 18 Jan 2018 15:34:44 +0530
Message-ID: <ab16f642-32ce-662d-c086-b185ec60f038@amd.com>
References: <1516265488-31452-1-git-send-email-akshu.agrawal@amd.com>
 <20180118091103.GF3012@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bl2nam02on0041.outbound.protection.outlook.com ([104.47.38.41]:55342
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754932AbeARKFY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Jan 2018 05:05:24 -0500
In-Reply-To: <20180118091103.GF3012@vireshk-i7>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, satyajit.sahu@amd.com



On 1/18/2018 2:41 PM, Viresh Kumar wrote:
> On 18-01-18, 14:21, Akshu Agrawal wrote:
>> In ST/CZ CPUID 8000_0007_EDX[11, ProcFeedbackInterface] is 0,
>> but the mechanism is still available and can be used.
>>
>> Change-Id: I5751d92c628da9ad4e15ec34079090c4315d4f2a
> 
> ??

unique-id to keep track of changes. Came in because I made the patch on 
a different git.
Removing it and sending a v2.

> 
>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>> ---
>>   drivers/cpufreq/amd_freq_sensitivity.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
>> index 042023bbbf62..be926d9a66e5 100644
>> --- a/drivers/cpufreq/amd_freq_sensitivity.c
>> +++ b/drivers/cpufreq/amd_freq_sensitivity.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/types.h>
>> +#include <linux/pci.h>
>>   #include <linux/percpu-defs.h>
>>   #include <linux/init.h>
>>   #include <linux/mod_devicetable.h>
>> @@ -109,12 +110,18 @@ static unsigned int amd_powersave_bias_target(struct cpufreq_policy *policy,
>>   static int __init amd_freq_sensitivity_init(void)
>>   {
>>   	u64 val;
>> +	struct pci_dev *pcidev;
>>   
>>   	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>>   		return -ENODEV;
>>   
>> -	if (!static_cpu_has(X86_FEATURE_PROC_FEEDBACK))
>> -		return -ENODEV;
>> +	pcidev = pci_get_device(PCI_VENDOR_ID_AMD,
>> +			PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, NULL);
>> +
>> +	if (!pcidev) {
>> +		if (!static_cpu_has(X86_FEATURE_PROC_FEEDBACK))
>> +			return -ENODEV;
>> +	}
>>   
>>   	if (rdmsrl_safe(MSR_AMD64_FREQ_SENSITIVITY_ACTUAL, &val))
>>   		return -ENODEV;
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
