From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 1/1] thermal: add a warning for temperature emulation
 feature
Date: Tue, 2 Apr 2013 12:05:43 -0400
Message-ID: <515B01D7.30101@ti.com>
References: <1364333914-32586-1-git-send-email-eduardo.valentin@ti.com> <1364909633.2190.42.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41717 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932514Ab3DBQGM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Apr 2013 12:06:12 -0400
In-Reply-To: <1364909633.2190.42.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org

On 02-04-2013 09:33, Zhang Rui wrote:
> On Tue, 2013-03-26 at 17:38 -0400, Eduardo Valentin wrote:
>> Because this feature is for debuging purposes, it is highly
>> recommended to do not enable this on production systems.
>> This patch adds warnings for system integrators, so that
>> people are aware of this potential security issue.
>>
>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>> ---
>>   Documentation/thermal/sysfs-api.txt |    4 ++++
>>   drivers/thermal/Kconfig             |    5 +++++
>>   2 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
>> index a9abb84..0a7d6df 100644
>> --- a/Documentation/thermal/sysfs-api.txt
>> +++ b/Documentation/thermal/sysfs-api.txt
>> @@ -265,6 +265,10 @@ emul_temp
>>   	Unit: millidegree Celsius
>>   	WO, Optional
>>
>> +	  WARNING: Be careful while enabling this option on production systems,
>> +	  because userland can easily disable the thermal policy by simply
>> +	  flooding this sysfs node with low temperature values.
>> +
>>   *****************************
>>   * Cooling device attributes *
>>   *****************************
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index a764f16..004e5f7 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -80,12 +80,17 @@ config CPU_THERMAL
>>
>>   config THERMAL_EMULATION
>>   	bool "Thermal emulation mode support"
>> +	default false
>
> we do not need this as any Kconfig option is set to 'n' by default.
>


Yeah, I know it is a NOP. But that was intentional, just make the warn 
shout aloud :-)

> Others seem okay to me and applied.

OK. Thanks.


>
> thanks,
> rui
>>   	help
>>   	  Enable this option to make a emul_temp sysfs node in thermal zone
>>   	  directory to support temperature emulation. With emulation sysfs node,
>>   	  user can manually input temperature and test the different trip
>>   	  threshold behaviour for simulation purpose.
>>
>> +	  WARNING: Be careful while enabling this option on production systems,
>> +	  because userland can easily disable the thermal policy by simply
>> +	  flooding this sysfs node with low temperature values.
>> +
>>   config SPEAR_THERMAL
>>   	bool "SPEAr thermal sensor driver"
>>   	depends on PLAT_SPEAR
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

