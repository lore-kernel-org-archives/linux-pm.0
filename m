From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 01/17] thermal: add thermal_zone_set_mode() helper
Date: Tue, 6 Nov 2018 17:11:23 +0100
Message-ID: <a126af62-cbea-a737-94b0-71cb5a4bebef@samsung.com>
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155320epcas2p439b713149d94aa485b3c2ffba063ea03@epcas2p4.samsung.com>
        <1539791563-5959-2-git-send-email-b.zolnierkie@samsung.com>
        <1541491911.2124.91.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541491911.2124.91.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Amit kucheria <amit.kucheria@linaro.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On 11/06/2018 09:11 AM, Zhang Rui wrote:
> On 三, 2018-10-17 at 17:52 +0200, Bartlomiej Zolnierkiewicz wrote:
>> In order to remove the code duplication and prepare for further
>> changes:
>>
>> * Add thermal_zone_set_mode() helper. Then update core code and
>>   drivers to use it.
>>
>> There should be no functional changes caused by this patch.
>>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> ---
>>  drivers/thermal/hisi_thermal.c     | 14 ++------------
>>  drivers/thermal/of-thermal.c       |  3 ++-
>>  drivers/thermal/rockchip_thermal.c | 26 +++++++++-----------------
>>  drivers/thermal/thermal_helpers.c  | 14 ++++++++++++++
>>  drivers/thermal/thermal_sysfs.c    |  8 +++++---
>>  include/linux/thermal.h            |  5 +++++
>>  6 files changed, 37 insertions(+), 33 deletions(-)
>>
>>  
>>  
>> diff --git a/drivers/thermal/thermal_helpers.c
>> b/drivers/thermal/thermal_helpers.c
>> index 2ba756a..b18cee2 100644
>> --- a/drivers/thermal/thermal_helpers.c
>> +++ b/drivers/thermal/thermal_helpers.c
>> @@ -224,3 +224,17 @@ int thermal_zone_get_offset(struct
>> thermal_zone_device *tz)
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(thermal_zone_get_offset);
>> +
>> +/**
>> + * thermal_zone_set_mode() - sets mode of thermal zone device
>> + * @tz: a valid pointer to a struct thermal_zone_device
>> + * @mode: mode to be set
>> + *
>> + * Return: On success returns 0, an error code otherwise.
>> + */
>> +int thermal_zone_set_mode(struct thermal_zone_device *tz,
>> +			  enum thermal_device_mode mode)
>> +{
>> +	return tz->ops->set_mode(tz, mode);
> 
> better to check tz->ops->set_mode first.

I think that it should be added incrementally later when needed.

We don't do 'defensive coding' in the kernel and in this patchset
thermal_zone_set_mode() is not used in any place which has not used
->set_mode directly previously (actually patches #1-4 should not
cause any functionality changes as noted in patch descriptions).

> thanks,
> rui
>> +}
>> +EXPORT_SYMBOL_GPL(thermal_zone_set_mode);
>> diff --git a/drivers/thermal/thermal_sysfs.c
>> b/drivers/thermal/thermal_sysfs.c
>> index 2241cea..2e9e762 100644
>> --- a/drivers/thermal/thermal_sysfs.c
>> +++ b/drivers/thermal/thermal_sysfs.c
>> @@ -69,17 +69,19 @@
>>  {
>>  	struct thermal_zone_device *tz = to_thermal_zone(dev);
>>  	int result;
>> +	enum thermal_device_mode mode;
>>  
>>  	if (!tz->ops->set_mode)
>>  		return -EPERM;
>>  
>>  	if (!strncmp(buf, "enabled", sizeof("enabled") - 1))
>> -		result = tz->ops->set_mode(tz,
>> THERMAL_DEVICE_ENABLED);
>> +		mode = THERMAL_DEVICE_ENABLED;
>>  	else if (!strncmp(buf, "disabled", sizeof("disabled") - 1))
>> -		result = tz->ops->set_mode(tz,
>> THERMAL_DEVICE_DISABLED);
>> +		mode = THERMAL_DEVICE_DISABLED;
>>  	else
>> -		result = -EINVAL;
>> +		return -EINVAL;
>>  
>> +	result = thermal_zone_set_mode(tz, mode);
>>  	if (result)
>>  		return result;
>>  
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index 5f4705f..9d21fd1 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -452,6 +452,8 @@ struct thermal_cooling_device *
>>  int thermal_zone_get_temp(struct thermal_zone_device *tz, int
>> *temp);
>>  int thermal_zone_get_slope(struct thermal_zone_device *tz);
>>  int thermal_zone_get_offset(struct thermal_zone_device *tz);
>> +int thermal_zone_set_mode(struct thermal_zone_device *tz,
>> +			  enum thermal_device_mode mode);
>>  
>>  int get_tz_trend(struct thermal_zone_device *, int);
>>  struct thermal_instance *get_thermal_instance(struct
>> thermal_zone_device *,
>> @@ -518,6 +520,9 @@ static inline int thermal_zone_get_slope(
>>  static inline int thermal_zone_get_offset(
>>  		struct thermal_zone_device *tz)
>>  { return -ENODEV; }
>> +static inline int thermal_zone_set_mode(
>> +		struct thermal_zone_device *tz, enum
>> thermal_device_mode mode)
>> +{ return -ENODEV; }
>>  static inline int get_tz_trend(struct thermal_zone_device *tz, int
>> trip)
>>  { return -ENODEV; }
>>  static inline struct thermal_instance *

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
