From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] cpufreq:exynos-cpufreq - Fix for memory leak in case SOC
 name does not match.
Date: Tue, 09 Jun 2015 16:23:25 +0900
Message-ID: <5576946D.2070909@samsung.com>
References: <1432519780-2910-1-git-send-email-shailendra.capricorn@gmail.com>
 <20150525073149.GF9992@linux> <20150608103100.57f0473b@amdc2363>
 <8344426.BL3KyufMos@vostro.rjw.lan> <20150609090722.43965fa0@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20150609090722.43965fa0@amdc2363>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Shailendra Verma <shailendra.capricorn@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 09.06.2015 16:07, Lukasz Majewski wrote:
> Hi Rafael,
> 
>> On Monday, June 08, 2015 10:31:00 AM Lukasz Majewski wrote:
>>> Hi Viresh,
>>>
>>>> On 25-05-15, 07:39, Shailendra Verma wrote:
>>>>> During probe free the memory allocated to "exynos_info" in case
>>>>> of unknown SOC type.
>>>>>
>>>>> Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
>>>>> ---
>>>>>  drivers/cpufreq/exynos-cpufreq.c |    6 ++++--
>>>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/cpufreq/exynos-cpufreq.c
>>>>> b/drivers/cpufreq/exynos-cpufreq.c index 82d2fbb..8682378 100644
>>>>> --- a/drivers/cpufreq/exynos-cpufreq.c
>>>>> +++ b/drivers/cpufreq/exynos-cpufreq.c
>>>>> @@ -182,7 +182,7 @@ static int exynos_cpufreq_probe(struct
>>>>> platform_device *pdev) ret =
>>>>> exynos5250_cpufreq_init(exynos_info); } else {
>>>>>  		pr_err("%s: Unknown SoC type\n", __func__);
>>>>> -		return -ENODEV;
>>>>> +		ret = -ENODEV;
>>>>>  	}
>>>>>  
>>>>>  	if (ret)
>>>>> @@ -190,12 +190,14 @@ static int exynos_cpufreq_probe(struct
>>>>> platform_device *pdev) 
>>>>>  	if (exynos_info->set_freq == NULL) {
>>>>>  		dev_err(&pdev->dev, "No set_freq function
>>>>> (ERR)\n");
>>>>> +		ret = -EINVAL;
>>>>>  		goto err_vdd_arm;
>>>>>  	}
>>>>>  
>>>>>  	arm_regulator = regulator_get(NULL, "vdd_arm");
>>>>>  	if (IS_ERR(arm_regulator)) {
>>>>>  		dev_err(&pdev->dev, "failed to get resource
>>>>> vdd_arm\n");
>>>>> +		ret = -EINVAL;
>>>>>  		goto err_vdd_arm;
>>>>>  	}
>>>>>  
>>>>> @@ -227,7 +229,7 @@ err_cpufreq_reg:
>>>>>  	regulator_put(arm_regulator);
>>>>>  err_vdd_arm:
>>>>>  	kfree(exynos_info);
>>>>> -	return -EINVAL;
>>>>> +	return ret;
>>>>>  }
>>>>>  
>>>>>  static struct platform_driver exynos_cpufreq_platdrv = {
>>>>
>>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>>
>>>
>>> Acked-by: Lukasz Majewski <l.majewski@samsung.com>
>>
>> I'm assuming that it will go it through the Samsung tree.
>>
>>
> 
> That would be the easiest way to proceed. 
> 
> Krzystof would you like to grab this patch?

Sure, I'll take it.

Best regards,
Krzysztof
