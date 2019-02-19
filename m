From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH v7 3/3] thermal: tegra: add get_trend ops
Date: Tue, 19 Feb 2019 10:15:05 +0800
Message-ID: <ecabe3d8-274f-7c0e-f875-6968c65a4425@nvidia.com>
References: <1546510369-28491-1-git-send-email-wni@nvidia.com>
 <1546510369-28491-4-git-send-email-wni@nvidia.com>
 <bae5b0c3-3d7f-0b60-da96-730c7e8c4e5c@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bae5b0c3-3d7f-0b60-da96-730c7e8c4e5c@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, edubezval@gmail.com
Cc: thierry.reding@gmail.com, linux-tegra@vger.kernel.org, rui.zhang@intel.com, srikars@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 18/2/2019 6:27 PM, Daniel Lezcano wrote:
> On 03/01/2019 11:12, Wei Ni wrote:
>> Add support for get_trend ops that allows soctherm
>> sensors to be used with the step-wise governor.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  drivers/thermal/tegra/soctherm.c | 34 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>
>> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
>> index fd2703c0cfc5..864205af104b 100644
>> --- a/drivers/thermal/tegra/soctherm.c
>> +++ b/drivers/thermal/tegra/soctherm.c
>> @@ -488,9 +488,43 @@ static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
>>  	return 0;
>>  }
>>  
>> +static int tegra_thermctl_get_trend(void *data, int trip,
>> +				    enum thermal_trend *trend)
>> +{
>> +	struct tegra_thermctl_zone *zone = data;
>> +	struct thermal_zone_device *tz = zone->tz;
>> +	int trip_temp, temp, last_temp, ret;
>> +
>> +	if (!tz)
>> +		return -EINVAL;
>> +
>> +	ret = tz->ops->get_trip_temp(zone->tz, trip, &trip_temp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mutex_lock(&tz->lock);
> 
> No need to use the mutex here.
> 
> Why not ?
> 
> temp = READ_ONCE(tz->temperature);
> last_temp = READ_ONCE(tz->last_temperature);

Yes, you are right, will change it in next version.

Wei.

> 
>> +	temp = tz->temperature;
>> +	last_temp = tz->last_temperature;
>> +	mutex_unlock(&tz->lock);
>> +
>> +	if (temp > trip_temp) {
>> +		if (temp >= last_temp)
>> +			*trend = THERMAL_TREND_RAISING;
>> +		else
>> +			*trend = THERMAL_TREND_STABLE;
>> +	} else if (temp < trip_temp) {
>> +		*trend = THERMAL_TREND_DROPPING;
>> +	} else {
>> +		*trend = THERMAL_TREND_STABLE;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
>>  	.get_temp = tegra_thermctl_get_temp,
>>  	.set_trip_temp = tegra_thermctl_set_trip_temp,
>> +	.get_trend = tegra_thermctl_get_trend,
>>  };
>>  
>>  static int get_hot_temp(struct thermal_zone_device *tz, int *trip, int *temp)
>>
> 
> 
