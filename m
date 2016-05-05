From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v5 04/11] thermal: core: export apis to get slope and
 offset
Date: Thu, 05 May 2016 10:17:26 +0530
Message-ID: <572AD05E.3060303@codeaurora.org>
References: <1460626319-14516-1-git-send-email-rnayak@codeaurora.org> <1460626319-14516-5-git-send-email-rnayak@codeaurora.org> <20160428000813.GA17932@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160428000813.GA17932@localhost.localdomain>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com, sboyd@codeaurora.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com
List-Id: linux-pm@vger.kernel.org


On 04/28/2016 05:38 AM, Eduardo Valentin wrote:
> On Thu, Apr 14, 2016 at 03:01:52PM +0530, Rajendra Nayak wrote:
>> Add apis for platform thermal drivers to query for slope and offset
>> attributes, which might be needed for temperature calculations.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>  drivers/thermal/thermal_core.c | 16 ++++++++++++++++
>>  include/linux/thermal.h        |  8 ++++++++
>>  2 files changed, 24 insertions(+)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index d4b5465..7d72aad 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -2065,6 +2065,22 @@ exit:
>>  }
>>  EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_name);
>>  
>> +int thermal_zone_get_slope(struct thermal_zone_device *tz)
>> +{
>> +	if (tz && tz->tzp)
>> +		return tz->tzp->slope;
>> +	return 1;
>> +}
>> +EXPORT_SYMBOL_GPL(thermal_zone_get_slope);
>> +
>> +int thermal_zone_get_offset(struct thermal_zone_device *tz)
>> +{
>> +	if (tz && tz->tzp)
>> +		return tz->tzp->offset;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(thermal_zone_get_offset);
> 
> 
> Please include kernel doc entries for the exported functions. Updating
> sysfs-api.txt would be also appreciated.

Sure, will update and repost.

> 
> Thanks for adding this.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
