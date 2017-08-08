From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal/drivers/hisi: Remove confusing error message
Date: Tue, 8 Aug 2017 12:15:56 +0200
Message-ID: <46604862-fbb8-8ed1-8b0d-7a51543b3398@linaro.org>
References: <1499439833-32531-1-git-send-email-daniel.lezcano@linaro.org>
 <1502178956.4296.7.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:35603 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbdHHKP7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Aug 2017 06:15:59 -0400
Received: by mail-wr0-f180.google.com with SMTP id k71so11082933wrc.2
        for <linux-pm@vger.kernel.org>; Tue, 08 Aug 2017 03:15:58 -0700 (PDT)
In-Reply-To: <1502178956.4296.7.camel@intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, edubezval@gmail.com
Cc: "open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, kong.kongxinwei@hisilicon.com, leo.yan@linaro.org

On 08/08/2017 09:55, Zhang Rui wrote:
> On Fri, 2017-07-07 at 17:03 +0200, Daniel Lezcano wrote:
>> The sensor id is unknown at init time and we use all id in the
>> authorized
>> MAX_SENSORS interval to register the sensor. On this SoC there is one
>> thermal-zone with one sensor on it. No need to spit on the console
>> everytime we
>> failed to register thermal sensors, information which is deliberaly
>> known as it
>> is part of the discovery process.
>>
>>  hisi_thermal f7030700.tsensor: failed to register sensor id 0: -19
>>  hisi_thermal f7030700.tsensor: failed to register thermal sensor:
>> -19
>>  hisi_thermal f7030700.tsensor: failed to register sensor id 1: -19
>>  hisi_thermal f7030700.tsensor: failed to register thermal sensor:
>> -19
>>  hisi_thermal f7030700.tsensor: failed to register sensor id 3: -19
>>  hisi_thermal f7030700.tsensor: failed to register thermal sensor:
>> -19
>>
>> Remove the error messages.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/thermal/hisi_thermal.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/thermal/hisi_thermal.c
>> b/drivers/thermal/hisi_thermal.c
>> index f642966..2cc98c6 100644
>> --- a/drivers/thermal/hisi_thermal.c
>> +++ b/drivers/thermal/hisi_thermal.c
>> @@ -187,6 +187,9 @@ static int hisi_thermal_get_temp(void *_sensor,
>> int *temp)
>>  
>>  	dev_dbg(&data->pdev->dev, "id=%d, irq=%d, temp=%d,
>> thres=%d\n",
>>  		sensor->id, data->irq_enabled, *temp, sensor-
>>> thres_temp);
>> +
>> +	printk("id=%d, irq=%d, temp=%d, thres=%d\n",
>> +		sensor->id, data->irq_enabled, *temp, sensor-
>>> thres_temp);
> 
> what's this printk for?

Argh. It shouldn't be there.

>>  	/*
>>  	 * Bind irq to sensor for two cases:
>>  	 *   Reenable alarm IRQ if temperature below threshold;
>> @@ -260,8 +263,6 @@ static int hisi_thermal_register_sensor(struct
>> platform_device *pdev,
>>  	if (IS_ERR(sensor->tzd)) {
>>  		ret = PTR_ERR(sensor->tzd);
>>  		sensor->tzd = NULL;
>> -		dev_err(&pdev->dev, "failed to register sensor id
>> %d: %d\n",
>> -			sensor->id, ret);
>>  		return ret;
>>  	}
>>  
>> @@ -352,10 +353,9 @@ static int hisi_thermal_probe(struct
>> platform_device *pdev)
>>  		ret = hisi_thermal_register_sensor(pdev, data,
>>  						   &data-
>>> sensors[i], i);
>>  		if (ret)
>> -			dev_err(&pdev->dev,
>> -				"failed to register thermal sensor:
>> %d\n", ret);
>> -		else
>> -			hisi_thermal_toggle_sensor(&data-
>>> sensors[i], true);
>> +			continue;
>> +
>> +		hisi_thermal_toggle_sensor(&data->sensors[i], true);
>>  	}
>>  
>>  	return 0;
> 
> With these removed, is there any other information in dmesg that
> suggests this failure?

The problem is there are always failures showed in dmesg. The init
function is based on the assumption there is HISI_MAX_SENSORS sensors
which is not true for the hi6220 and that raises at boot time errors.

Why HISI_MAX_SENSORS(=4) while there is only one on hi6220 AFAIK? and
this driver is only used for hi6220 (now).

That ends up with 3 errors in dmesg for nothing.





-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
