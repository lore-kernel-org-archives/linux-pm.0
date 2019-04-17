From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 17/19] PM / devfreq: tegra: Support Tegra30
Date: Wed, 17 Apr 2019 09:28:37 +0900
Message-ID: <4e896313-8fd9-1c1e-10f6-eac80aa01580@samsung.com>
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145707epcas3p27b7b927b14ef3c54274626c9df7cc14f@epcas3p2.samsung.com>
        <20190415145505.18397-18-digetx@gmail.com>
        <203f3cbf-d825-0597-b64a-dc876743ae86@samsung.com>
        <53d0ead1-3a82-01d3-3b8a-094c1e6e34e0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53d0ead1-3a82-01d3-3b8a-094c1e6e34e0@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 19. 4. 17. 오전 12:49, Dmitry Osipenko wrote:
> 16.04.2019 10:48, Chanwoo Choi пишет:
>> Hi,
>>
>> On 19. 4. 15. 오후 11:55, Dmitry Osipenko wrote:
>>> The devfreq driver can be used on Tegra30 without any code change and
>>> it works perfectly fine, the default Tegra124 parameters are good enough
>>> for Tegra30.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/devfreq/Kconfig         | 4 ++--
>>>  drivers/devfreq/tegra-devfreq.c | 1 +
>>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>>> index a78dffe603c1..78c33ddd4eea 100644
>>> --- a/drivers/devfreq/Kconfig
>>> +++ b/drivers/devfreq/Kconfig
>>> @@ -92,8 +92,8 @@ config ARM_EXYNOS_BUS_DEVFREQ
>>>  	  This does not yet operate with optimal voltages.
>>>  
>>>  config ARM_TEGRA_DEVFREQ
>>> -	tristate "Tegra DEVFREQ Driver"
>>> -	depends on ARCH_TEGRA_124_SOC
>>> +	tristate "NVIDIA Tegra30+ DEVFREQ Driver"
>>
>> Looks good to me. But, I have a question.
>>
>> 'Tegra30+' expression is enough in order to indicate
>> the support for both tegra30 and tegra124?
>>
>> In my case, it is difficult to catch the meaning
>> of which tegra30+ support the kind of tegra124.
> 
> The ACTMON serves Tegra30, Tegra124 and Tegra210 SoC's. The later Tegra generations also have the ACTMON hardware unit, but most of actual drivers have been moved into firmware on the later gens, including the ACTMON driver. I'll change the wording to "Tegra30/124/210" for clarity. Note that Tegra210 support isn't implemented at the moment by the driver, but that may change in the future.

OK. Thanks.

> 
>>> +	depends on ARCH_TEGRA
>>>  	select PM_OPP
>>>  	help
>>>  	  This adds the DEVFREQ driver for the Tegra family of SoCs.
>>> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
>>> index f0711d5ad27d..0a2465a58cf5 100644
>>> --- a/drivers/devfreq/tegra-devfreq.c
>>> +++ b/drivers/devfreq/tegra-devfreq.c
>>> @@ -719,6 +719,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
>>>  }
>>>  
>>>  static const struct of_device_id tegra_devfreq_of_match[] = {
>>> +	{ .compatible = "nvidia,tegra30-actmon" },
>>>  	{ .compatible = "nvidia,tegra124-actmon" },
>>>  	{ },
>>>  };
>>>
>>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
> 
> Thanks.
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
