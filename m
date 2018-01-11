From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] thermal: thermal_hwmon: Convert to
 hwmon_device_register_with_info()
Date: Wed, 10 Jan 2018 21:14:59 -0800
Message-ID: <882a8eb8-a99c-a49e-75fc-2d6ae82d381b@roeck-us.net>
References: <1514976294-31880-1-git-send-email-festevam@gmail.com>
 <20180110192955.GD3837@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44051 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750823AbeAKFPD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jan 2018 00:15:03 -0500
Received: by mail-pf0-f195.google.com with SMTP id m26so638004pfj.11
        for <linux-pm@vger.kernel.org>; Wed, 10 Jan 2018 21:15:03 -0800 (PST)
In-Reply-To: <20180110192955.GD3837@localhost.localdomain>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Fabio Estevam <festevam@gmail.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, arthurborsboom@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>, Pavel Machek <pavel@ucw.cz>

On 01/10/2018 11:29 AM, Eduardo Valentin wrote:
> On Wed, Jan 03, 2018 at 08:44:54AM -0200, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@nxp.com>
>>
>> Booting Linux on a mx6q based board leads to the following warning:
>>      
>> (NULL device *): hwmon_device_register() is deprecated. Please convert the
>> driver to use hwmon_device_register_with_info().
>>      
>> , so do the conversion as suggested.
>>
>> Also, this results in the core taking care of creating the 'name'
>> attribute, so drop the code doing that from the thermal driver.
>>
>> The initial attempt to convert this driver to
>> hwmon_device_register_with_info() caused issues on the N900 platform
>> in commit 611fb68062f ("thermal: thermal_hwmon: Convert to
>> hwmon_device_register_with_info()"):
>>
>> bq27xxx-battery 2-0055: failed to register battery
>> bq27xxx-battery: probe of 2-0055 failed with error -22
>> ...
>> rx51-battery: probe of n900-battery failed with error -22
>>
>> , leading to a revert in commit 3feb479cea37 ("Revert "thermal:
>> thermal_hwmon: Convert to hwmon_device_register_with_info()"").
>>
>> The probe errors happened due to the '-' character being present in
>> the name of the power supply devices: bq27200-0 and rx51-battery.
>>
>> Since commit 74d3b6419772 ("hwmon: Relax name attribute validation
>> for new APIs") hwmon will no longer treat these names as errors,
>> allowing the transition for hwmon_device_register_with_info() to
>> happen in a safely manner.
> 
> I am mostly fine with the patch as long as we get an ack from hwmon
> folks.
> 

An official one ?

I am not really happy with the patch. The conversion to the _info API should
be a real conversion, not just one to silence the warning. However, that would
require a 'dev' argument, and I have absolutely no idea how to do that.
Given that,

Acked-by: Guenter Roeck <linux@roeck-us.net>

Guenter

>>
>> Cc: Pavel Machek <pavel@ucw.cz>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
>> ---
>> Pavel,
>>
>> Could you please test this patch on your N900 platform?
>>
>> Thanks
>>
>>   drivers/thermal/thermal_hwmon.c | 20 +++-----------------
>>   1 file changed, 3 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
>> index 541af59..c4a508a 100644
>> --- a/drivers/thermal/thermal_hwmon.c
>> +++ b/drivers/thermal/thermal_hwmon.c
>> @@ -59,14 +59,6 @@ static LIST_HEAD(thermal_hwmon_list);
>>   static DEFINE_MUTEX(thermal_hwmon_list_lock);
>>   
>>   static ssize_t
>> -name_show(struct device *dev, struct device_attribute *attr, char *buf)
>> -{
>> -	struct thermal_hwmon_device *hwmon = dev_get_drvdata(dev);
>> -	return sprintf(buf, "%s\n", hwmon->type);
>> -}
>> -static DEVICE_ATTR_RO(name);
>> -
>> -static ssize_t
>>   temp_input_show(struct device *dev, struct device_attribute *attr, char *buf)
>>   {
>>   	int temperature;
>> @@ -165,15 +157,12 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
>>   
>>   	INIT_LIST_HEAD(&hwmon->tz_list);
>>   	strlcpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
>> -	hwmon->device = hwmon_device_register(NULL);
>> +	hwmon->device = hwmon_device_register_with_info(NULL, hwmon->type,
>> +							hwmon, NULL, NULL);
>>   	if (IS_ERR(hwmon->device)) {
>>   		result = PTR_ERR(hwmon->device);
>>   		goto free_mem;
>>   	}
>> -	dev_set_drvdata(hwmon->device, hwmon);
>> -	result = device_create_file(hwmon->device, &dev_attr_name);
>> -	if (result)
>> -		goto free_mem;
>>   
>>    register_sys_interface:
>>   	temp = kzalloc(sizeof(*temp), GFP_KERNEL);
>> @@ -222,10 +211,8 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
>>    free_temp_mem:
>>   	kfree(temp);
>>    unregister_name:
>> -	if (new_hwmon_device) {
>> -		device_remove_file(hwmon->device, &dev_attr_name);
>> +	if (new_hwmon_device)
>>   		hwmon_device_unregister(hwmon->device);
>> -	}
>>    free_mem:
>>   	if (new_hwmon_device)
>>   		kfree(hwmon);
>> @@ -267,7 +254,6 @@ void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
>>   	list_del(&hwmon->node);
>>   	mutex_unlock(&thermal_hwmon_list_lock);
>>   
>> -	device_remove_file(hwmon->device, &dev_attr_name);
>>   	hwmon_device_unregister(hwmon->device);
>>   	kfree(hwmon);
>>   }
>> -- 
>> 2.7.4
>>
> 
