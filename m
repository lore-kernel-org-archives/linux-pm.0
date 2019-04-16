From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2 18/19] PM / devfreq: tegra: Enable COMPILE_TEST for the
 driver
Date: Tue, 16 Apr 2019 18:52:58 +0300
Message-ID: <77653f79-45ef-1557-c940-0140bcb69311@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
 <CGME20190415145614epcas4p494a515b20cd351e220ac4eb37c05b7fb@epcas4p4.samsung.com>
 <20190415145505.18397-19-digetx@gmail.com>
 <8d8c55b8-b4aa-e072-7c5f-0b1e5e883031@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8d8c55b8-b4aa-e072-7c5f-0b1e5e883031@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

16.04.2019 10:43, Chanwoo Choi пишет:
> On 19. 4. 15. 오후 11:55, Dmitry Osipenko wrote:
>> The driver's compilation doesn't have any specific dependencies, hence
>> the COMPILE_TEST option can be supported in Kconfig.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>> index 78c33ddd4eea..bd6652863e7d 100644
>> --- a/drivers/devfreq/Kconfig
>> +++ b/drivers/devfreq/Kconfig
>> @@ -93,7 +93,7 @@ config ARM_EXYNOS_BUS_DEVFREQ
>>  
>>  config ARM_TEGRA_DEVFREQ
>>  	tristate "NVIDIA Tegra30+ DEVFREQ Driver"
>> -	depends on ARCH_TEGRA
>> +	depends on ARCH_TEGRA || COMPILE_TEST
>>  	select PM_OPP
>>  	help
>>  	  This adds the DEVFREQ driver for the Tegra family of SoCs.
>>
> 
> I think that it doesn't need to make it a separate patch.
> You can merge this patch to patch17 and then drop this patch.
> 

I'd prefer to have this change as a separate patch because this is a logically distinct change from the patch 17.
