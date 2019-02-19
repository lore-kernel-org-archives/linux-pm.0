From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH v7 1/3] thermal: tegra: remove unnecessary warnings
Date: Tue, 19 Feb 2019 10:14:15 +0800
Message-ID: <b47037a2-86de-eacd-e9f7-760744783835@nvidia.com>
References: <1546510369-28491-1-git-send-email-wni@nvidia.com>
 <1546510369-28491-2-git-send-email-wni@nvidia.com>
 <ec484530-0a07-b725-a376-43c65ca4a723@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ec484530-0a07-b725-a376-43c65ca4a723@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, edubezval@gmail.com
Cc: thierry.reding@gmail.com, linux-tegra@vger.kernel.org, rui.zhang@intel.com, srikars@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 18/2/2019 5:47 PM, Daniel Lezcano wrote:
> On 03/01/2019 11:12, Wei Ni wrote:
>> Convert warnings to info as not all platforms may
>> have all the thresholds and sensors enabled.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
> 
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Daniel, thank you for your review.
> 
>>  drivers/thermal/tegra/soctherm.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
>> index ed28110a3535..f07de8258e93 100644
>> --- a/drivers/thermal/tegra/soctherm.c
>> +++ b/drivers/thermal/tegra/soctherm.c
>> @@ -569,7 +569,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
>>  set_throttle:
>>  	ret = get_hot_temp(tz, &trip, &temperature);
>>  	if (ret) {
>> -		dev_warn(dev, "throttrip: %s: missing hot temperature\n",
>> +		dev_info(dev, "throttrip: %s: missing hot temperature\n",
>>  			 sg->name);
>>  		return 0;
>>  	}
>> @@ -600,7 +600,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
>>  	}
>>  
>>  	if (i == THROTTLE_SIZE)
>> -		dev_warn(dev, "throttrip: %s: missing throttle cdev\n",
>> +		dev_info(dev, "throttrip: %s: missing throttle cdev\n",
>>  			 sg->name);
>>  
>>  	return 0;
>>
> 
> 
