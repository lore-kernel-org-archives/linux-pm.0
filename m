From: Raju P L S S S N <rplsssn@codeaurora.org>
Subject: Re: [PATCH RFC v1 7/8] drivers: qcom: cpu_pd: Handle cpu hotplug in
 the domain
Date: Fri, 12 Oct 2018 23:40:05 +0530
Message-ID: <f3452af3-a180-8700-43c7-b20dbaa2549e@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-8-git-send-email-rplsssn@codeaurora.org>
 <20181012142503.GF3401@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012142503.GF3401@e107155-lin>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org
List-Id: linux-pm@vger.kernel.org



On 10/12/2018 7:55 PM, Sudeep Holla wrote:
> On Thu, Oct 11, 2018 at 02:50:54AM +0530, Raju P.L.S.S.S.N wrote:
>> Use cpu hotplug callback mechanism to attach/dettach the cpu in
>> the cpu power domain. During cpu hotplug callback registration,
>> the starting callback is invoked on all online cpus. So there is
>> no need to attach from device probe.
>>
>> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
>> ---
>>   drivers/soc/qcom/cpu_pd.c  | 33 +++++++++++++++++++++++++--------
>>   include/linux/cpuhotplug.h |  1 +
>>   2 files changed, 26 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/cpu_pd.c b/drivers/soc/qcom/cpu_pd.c
>> index 242eced..bf2d95d 100644
>> --- a/drivers/soc/qcom/cpu_pd.c
>> +++ b/drivers/soc/qcom/cpu_pd.c
>> @@ -3,6 +3,7 @@
>>    * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>>    */
>>   
>> +#include <linux/cpuhotplug.h>
>>   #include <linux/ktime.h>
>>   #include <linux/of_platform.h>
>>   #include <linux/pm_domain.h>
>> @@ -85,12 +86,26 @@ static int cpu_pd_power_off(struct generic_pm_domain *domain)
>>   	return 0;
>>   }
>>   
>> +static int cpu_pd_starting(unsigned int cpu)
>> +{
>> +	if (!suspend && of_genpd_attach_cpu(cpu))
>> +		pr_err("%s: genpd_attach_cpu fail\n", __func__);
> 
> If it's that serious, return proper error code and drop the message which
> could be annoying if you are running some hotplug test loop.

Sure will do that.

Thanks Sudeep.

- Raju

> 
> --
> Regards,
> Sudeep
> 
