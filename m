From: Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v12 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Date: Fri, 14 Dec 2018 09:40:20 +0530
Message-ID: <a220e6d4-04e7-c911-06fa-202f46ecf4b0@codeaurora.org>
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org>
 <1544687394-331-3-git-send-email-tdas@codeaurora.org>
 <154469510700.19322.7762676027024031719@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154469510700.19322.7762676027024031719@swboyd.mtv.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

Hello Stephen, Viresh,

On 12/13/2018 3:28 PM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-12-12 23:49:54)
>> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
>> for changing the frequency of CPUs. The driver implements the cpufreq
>> driver interface for this hardware engine.
>>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> 
> But I noticed that we don't release the I/O region anymore so hotplug
> and replug of a whole clk domain fails. I guess devm_ioremap_resource()
> was just too much magic so how about we downgrade to devm_ioremap()
> instead?
> 
> BTW, Viresh, I see a lockdep splat when cpufreq_init returns an error
> upon bringing the policy online the second time. I guess cpufreq_stats
> aren't able to be freed from there because they take locks in different
> order vs. the normal path?
> 
> -----8<-------
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index fce7a1162e87..0e1105151478 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -182,9 +182,12 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>   	index = args.args[0];
>   
>   	res = platform_get_resource(global_pdev, IORESOURCE_MEM, index);
> -	base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(base))
> -		return PTR_ERR(base);
> +	if (!res)
> +		return -ENODEV;
> +
> +	base = devm_ioremap(dev, res->start, resource_size(res));
> +	if (!base)
> +		return -ENOMEM;
>   

Updated the above in the next series.

>   	/* HW should be in enabled state to proceed */
>   	if (!(readl_relaxed(base + REG_ENABLE) & 0x1)) {
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
